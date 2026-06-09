/**************************************************************************
CHAPTER 3 – EXCHANGING DATA USING COPY
**************************************************************************/

/*
Exercise 3.1

Export the contents of the customers table to a CSV file.

Requirements:
- CSV format
- Include column headers
- Use commas as delimiters

Questions:
- Which PostgreSQL command exports data to a file?
- Can that command export a query result instead of a whole table?
- Where is the file written?
*/

COPY customers TO '/Users/laimis/Desktop/SQL learning/customers.csv' WITH CSV HEADER DELIMITER ',';
-- Q3.1 A: COPY
-- Q3.1 B: Yes it can, the command would be (I've introduced a limit here) and (run in terminal):
-- COPY (SELECT * FROM customers LIMIT 5) TO STDOUT WITH CSV HEADER;
-- Q3.1 B cont.: It would print to the terminal

/*
Activity 3 – Task 1

Export data from the salespeople table.

Questions:
- Do you need all rows or only a subset?
- Which command exports data from PostgreSQL?
*/

COPY salespeople TO '/Users/laimis/Desktop/SQL learning/salespeople.csv' WITH CSV HEADER DELIMITER ',' QUOTE '"';

/*
Activity 3 – Task 3

Replace real names with anonymised values.

Questions:
- How could names be transformed so they are no longer readable?
- What are the advantages and disadvantages of hashing?
*/

CREATE TABLE salespeople_temp AS (SELECT * FROM salespeople LIMIT 10);

UPDATE salespeople_temp
SET (first_name, last_name) = (md5(first_name), md5(last_name));

SELECT * FROM salespeople_temp;

COPY salespeople_temp TO '/Users/laimis/Desktop/SQL learning/salespeople_sample.csv' WITH CSV HEADER DELIMITER ',' NULL '' QUOTE '"';

DROP TABLE salespeople_temp;

/*
Activity 3 – Task 5

Import the modified CSV file into the new table.

*/

CREATE TABLE salespeople_anon (LIKE salespeople);
SELECT * FROM salespeople_anon;

COPY salespeople_anon FROM '/Users/laimis/Desktop/SQL learning/salespeople_sample.csv' WITH CSV HEADER DELIMITER ',' NULL '' QUOTE '"';
SELECT * FROM salespeople_anon;
-- DROP TABLE salespeople_anon;
