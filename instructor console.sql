CREATE SCHEMA schulich;

CREATE TABLE instructor (
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    age        INTEGER
);




INSERT INTO schulich.instructor (first_name, last_name, age)
VALUES ('Alex', 'Preciado', 39);

INSERT INTO schulich.instructor (first_name, last_name, age)
VALUES ('Delina', 'Ivanova', 35);

UPDATE schulich.instructor
SET age = 33
WHERE first_name = 'Delina'
AND last_name = 'Ivanova';



-- Adding a new column called instructor_id
ALTER TABLE schulich.instructor
ADD COLUMN instructor_id INTEGER;

UPDATE schulich.instructor
SET instructor_id = 1
WHERE first_name = 'Alex';


UPDATE schulich.instructor
SET instructor_id = 2
WHERE first_name = 'Delina'
  AND last_name = 'Ivanova'
  AND age = 33;

SELECT *
FROM schulich.instructor;

SELECT first_name,
       last_name
FROM schulich.instructor;

SELECT i.first_name,
       i.last_name,
       i.age
FROM schulich.instructor AS i;

SELECT COUNT(*)
FROM schulich.instructor;



