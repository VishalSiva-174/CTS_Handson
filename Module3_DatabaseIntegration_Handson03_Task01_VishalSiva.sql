USE college_db;

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) >
(
    SELECT AVG(course_count)
    FROM
    (
        SELECT COUNT(*) AS course_count
        FROM enrollments
        GROUP BY student_id
    ) AS avg_enrollments
);

SELECT
    c.course_id,
    c.course_name
FROM courses c
WHERE EXISTS
(
    SELECT 1
    FROM enrollments e
    WHERE e.course_id = c.course_id
)
AND NOT EXISTS
(
    SELECT 1
    FROM enrollments e
    WHERE e.course_id = c.course_id
      AND e.grade <> 'A'
);

SELECT
    p.professor_id,
    p.prof_name,
    d.dept_name,
    p.salary
FROM professors p
JOIN departments d
    ON p.department_id = d.department_id
WHERE p.salary =
(
    SELECT MAX(p2.salary)
    FROM professors p2
    WHERE p2.department_id = p.department_id
);

SELECT
    dept_name,
    average_salary
FROM
(
    SELECT
        d.dept_name,
        ROUND(AVG(p.salary), 2) AS average_salary
    FROM departments d
    JOIN professors p
        ON d.department_id = p.department_id
    GROUP BY d.department_id, d.dept_name
) AS department_avg
WHERE average_salary > 85000;