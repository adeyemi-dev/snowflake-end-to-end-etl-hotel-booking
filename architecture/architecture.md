# Architecture Overview

This project uses the Bronze / Silver / Gold medallion architecture inside Snowflake:

### **1. Raw Data (Bronze Layer)**
- CSV file ingested into Snowflake Stage `STG_HOTEL_BOOKINGS`
- Loaded directly into `BRONZE_HOTEL_BOOKING`

### **2. Cleaned Data (Silver Layer)**
- Standardised strings
- Validated & corrected emails
- Converted dates and numeric values
- Removed invalid data
- Stored in `SILVER_HOTEL_BOOKINGS`

### **3. Analytics Layer (Gold Layer)**
- `GOLD_AGG_DAILY_BOOKING` → Daily bookings & revenue
- `GOLD_AGG_HOTEL_CITY_SALES` → Revenue by city
- `GOLD_BOOKING_CLEAN` → Final fact table

### **4. Dashboard**
A Snowflake dashboard visualising:
- Monthly revenue trend  
- Top cities by revenue  
- Quarterly bookings  
- Bookings by type & status
