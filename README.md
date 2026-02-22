# Snowflake Hotel Bookings Analytics – End-to-End ETL

This project is an end-to-end analytics pipeline built in **Snowflake** using the **Bronze / Silver / Gold** medallion pattern.

Starting from raw CSV hotel booking data, the pipeline:

1. **Ingests** data into a Bronze layer using a Snowflake Stage and File Format  
2. **Cleans & standardises** it into a Silver layer (types, dates, email quality, status fixes, etc.)  
3. **Aggregates** it into Gold tables for analytics (daily revenue, city revenue, bookings table)  
4. **Visualises** key metrics in a **Snowflake dashboard** (revenue trends, top cities, booking mix)

> Built as a personal portfolio project to demonstrate my Snowflake data engineering and analytics skills.

<img width="4612" height="1308" alt="image" src="https://github.com/user-attachments/assets/48a6ff84-8bd4-44eb-986b-670d59bf765c" />

---

## Tech Stack

- **Snowflake** – data warehouse, stages, file formats, SQL  
- **SQL** – data cleaning, quality checks, aggregations  
- **Snowflake Dashboards** – reporting layer for business insights  

---

## Data Model – Bronze / Silver / Gold

### Bronze – Raw Ingestion

- Table: `BRONZE_HOTEL_BOOKING`
- Direct copy from CSV into Snowflake via stage `STG_HOTEL_BOOKINGS`
- Minimal assumptions, all columns ingested as `STRING`

### Silver – Cleaned & Typed

- Table: `SILVER_HOTEL_BOOKINGS`
- Key transformations:
  - Cast date fields to `DATE`
  - Cast numeric fields (`num_guests`, `total_amount`) to `INTEGER` / `FLOAT`
  - Standardise city and customer names with `TRIM` + `INITCAP`
  - Lowercase and validate email addresses, invalid ones set to `NULL`
  - Fix inconsistent `booking_status` values (e.g. `confirmeeed`, `confirmd` → `Confirmed`)
  - Filter out invalid records:
    - Missing check-in / check-out dates
    - Check-out earlier than check-in
    - Negative amounts

### Gold – Analytics-Ready

- `GOLD_AGG_DAILY_BOOKING`  
  - Daily bookings & daily revenue

- `GOLD_AGG_HOTEL_CITY_SALES`  
  - Total revenue by city (descending)

- `GOLD_BOOKING_CLEAN`  
  - Clean fact table exposing all booking attributes for flexible analysis

---

## Business Questions Answered

The pipeline and dashboard are designed to help answer:

- How is **monthly revenue** trending over time?  
- Which **cities generate the highest revenue**?  
- How are **bookings distributed by status** (Confirmed, Cancelled, etc.)?  
- What is the **booking mix by type** (room types / segments)?  
- How do **quarterly bookings** evolve across the year?

---

## Architecture

```mermaid
flowchart LR
    A[CSV Hotel Bookings<br/>hotel_bookings_sample.csv] --> B[Snowflake Stage<br/>STG_HOTEL_BOOKINGS]
    B --> C[BRONZE_HOTEL_BOOKING<br/>Raw Layer]
    C --> D[SILVER_HOTEL_BOOKINGS<br/>Clean & Typed]
    D --> E[GOLD_AGG_DAILY_BOOKING<br/>Daily Revenue]
    D --> F[GOLD_AGG_HOTEL_CITY_SALES<br/>City Revenue]
    D --> G[GOLD_BOOKING_CLEAN<br/>Bookings Fact]
    E & F & G --> H[Snowflake Dashboard<br/>Hotel_Bookings_Analytics]
