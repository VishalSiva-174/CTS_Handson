USE college_db;

SELECT
    c.course_name,
    COUNT(e.student_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_id;

SELECT
    d.dept_name,
    ROUND(AVG(p.salary), 2) AS average_salary
FROM departments d
LEFT JOIN professors p
ON d.department_id = p.department_id
GROUP BY d.department_id, d.dept_name
ORDER BY d.department_id;

SELECT
    dept_name,
    budget
FROM departments
WHERE budget > 600000;

SELECT
    e.grade,
    COUNT(*) AS grade_count
FROM enrollments e
INNER JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_code = 'CS101'
GROUP BY e.grade
ORDER BY e.grade;

SELECT
    d.dept_name,
    COUNT(DISTINCT e.student_id) AS total_students
FROM departments d
INNER JOIN courses c
ON d.department_id = c.department_id
INNER JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY d.department_id, d.dept_name
HAVING COUNT(DISTINCT e.student_id) > 2
ORDER BY d.department_id;