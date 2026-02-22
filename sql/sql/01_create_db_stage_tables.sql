-- 1) Create database
CREATE OR REPLACE DATABASE HOTEL_DB;

USE DATABASE HOTEL_DB;

-- 2) Create file format
CREATE OR REPLACE FILE FORMAT FF_CSV
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('NULL', 'null', '');

-- 3) Create stage
CREATE OR REPLACE STAGE STG_HOTEL_BOOKINGS
    FILE_FORMAT = FF_CSV;

-- 4) Create Bronze table (raw)
CREATE OR REPLACE TABLE BRONZE_HOTEL_BOOKING (
    booking_id STRING,
    hotel_id STRING,
    hotel_city STRING,
    customer_id STRING,
    customer_name STRING,
    customer_email STRING,
    check_in_date STRING,
    check_out_date STRING,
    room_type STRING,
    num_guests STRING,
    total_amount STRING,
    currency STRING,
    booking_status STRING
);

-- 5) Load data into Bronze
COPY INTO BRONZE_HOTEL_BOOKING
FROM @STG_HOTEL_BOOKINGS
FILE_FORMAT = (FORMAT_NAME = FF_CSV)
ON_ERROR = 'CONTINUE';
