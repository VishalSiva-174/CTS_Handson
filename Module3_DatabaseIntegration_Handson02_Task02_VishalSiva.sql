USE college_db;

SELECT *
FROM students
WHERE enrollment_year = 2022
ORDER BY last_name ASC;

SELECT *
FROM courses
WHERE credits > 3
ORDER BY credits DESC;

SELECT *
FROM professors
WHERE salary BETWEEN 80000 AND 95000;

SELECT *
FROM students
WHERE email LIKE '%@college.edu';

SELECT
    enrollment_year,
    COUNT(*) AS total_students
FROM students
GROUP BY enrollment_year
ORDER BY enrollment_year;