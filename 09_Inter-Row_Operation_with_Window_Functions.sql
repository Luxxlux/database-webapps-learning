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
	COUNT(*) OVER w AS total_customers,
	SUM(CASE WHEN title IS NOT NULL THEN 1 ELSE 0 END)
		OVER w AS total_customers_title
FROM customers
WINDOW w AS (
	PARTITION BY gender
	ORDER BY customer_id
);

-- Window frame
WITH 
	daily_sales AS (
		SELECT
		sales_transaction_date::DATE,
		SUM(sales_amount) AS total_sales
		FROM sales
		GROUP BY 1
	),
	moving_average_calculation_7 AS (
		SELECT 
			sales_transaction_date,
			total_sales,
			AVG(total_sales) OVER (
				ORDER BY sales_transaction_date
				ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
			) AS sales_moving_average_7,
		ROW_NUMBER() OVER (
			ORDER BY sales_transaction_date
		) AS row_number
		FROM daily_sales
		ORDER BY 1
	)
SELECT 
	sales_transaction_date,
	CASE
		WHEN row_number>=7 THEN sales_moving_average_7
		ELSE NULL
	END
FROM
	moving_average_calculation_7;

-- Exercise 9.2: Team Lunch Motivation
SELECT * FROM sales;

WITH
	daily_sales AS (
		SELECT 
			sales_transaction_date::DATE,
			SUM(sales_amount) AS total_sales
		FROM sales
		GROUP BY 1
	),
	sales_stats_30 AS (
		SELECT
			sales_transaction_date,
			total_sales,
			MAX(total_sales) OVER (
				ORDER BY sales_transaction_date
				ROWS BETWEEN 30 PRECEDING AND 1 PRECEDING
			) AS max_sales_30
		FROM daily_sales
		ORDER BY 1
	)
SELECT 
	sales_transaction_date,
	total_sales,
	max_sales_30
FROM sales_stats_30
WHERE sales_transaction_date>='2021-12-31';

WITH 
	daily_sales AS (
		SELECT
			sales_transaction_date::DATE,
			SUM(sales_amount) AS total_sales
		FROM sales
		GROUP BY 1
	),
	sales_stats_30 AS (
		SELECT
			sales_transaction_date,
			total_sales,
			MAX(total_sales) OVER (
				ORDER BY sales_transaction_date
				ROWS BETWEEN 30 PRECEDING AND 1 PRECEDING
			) AS max_sales_30
		FROM
			daily_sales
		ORDER BY 1
	)
SELECT
	sales_transaction_date,
	total_sales,
	max_sales_30
FROM sales_stats_30
WHERE total_sales > max_sales_30
AND sales_transaction_date >= '2021-12-31';

-- Activity 9
SELECT * FROM sales;

WITH daily_sales AS (
	SELECT
		sales_transaction_date::DATE, 
		SUM(sales_amount) AS total_daily_sales
	FROM sales
	GROUP BY 1
),
day_30_average AS (
	SELECT 
		sales_transaction_date,
		total_daily_sales,
		AVG(total_daily_sales) OVER (
			ORDER BY sales_transaction_date
			ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
		) AS running_30_day_avg
	FROM daily_sales
	),
decile_calc AS (
	SELECT
		sales_transaction_date,
		total_daily_sales,
		running_30_day_avg,
		NTILE(10) OVER (
			ORDER BY running_30_day_avg
		) AS decile
	FROM day_30_average
	WHERE sales_transaction_date>='2024-01-01' AND sales_transaction_date<'2025-01-01'
)
SELECT 
	sales_transaction_date,
	ROUND(running_30_day_avg::NUMERIC, 2) AS running_30_day_avg,
	decile
FROM decile_calc
ORDER BY sales_transaction_date;
