USE college_db;

ALTER TABLE students
ADD COLUMN phone_number VARCHAR(15);

DESCRIBE students;

ALTER TABLE courses
ADD COLUMN max_seats INT DEFAULT 60;

DESCRIBE courses;

ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A', 'B', 'C', 'D', 'F') OR grade IS NULL);

SHOW CREATE TABLE enrollments;

ALTER TABLE departments
CHANGE hod_name head_of_dept VARCHAR(100);

DESCRIBE departments;

ALTER TABLE students
DROP COLUMN phone_number;

DESCRIBE students;