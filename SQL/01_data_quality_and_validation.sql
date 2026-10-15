-- =====================================================
-- DATA QUALITY CHECKS AND DATA VALIDATION
-- UPI Transaction Analysis Project
-- =====================================================

-- 1. Duplicate Transaction ID Check
-- 2. NULL Value Check
-- 3. Invalid Transaction Amount Check
-- 4. Invalid Fraud Flag Check
-- 5. Transaction Status Check
-- 6. Invalid Hour Check
-- 7. Day of Week Check
-- =========================================================
-- PROJECT: UPI TRANSACTION ANALYSIS
-- SECTION: DATA QUALITY CHECKS AND DATA VALIDATION
-- TABLE: upi_staging
-- =========================================================


-- 1. DUPLICATE TRANSACTION ID CHECK
-- Purpose: Identify duplicate transaction IDs

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS unique_transactions,
    COUNT(*) - COUNT(DISTINCT transaction_id) AS duplicate_ids
FROM upi_staging;


-- =========================================================


-- 2. NULL VALUE CHECK
-- Purpose: Identify missing values in important columns

SELECT
    SUM(transaction_id IS NULL) AS null_transaction_id,
    SUM(`timestamp` IS NULL) AS null_timestamp,
    SUM(transaction_type IS NULL) AS null_transaction_type,
    SUM(merchant_category IS NULL) AS null_merchant_category,
    SUM(amount IS NULL) AS null_amount,
    SUM(transaction_status IS NULL) AS null_status,
    SUM(sender_age_group IS NULL) AS null_sender_age,
    SUM(receiver_age_group IS NULL) AS null_receiver_age,
    SUM(sender_state IS NULL) AS null_sender_state,
    SUM(sender_bank IS NULL) AS null_sender_bank,
    SUM(receiver_bank IS NULL) AS null_receiver_bank,
    SUM(device_type IS NULL) AS null_device_type,
    SUM(network_type IS NULL) AS null_network_type,
    SUM(fraud_flag IS NULL) AS null_fraud_flag,
    SUM(hour_of_day IS NULL) AS null_hour,
    SUM(day_of_week IS NULL) AS null_day,
    SUM(is_weekend IS NULL) AS null_weekend
FROM upi_staging;


-- =========================================================


-- 3. INVALID TRANSACTION AMOUNT CHECK
-- Purpose: Identify zero or negative transaction amounts

SELECT *
FROM upi_staging
WHERE amount <= 0;


-- =========================================================


-- 4. INVALID FRAUD FLAG CHECK
-- Purpose: Identify values other than 0 and 1

SELECT *
FROM upi_staging
WHERE fraud_flag NOT IN (0, 1);


-- =========================================================


-- 5. TRANSACTION STATUS CHECK
-- Purpose: Identify unique transaction statuses

SELECT DISTINCT transaction_status
FROM upi_staging;


-- =========================================================


-- 6. INVALID HOUR CHECK
-- Purpose: Identify hours outside the valid 0-23 range

SELECT *
FROM upi_staging
WHERE hour_of_day NOT BETWEEN 0 AND 23;


-- =========================================================


-- 7. DAY OF WEEK CHECK
-- Purpose: Identify unique day values

SELECT DISTINCT day_of_week
FROM upi_staging
ORDER BY day_of_week;


-- =========================================================
-- END OF DATA QUALITY CHECKS AND VALIDATION
-- =========================================================
