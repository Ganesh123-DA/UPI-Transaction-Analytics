-- Q1. Find transactions where amount is greater than the overall average amount.
-- Display transaction_id, amount, transaction_status.
-- Use a subquery to calculate the average amount.
-- Sort by amount DESC.
SELECT transaction_id,amount,transaction_status
FROM upi_staging
WHERE amount	> (SELECT AVG(amount) FROM upi_staging )
ORDER BY amount desc; 

-- Q2. Find transactions whose amount is greater than the average amount of their transaction_status.
-- Display transaction_id, transaction_status, amount.
-- Use a correlated subquery.
-- Sort by amount DESC.
SELECT transaction_id, transaction_status, amount
FROM upi_staging U
WHERE U.amount > (SELECT AVG(U1.amount)
FROM upi_staging U1 
WHERE U.transaction_status=U1.transaction_status
); 

-- (second if the query is not responding)----------------------------------------------------------
-- SELECT U.transaction_id, U.transaction_status, U.amount
-- FROM upi_staging U
-- JOIN (
--    -- SELECT transaction_status, AVG(amount) AS avg_amount
--     -- FROM upi_staging
--     -- GROUP BY transaction_status
--  -- ) A
-- ON U.transaction_status = A.transaction_status
-- WHERE U.amount > A.avg_amount
-- ORDER BY U.amount DESC;-------------------------------------------------------------------------



-- Q3. Find transactions whose amount is greater than the maximum transaction amount.
-- Display transaction_id, transaction_status, amount.
-- Use a subquery to calculate the maximum amount.
-- Sort by amount DESC.
SELECT transaction_id, transaction_status, amount
FROM upi_staging 
WHERE amount > (SELECT AVG(amount) FROM upi_staging);

-- Q3. Find the transaction(s) with the second-highest amount.
-- Display transaction_id, transaction_status, amount.
-- Use a subquery.
-- Sort by amount DESC.
SELECT transaction_id, transaction_status, amount
FROM upi_staging
WHERE amount IN (
    SELECT MAX(amount)
    FROM upi_staging
    WHERE amount < (SELECT MAX(amount) FROM upi_staging)
); 

-- Q4. Find transactions with an amount greater than the average amount of SUCCESS transactions.
-- Display transaction_id, transaction_status, amount.
-- Use a subquery.
-- Sort by amount DESC.
SELECT transaction_id, transaction_status, amount
FROM upi_staging  
WHERE AMOUNT > (
SELECT ROUND(AVG(AMOUNT),2) 
FROM upi_staging 
WHERE transaction_status = 'SUCCESS'
  )
ORDER BY AMOUNT DESC ;
  
-- Q5. Find transactions with an amount greater than the average amount of their receiver_bank.
-- Display transaction_id, receiver_bank, amount.
-- Use a subquery.
-- Sort by amount DESC.
SELECT  U.transaction_id, U.receiver_bank, U.amount 
FROM upi_staging U 
JOIN  (
SELECT receiver_bank,AVG(AMOUNT) AS AVG_aMOUNT
FROM upi_staging  
GROUP BY receiver_bank
)us
ON  U.receiver_bank=US.receiver_bank
WHERE U.AMOUNT > AVG_aMOUNT
ORDER BY U.AMOUNT DESC ;

-- Q6. Find transactions whose amount is greater than the average amount of FAILED transactions.
-- Display transaction_id, transaction_status, amount.
-- Use a subquery.
-- Sort by amount DESC.
SELECT transaction_id, transaction_status, amount 
FROM upi_staging
WHERE AMOUNT > (SELECT AVG(AMOUNT) FROM upi_staging 
                WHERE transaction_status = 'FAILED'  )
ORDER BY AMOUNT DESC   ;

-- Q7. Find transactions whose amount is equal to the highest amount for their receiver_bank.
-- Display transaction_id, receiver_bank, amount.
-- Use a correlated subquery.
-- Sort by amount DESC.
SELECT  transaction_id, receiver_bank, amount
FROM upi_staging U 
WHERE  AMOUNT = (
SELECT MAX(US.AMOUNT) 
FROM upi_staging US 
WHERE U.receiver_BANK = US.receiver_BANK 
);

-- Q8. Find transactions whose amount is less than the average amount of their receiver_bank.
-- Display transaction_id, receiver_bank, amount.
-- Use a correlated subquery.
-- Sort by amount ASC.
SELECT  transaction_id, receiver_bank, amount
FROM upi_staging U 
WHERE  AMOUNT < (
SELECT AVG(US.AMOUNT) 
FROM upi_staging US 
WHERE U.receiver_BANK = US.receiver_BANK 
)
ORDER BY U.AMOUNT ASC ;


-- CTE_Analysis 
             
 -- Q1. Find all successful transactions.
-- Display transaction_id, amount, and transaction_status.

WITH SUCCESS_TRANS AS (
    SELECT transaction_id, amount, transaction_status
    FROM upi_staging
    WHERE transaction_status = 'SUCCESS'
)
SELECT *
FROM SUCCESS_TRANS;

-- Q2. Calculate total transactions for each sender_bank.
-- Display sender_bank and total_transactions.

WITH BANK_COUNT AS (
    SELECT sender_bank, COUNT(*) AS total_transactions
    FROM upi_staging
    GROUP BY sender_bank
)
SELECT *
FROM BANK_COUNT;

-- Q3. Find sender banks having more than 1000 transactions.
-- Display sender_bank and total_transactions.

WITH BANK_COUNT AS (
    SELECT sender_bank, COUNT(*) AS total_transactions
    FROM upi_staging
    GROUP BY sender_bank
)
SELECT *
FROM BANK_COUNT
WHERE total_transactions > 1000;

-- Q4. Categorize transactions as Low, Medium, and High.
-- Display transaction_id, amount, and amount_category.

WITH AMOUNT_CATEGORY AS (
    SELECT transaction_id, amount,
           CASE
               WHEN amount < 1000 THEN 'LOW'
               WHEN amount BETWEEN 1000 AND 5000 THEN 'MEDIUM'
               ELSE 'HIGH'
           END AS amount_category
    FROM upi_staging
)
SELECT *
FROM AMOUNT_CATEGORY;


-- Q5. Find banks having more than 500 failed transactions.
-- Display sender_bank and failed_transactions.

WITH FAILED_TRANS AS (
    SELECT sender_bank, COUNT(*) AS failed_transactions
    FROM upi_staging
    WHERE transaction_status = 'FAILED'
    GROUP BY sender_bank
)
SELECT *
FROM FAILED_TRANS
WHERE failed_transactions > 500;


-- Q6. Find transactions having an amount greater than
-- the overall average transaction amount.
-- Display transaction_id and amount.

WITH AVG_AMOUNT AS (
    SELECT AVG(amount) AS average_amount
    FROM upi_staging
)
SELECT transaction_id, amount
FROM upi_staging
WHERE amount > (SELECT average_amount FROM AVG_AMOUNT);


-- Q7. Find success percentage for each transaction_type.
-- Display transaction_type, total_transactions,
-- successful_transactions, and success_percentage.

WITH TOTAL_TRANS AS (
    SELECT transaction_type, COUNT(*) AS total_transactions
    FROM upi_staging
    GROUP BY transaction_type
),
SUCCESS_TRANS AS (
    SELECT transaction_type, COUNT(*) AS successful_transactions
    FROM upi_staging
    WHERE transaction_status = 'SUCCESS'
    GROUP BY transaction_type
)
SELECT T.transaction_type,
       T.total_transactions,
       S.successful_transactions,
       ROUND(S.successful_transactions * 100.0 /
             T.total_transactions, 2) AS success_percentage
FROM TOTAL_TRANS T
LEFT JOIN SUCCESS_TRANS S
ON T.transaction_type = S.transaction_type;


-- Q8. Find the top 3 highest-value transactions for each sender_bank.
-- Display transaction_id, sender_bank, and amount.

WITH BANK_RANK AS (
    SELECT transaction_id, sender_bank, amount,
           DENSE_RANK() OVER(
               PARTITION BY sender_bank
               ORDER BY amount DESC
           ) AS transaction_rank
    FROM upi_staging
)
SELECT transaction_id, sender_bank, amount
FROM BANK_RANK
WHERE transaction_rank <= 3;








