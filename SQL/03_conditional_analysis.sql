-- Q1. For each transaction_type, calculate:
-- 1. Total successful transactions
-- 2. Total failed transactions
-- Display transaction_type, successful_transactions,
-- and failed_transactions.
-- Sort by successful_transactions in descending order.
SELECT tranSaction_type,
	   SUM(CASE WHEN transaction_status = 'SUCCESS' THEN 1 ELSE 0 END) AS SUCCESSFUL_TRANSACTION,
       SUM(CASE WHEN transaction_status = 'FAILED' THEN 1 ELSE 0 END ) AS FAILED_TRANSACTION
FROM UPI_STAGING
GROUP BY tranSaction_type
ORDER BY SUCCESSFUL_TRANSACTION DESC;

-- Q2. Categorize transactions based on amount:
-- LOW: Amount less than 1000
-- MEDIUM: Amount between 1000 and 5000 (inclusive)
-- HIGH: Amount greater than 5000
--
-- For each category, calculate:
-- 1. Total number of transactions
-- 2. Total transaction amount
--
-- Display amount_category, total_transactions,
-- and total_amount.
-- Sort by total_transactions in descending order.
SELECT CASE WHEN AMOUNT < 1000 THEN 'LOW' 
            WHEN AMOUNT BETWEEN 1000 AND 5000 THEN 'MEDIUM'
            ELSE 'HIGH'
            END AS AMOUNT_CATEGORY,
            COUNT(*) AS TOTAL_TRANS ,
            SUM(AMOUNT) AS TOTAL_TRANS_AMOUNT
FROM UPI_STAGING
            GROUP BY AMOUNT_CATEGORY
            ORDER BY TOTAL_TRANS DESC; 
            
-- Q3. For each transaction_type, calculate total transactions,
-- successful transactions, and success percentage (2 decimals).
-- Display transaction_type, total_transactions,
-- successful_transactions, success_percentage.
-- Sort by success_percentage DESC.
SELECT TRANSACTION_TYPE,
       COUNT(*) AS TOTAL_TRANS,
       SUM(CASE WHEN TRANSACTION_STATUS = 'SUCCESS' THEN 1 ELSE 0 END )
       AS successful_transactions,
       ROUND(SUM(CASE WHEN TRANSACTION_STATUS = 'SUCCESS' THEN 1 ELSE 0 END )*100/COUNT(*),2)
       AS success_percentage
FROM upi_staging
GROUP BY  TRANSACTION_TYPE   
ORDER BY  success_percentage DESC;

-- Q4. For each transaction_type, calculate:
-- Failed transaction COUNT and failure percentage (2 decimals).
-- Display transaction_type, failed_transactions, failure_percentage.
-- Sort by failure_percentage DESC.
SELECT TRANSACTION_TYPE,
       SUM(CASE WHEN TRANSACTION_STATUS = 'FAILED' THEN 1 ELSE 0 END ) AS FAILED_TRANSACTION,
       ROUND(SUM(CASE WHEN TRANSACTION_STATUS = 'FAILED' THEN 1 ELSE 0 END )*100/COUNT(*),2) AS FAILED_PERCENTAGE 
       FROM UPI_STAGING
       GROUP BY TRANSACTION_TYPE
       ORDER BY FAILED_PERCENTAGE DESC ;
       
-- Q5. For each sender_state, calculate successful transaction COUNT
-- and successful transaction AMOUNT (sum of amount).
-- Display sender_state, successful_transactions, success_amount.
-- Include only states with at least 1 successful transaction.
-- Sort by success_amount DESC.
SELECT SENDER_STATE,
       SUM(CASE WHEN TRANSACTION_STATUS = 'SUCCESS' THEN 1 ELSE 0 END)AS SUCCESSFUL_TRANS,
       SUM(AMOUNT) AS SUCCESSFUL_TRANS_AMOUNT
FROM UPI_STAGING    
WHERE TRANSACTION_STATUS = 'SUCCESS'   
GROUP BY SENDER_STATE
ORDER BY SUCCESSFUL_TRANS_AMOUNT DESC;

-- Q6. For each sender_bank, calculate failed transaction COUNT
-- and failed transaction AMOUNT (sum of amount).
-- Display sender_bank, failed_transactions, failed_amount.
-- Sort by failed_amount DESC.
SELECT SENDER_BANK,
       SUM(AMOUNT) AS FAILED_TRANS_AMOUNT,
       SUM(CASE WHEN TRANSACTION_STATUS = 'FAILED' THEN 1 ELSE 0 END ) AS COUNT_FAILED_TRANS
FROM upi_staging
WHERE TRANSACTION_STATUS = 'FAILED'
GROUP BY SENDER_BANK
ORDER BY FAILED_TRANS_AMOUNT DESC;

-- Q7. For each transaction_type, calculate total transaction COUNT
-- and failed transaction COUNT.
-- Display transaction_type, total_transactions, failed_transactions.
-- Include only transaction types with more than 1000 failed transactions.
-- Sort by failed_transactions DESC.
SELECT transaction_type,
	   COUNT(*) AS COUNT_OF_TRANS,
	   SUM(CASE WHEN TRANSACTION_STATUS = 'FAILED' THEN 1 ELSE 0 END ) AS FAILED_TRANS
FROM UPI_STAGING
GROUP BY transaction_type
HAVING FAILED_TRANS > 1000
ORDER BY FAILED_TRANS DESC;

-- Q8. For each sender_bank, calculate successful transaction COUNT
-- and successful transaction AMOUNT (sum of amount).
-- Display sender_bank, successful_transactions, success_amount.
-- Include only banks with success_amount greater than 10,000,000.
-- Sort by success_amount DESC.
SELECT SENDER_BANK,
	   COUNT(*) AS SUCCESSFUL_TRANS_COUNT,
       SUM(AMOUNT) AS success_amount
FROM UPI_STAGING
WHERE TRANSACTION_STATUS = 'SUCCESS'
GROUP BY SENDER_BANK 
HAVING SUM(AMOUNT) > 10000000
ORDER BY success_amount DESC ;

-- Q9. For each sender_state, calculate total transaction COUNT
-- and failed transaction COUNT. Include only states where
-- failed transaction COUNT is greater than 500.
-- Display sender_state, total_transactions, failed_transactions.
-- Sort by failed_transactions DESC.
SELECT SENDER_STATE,
       COUNT(*) AS TOTAL_TRANS_COUNT,
	   SUM(CASE WHEN TRANSACTION_STATUS = 'FAILED' THEN 1  ELSE  0 END ) AS FAILED_TRANS_COUNT
       FROM upi_staging
       GROUP BY SENDER_STATE 
       HAVING FAILED_TRANS_COUNT > 500
       ORDER BY FAILED_TRANS_COUNT DESC ;
       
-- Q10. For each receiver_bank, calculate failed transaction COUNT
-- and failed transaction AMOUNT (sum of amount).
-- Display receiver_bank, failed_transactions, failed_amount.
-- Include only banks with failed_amount greater than 5,000,000.
-- Sort by failed_amount DESC.
SELECT receiver_bank,
	   SUM(case when transaction_status = 'FAILED' THEN 1 ELSE 0 END ) AS FAILED_TRANS_COUNT,
       SUM(AMOUNT) AS FAILED_AMOUNT 
       FROM upi_staging
       WHERE TRANSACTION_STATUS = 'FAILED'
       GROUP BY receiver_bank
       HAVING FAILED_AMOUNT > 5000000
       ORDER BY FAILED_AMOUNT DESC ; 
       
       
       
       
       













        
