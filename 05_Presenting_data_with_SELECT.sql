SELECT product_id, model, base_msrp FROM products;

SELECT 1 FROM products;

SELECT model, base_msrp * 0.9 FROM products;

SELECT model, base_msrp *0.9 AS Discounted_Price
FROM products;

SELECT model Product_Name,
0.9 Discount,
base_msrp * 0.9 Discounted_Price
FROM products;

SELECT * FROM products LIMIT 5;

SELECT model, production_start_date
FROM products
ORDER BY production_start_date;

SELECT model, year
FROM products
WHERE year = 2017
OR year = 2019
OR year = 2022;

SELECT model, year
FROM products
WHERE year IN (2017, 2019, 2022);

SELECT model, year
FROM products
WHERE year NOT IN (2017, 2019, 2022);

SELECT model, production_end_date
FROM products
WHERE production_end_date IS NULL;

SELECT model, production_end_date
FROM products
WHERE production_end_date IS NOT NULL;

-- Exercise 5.1
SELECT * FROM customers LIMIT 3;

SELECT first_name, last_name, date_added
FROM customers 
ORDER BY date_added DESC
LIMIT 3;

SELECT first_name, last_name, date_added
FROM customers
WHERE date_added IS NULL
LIMIT 3;

SELECT DISTINCT state FROM customers;

SELECT first_name, last_name, state, date_added
FROM customers
WHERE state IN ('CA', 'FL')
AND date_added >= '01/01/2025'
LIMIT 3;

-- Activity 5

-- 5.1
-- Pull all salespeople hired in 2024 and 2025 who have not been terminated.
-- Order by hire_date, latest first.

SELECT first_name, last_name, hire_date
FROM salespeople
WHERE (hire_date >= '2024/01/01' AND hire_date < '2026/01/01')
AND termination_date IS NULL
ORDER BY hire_date DESC;


-- 5.2
-- Pull first names, last names, and emails for ZoomZoom customers in New York City, NY.
-- Order alphabetically: last name first, then first name.

SELECT first_name, last_name, email, city
FROM customers
WHERE city = 'New York City'
ORDER BY last_name, first_name;


-- 5.3
-- Return all customers with a phone number.
-- Order by the date the customer was added to the database.

SELECT first_name, last_name, phone, date_added
FROM customers
WHERE phone IS NOT NULL
ORDER BY date_added;



