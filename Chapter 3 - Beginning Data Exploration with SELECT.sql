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