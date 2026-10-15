-- 02_Business_Analysis_Questions.sql

-- Q1. Display the first 10 transactions with their
-- transaction ID, transaction type, amount, and status.
SELECT transaction_id, transaction_type,
	   amount,transaction_status
FROM upi_staging
LIMIT 10;

-- Q2. Display all successful transactions with their
-- transaction ID, amount, and transaction type.
SELECT transaction_id,amount,
       transaction_type 
FROM upi_staging       
WHERE transaction_status = 'SUCCESS' ;

-- Q3. Display all unique transaction types available
-- in the UPI transaction dataset.
SELECT 
	DISTINCT transaction_type
FROM upi_staging; 

-- Q4. Display the top 10 highest-value UPI transactions,
-- showing transaction ID, amount, and transaction type.
SELECT transaction_id,amount,transaction_type
       FROM UPI_STAGING
       ORDER BY AMOUNT DESC 
       LIMIT 10;
       
-- Q5. Display the top 10 highest-value successful
-- transactions, showing transaction ID, amount,
-- and transaction type.
SELECT transaction_id,transaction_type,amount
FROM upi_staging
WHERE transaction_status = 'SUCCESS'
ORDER BY AMOUNT DESC 
LIMIT 10;

-- Q6. Display all transactions with amounts between
-- ₹1,000 and ₹5,000, including both boundary values.
SELECT transaction_id,amount
FROM upi_staging
WHERE amount BETWEEN 1000 AND 5000;

-- Q7. Display all transactions whose transaction type
-- is either P2P or P2M.
SELECT transaction_id,transaction_type,amount
FROM upi_staging
WHERE transaction_type IN ('P2P','P2M');
     
-- Q8. Display successful transactions with amounts
-- greater than ₹5,000.
 SELECT transaction_id,amount
 FROM upi_staging
 WHERE amount > 5000 
 AND transaction_status = 'SUCCESS';
 
 -- Q9. Display transactions that either failed
-- OR have an amount greater than ₹10,000.
-- Show transaction_id, amount, and transaction_status.
SELECT transaction_id, amount,transaction_status
FROM UPI_STAGING
WHERE transaction_status = 'FAILED'
OR amount > 10000;

-- Q10. Count the total number of successful transactions.
-- Return only the total count with a meaningful column alias.
SELECT COUNT(transaction_id) AS total_number_of_successfull_tns
FROM upi_staging
WHERE transaction_status = 'SUCCESS' ;

-- Q11. Count the number of transactions for each
-- transaction type.
-- Display transaction_type and total_transactions.
-- Sort the results by total_transactions in descending order.
SELECT transaction_type,COUNT(*) AS total_transactions 
FROM UPI_STAGING
GROUP BY transaction_type
ORDER BY COUNT(*) DESC ;

-- Q12. Display transaction types that have more than
-- 50,000 transactions.
-- Show transaction_type and total_transactions.
-- Sort by total_transactions in descending order.
SELECT transaction_type,COUNT(*) AS total_transactionS
FROM UPI_STAGING
GROUP BY transaction_type
HAVING COUNT(*) > 50000;

-- Q13. Calculate the total transaction amount for each
-- transaction type.
-- Display transaction_type and total_amount.
-- Sort by total_amount in descending order.
SELECT transaction_type,SUM(AMOUNT) AS total_transaction_amount
FROM UPI_STAGING
GROUP BY transaction_type 
ORDER BY total_transaction_amount DESC ;

-- Q14. Calculate the average transaction amount for each
-- transaction type.
-- Display transaction_type and average_amount.
-- Sort by average_amount in descending order.
SELECT transaction_type,ROUND(AVG(amount),2) AS avg_amount
FROM UPI_STAGING
GROUP BY transaction_type 
ORDER BY avg_amount desc;

-- Q15. Find the minimum and maximum transaction amount
-- for each transaction type.
-- Display transaction_type, minimum_amount, and maximum_amount.
SELECT transaction_type,
MAX(amount) AS MAXIMUM_AMOUNT,
MIN(amount) As MINMUM_AMOUNT
FROM UPI_STAGING
GROUP BY transaction_type;

-- Q16. Count how many unique sender banks are present
-- in the dataset.
-- Display the result with the alias unique_sender_banks.
SELECT COUNT(DISTINCT sender_bank ) 
       AS unique_sender_banks
FROM UPI_STAGING ;

-- Q17. Count the number of unique sender banks
-- involved in successful transactions only.
-- Display the result with the alias unique_sender_banks.
SELECT 
       COUNT(distinct SENDER_BANK) AS unique_sender_banks
FROM upi_staging
WHERE transaction_status = 'SUCCESS' ;

-- Q18. Count successful and failed transactions separately.
-- Display transaction_status and total_transactions.
-- Sort by total_transactions in descending order.
SELECT transaction_status,
       COUNT(*) AS total_number_OF_trans 
FROM UPI_STAGING
GROUP BY  transaction_status
ORDER BY total_number_OF_trans DESC;

-- Q19. Calculate the total transaction amount for
-- successful transactions only, grouped by transaction type.
-- Display transaction_type and total_amount.
-- Sort by total_amount in descending order.
SELECT transaction_type,
	   SUM(AMOUNT) AS TOTAL_AMOUNT 	 
FROM UPI_STAGING
WHERE transaction_status = 'SUCCESS'
GROUP BY transaction_type;

-- Q20. Calculate the average transaction amount for
-- each transaction status (SUCCESS and FAILED).
-- Display transaction_status and average_amount.
-- Sort by average_amount in descending order.
SELECT transaction_status, ROUND(AVG(AMOUNT),2) AS AVG_AMOUNT
FROM UPI_STAGING
GROUP BY transaction_status 
ORDER BY AVG_AMOUNT DESC;

-- ===============================================================
-- CASE WHEN 

-- Q21. Categorize transactions based on their amount:
-- Below ₹1,000      = 'Low'
-- ₹1,000 to ₹5,000  = 'Medium'
-- Above ₹5,000      = 'High'
-- Display transaction_id, amount, and amount_category.
-- Show only the first 20 rows.
SELECT transaction_id,amount,
       CASE 
           WHEN AMOUNT < 1000 THEN 'LOW'
           WHEN AMOUNT BETWEEN 1000 AND 5000 THEN 'MEDIUM'
           ELSE 'HIGH'
           END AS AMOUNT_CATEGORY
FROM UPI_STAGING
LIMIT 20 ;

-- Q22. Categorize transactions into Low, Medium, and High
-- using the same amount ranges as Q21.
-- Count how many transactions belong to each category.
-- Display amount_category and total_transactions.
-- Sort by total_transactions in descending order.
WITH TRANS_COUNT AS (SELECT transaction_id,
		 CASE 
           WHEN AMOUNT < 1000 THEN 'LOW'
           WHEN AMOUNT BETWEEN 1000 AND 5000 THEN 'MEDIUM'
           ELSE 'HIGH'
		END AS AMOUNT_CATEGORY
FROM UPI_STAGING ) 
SELECT AMOUNT_CATEGORY,
       COUNT(*) AS TOTAL_TRANSACTION
       FROM TRANS_COUNT
       GROUP BY AMOUNT_CATEGORY
       ORDER BY TOTAL_TRANSACTION DESC;
       
-- Q23. Count successful and failed transactions using
-- conditional aggregation.
-- Display success_count and failed_count in a single row.
SELECT SUM(CASE WHEN transaction_status = 'SUCCESS' THEN 1 ELSE 0 END ) 
       AS SUCCESSFUL_TRANS,
       SUM(CASE WHEN transaction_status = 'FAILED' THEN 1 ELSE 0 END )
       AS FAILED_TRANS  
FROM UPI_STAGING;

-- Q24. Count the number of transactions for each day.
-- Use the timestamp column to extract the date.
-- Display transaction_date and total_transactions.
-- Sort by transaction_date in ascending order.

-- =========================================================================================
-- DATE ANALYSIS
-- Q24. Count the number of transactions for each day.
-- Use the timestamp column to extract the date.
-- Display transaction_date and total_transactions.
-- Sort by transaction_date in ascending order.
SELECT DATE(`timestamp`) AS TRANSACTION_DATE,COUNT(*) AS TOTAL_TRANSACTION
FROM UPI_STAGING
GROUP BY TRANSACTION_DATE
ORDER BY TOTAL_TRANSACTION ASC;

-- Q25. Calculate the total transaction amount for each month.
-- Use the timestamp column to extract the year and month.
-- Display transaction_month and total_amount.
-- Sort by transaction_month in ascending order.
SELECT DATE_FORMAT(TIMESTAMP,'%Y-%m') AS TRANS_MONTH, 
       SUM(AMOUNT) AS TOTAL_AMOUNT
FROM upi_staging
GROUP BY TRANS_MONTH
ORDER BY TOTAL_AMOUNT ASC;

-- Q26. Count transactions separately for weekends and weekdays.
-- Use the is_weekend column (1 = Weekend, 0 = Weekday).
-- Display day_type and total_transactions.
SELECT CASE 
           WHEN is_weekend = 1 THEN 'WEEKEND'
           WHEN is_weekend = 0 THEN 'WEEKDAY'
           END AS DAY_TYPE,
           COUNT(*) AS TOTAL_TRANSACTION
           FROM upi_staging
           GROUP BY DAY_TYPE;
           
-- Q27. Calculate the average transaction amount separately
-- for weekends and weekdays.
-- Use the is_weekend column (1 = Weekend, 0 = Weekday).
-- Display day_type and average_amount.
-- Sort by average_amount in descending order.
SELECT CASE WHEN IS_WEEKEND = 1 THEN 'Weekend'
			ELSE 'Weekday' 
            END AS DAY_TYPE,
            ROUND(AVG(AMOUNT),2) AS AVG_AMOUNT
            FROM UPI_STAGING
            GROUP BY DAY_TYPE
            ORDER BY AVG_AMOUNT DESC ;
            
-- Q28. Find the highest transaction amount for each transaction type.
-- Display transaction_type and highest_amount.
-- Sort by highest_amount in descending order.
SELECT TRANSACTION_TYPE,
MAX(amount) AS Highest_transa
FROM upi_staging
GROUP BY TRANSACTION_TYPE
ORDER BY Highest_transa DESC;

-- Q29. Calculate the percentage of successful transactions
-- out of all transactions.
-- Display the result as success_percentage, rounded to 2 decimals.
SELECT ROUND(SUM(CASE 
               WHEN TRANSACTION_STATUS = 'SUCCESS' THEN 1 ELSE 0 END )*100/COUNT(*),2)
               AS SUCCESS_PERCENTAGE 
               FROM upi_staging;
               
-- Q30. For each transaction type, calculate:
-- 1. Total number of transactions
-- 2. Total transaction amount
-- 3. Average transaction amount
-- Display transaction_type, total_transactions,
-- total_amount, and average_amount.
-- Sort by total_amount in descending order.
SELECT transaction_type,
       COUNT(*) AS total_trans,
       SUM(AMOUNT) AS total_trans_amount,
       AVG(AMOUNT) AS avg_amount
FROM upi_staging
GROUP BY TRANSACTION_TYPE ; 
      
               
                   
		



