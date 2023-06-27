CREATE SCHEMA simpsons;

CREATE TABLE simpsons.characters (
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    dob DATE,
    salary NUMERIC
)

DROP TABLE simpsons.characters;


INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Homer', 'Simpson', '1985-01-01', 50000);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Marge', 'Simpson', '1982-03-15', 40000);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Lisa', 'Simpson', '2014-07-15', 0);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Bart', 'Simpson', '2012-05-01', 0);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Maggie', 'Simpson', '2020-12-25', 0);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Ned', 'Flanders', '1981-10-12', 70000);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Moe', 'Szyslak', '1980-02-01', 80000);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Ralph', 'Wiggum', '2014-09-23', 0);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Clancy', 'Wiggum', '1979-05-30', 65000);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Montgomery', 'Burns', '1950-08-07', 500000);

INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Sideshow', 'Bob', '1970-01-01', 80000);


INSERT INTO simpsons.characters (first_name, last_name, dob, salary)
VALUES ('Bart', 'Thomson', '2012-05-01', NULL),
       ('Lisa', 'Thomson', '2012-05-01', NULL);

DELETE FROM simpsons.characters
WHERE last_name = 'Thomson'

DELETE FROM simpsons.characters
WHERE salary IS NULL;



-- CASE WHEN Statement
SELECT c.*
FROM simpsons.characters AS c;

SELECT c.first_name,
       c.last_name,
       c.dob,
       c.salary
FROM simpsons.characters AS c
ORDER BY c.salary DESC
LIMIT 10;

-- SALARY RANGES
-- 0-50k
-- 50k-100k
-- 100k+

SELECT c.first_name,
       c.last_name,
       c.dob,
       c.salary,
       CASE
           WHEN c.salary < 50000 THEN '0-50k'
           WHEN c.salary BETWEEN 50000 AND 100000 THEN '50k-100k'
           WHEN c.salary > 100000 THEN '100k+'
           ELSE 'Unknown'
       END AS salary_range,
       EXTRACT('year' from AGE(dob)) AS age
FROM simpsons.characters AS c
ORDER BY c.salary ASC;


SELECT
    CASE
        WHEN c.salary < 50000 THEN '0-50k'
        WHEN c.salary BETWEEN 50000 AND 100000 THEN '50k-100k'
        WHEN c.salary > 100000 THEN '100k+'
        ELSE 'Unknown'
    END AS salary_range,
    COUNT(*)
FROM simpsons.characters AS c
GROUP BY 1;

-- RANK, DENSE_RANK, ROW
-- Write a query to get the top 3 earners (people with the highest salaries)
SELECT c.first_name,
       c.last_name,
       c.dob,
       c.salary,
       RANK() OVER (ORDER BY c.salary DESC) AS salary_rank,
       DENSE_RANK() OVER (ORDER BY c.salary DESC) AS salary_dense_rank
FROM simpsons.characters AS c
ORDER BY c.salary DESC;

WITH ranked_salaries AS (
    SELECT c.first_name,
       c.last_name,
       c.dob,
       c.salary,
       RANK() OVER (ORDER BY c.salary DESC) AS salary_rank,
       DENSE_RANK() OVER (ORDER BY c.salary DESC) AS salary_dense_rank,
       row_number() over (ORDER BY c.salary DESC) salary_row
FROM simpsons.characters AS c
)
SELECT *
FROM ranked_salaries;
--WHERE salary_dense_rank <= 3;


SELECT c.first_name,
       c.last_name,
       c.dob,
       c.salary,
       RANK() OVER (PARTITION BY last_name ORDER BY c.salary DESC) AS salary_rank
FROM simpsons.characters AS c;

WITH family_incomes AS (
    SELECT c.last_name,
           SUM(c.salary) AS total_income
    FROM simpsons.characters AS c
    GROUP BY 1
)
SELECT *,
       DENSE_RANK() OVER (ORDER BY total_income DESC) AS family_rank
FROM family_incomes;

SELECT c.last_name,
       SUM(c.salary) AS total_income,
       RANK() OVER (ORDER BY sum(c.salary) DESC) AS total_income_rank
FROM simpsons.characters AS c
GROUP BY 1;


SELECT *,
       RANK() OVER (ORDER BY AGE(c.dob) ASC) AS age_rank
FROM simpsons.characters AS c;