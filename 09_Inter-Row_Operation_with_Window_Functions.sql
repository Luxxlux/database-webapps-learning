-- Inter-Row Operation with Window Functions
SELECT first_name, last_name, date_added
FROM customers
ORDER BY date_added;

SELECT date_added, COUNT(*)
FROM customers
GROUP BY date_added
ORDER BY date_added;

-- The basics of window functions
SELECT first_name, last_name, gender,
	COUNT(*) OVER () AS total_customers
FROM customers;

SELECT COUNT(*) FROM customers;

SELECT first_name, last_name, gender,
COUNT(*) OVER (PARTITION BY gender)
FROM customers;

SELECT gender, COUNT(*)
FROM customers
GROUP BY gender;

SELECT first_name, last_name, gender,
COUNT(*) OVER (ORDER BY customer_id)
FROM customers;

SELECT first_name, last_name, gender,
COUNT(*) OVER (
	PARTITION BY gender
	ORDER BY customer_id
)
FROM customers;

-- Exercise 9.1: Analyzing Customer Data Fill Rates over Time
SELECT customer_id, date_added::DATE,
COUNT(CASE
		WHEN street_address IS NOT NULL THEN customer_id
		ELSE NULL
	END)
OVER (ORDER BY date_added::DATE) AS non_null_add,
COUNT(*) OVER (ORDER BY date_added::DATE) AS total_add
FROM customers;

WITH daily_rolling_count AS (
	SELECT 
	customer_id,
	date_added::DATE,
	COUNT(
		CASE
			WHEN street_address IS NOT NULL THEN customer_id
			ELSE NULL
		END
	) OVER (ORDER BY date_added::DATE) AS non_null_add,
	COUNT(*) OVER (ORDER BY date_added::DATE) AS total_add
	FROM customers
)
SELECT 
	DISTINCT date_added,
	non_null_add,
	total_add,
	ROUND(1 - 1.0* non_null_add/total_add, 6)
		AS null_address_percentage
FROM daily_rolling_count
ORDER BY date_added DESC;

-- Using advanced window definitions
-- Common window functions
SELECT first_name, last_name, gender,
	COUNT(*) OVER (
		PARTITION BY gender ORDER BY customer_id
	) AS total_customers,
	SUM(CASE WHEN title IS NOT NULL THEN 1 ELSE 0 END) OVER (
		PARTITION BY gender ORDER BY customer_id
	) AS total_customers_title
FROM customers;

SELECT first_name, last_name, gender,
	COUNT(*)
	OVER w AS total_customers,
	SUM(CASE WHEN title IS NOT NULL THEN 1 ELSE 0 END) 
	OVER w AS total_customers_title
FROM customers
WINDOW w AS (
	PARTITION BY gender
	ORDER BY customer_id
);

-- Window Frame






























