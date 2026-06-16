UPDATE products
SET base_msrp = 299.99
WHERE product_type = 'scooter'
AND year < 2021;

UPDATE products
SET base_msrp = base_msrp * 0.9
WHERE product_type = 'scooter'
AND year < 2021;

-- DELETE FROM products
-- WHERE product_type = 'scooter';

-- DELETE FROM products;
-- TRUNCATE TABLE products;

SELECT * FROM products;

COPY products FROM '/Users/laimis/Desktop/products_recovery.csv' WITH HEADER DELIMITER '|' NULL 'NULL';
SELECT * FROM products;

-- Exercise 6.1: Updating and deleting data
CREATE TABLE products_2025 AS (
SELECT DISTINCT * FROM products
WHERE year=2025
);

SELECT EXISTS (
SELECT FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name = 'products_2025'
);

UPDATE products_2025
SET base_msrp = base_msrp * 1.10
WHERE model = 'Model Chi'
AND year=2025;

SELECT model, year, base_msrp
FROM products_2025;

DELETE FROM products_2025
WHERE model = 'Lemon Zester';

SELECT model, year, base_msrp
FROM products_2025;

DROP TABLE products_2025;

-- Running data transformation functions
SELECT
	CASE
		WHEN postal_code='33111' THEN 'Elite Customer'
		WHEN postal_code='33124' THEN 'Premium Customer'
		ELSE 'Standard Customer'
	END AS customer_type,
	COUNT(*) AS customer_count
FROM customers
GROUP BY customer_type;

SELECT 
	first_name, last_name,
	COALESCE(phone, 'NO PHONE') AS phone
FROM customers;

SELECT customer_id,
	NULLIF(title, 'Honorable') AS title,
	first_name, last_name
FROM customers c;

SELECT 
	NULLIF(title, 'Honorable') AS cleaned_title,
	COUNT(*) AS title_count
FROM customers
GROUP BY NULLIF(title, 'Honorable');

-- Exercise 6.2
SELECT
	first_name || ' ' || last_name AS Name, 
	hire_date,
	EXTRACT(day FROM Current_Timestamp - hire_date) AS DaysServed
FROM salespeople
ORDER BY DaysServed DESC
LIMIT 3;

SELECT model,
	CASE
		WHEN production_end_date IS NULL THEN 'Active'
		ELSE 'Inactive'
	END AS product_status
FROM products;

SELECT * FROM sales;

SELECT * FROM sales
WHERE COALESCE(NULLIF(channel, 'dealership'), dealership_id::TEXT) IS NULL;

-- Exercise 6.3 Creating functions with arguments (in terminal)

/*
sqlda=# CREATE FUNCTION longest_serving_salespeople(dealership INT)
sqlda-# RETURNS numeric AS $serving$
sqlda$# DECLARE salespersonid numeric;
sqlda$# 
sqlda$# BEGIN
sqlda$# SELECT salesperson_id
sqlda$# FROM salespeople
sqlda$# INTO salespersonid
sqlda$# WHERE dealership_id = dealership
sqlda$# ORDER BY hire_date ASC
sqlda$# LIMIT 1;
sqlda$# 
sqlda$# RETURN salespersonid;
sqlda$# END; $serving$
sqlda-# LANGUAGE PLPGSQL;
CREATE FUNCTION
sqlda=# \df
                                  List of functions
 Schema |            Name             | Result data type | Argument data types | Type 
--------+-----------------------------+------------------+---------------------+------
 public | longest_serving_salespeople | numeric          | dealership integer  | func
(1 row)
~
~
~
~
~
~
~
~

sqlda=# SELECT longest_serving_salespeople(1);
 longest_serving_salespeople 
-----------------------------
                          65
(1 row)

sqlda=# \sf longest_serving_salespeople
CREATE OR REPLACE FUNCTION public.longest_serving_salespeople(dealership integer)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE salespersonid numeric;

BEGIN
SELECT salesperson_id
FROM salespeople
INTO salespersonid
WHERE dealership_id = dealership
ORDER BY hire_date ASC
LIMIT 1;

RETURN salespersonid;
END; $function$
sqlda=# DROP FUNCTION longest_serving_salespeople;
DROP FUNCTION
*/

-- Changing the table definition
ALTER TABLE products ADD COLUMN weight INT;
SELECT * FROM products LIMIT 3;

ALTER TABLE products DROP COLUMN weight;
SELECT * FROM products LIMIT 3;

ALTER TABLE products
ALTER COLUMN year TYPE decimal(10,0);

ALTER TABLE products
ALTER COLUMN year TYPE INT;

SELECT * FROM products;

-- Activity 6.1

-- Precursers
DROP TABLE IF EXISTS products_new;
CREATE TABLE products_new AS SELECT * FROM products;



-- Function

DROP TABLE IF EXISTS products_new;
CREATE TABLE products_new AS
SELECT * FROM products;

CREATE OR REPLACE FUNCTION update_products()
RETURNS void
AS $$

BEGIN



ALTER TABLE products_new ADD COLUMN last_update_date TIMESTAMP WITHOUT TIME ZONE;

UPDATE products_new
SET last_update_date = '2999-01-01'
WHERE last_update_date IS NULL;

DELETE FROM products_new
WHERE production_end_date IS NOT NULL
OR production_start_date < '2020-01-01';

UPDATE products_new
SET production_end_date = last_update_date
WHERE production_end_date IS NULL;



RETURN;

END;
$$ LANGUAGE plpgsql;

SELECT update_products();
SELECT * FROM products_new;


-- Activity 6.2
SELECT last_name, first_name, email 
FROM customers
ORDER BY last_name;

-- Activity 6.3
SELECT *
FROM customers
WHERE phone IS NOT NULL
ORDER BY date_added;

