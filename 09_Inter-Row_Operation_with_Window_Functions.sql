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

SELECT gender, COUNT(*) FROM customers GROUP BY 1;

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
-- The company would like a running total of how many users have filled in their street addresses over time
SELECT 
	customer_id,
	date_added::DATE,
	COUNT(
		CASE
			WHEN street_address IS NOT NULL THEN customer_id
			ELSE NULL
		END
	) OVER (ORDER BY date_added) AS non_null_add,
	COUNT(*) OVER (ORDER BY date_added)
FROM customers
ORDER BY date_added;


-- Write a query to see how the numbers of people filling out the street field change over time.
WITH daily_rolling_count AS (
	SELECT
		customer_id,
		date_added::DATE,
		COUNT(
			CASE 
			WHEN street_address IS NOT NULL THEN customer_id
			ELSE NULL
			END
		) OVER (ORDER BY date_added) AS non_null_add,
		COUNT(*) OVER (ORDER BY date_added) AS total_add
	FROM customers
	ORDER BY date_added
)
SELECT 
	DISTINCT 
	date_added,
	non_null_add,
	total_add,
	1 - (((1.0 * non_null_add) / total_add)) AS daily_rolling_count
FROM daily_rolling_count
ORDER BY date_added DESC;

-- Using advanced window definitions