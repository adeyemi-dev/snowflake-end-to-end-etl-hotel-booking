USE DATABASE HOTEL_DB;

-- 1) Gold: Daily bookings & revenue
CREATE OR REPLACE TABLE GOLD_AGG_DAILY_BOOKING AS
SELECT
    check_in_date AS date,
    COUNT(*) AS total_booking,
    SUM(total_amount) AS total_revenue
FROM SILVER_HOTEL_BOOKINGS
GROUP BY check_in_date
ORDER BY date;

-- 2) Gold: Revenue by city
CREATE OR REPLACE TABLE GOLD_AGG_HOTEL_CITY_SALES AS
SELECT
    hotel_city,
    SUM(total_amount) AS total_revenue
FROM SILVER_HOTEL_BOOKINGS
GROUP BY hotel_city
ORDER BY total_revenue DESC;

-- 3) Gold: Clean booking fact table
CREATE OR REPLACE TABLE GOLD_BOOKING_CLEAN AS
SELECT *
FROM SILVER_HOTEL_BOOKINGS;
