-- Exercise 10.1: Interpreting the query planner
EXPLAIN SELECT * FROM emails;

EXPLAIN SELECT * FROM emails LIMIT 5;

EXPLAIN
SELECT * FROM emails
WHERE clicked_date
	BETWEEN '2014-01-01' AND '2013-02-01';

CREATE INDEX ix_customers ON customers
USING BTREE(customer_id);

-- Exercise 10.2: Creating an index scan
EXPLAIN SELECT * FROM customers WHERE state='FO';

EXPLAIN SELECT DISTINCT state FROM customers;

CREATE INDEX ix_state ON customers(state);

EXPLAIN SELECT * FROM customers WHERE state='FO';

EXPLAIN SELECT * FROM customers WHERE gender='M';

CREATE INDEX ix_gender ON customers(gender);
-- DROP INDEX ix_gender;
EXPLAIN SELECT * FROM customers WHERE gender='M';

EXPLAIN SELECT * FROM customers
WHERE (latitude < 38) AND (latitude > 30);

CREATE INDEX ix_latitude ON customers(latitude);

EXPLAIN SELECT * FROM customers
WHERE (latitude < 38) AND (latitude > 30);

EXPLAIN ANALYSE
SELECT * FROM customers
WHERE (latitude < 38) AND (latitude > 30);

CREATE INDEX ix_latitude_less
ON customers(latitude)
WHERE (latitude < 38) AND (latitude > 30);

EXPLAIN ANALYSE
SELECT * FROM customers
WHERE (latitude < 38) AND (latitude > 30);

-- The hash index
-- Exercise 10.3: Generating hash indexes to investigate performance
DROP INDEX ix_gender;
DROP INDEX ix_state;
DROP INDEX ix_latitude;
DROP INDEX ix_latitude_less;

EXPLAIN ANALYZE
SELECT * FROM customers
WHERE gender='M';

CREATE INDEX ix_gender ON customers
USING btree(gender);

EXPLAIN ANALYZE
SELECT * FROM customers
WHERE gender='M';

DROP INDEX ix_gender;
CREATE INDEX ix_gender ON customers
USING HASH(gender);

EXPLAIN ANALYZE
SELECT * FROM customers
WHERE gender='M';

EXPLAIN ANALYZE
SELECT * FROM customers
WHERE state='F0';

CREATE INDEX ix_state ON customers
USING HASH(state);

EXPLAIN ANALYZE
SELECT * FROM customers
WHERE state='F0';

-- Activity 10
SELECT *
FROM sales
WHERE (customer_id = 1);

SELECT *
FROM sales
WHERE (customer_id < 100);

--
EXPLAIN ANALYSE
SELECT *
FROM sales
WHERE (customer_id = 1);

EXPLAIN ANALYSE
SELECT *
FROM sales
WHERE (customer_id < 100);

--

DROP INDEX ix_sales;

CREATE INDEX ix_sales 
ON sales 
USING BTREE(customer_id);

EXPLAIN ANALYSE
SELECT *
FROM sales
WHERE (customer_id = 1);

EXPLAIN ANALYSE
SELECT *
FROM sales
WHERE (customer_id < 100);

--

DROP INDEX ix_sales;

CREATE INDEX ix_sales
ON sales
USING HASH(customer_id);

EXPLAIN ANALYSE
SELECT * 
FROM sales
WHERE (customer_id = 1);

EXPLAIN ANALYSE
SELECT *
FROM sales
WHERE (customer_id < 100);
