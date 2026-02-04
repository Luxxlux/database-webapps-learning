CREATE TABLE char_data_types (
    char_column char(10),
    varchar_column varchar(10),
    text_column text
);

INSERT INTO char_data_types
VALUES 
    ('abc', 'abc', 'abc'),
    ('defghi', 'defghi', 'defghi');

COPY char_data_types TO '/Users/laimis/Desktop/typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

CREATE TABLE people (
    id serial,
    person_name varchar(100)
);

SELECT *
FROM people;

DROP TABLE people;

CREATE TABLE people (
    id integer GENERATED ALWAYS AS IDENTITY,
    person_name varchar(100)
);

CREATE TABLE number_data_types (
    numeric_column numeric(20,5),
    real_column real,
    double_column double precision
);

INSERT INTO number_data_types
VALUES
    (.7,.7,.7),
    (2.13579, 2.13579, 2.13579),
    (2.1357987654, 2.1357987654, 2.1357987654);

SELECT * FROM number_data_types;

SELECT 
    numeric_column * 10000000 AS fixed,
    real_column * 10000000 AS floating
FROM number_data_types
WHERE numeric_column = .7;

CREATE TABLE date_time_types (
    timestamp_column timestamp with time zone,
    interval_column interval
);

INSERT INTO date_time_types
VALUES
    ('2022-12-31 01:00 EST', '2 days'),
    ('2022-12-31 01:00 -8', '1 month'),
    ('2022-12-31 01:00 Australia/Melbourne', '1 century'),
    (now(), '1 week');

SELECT * FROM date_time_types;

SELECT 
    timestamp_column,
    interval_column,
    timestamp_column - interval_column AS new_date
FROM date_time_types;

SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM date_time_types;

SELECT numeric_column,
    CAST(numeric_column AS integer),
    CAST(numeric_column AS text)
FROM number_data_types;

SELECT CAST(char_column AS integer) FROM char_data_types;

SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM date_time_types;

SELECT timestamp_column::varchar(10)
FROM date_time_types;

-- Your company delivers fruit and vegetables to local grocery stores, and you need to track the mileage driven by each driver each day to a tenth of a mile. Assuming no driver would ever travel more than 999 miles in a day, what would be an appropriate data type for the mileage column in your table? Why?
-- Answer: descimal(4,1), this provides whats needed without creating fantom errors

-- In the table listing each driver in your company, what are appropriate data types for the drivers’ first and last names?
-- Answer: varchar(50), this would create a long enough datatype that won't be problematic for users, increase performance, and prevents large texts that are not names from being inserted

-- Why is it a good idea to separate first and last names into two columns rather than having one larger name column?
-- Answer: easier to differentiate between first names and last names, makes searching by first or last names possible (making the data atomic).

-- Assume you have a text column that includes strings formatted as dates. One of the strings is written as '4//2021'. What will happen when you try to convert that string to the timestamp data type?
-- Answer: It would fail due to inpropper formatting. 