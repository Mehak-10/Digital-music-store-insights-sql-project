-- CREATE DATABASE FOR STORING THE DATA
create database MUSIC_PLAYER;
USE MUSIC_PLAYER;

-- Question Set 1 - Easy
 
 -- Q1: Who is the senior most employee based on job title? 
 
SELECT 
    title, last_name, first_name
FROM
    employee
ORDER BY levels DESC
LIMIT 1;
 
 -- Q2: Which countries have the most Invoices? 
 
 SELECT 
    COUNT(*) AS c, billing_country
FROM
    invoice
GROUP BY billing_country
ORDER BY c DESC;

-- Q3: What are top 3 values of total invoice?

SELECT 
    total
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals */

SELECT 
    SUM(total) AS invoice_total, billing_city
FROM
    invoice
GROUP BY billing_city
ORDER BY invoice_total DESC;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(invoice.total) AS total_spend
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id , customer.first_name , customer.last_name
ORDER BY total_spend DESC
LIMIT 1;

-- Question Set 2 - Moderate 

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT
    email, first_name, last_name
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
        JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE
    track_id IN (SELECT 
            track_id
        FROM
            track
                JOIN
            genre ON track.genre_id = genre.genre_id
        WHERE
            genre.name LIKE 'Rock')
ORDER BY email;

/* Method 2 */

SELECT DISTINCT
    email AS Email,
    first_name AS FirstName,
    last_name AS LastName,
    genre.name AS Name
FROM
    customer
        JOIN
    invoice ON invoice.customer_id = customer.customer_id
        JOIN
    invoice_line ON invoice_line.invoice_id = invoice.invoice_id
        JOIN
    track ON track.track_id = invoice_line.track_id
        JOIN
    genre ON genre.genre_id = track.genre_id
WHERE
    genre.name LIKE 'Rock'
ORDER BY email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT 
    artist.artist_id,
    artist.name,
    COUNT(artist.artist_id) AS number_of_songs
FROM
    track
        JOIN
    album2 ON album2.album_id = track.album_id
        JOIN
    artist ON artist.artist_id = album2.artist_id
        JOIN
    genre ON genre.genre_id = track.genre_id
WHERE
    genre.name LIKE 'Rock'
GROUP BY artist.artist_id , artist.name
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */


SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds) AS avg_track_length
        FROM
            track)
ORDER BY milliseconds DESC;

-- Question Set 3 - Advance 

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */


WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, 
    SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album2 ON album2.album_id = track.album_id
	JOIN artist ON artist.artist_id = album2.artist_id
	GROUP BY artist.artist_id , artist.name
	ORDER BY total_sales DESC
	LIMIT 1
)

SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, 
SUM(il.unit_price * il.quantity) AS amount_spent
FROM invoice i 
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album2 alb2 ON alb2.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb2.artist_id
GROUP BY  c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY amount_spent DESC;






