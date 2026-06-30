USE college_db;

CREATE VIEW vw_student_enrollment_summary AS
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.dept_name AS department,
    COUNT(e.course_id) AS total_courses,
    ROUND(
        AVG(
            CASE
                WHEN e.grade = 'A' THEN 4
                WHEN e.grade = 'B' THEN 3
                WHEN e.grade = 'C' THEN 2
                WHEN e.grade = 'D' THEN 1
                WHEN e.grade = 'F' THEN 0
            END
        ), 2
    ) AS GPA
FROM students s
JOIN departments d
ON s.department_id = d.department_id
LEFT JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name,
    d.dept_name;

CREATE VIEW vw_course_stats AS
SELECT
    c.course_name,
    c.course_code,
    COUNT(e.student_id) AS total_enrollments,
    ROUND(
        AVG(
            CASE
                WHEN e.grade = 'A' THEN 4
                WHEN e.grade = 'B' THEN 3
                WHEN e.grade = 'C' THEN 2
                WHEN e.grade = 'D' THEN 1
                WHEN e.grade = 'F' THEN 0
            END
        ), 2
    ) AS avg_gpa
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name,
    c.course_code;

SELECT *
FROM vw_student_enrollment_summary
WHERE GPA > 3.0;

UPDATE vw_student_enrollment_summary
SET department = 'Computer Science'
WHERE student_id = 1;

DROP VIEW IF EXISTS vw_course_stats;

DROP VIEW IF EXISTS vw_student_enrollment_summary;

CREATE VIEW vw_student_enrollment_summary AS
SELECT
    student_id,
    first_name,
    last_name,
    department_id,
    enrollment_year
FROM students
WHERE enrollment_year >= 2022
WITH CHECK OPTION;

SELECT *
FROM vw_student_enrollment_summary;