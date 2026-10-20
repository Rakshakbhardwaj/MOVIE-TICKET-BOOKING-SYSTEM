# MOVIE-TICKET-BOOKING-SYSTEM
🎬 Movie Ticket Booking System (DBMS Mini Project)

An enterprise-ready, normalized Relational Database Management System (RDBMS) designed to manage multiplex ticket reservations, customer records, auditorium venues, screening schedules, and financial transactions.

📌 Table of Contents

Project Overview

Problem Statement & Objectives

Key Features

System Architecture & Modules

Relational Schema & Entity Relationships

Data Integrity & Constraints

Technology Stack

Installation & Execution Guide

Operational Queries Summary

Expected Results & Analytics

Future Scope & Enhancements

License

📖 Project Overview

Manual cinema management systems often suffer from duplicate seat allocations, broken audit trails between payments and tickets, data redundancy, and poor query performance.

This project solves those limitations through an ACID-compliant relational schema structured across six interconnected tables:

customer: Tracks verified user identities and contact details.

movie: Catalogs titles, genres, languages, and film durations.

theatre: Manages hall venues, physical locations, and seating capacities.

movie_show: Schedules film projections, screening dates, time slots, and admission rates.

booking: Captures real-time reservation logs, ticket quantities, and order states.

payment: Reconciles billing amounts, payment methods, and transaction statuses.

🎯 Problem Statement & Objectives

Problem Statement

Spreadsheet-driven cinema management lacks transactional concurrency, referential constraints, and structured relationship mapping. This leads to duplicate records, orphaned payment entries, and inability to produce cross-table analytical insights.

Objectives

Schema Design: Develop a third-normal-form (3NF) relational schema for multiplex operations.

Master Data Integrity: Maintain customer profiles and film catalogs with unique identifier safeguards.

Venue & Screen Scheduling: Correlate physical auditoriums to movie listings with variable pricing models.

Reservation Workflow: Automate booking pipelines linking users directly to scheduled shows.

Financial Reconciliation: Ensure one-to-one transactional mapping between bookings and payment receipts.

Constraint Validation: Enforce database rules via primary, foreign, unique, and check constraints.

Business Intelligence Retrieval: Perform multi-table relational joins, data filtering, and aggregations.

✨ Key Features

Strict Referential Integrity: Foreign keys enforce valid parent-child relationships across all operational steps.

Domain Constraints: Prevents negative or zero values for ticket prices, seat counts, runtimes, and payment amounts.

End-to-End Itinerary Synthesis: Reconstructs complete booking manifests combining customer identity, film title, auditorium venue, screening time, and amount paid.

Aggregate Analytics: Computes real-time gross revenue, average spend per transaction, and per-user ticket reservation counts.

Integrity Violation Defense: Explicitly rejects duplicate primary keys, repeated phone/email registrations, and invalid references.

🧩 System Architecture & Modules

Module Name

Primary Entity

Core Responsibilities

Customer Management

customer

Stores distinct customer profiles, verified emails, and phone contacts.

Movie Catalog

movie

Maintains cinema inventory, genres, durations, and original languages.

Theatre Management

theatre

Catalogs cinema branches across cities and overall auditorium capacities.

Show Scheduling

movie_show

Maps movie titles to theatres with specific calendar dates, times, and prices.

Booking Engine

booking

Records reservations, ticket quantities, timestamps, and order statuses.

Payment Reconciliation

payment

Tracks 1-to-1 settlement audits linked directly to confirmed bookings.

🗄️ Relational Schema & Entity Relationships

Relational Schema Blueprint

customer (customer_id [PK], customer_name, email [UQ], phone [UQ])

movie (movie_id [PK], movie_name, genre, duration, language)

theatre (theatre_id [PK], theatre_name, city, total_seats)

movie_show (show_id [PK], movie_id [FK $\rightarrow$ movie], theatre_id [FK $\rightarrow$ theatre], show_date, show_time, ticket_price)

booking (booking_id [PK], customer_id [FK $\rightarrow$ customer], show_id [FK $\rightarrow$ movie_show], tickets, booking_date, status)

payment (payment_id [PK], booking_id [FK/UQ $\rightarrow$ booking], amount, payment_method, payment_status)

Cardinality Mapping

Customer $\rightarrow$ Booking: $1 : N$ (One customer can make multiple bookings; each booking belongs to one customer).

Movie $\rightarrow$ Show: $1 : N$ (One movie can be screened in multiple shows).

Theatre $\rightarrow$ Show: $1 : N$ (One auditorium hosts multiple scheduled shows over time).

Show $\rightarrow$ Booking: $1 : N$ (One show can have multiple ticket bookings).

Booking $\rightarrow$ Payment: $1 : 1$ (Each confirmed booking corresponds to exactly one payment receipt).

🛡️ Data Integrity & Constraints

The system uses declarative SQL constraints to maintain complete entity and domain integrity:

PRIMARY KEY: Uniquely identifies each record across all six tables (customer_id, movie_id, theatre_id, show_id, booking_id, payment_id).

FOREIGN KEY: Guarantees referential validity, ensuring orphaned bookings or invalid show schedules cannot be entered.

UNIQUE Constraint: Prevents registration conflicts by disallowing duplicate customer email addresses and phone numbers.

CHECK Constraints:

duration > 0: Eliminates invalid or negative movie lengths.

total_seats > 0: Guarantees positive venue capacities.

ticket_price > 0: Enforces positive unit pricing for cinema tickets.

tickets > 0: Ensures bookings cannot be registered with zero or negative ticket quantities.

amount > 0: Validates positive settlement sums.

DEFAULT Constraints: Applies standard baseline values ('Hindi' for languages, 'Confirmed' for booking status, 'UPI' for payment method, and 'Paid' for transaction state).

🛠️ Technology Stack

Database Engine: MySQL Server (Version 8.0+ Community Edition) / MariaDB

Database Architecture: Relational Database Management System (RDBMS)

Standard Applied: ANSI / ISO SQL Standards

Client & Tooling: MySQL Command Line Client (CLI), MySQL Workbench, Visual Studio Code

Operating Environment: Cross-platform (Windows, Linux, macOS)

🚀 Installation & Execution Guide

Clone the Repository:
Download or clone the project repository to your local workstation.

Launch Database Server:
Ensure your MySQL server daemon is active and running on standard port 3306.

Connect to MySQL:
Log in to the database server using your administrative credentials via terminal or CLI.

Load the SQL Script:
Execute the provided .sql batch file using the database import utility or MySQL SOURCE command.

Inspect the Records:
Run schema inspection commands (SHOW TABLES, DESCRIBE table_name) to verify all six relational entities and their respective keys.

📋 Operational Queries Summary

The project covers all major relational data manipulation and extraction workflows:

Full Data Projections: Verification of base tables via complete row and column retrieval.

Relational Joins: Multi-table INNER JOIN operations consolidating booking, customer, movie_show, movie, theatre, and payment into a single comprehensive booking itinerary.

Statistical Aggregations:

COUNT(): Determines total reservations across the system.

SUM(): Evaluates cumulative gross revenue generated from ticket sales.

AVG(): Calculates the mean transaction value across all bookings.

Predicate Filtering:

Single-condition and range filtering (e.g., retrieving premium shows priced above 250).

Grouping & Summarization:

GROUP BY: Aggregates cumulative ticket counts purchased by each distinct customer profile.

Constraint Enforcement Verifications:

Demonstrates engine-level rejection of duplicate primary keys (Error 1062).

Demonstrates engine-level rejection of duplicate unique emails (Error 1062).

Demonstrates check constraint violations when booking zero tickets (Error 3819).

Demonstrates foreign key violations when assigning non-existent customer IDs (Error 1452).

📊 Expected Results & Analytics

Metric / Analysis

Operational Rule

Observed Result

Total Headcount Booked

Aggregate count of all reservation records

5 Confirmed Bookings

Total Revenue

Cumulative sum across all transaction amounts

₹2,840.00

Average Transaction Size

Mean calculation across customer orders

₹568.00

Premium Show Filtering

Screenings with ticket prices exceeding ₹250.00

Space Mission (₹300.00), Mystery House (₹280.00)

Customer Ticket Volume

Sum of tickets grouped by customer name

Priya Verma (4), Simran Kaur (3), Rahul Sharma (2), Arjun Singh (2), Aman Kumar (1)

🔮 Future Scope & Enhancements

Interactive Seat Matrix: Introduce a visual grid (Row A–J, Seat 1–20) with row-level transactional locking (SELECT ... FOR UPDATE) to eliminate race conditions.

Automated Triggers: Implement database triggers to dynamically decrement available seat counts upon ticket confirmation and restore capacity upon cancellation.

Stored Procedures & ACID Transactions: Package booking creation and payment clearance inside formal transactions (START TRANSACTION, COMMIT, ROLLBACK).

Payment Gateway Integration: Connect the schema to mock or live payment APIs (Stripe / Razorpay) for tokenized payment callbacks.

Role-Based Access Control (RBAC): Establish distinct permission levels for regular customers, box office staff, and cinema administrators.

Web Interface: Develop a responsive frontend in React, Vue, or Next.js backed by a RESTful API service (Node.js, FastAPI, or Django).
