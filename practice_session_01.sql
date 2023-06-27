CREATE SCHEMA IF NOT EXISTS schulich;

CREATE TABLE schulich.instructor (
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    age        INTEGER
);

INSERT INTO schulich.instructor (first_name, last_name, age)
VALUES ('Alex', 'Preciado', 39);

INSERT INTO schulich.instructor (first_name, last_name)
VALUES ('Delina', 'Ivanova');

INSERT INTO schulich.instructor (first_name, age)
VALUES ('David', 67);

INSERT INTO schulich.instructor (first_name, last_name, age)
VALUES ('Alber', 'Einstein', 65);

INSERT INTO schulich.instructor (first_name, last_name, age)
VALUES ('Marie', 'Curie', 40);

-- Query to update age for instructor Delina Ivanova
UPDATE schulich.instructor
SET age = 33
WHERE first_name = 'Delina'
  AND last_name  = 'Ivanova';

UPDATE schulich.instructor
SET last_name = 'Elsner'
WHERE first_name = 'David';

ALTER TABLE schulich.instructor
ADD COLUMN instructor_id INTEGER;

UPDATE schulich.instructor
SET instructor_id = 5
WHERE first_name = 'Albert';

-- Adding a new column called instructor_id
ALTER TABLE schulich.instructor
ADD COLUMN address VARCHAR(255);

UPDATE schulich.instructor
SET instructor_id = 1
WHERE first_name = 'Alex';

UPDATE schulich.instructor
SET instructor_id = 2
WHERE first_name = 'Alex'
  AND last_name = 'Preciado';

UPDATE schulich.instructor
SET instructor_id = 3
WHERE first_name = 'Delina'
  AND last_name = 'Ivanova'
  AND age = 35;

DELETE FROM schulich.instructor
WHERE instructor_id IS NULL

SELECT *
FROM schulich.instructor;

select first_name,
       age,
       last_name
FROM schulich.instructor;

SELECT A.first_name,
       A.last_name,
       A.age
FROM schulich.instructor AS A;


SELECT COUNT(DISTINCT first_name)
FROM schulich.instructor;


SELECT COUNT(first_name)
FROM schulich.instructor;

SELECT COUNT(DISTINCT first_name)
FROM schulich.instructor;


SELECT AVG(age)
FROM schulich.instructor;


DROP TABLE IF EXISTS schulich.instructor;
