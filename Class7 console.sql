CREATE SCHEMA simpsons;

CREATE TABLE simpsons.characters (
    character_id INTEGER,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    dob DATE,
    salary NUMERIC
);

INSERT INTO simpsons.characters(first_name, last_name, dob, salary)
VALUES ('Homer', 'Simpson', '1985-01-01', 50000),
       ('Marge', 'Simpson', '1982-03-15', 40000),
       ('Ned', 'Flanders', '1981-10-12', 70000),
       ('Moe', 'Szyslak', '1980-02-01', 80000),
       ('Clancy', 'Wiggum', '1979-05-30', 65000),
       ('Montgomery', 'Burns', '1950-08-07', 500000),
       ('Maggie', 'Simpson', '2020-12-25', 0),
       ('Ralph', 'Wiggum', '2014-09-23', 0),
       ('Bart', 'Simpson', '2012-05-01', 0),
       ('Lisa', 'Simpson', '2014-07-05', 0),
       ('Sideshow', 'Bob', '1970-01-01', 80000);

DROP TABLE characters;

CREATE TABLE simpsons.characters
(
    character_id INTEGER,
    first_name   VARCHAR(255),
    last_name    VARCHAR(255),
    dob          DATE,
    salary       NUMERIC
);

INSERT INTO simpsons.characters(character_id, first_name, last_name, dob, salary)
VALUES (1, 'Homer', 'Simpson', '1985-01-01', 50000),
       (2, 'Marge', 'Simpson', '1982-03-15', 40000),
       (3, 'Ned', 'Flanders', '1981-10-12', 70000),
       (4, 'Moe', 'Szyslak', '1980-02-01', 80000),
       (5, 'Clancy', 'Wiggum', '1979-05-30', 65000),
       (6, 'Montgomery', 'Burns', '1950-08-07', 500000),
       (7, 'Maggie', 'Simpson', '2020-12-25', 0),
       (8, 'Ralph', 'Wiggum', '2014-09-23', 0),
       (9, 'Bart', 'Simpson', '2012-05-01', 0),
       (10, 'Lisa', 'Simpson', '2014-07-05', 0),
       (11, 'Sideshow', 'Bob', '1970-01-01', 80000);

--- DELETE FROM simpsons.characters
--- WHERE salary is NULL;

SELECT c.first_name,
       c.last_name,
       c.dob,
       c.salary,
    CASE
        WHEN c.salary < 50000 THEN '<50K'
        WHEN c.salary BETWEEN 50000 AND 100000 THEN '50K-100K'
        WHEN c.salary > 100000 THEN '100K+'
        ELSE 'Unknown'
    END AS salary_range
FROM simpsons.characters AS c
ORDER BY c.salary ASC;

UPDATE simpsons.characters
SET salary = NULL
WHERE first_name = 'Maggie';

---RANK, DENSE_RANK, ROW
---Write a query to get the top 3 earners (people with the highest salaries)
SELECT c.first_name,
       c.last_name,
       c.salary
FROM simpsons.characters AS c
WHERE c.salary IS NOT NULL
ORDER BY c.salary DESC
LIMIT 3; ---print the rows you want to

SELECT c.first_name,
       c.last_name,
       c.salary,
       RANK() OVER (ORDER BY c.salary DESC) AS salary_rank,
       DENSE_RANK() OVER (ORDER BY c.salary DESC) AS salary_dense_rank,
       ROW_NUMBER() OVER (ORDER BY c.salary DESC) AS salary_row_number   ---count
FROM simpsons.characters AS c
WHERE c.salary IS NOT NULL
ORDER BY c.salary DESC;


---Rank each families
SELECT c.first_name,
       c.last_name,
       c.salary,
       RANK() OVER (PARTITION BY c.last_name ORDER BY c.salary DESC) AS salary_rank
FROM simpsons.characters AS c
WHERE c.salary IS NOT NULL
ORDER BY c.last_name, c.salary DESC;


---Rank families by Total Income
SELECT c.last_name,
       SUM(c.salary) AS total_income,
       RANK() OVER (ORDER BY SUM(c.salary) DESC) AS family_rank
FROM simpsons.characters AS c
GROUP BY c.last_name;


SELECT c.first_name,
       c.last_name,
       c.dob,
       DATE_PART('year', c.dob) AS birth_year,
       EXTRACT('year' from c.dob) AS birth_year,
       AGE(c.dob)
FROM simpsons.characters AS c;


SELECT c.first_name,
       c.last_name,
       c.dob,
       DATE_PART('year', c.dob) AS birth_year,
       EXTRACT('year' from c.dob) AS birth_year,
       EXTRACT('year' from AGE(c.dob)) AS age
FROM simpsons.characters AS c;


---Rank people by age with the youngest to be one
SELECT c.first_name,
       c.last_name,
       c.dob,
       DATE_PART('year', c.dob) AS birth_year,
       EXTRACT('year' from c.dob) AS birth_year,
       EXTRACT('year' from AGE(c.dob)) AS age,
       RANK() OVER (ORDER BY AGE(c.dob)) AS age_rank
FROM simpsons.characters AS c;


SELECT c.first_name,
       c.last_name,
       c.dob,
       RANK() OVER (ORDER BY AGE(c.dob) ASC) AS age_rank
FROM simpsons.characters AS c;

---change to mban_db.assignment01
SELECT bs.article,
       SUM(bs.quantity * bs.unit_price) AS revenue,
       RANK() OVER (ORDER BY SUM(bs.quantity * bs.unit_price) DESC) AS sales_rank
FROM assignment01.bakery_sales AS bs
WHERE bs.unit_price IS NOT NULL
GROUP BY bs.article
ORDER BY revenue DESC;


SELECT EXTRACT('year' FROM bs.sale_datetime) AS sale_year,
       EXTRACT('month' FROM bs.sale_datetime) AS sale_month,
       bs.article,
       SUM(bs.quantity * bs.unit_price) AS revenue,
       RANK() OVER (
           PARTITION BY EXTRACT('year' FROM bs.sale_datetime), EXTRACT('year' FROM bs.sale_datetime)
           ORDER BY SUM(bs.quantity * bs.unit_price) DESC
        ) AS sales_rank
FROM assignment01.bakery_sales AS bs
WHERE bs.unit_price IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY 1, 2, 4 DESC;


WITH ranked_products AS (
    SELECT EXTRACT('year' FROM bs.sale_datetime) AS sale_year,
       EXTRACT('month' FROM bs.sale_datetime) AS sale_month,
       bs.article,
       SUM(bs.quantity * bs.unit_price) AS revenue,
       RANK() OVER (
           PARTITION BY EXTRACT('year' FROM bs.sale_datetime), EXTRACT('year' FROM bs.sale_datetime)
           ORDER BY SUM(bs.quantity * bs.unit_price) DESC
        ) AS sales_rank
FROM assignment01.bakery_sales AS bs
WHERE bs.unit_price IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY 1, 2, 4 DESC
)
SELECT *
FROM ranked_products
WHERE sales_rank <= 3;


SELECT EXTRACT('year' FROM bs.sale_datetime) AS sale_year,
       EXTRACT('month' FROM bs.sale_datetime) AS sale_month,
       bs.article,
       SUM(bs.quantity) AS volume
FROM assignment01.bakery_sales AS bs
GROUP BY 1, 2, 3;


SELECT EXTRACT('year' FROM bs.sale_datetime) AS sale_year,
       EXTRACT('month' FROM bs.sale_datetime) AS sale_month,
       bs.article,
       SUM(bs.quantity) AS volume
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'BAGUETTE'
GROUP BY 1, 2, 3
ORDER BY 1, 2;
