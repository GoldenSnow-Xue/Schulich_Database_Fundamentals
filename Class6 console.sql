--Write a query sale datetime
--ticket number, article, quantity, revenue
SELECT bs.sale_datetime,
       bs.ticket_number,
       bs.article,
       bs.quantity,
       bs.unit_price * bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
--WHERE bs.ticket_number >= 150060
--    AND bs.ticket_number <= 150070;
--WHERE bs.ticket_number BETWEEN 150060 AND 150070;
WHERE bs.sale_date BETWEEN '2022-01-01' AND '2022-01-31'
ORDER BY bs.sale_date desc;

-- =
-- >, >=
-- <, <=
-- !=, <>


SELECT bs.sale_datetime,
       bs.ticket_number,
       bs.article,
       bs.quantity,
       bs.unit_price * bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
WHERE bs.ticket_number = 150063
ORDER BY revenue;
--ORDER BY 5 DESC;


SELECT bs.sale_datetime,
       bs.ticket_number,
       bs.article,
       bs.quantity,
       bs.unit_price * bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'Mexican Baguette'
OR bs.article = 'Italian Baguette'
OR bs.article = 'Veggie Baguette';


SELECT bs.sale_datetime,
       bs.ticket_number,
       bs.article,
       bs.quantity,
       bs.unit_price * bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
WHERE bs.article LIKE '% Baguette';

SELECT bs.sale_datetime,
       bs.ticket_number,
       lower(bs.article) AS article_name_lowercase, --May not need
       bs.quantity,
       bs.unit_price * bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
--WHERE bs.article_name_lowercase LIKE '%baguette';
WHERE lower(bs.article) LIKE '%baguette%';


SELECT distinct(bs.article)  --unique list
FROM assignment01.bakery_sales AS bs
WHERE upper(bs.article) LIKE '%BAGUETTE%';

--find all records for the DEMI and CEREAL BAGUETTE
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'DEMI BAGUETTE'
OR bs.article = 'CEREAL BAGUETTE';
--WHERE bs.article IN ('DEMI BAGUETTE', 'CEREAL BAGUETTE');


SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.ticket_number IN (150060, 150065, 150078);


SELECT *
FROM assignment01.bakery_sales AS bs
WHERE CAST(bs.ticket_number AS text) LIKE '15006_';
--ticket_number is a number not a string, need to convert
--if there is '15006a', it can be found
-- % means unlimited thing, _ means only one position

--WHERE CAST(bs.ticket_number AS text) LIKE '1500__'; two positions

-- UPDATE assignment01.bakery_sales AS bs
-- VALUE


SELECT *
FROM assignment01.bakery_sales AS bs
WHERE CAST(bs.sale_date AS text) LIKE '2022-01-__';


SELECT *
FROM assignment01.bakery_sales AS bs
WHERE CAST(bs.sale_time AS text) LIKE '09:%';


--TIME FUNCTIONS: DATE_PART(), EXTRACT()
SELECT bs.sale_datetime,
       date_part('year', bs.sale_datetime) AS sale_year,
       extract('year' FROM bs.sale_datetime) AS sale_year_with_extract,
       date_part('month',bs.sale_datetime) AS sale_month,
       date_part('day', bs.sale_datetime) AS sale_day,
       date_part('hour', bs.sale_datetime) AS sale_hour,
       date_part('minute', bs.sale_datetime) AS sale_minute,
       date_part('second', bs.sale_datetime) AS sale_second,
       date_part('millisecond',bs.sale_datetime) AS sale_millisecond,
       date_part('microsecond',bs.sale_datetime) AS sale_microsecond,
       bs.sale_date,
       bs.ticket_number,
       bs.article,
       bs.quantity
FROM assignment01.bakery_sales AS bs;


SELECT CURRENT_DATE;
SELECT CURRENT_TIMESTAMP; -- UTC TIME


SELECT CURRENT_DATE,
       date_part('year', CURRENT_DATE),
       date_part('month', CURRENT_DATE),
       date_part('day', CURRENT_DATE),
       date_part('dow', CURRENT_DATE);  --Day of Week


-- CALCULATE Revenue by Year and Month
SELECT date_part('year', bs.sale_datetime) AS sale_year,
       date_part('month', bs.sale_datetime) AS sale_month,
       SUM(bs.unit_price*bs.quantity) AS revenue
FROM assignment01.bakery_sales AS bs
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;



-- Naming the previous tables
WITH monthly_sales AS (SELECT date_part('year', bs.sale_datetime)  AS sale_year,
                              date_part('month', bs.sale_datetime) AS sale_month,
                              SUM(bs.unit_price * bs.quantity)     AS revenue
                       FROM assignment01.bakery_sales AS bs
                       GROUP BY sale_year, sale_month
                       ORDER BY sale_year, sale_month)

--SELECT *
--FROM monthly_sales
--WHERE sale_year = 2021;

SELECT sale_year, AVG(revenue)
FROM monthly_sales
GROUP BY sale_year;