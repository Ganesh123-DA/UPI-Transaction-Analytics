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

             
 


