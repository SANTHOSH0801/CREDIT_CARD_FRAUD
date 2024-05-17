-- Large Transactions
SELECT id, date, amount, id_merchant,card
FROM transaction
WHERE amount > 10000; -- Adjust the threshold value as needed

-- Rapid Succession Transactions
SELECT id, COUNT(id) as transaction_count, MIN(date) as first_transaction, MAX(date) as last_transaction
FROM transaction
GROUP BY id
HAVING COUNT(id) > 5 AND TIMESTAMPDIFF(MINUTE, MIN(date), MAX(date)) < 60;


-- Transactions Just Below Reporting Threshold
SELECT id, id_merchant, amount, date
FROM transaction
WHERE amount BETWEEN 9000 AND 10000; -- Threshold value should be set based on the specific reporting requirement

-- Multiple Transactions to the Same Receiver
SELECT id_merchant, COUNT(id) as transaction_count, SUM(amount) as total_amount
FROM transaction
GROUP BY id_merchant
HAVING COUNT(id) > 5 AND SUM(amount) > 10000; -- Adjust the count and amount as needed


-- IF COUNTRY_DATA IS PRESENT
-- Transactions to High-Risk Countries
SELECT id, id_merchant, amount, date, receiver_country
FROM transaction
WHERE receiver_country IN ('Country1', 'Country2'); -- List high-risk countries


-- High-Frequency Low-Amount Transactions 
SELECT id, COUNT(id) as transaction_count, SUM(amount) as total_amount
FROM transaction
WHERE amount < 500 -- Adjust the amount threshold as needed
GROUP BY id
HAVING COUNT(id) > 10 AND SUM(amount) > 10000; -- Adjust the count and total amount as needed


-- Transactions with Negative Balances
SELECT t.id, t.amount, a.balance
FROM transaction
JOIN accounts a ON t.sender_id = a.account_id
WHERE a.balance < 0;

-- IF HOURS DATA PRESENT IN THE TABLE
-- Transactions During Unusual Hours
SELECT id, id_merchant, amount, date
FROM transactions
WHERE HOUR(date) BETWEEN 0 AND 5; -- Time range for unusual hours


