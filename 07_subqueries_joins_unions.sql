SELECT * FROM dealerships;
SELECT * FROM salespeople;

SELECT dealership_id
FROM dealerships
WHERE state='CA';

SELECT * FROM salespeople
WHERE dealership_id IN (2, 5);

SELECT * FROM salespeople
WHERE dealership_id IN (
	SELECT dealership_id
	FROM dealerships
	WHERE state='CA'
);

SELECT * FROM (
	SELECT * FROM salespeople
	WHERE termination_date IS NULL
	) AS s
WHERE dealership_id IN (
	SELECT dealership_id FROM dealerships
	WHERE dealerships.state = 'CA'
);

WITH s AS (
	SELECT * FROM salespeople
	WHERE termination_date IS NULL
)
SELECT * FROM s
WHERE dealership_id IN (
	SELECT dealership_id FROM dealerships
	WHERE dealerships.state = 'CA'
);


-- Example of self referencing, will throw error
WITH s AS (
	SELECT * FROM salespeople
	WHERE termination_date IS NULL
), s_CA as (
	SELECT * FROM s
	WHERE dealership_id IN (
		SELECT dealership_id FROM dealerships	
		WHERE dealership.state = 'CA'
	)
);

CREATE VIEW active_salespeople AS (
	SELECT * FROM salespeople
	WHERE termination_date IS NULL
);

SELECT * FROM active_salespeople
WHERE dealership_id IN (
	SELECT dealership_id FROM dealerships
	WHERE dealerships.state = 'CA'
);

-- Exercise 7.1: Utilizing subqueries
SELECT first_name, last_name, email
FROM customers
WHERE state IN (
	SELECT state FROM dealerships
);

WITH c AS (
	SELECT first_name, last_name, state, email
	FROM customers
	WHERE phone IS NOT NULL
)
SELECT first_name, last_name, email
FROM c
WHERE state IN (
	SELECT DISTINCT state from dealerships
);

CREATE VIEW reachable_customer AS (
	SELECT first_name, last_name, state, email
	FROM customers
	WHERE phone IS NOT NULL
);

SELECT first_name, last_name, email
FROM reachable_customer
WHERE state IN (
	SELECT DISTINCT state FROM dealerships
);

-- Joining tables
SELECT *
FROM salespeople
INNER JOIN dealerships
	ON salespeople.dealership_id = dealerships.dealership_id;

SELECT * 
FROM salespeople;

SELECT * 
FROM dealerships;

SELECT *
FROM salespeople
INNER JOIN dealerships
	ON salespeople.dealership_id = dealerships.dealership_id
WHERE dealerships.state = 'CA';

SELECT salespeople.*
FROM salespeople
INNER JOIN dealerships
	ON dealerships.dealership_id = salespeople.dealership_id
WHERE dealerships.state = 'CA';

-- Cross joins
SELECT 
p1.product_id, p1.model, p2.product_id, p2.model
FROM products p1
CROSS JOIN products p2;

-- Exercise 7.2
SELECT 
c.customer_id, c.first_name, c.last_name, p.model
FROM sales s
INNER JOIN customers c
	ON c.customer_id = s.customer_id
INNER JOIN products p
	ON p.product_id = s.product_id
WHERE p.product_type = 'automobile'
	AND c.phone IS NOT NULL;

-- Running set operations
SELECT street_address, city, state, postal_code
FROM customers
WHERE street_address IS NOT NULL;

SELECT street_address, city, state, postal_code
FROM dealerships
WHERE street_address IS NOT NULL;

	SELECT street_address, city, state, postal_code
	FROM customers 
	WHERE street_address IS NOT NULL
UNION
	SELECT street_address, city, state, postal_code
	FROM dealerships
	WHERE street_address IS NOT NULL;

SELECT * FROM products
UNION
SELECT * FROM products
ORDER BY 1;

SELECT * FROM products
UNION ALL
SELECT * FROM products
ORDER BY 1;

-- Exercise 7.3
	SELECT first_name, last_name,
	'Customer' as guest_type
	FROM customers
	WHERE city='Los Angeles' AND state='CA'
UNION
	SELECT first_name, last_name
	'Employee' as guest_type
	FROM salespeople s
	INNER JOIN dealerships d
		ON d.dealership_id = s.dealership_id
	WHERE d.city = 'Los Angeles' A

-- Activity 7
SELECT
	c.*,
	s.*
FROM customers c
INNER JOIN sales s
	ON c.customer_id = s.customer_id
ORDER BY c.customer_id;

SELECT
	c.*,
	s.*,
	p.*
FROM customers c
INNER JOIN sales s
	ON c.customer_id = s.customer_id
INNER JOIN products p
	ON p.product_id = s.product_id
ORDER BY c.customer_id;

SELECT
	s.*,
	d.*
FROM sales s
LEFT JOIN dealerships d
	ON s.dealership_id = d.dealership_id
ORDER BY s.channel DESC, s.product_id;
