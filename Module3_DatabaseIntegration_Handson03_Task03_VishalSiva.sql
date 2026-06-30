USE college_db;

DELIMITER $$

CREATE PROCEDURE sp_enroll_student(
    IN p_student_id INT,
    IN p_course_id INT,
    IN p_enrollment_date DATE
)
BEGIN

    IF EXISTS (
        SELECT 1
        FROM enrollments
        WHERE student_id = p_student_id
          AND course_id = p_course_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate enrollment is not allowed.';
    ELSE

        INSERT INTO enrollments
        (
            student_id,
            course_id,
            enrollment_date,
            grade
        )
        VALUES
        (
            p_student_id,
            p_course_id,
            p_enrollment_date,
            NULL
        );

    END IF;

END $$

DELIMITER ;

CALL sp_enroll_student(9, 2, '2024-07-01');

CALL sp_enroll_student(9, 2, '2024-07-01');

CREATE TABLE IF NOT EXISTS department_transfer_log
(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    old_department INT NOT NULL,
    new_department INT NOT NULL,
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE PROCEDURE sp_transfer_student
(
    IN p_student_id INT,
    IN p_new_department INT
)
BEGIN

    DECLARE v_old_department INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    SELECT department_id
    INTO v_old_department
    FROM students
    WHERE student_id = p_student_id;

    UPDATE students
    SET department_id = p_new_department
    WHERE student_id = p_student_id;

    INSERT INTO department_transfer_log
    (
        student_id,
        old_department,
        new_department
    )
    VALUES
    (
        p_student_id,
        v_old_department,
        p_new_department
    );

    COMMIT;

END $$

DELIMITER ;

CALL sp_transfer_student(1,2);

SELECT *
FROM department_transfer_log;

CALL sp_transfer_student(2,999);

SELECT
student_id,
department_id
FROM students
WHERE student_id=2;

SELECT *
FROM department_transfer_log;

START TRANSACTION;

INSERT INTO enrollments
(
student_id,
course_id,
enrollment_date,
grade
)
VALUES
(
9,
3,
'2024-07-10',
NULL
);

SAVEPOINT first_insert;

INSERT INTO enrollments
(
student_id,
course_id,
enrollment_date,
grade
)
VALUES
(
9,
999,
'2024-07-10',
NULL
);

ROLLBACK TO SAVEPOINT first_insert;

COMMIT;

SELECT *
FROM enrollments
WHERE student_id=9;
