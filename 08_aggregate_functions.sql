-- Aggregating Data with GROUP BY
SELECT MAX(hire_date) FROM salespeople;

SELECT COUNT(*) FROM customers WHERE state='CA';

SELECT COUNT(*)/2 FROM customers;

SELECT SUM(base_msrp)/COUNT(*) AS avg_base_msrp
FROM products;

SELECT AVG(base_msrp) AS avg_base_msrp
FROM products;

SELECT COUNT(customer_id) FROM customers;

SELECT COUNT(*) FROM customers;

SELECT COUNT(state) FROM customers;

SELECT COUNT(DISTINCT state) FROM customers;

SELECT 
	(COUNT(customer_id)::numeric
	/ COUNT(DISTINCT state)) 
		AS Average_customers_per_state
FROM customers;

SELECT 
	(COUNT(customer_id) * 1.0	/ COUNT(DISTINCT state)) 
		AS Average_customers_per_state
FROM customers;

SELECT 
	COUNT(customer_id) / COUNT(DISTINCT state)
		AS Average_customers_per_state
FROM customers;

-- Exercise 8.1: Using aggregate functions to analyze data
SELECT
	MIN(base_msrp),
	MAX(base_msrp),
	AVG(base_msrp),
	STDDEV(base_msrp)
FROM products;

-- Aggregating with GROUP BY clause
SELECT DISTINCT state FROM customers;

SELECT COUNT(*) FROM customers
WHERE state='{state}'; -- {state} for illustration purposes

	-- The GROUP BY clause
SELECT state, COUNT(*) 
FROM customers 
GROUP BY state;

SELECT TO_CHAR(date_added, 'YYYY'), COUNT(*)
FROM customers
GROUP BY TO_CHAR(date_added, 'YYYY')
ORDER BY 1 DESC;

SELECT TO_CHAR(date_added, 'YYYY'), COUNT(*)
FROM customers
GROUP BY 1
ORDER BY 1 DESC;

SELECT state, COUNT(*)
FROM customers
GROUP BY state
ORDER BY state;

SELECT state, COUNT(*)
FROM customers
GROUP BY 1
ORDER BY 1;

SELECT state, COUNT(*)
FROM customers
GROUP BY state
ORDER BY COUNT(*) ASC;

SELECT state, COUNT(*)
FROM customers
WHERE gender='M'
GROUP BY state
ORDER BY state;

SELECT state, gender, COUNT(*)
FROM customers
GROUP BY state, gender
ORDER BY state, COUNT(*) DESC;

-- Exercise 8.2: Calculating the cost by product type using GROUP BY
SELECT
	product_type,
	MIN(base_msrp),
	MAX(base_msrp),
	AVG(base_msrp),
	STDDEV(base_msrp)
FROM products
GROUP BY product_type;

-- Grouping sets
	SELECT state, NULL AS gender, COUNT(*)
	FROM customers
	GROUP BY 1, 2
UNION ALL
	SELECT state, gender, COUNT(*)
	FROM customers
	GROUP BY 1, 2;

SELECT state, gender, COUNT(*)
FROM customers
GROUP BY GROUPING SETS (
	(state), (state, gender)
);

-- Ordered set aggregates
SELECT
	PERCENTILE_CONT(0.5)
		WITHIN GROUP (ORDER BY base_msrp) AS median
FROM products;

-- Exercise 8.3: Calculating and displaying data using the HAVING clause
SELECT
	state, COUNT(*)
FROM customers
GROUP BY state
HAVING COUNT(*) >= 1000
ORDER BY COUNT(*) DESC;

-- Activity 8
-- Please help your business users with the following requests:
-- 1. The business users would like to calculate the total number of unit sales the company has made.
SELECT COUNT(product_id)
FROM sales;


-- 2. They also want to calculate the total sales amount in dollars for the states of New Jersey, California, and Florida. 
-- The sales of each state should be reported separately.
SELECT c.state,
	SUM(sales_amount) AS total_sales_amount
FROM sales s
INNER JOIN customers c
	ON c.customer_id = s.customer_id
WHERE c.state IN ('CA', 'NJ', 'FL')
GROUP BY c.state
ORDER BY 2;


-- 3. Finally, they would like to filter out the state where the total sales are less than $10M ($10,000,000).
SELECT c.state,
	SUM(sales_amount) AS total_sales_amount
FROM customers c
INNER JOIN sales s
	ON c.customer_id = s.customer_id
WHERE c.state IS NOT NULL
GROUP BY c.state
HAVING SUM(sales_amount) >= 10000000;
