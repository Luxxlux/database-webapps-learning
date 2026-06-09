/**************************************************************************
CHAPTER 2 – CREATING TABLES WITH SOLID STRUCTURES
**************************************************************************/

/*
Exercise 2.1A

Create a table called products_new that has the same columns
as products.

Questions:
- How can you inspect the structure of products?
- Which data types are required?
- How do you create a table manually?
*/

/* solution:

-- terminal:
-- psql -U laimis -d sqlda
-- \d products

                               Table "public.products"
        Column         |            Type             | Collation | Nullable | Default 
-----------------------+-----------------------------+-----------+----------+---------
 product_id            | bigint                      |           |          | 
 model                 | text                        |           |          | 
 year                  | bigint                      |           |          | 
 product_type          | text                        |           |          | 
 base_msrp             | numeric                     |           |          | 
 production_start_date | timestamp without time zone |           |          | 
 production_end_date   | timestamp without time zone |           |          | 
Indexes:
    "ix_products_product_id" btree (product_id)


*/
CREATE TABLE products_new (
product_id bigint,
model text,
year bigint,
product_type text,
base_msrp numeric,
production_start_date timestamp,
production_end_date timestamp
);

-- DROP TABLE products_new;
--SELECT * FROM products_new;


/*
Exercise 2.1B

Create another table called products_new_2.

Requirements:
- Use a single SQL statement.
- Copy both the structure and all rows from products.
*/

CREATE TABLE products_new_2 AS (SELECT * FROM products);

SELECT * FROM products_new_2;


/*
Exercise 2.2A

Insert several rows manually into products_new.

Questions:
- Which command adds rows to a table?
- How are values supplied for each column?
*/

INSERT INTO products_new (product_id, model, year, product_type, base_msrp, production_start_date, production_end_date)
VALUES (13, 'Nimbus 5000', 2017, 'scooter', 500.00, '2017-03-03', '2023-03-03'),
(14, 'Nimbus 6900', 2019, 'scooter', 650.00, '2018-03-03','2024-03-03');


SELECT * FROM products_new;
-- DROP TABLE products_new;

/*
Exercise 2.2B

Populate products_new using rows already stored in products.

Questions:
- Can rows be inserted from a SELECT statement?
- How can data be copied from one table into another?
*/

INSERT INTO products_new (SELECT * FROM products LIMIT 5);
SELECT * FROM products_new;

/*
Exercise 2.3A

Delete one of the temporary tables.

Question:
- What is the difference between deleting rows and deleting
  the whole table?
*/

DROP TABLE products_new;
-- deleting rows will delete the entries within the table
-- deleting a whole table will remove all of the data there including the schema

/*
Exercise 2.3B

Delete the second temporary table safely.

Requirement:
- The statement should not fail if the table has already been removed.
*/

DROP TABLE IF EXISTS products_new_2;