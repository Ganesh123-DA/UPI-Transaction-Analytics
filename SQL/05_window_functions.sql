
-- Q1. Find the top 3 highest transactions for each sender_bank.
-- Display transaction_id, sender_bank, and amount.
-- Use DENSE_RANK() to rank transactions. 
SELECT transaction_id, sender_bank, amount
FROM(
SELECT transaction_id, sender_bank, amount,
dense_rank()OVER(partition by sender_bank order by amount DESC ) AS RN
FROM upi_staging
)i
WHERE RN <= 3;

-- Q2. Rank sender banks based on their total transaction amount.
-- Display sender_bank and total_amount.
-- Use DENSE_RANK() to rank the banks.
SELECT sender_bank,
	   sum(amount)over(partition by sender_bank );
       
-- Q3. Find the highest transaction for each transaction type.
-- Display transaction_id, transaction_type, and amount.

SELECT transaction_id, transaction_type, amount
FROM (
    SELECT transaction_id, transaction_type, amount,
           ROW_NUMBER() OVER(
               PARTITION BY transaction_type
               ORDER BY amount DESC
           ) AS rn
    FROM upi_staging
) t
WHERE rn = 1;

-- Q4. Rank all transactions based on their amount.
-- Display transaction_id, amount, and transaction_rank.

SELECT transaction_id, amount,
       RANK() OVER(ORDER BY amount DESC) AS transaction_rank
FROM upi_staging;


-- Q5. Display each transaction with its previous transaction amount.
-- Use LAG() based on timestamp.

SELECT transaction_id, `timestamp`, amount,
       LAG(amount) OVER(ORDER BY `timestamp`) AS previous_amount
FROM upi_staging;

-- Q6. Display each transaction with its next transaction amount.
-- Use LEAD() based on timestamp.

SELECT transaction_id, `timestamp`, amount,
       LEAD(amount) OVER(ORDER BY `timestamp`) AS next_amount
FROM upi_staging;


-- Q7. Calculate the running total of transaction amounts.
-- Display transaction_id, amount, and running_total.

SELECT transaction_id, amount,
       SUM(amount) OVER(
           ORDER BY `timestamp`, transaction_id
       ) AS running_total
FROM upi_staging;


-- Q8. Calculate the average transaction amount for each sender_bank.
-- Display transaction_id, sender_bank, amount, and average_amount.

SELECT transaction_id, sender_bank, amount,
       ROUND(AVG(amount) OVER(
           PARTITION BY sender_bank
       ), 2) AS average_amount
FROM upi_staging;


-- Q9. Divide transactions into 4 groups based on amount.
-- Display transaction_id, amount, and transaction_group.

SELECT transaction_id, amount,
       NTILE(4) OVER(ORDER BY amount DESC) AS transaction_group
FROM upi_staging;

       
-- Q10. Find the first transaction amount for each sender_bank.
-- Display transaction_id, sender_bank, amount, and first_amount.

SELECT transaction_id, sender_bank, amount,
       FIRST_VALUE(amount) OVER(
           PARTITION BY sender_bank
           ORDER BY `timestamp`
       ) AS first_amount
FROM upi_staging;       
