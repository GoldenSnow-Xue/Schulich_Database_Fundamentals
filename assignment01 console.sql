SELECT COUNT(*)
FROM assignment01.bakery_sales;

SELECT MIN(unit_price) AS min_unit_price,
       MAX(unit_price) AS max_unit_price,
       AVG(unit_price) AS avg_unit_price
FROM assignment01.bakery_sales;

--
SELECT MIN(unit_price) min_unit_price,
       MAX(unit_price) max_unit_price,
       AVG(unit_price) avg_unit_price
FROM assignment01.bakery_sales;

SELECT MIN(bs.unit_price) min_unit_price,
       MAX(bs.unit_price) max_unit_price,
       AVG(bs.unit_price) avg_unit_price
FROM assignment01.bakery_sales AS bs
WHERE bs.sale_date = '2021-01-02'
  AND bs.sale_time BETWEEN '9:00:00' AND '10:00:00';

SELECT MIN(bs.unit_price) min_unit_price,
       MAX(bs.unit_price) max_unit_price
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'BAGUETTE';

SELECT bs.article,
       MIN(bs.unit_price) AS min_unit_price,
       MAX(bs.unit_price) AS max_unit_price
FROM assignment01.bakery_sales AS bs
GROUP BY bs.article;

SELECT bs.article,
       MIN(bs.unit_price) AS min_unit_price,
       MAX(bs.unit_price) AS max_unit_price
FROM assignment01.bakery_sales AS bs
WHERE bs.article LIKE 'BAGUETTE%' --
--'%BAGUETTE'
--'%BAGUETTE%'
--'% BAGUETTE'
GROUP BY bs.article;

