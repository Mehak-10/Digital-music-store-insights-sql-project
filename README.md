🎧 Digital Music Store Analysis — SQL Project

This project presents a structured SQL-based analysis of a digital music store's database. Through a series of business questions ranging from basic to advanced levels, the project aims to provide meaningful insights into sales performance, customer behavior, and music trends using SQL.

📌 Overview
This project simulates a real-world scenario where a digital music platform wants to:

Understand customer purchase behavior

Analyze which music genres and artists are most popular

Find top-performing regions, employees, and customers

Queries are organized into three levels:

🟢 Easy: Basic aggregations and sorting

🟡 Moderate: JOINs, filtering, and grouping

🔴 Advanced: CTEs and nested subqueries

🛠️ Technologies Used
SQL (MySQL) — Query writing and data analysis

Relational Database Schema — Simulated using CREATE DATABASE and pre-defined tables

📂 Database Tables Involved
The project uses the following tables:

employee — Employee details with job titles and hierarchy

customer — Customer personal and contact info

invoice — Records of customer purchases

invoice_line — Individual items within each invoice

track — Information about music tracks

genre — Music genres (e.g., Rock, Jazz)

album2 — Album details (renamed version of album)

artist — Music artists

📊 Features & Business Questions Answered
🔹 Easy Level
Who is the most senior employee?

Which country has the most invoices?

Top 3 invoices with the highest amounts

Which city generates the most revenue?

Who is the highest-spending customer?

🔸 Moderate Level
List of Rock music listeners sorted by email

Top 10 rock artists by track count

Tracks longer than the average song duration

🔺 Advanced Level
Which customers spent the most on the top-selling artist?

Use of CTEs (Common Table Expressions) to improve readability and structure

Calculation of total revenue per customer-artist pair

🧠 Learning Outcomes
Writing efficient SQL queries using JOIN, GROUP BY, ORDER BY, and LIMIT

Working with aggregate functions like SUM(), AVG(), and COUNT()

Using subqueries and CTEs for complex calculations

Gaining insights from raw relational data to support business decision-making
