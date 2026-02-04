SELECT * FROM teachers;

TABLE teachers;

SELECT first_name, last_name, salary FROM teachers;

SELECT first_name, last_name, salary
FROM teachers
ORDER BY 3 DESC;

SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC, hire_date DESC;

SELECT DISTINCT school
FROM teachers
ORDER BY school;

SELECT DISTINCT school, salary
FROM teachers
ORDER BY school, salary;

SELECT school, salary
FROM teachers
ORDER BY school, salary;

SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

SELECT first_name, last_name, school
FROM teachers
WHERE first_name = 'Janet';

SELECT * FROM teachers;

SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS';

SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';

SELECT first_name, last_name, salary
FROM teachers
WHERE salary >= '43500';

SELECT first_name, last_name, salary
FROM teachers
WHERE salary BETWEEN 40000 AND 65000;

SELECT first_name, last_name, school, salary
FROM teachers
WHERE salary >= 40000 AND salary <= 65000;

SELECT first_name
FROM teachers
WHERE first_name LIKE 'sam%';

SELECT first_name
FROM teachers
WHERE first_name ILIKE 'sam%';

SELECT * FROM teachers
WHERE school = 'Myers Middle School'

SELECT *
FROM teachers
WHERE school = 'Myers Middle School' AND salary < 40000;

SELECT *
FROM teachers
WHERE last_name = 'Cole'
OR last_name = 'Bush';

SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS'
    AND (salary < 38000 OR salary > 40000);

SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS'
    AND salary < 38000 OR salary > 40000;

SELECT first_name, last_name, school, hire_date, salary
FROM teachers
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC;

-- The school district superintendent asks for a list of teachers in each school. Write a query that lists the schools in alphabetical order along with teachers ordered by last name A–Z.

SELECT first_name, last_name, school
FROM teachers
ORDER BY school ASC, last_name ASC;

-- Write a query that finds the one teacher whose first name starts with the letter S and who earns more than $40,000. 
SELECT *
FROM teachers
WHERE first_name LIKE 'S%' AND salary > 40000;

-- Rank teachers hired since January 1, 2010, ordered by highest paid to lowest.
SELECT *
FROM teachers
WHERE hire_date > '01-01-2010'
ORDER BY salary DESC;