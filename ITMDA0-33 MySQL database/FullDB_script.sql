-- ================================================================
-- ITMDA0 - Project 
-- Database: Eduvos
-- Author: John Wesley Williams
-- Date: 2025/08/24
-- Description: Eduvos has hired me to create a database that is reliable and can fix many real world problems the university is facing.
-- ================================================================

-- Create database
DROP DATABASE IF EXISTS eduvos;
CREATE DATABASE eduvos
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
USE eduvos;

-- =================================================================
-- TABLE CREATION SECTION
-- Author: John Wesley Williams
-- Date: 2025/08/24
-- Description: Create all required tables with constraints
-- =================================================================

-- Student table - Stores student information
CREATE TABLE students 
(
student_id INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
city VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
status ENUM('Active', 'Inactive', 'Graduated') DEFAULT 'Active',
CONSTRAINT chk_email_format CHECK (email LIKE '%@%.edu%'),
CONSTRAINT chk_enrollment_date CHECK (enrollment_date <= CURRENT_DATE),
PRIMARY KEY (student_id)
);
 
 -- Module table - stores course module information
CREATE TABLE module 
(
module_id VARCHAR(6) NOT NULL,
module_name VARCHAR(100) NOT NULL,
faculty VARCHAR(50) NOT NULL,
module_code VARCHAR(10) NOT NULL,
module_points INT NOT NULL DEFAULT 1,
term INT NOT NULL,
PRIMARY KEY (module_id),
CONSTRAINT chk_module_points CHECK (module_points BETWEEN 1 AND 10),
CONSTRAINT chk_term CHECK (term BETWEEN 1 AND 4)
);

-- Student_course table - enrollment relationship
CREATE TABLE student_course 
(
student_id INT NOT NULL,
module_id VARCHAR(6) NOT NULL,
enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
status ENUM('Enrolled', 'Suspended', 'Graduated') DEFAULT 'Enrolled',
PRIMARY KEY (student_id, module_id),
FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE
);

-- Exam table - stores students' exam details 
CREATE TABLE exam 
(
exam_id INT NOT NULL AUTO_INCREMENT,
student_id INT NOT NULL,
module_id VARCHAR(6) NOT NULL,
exam_name VARCHAR(50) NOT NULL,
marks DECIMAL(5,2) NOT NULL,
exam_date DATE NOT NULL,
exam_type ENUM('Assignment', 'Test', 'Final') NOT NULL,
PRIMARY KEY (exam_id),
FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE, 
CONSTRAINT chk_marks CHECK (marks BETWEEN 0 AND 100)
);

-- Module_stats table - stores statistics about the various exams such as how many students passed/failed a module
CREATE TABLE module_stats 
(
stat_id INT NOT NULL AUTO_INCREMENT,
module_id VARCHAR(6) NOT NULL,
total_attempts INT DEFAULT 0,
total_passes INT DEFAULT 0,
total_fails INT DEFAULT 0,
total_distinctions INT DEFAULT 0,
average_mark DECIMAL(5,2) DEFAULT (0.00),
exam_type ENUM('Assignment', 'Test', 'Final') NOT NULL,
last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (stat_id),
UNIQUE KEY (module_id, exam_type),
FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE,
CONSTRAINT chk_attempts CHECK (total_attempts >= 0),
CONSTRAINT chk_passes CHECK (total_passes >= 0),
CONSTRAINT chk_fails CHECK (total_fails >= 0),
CONSTRAINT chk_distinctions CHECK (total_distinctions >= 0)
);

-- Exam_audit table - Stores old data and changes to exam marks
CREATE TABLE exam_audit 
(
audit_id INT NOT NULL AUTO_INCREMENT,
student_id INT NOT NULL,
module_id VARCHAR(6) NOT NULL,
exam_id INT NOT NULL,
old_mark DECIMAL(5,2),
new_mark DECIMAL(5,2),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
change_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
PRIMARY KEY (audit_id),
FOREIGN KEY (exam_id) REFERENCES exam(exam_id) ON DELETE CASCADE,
FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE 
);

-- Top preformers table - Stores data on the top ranked students
CREATE TABLE top_performers
(
performer_id INT NOT NULL AUTO_INCREMENT,
student_id INT NOT NULL,
module_id VARCHAR(6) NOT NULL,
exam_id INT NOT NULL,
marks DECIMAL(5,2) NOT NULL,
exam_date DATE NOT NULL,
recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (performer_id),
FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE, 
FOREIGN KEY (exam_id) REFERENCES exam(exam_id) ON DELETE CASCADE,
CONSTRAINT chk_top_performer CHECK (marks >= 90)
);

-- =================================================================
-- SAMPLE DATA INSERTION
-- Author: John Wesley Williams
-- Date: 2025/08/24
-- Description: Inserting data into the created tables
-- =================================================================

-- Insert data into students table
INSERT INTO students (first_name, last_name, date_of_birth, city, email, enrollment_date, status) VALUES
('John', 'Smith', '2000-05-15', 'Cape Town', 'john.smith@harvard.edu', '2022-09-01', 'Active'),
('Emma', 'Johnson', '2001-02-28', 'Johannesburg', 'emma.johnson@harvard.edu', '2022-09-01', 'Active'),
('Michael', 'Brown', '1999-11-10', 'Durban', 'michael.brown@harvard.edu', '2021-09-01', 'Active'),
('Sophia', 'Davis', '2000-08-22', 'Pretoria', 'sophia.davis@harvard.edu', '2022-09-01', 'Active'),
('James', 'Wilson', '2001-03-17', 'Pretoria', 'james.wilson@harvard.edu', '2022-09-01', 'Active'),
('Olivia', 'Taylor', '2000-12-05', 'Cape Town', 'olivia.taylor@harvard.edu', '2022-09-01', 'Active'),
('William', 'Anderson', '1999-07-30', 'Durban', 'william.anderson@harvard.edu', '2021-09-01', 'Active'),
('Isabella', 'Thomas', '2000-04-12', 'Johannesburg', 'isabella.thomas@harvard.edu', '2022-09-01', 'Active'),
('Benjamin', 'Jackson', '2001-01-25', 'Pretoria', 'benjamin.jackson@harvard.edu', '2022-09-01', 'Active'),
('Charlotte', 'White', '2000-09-18', 'Cape Town', 'charlotte.white@harvard.edu', '2022-09-01', 'Active');

-- Insert data into the modules table
INSERT INTO module (module_id, module_name, faculty, module_code, module_points, term) VALUES
('MATH01', 'Calculus I', 'Mathematics', 'CAL101', 5, 1),
('MATH02', 'Linear Algebra', 'Mathematics', 'LINAL102', 4, 2),
('COMP01', 'Programming Fundamentals', 'Computer Science', 'PROG101', 6, 1),
('COMP02', 'Data Structures', 'Computer Science', 'DATA102', 6, 2),
('PHYS01', 'Classical Mechanics', 'Physics', 'MECH101', 5, 1),
('PHYS02', 'Electromagnetism', 'Physics', 'ELEC102', 5, 2),
('CHEM01', 'Organic Chemistry', 'Chemistry', 'ORGC101', 4, 1),
('CHEM02', 'Physical Chemistry', 'Chemistry', 'PHYC102', 4, 2),
('BIO01', 'Cell Biology', 'Biology', 'CELL101', 3, 1),
('BIO02', 'Genetics', 'Biology', 'GENE102', 3, 2);

-- Insert data into the student_course table
 INSERT INTO student_course (student_id, module_id, enrollment_date, status) VALUES
(1, 'MATH01', '2022-09-01', 'Enrolled'),
(1, 'COMP01', '2022-09-01', 'Enrolled'),
(1, 'PHYS01', '2022-09-01', 'Enrolled'),
(2, 'MATH01', '2022-09-01', 'Enrolled'),
(2, 'PHYS01', '2022-09-01', 'Enrolled'),
(2, 'CHEM01', '2022-09-01', 'Enrolled'),
(3, 'COMP01', '2021-09-01', 'Enrolled'),
(3, 'COMP02', '2022-01-15', 'Enrolled'),
(4, 'CHEM01', '2022-09-01', 'Enrolled'),
(4, 'BIO01', '2022-09-01', 'Enrolled'),
(5, 'MATH02', '2022-09-01', 'Enrolled'),
(5, 'PHYS02', '2022-09-01', 'Enrolled'),
(6, 'BIO01', '2022-09-01', 'Enrolled'),
(6, 'BIO02', '2022-09-01', 'Enrolled'),
(7, 'COMP01', '2021-09-01', 'Enrolled'),
(7, 'MATH01', '2021-09-01', 'Enrolled'),
(8, 'CHEM02', '2022-09-01', 'Enrolled'),
(8, 'PHYS01', '2022-09-01', 'Enrolled'),
(9, 'COMP02', '2022-09-01', 'Enrolled'),
(10, 'MATH01', '2022-09-01', 'Enrolled');

-- Insert data into the exam table  
INSERT INTO exam (student_id, module_id, exam_name, marks, exam_date, exam_type) VALUES
-- Exams written within the last month
(1, 'MATH01', 'Calculus Midterm Exam', 88.50, '2024-03-05', 'Test'),
(1, 'COMP01', 'Programming Assignment 3', 92.00, '2024-03-12', 'Assignment'),
(2, 'MATH01', 'Algebra Weekly Test', 85.75, '2024-03-03', 'Test'),
(2, 'PHYS01', 'Mechanics Lab Report', 90.25, '2024-03-15', 'Assignment'),
(3, 'COMP02', 'Data Structures Quiz', 87.00, '2024-03-08', 'Test'),
(4, 'CHEM01', 'Organic Chemistry Midterm', 82.75, '2024-03-10', 'Test'),
(4, 'BIO01', 'Cell Biology Assignment', 91.00, '2024-03-20', 'Assignment'),
(5, 'MATH02', 'Linear Algebra Test', 89.25, '2024-03-02', 'Test'),
(5, 'PHYS02', 'Electromagnetism Quiz', 86.50, '2024-03-18', 'Test'),
(6, 'BIO02', 'Genetics Midterm', 83.75, '2024-03-06', 'Test'),
(6, 'BIO01', 'Biology Lab Report', 95.00, '2024-03-14', 'Assignment'),
(7, 'COMP01', 'Programming Final', 88.00, '2024-03-09', 'Final'),
(7, 'MATH01', 'Calculus Assignment', 84.25, '2024-03-22', 'Assignment'),
(8, 'CHEM02', 'Physical Chemistry Test', 90.75, '2024-03-04', 'Test'),
(9, 'COMP02', 'Algorithms Assignment', 93.50, '2024-03-11', 'Assignment'),
(10, 'MATH01', 'Mathematics Quiz', 81.50, '2024-03-07', 'Test'),
-- Past exams
(1, 'PHYS01', 'Physics Final Exam', 79.25, '2024-01-20', 'Final'),
(2, 'CHEM01', 'Chemistry Final', 87.75, '2024-01-18', 'Final'),
(3, 'COMP01', 'Programming Midterm', 94.50, '2024-01-15', 'Test'),
(8, 'PHYS01', 'Mechanics Test', 92.50, '2024-01-22', 'Test'),
(4, 'BIO01', 'Biology Final Exam', 89.00, '2024-01-25', 'Final');

-- =================================================================
-- INDEX CREATION SECTION
-- Author: [Your Name]
-- Date: 2025/08/27-29
-- Description: Creating indexes for the most visited rows in the database
--              to improve optomization and preformance
-- =================================================================

-- Indexes for students table
CREATE INDEX idx_students_city ON students(city);
CREATE INDEX idx_students_enrollment_date ON students(enrollment_date);
-- Indexes for module table
CREATE INDEX idx_module_faculty ON module(faculty);
CREATE INDEX idx_module_term ON module(term);
CREATE INDEX idx_module_points ON module(module_points);
-- Indexes for exam table 
CREATE INDEX idx_exam_student_id ON exam(student_id);
CREATE INDEX idx_exam_module_id ON exam(module_id);
CREATE INDEX idx_exam_exam_date ON exam(exam_date);
CREATE INDEX idx_exam_exam_type ON exam(exam_type);
CREATE INDEX idx_exam_marks ON exam(marks);


-- =================================================================
-- STORED PROCEDURES SECTION
-- Author: John Wesley Williams
-- Date: 2025/08/25-29
-- Description: Creating stored procedures and functions
-- =================================================================


-- Procedure to populate module statistics using cursor
DELIMITER //
CREATE PROCEDURE sp_Populate_Module_Stats()
BEGIN 
-- Declaring variables for the cursor
    DECLARE finished INT DEFAULT 0;
    DECLARE v_module_id VARCHAR(6);
    DECLARE v_total_attempts INT DEFAULT 0;
    DECLARE v_total_passes INT DEFAULT 0;
    DECLARE v_total_fails INT DEFAULT 0;
    DECLARE v_total_distinctions INT DEFAULT 0;
    
-- Declaring a cursor for a specific action
    DECLARE m_stats_cursor CURSOR FOR
		SELECT DISTINCT module_id FROM exam;

-- Declaring a continue handler for error handling
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET finished = 1;

-- Open your cursor
	OPEN m_stats_cursor;
    
-- Create your fetch loop to retrieve the data
	exam_loop: LOOP 
		FETCH m_stats_cursor INTO v_module_id;
        IF finished THEN
			LEAVE exam_loop;
		END IF;
        
-- Create the calcuator that counts all the exams in the exam table
	SELECT -- Counts the exams in total
	COUNT(*) INTO v_total_attempts
	FROM exam 
	WHERE module_id = v_module_id;

	SELECT -- only counts the exams that passed
	COUNT(CASE WHEN marks >= 50 AND marks < 80 THEN 1 END) INTO v_total_passes
	FROM exam 
	WHERE module_id = v_module_id;

	SELECT -- only counts the exams that failed
	COUNT(CASE WHEN marks < 50 THEN 1 END) INTO v_total_fails
	FROM exam 
	WHERE module_id = v_module_id;

	SELECT -- only counts the distinctions
	COUNT(CASE WHEN marks >= 80 THEN 1 END) INTO v_total_distinctions
	FROM exam 
	WHERE module_id = v_module_id;

-- Inserting the calculated data into the module_stats table
	INSERT INTO module_stats (module_id, total_attempts, total_passes, total_fails, total_distinctions, exam_type) VALUES 
	(v_module_id, v_total_attempts, v_total_passes, v_total_fails, v_total_distinctions, 'Final');

-- End the loop        
    END LOOP;
    
-- Close the cursor once done
	CLOSE m_stats_cursor;
-- 	End the procedure
    SELECT 'Successfully inserted new data into module_stats table' AS message;
END //
DELIMITER ;

-- Creating procedure to get the exam summary report
DELIMITER //
CREATE PROCEDURE sp_Exam_Stats()
BEGIN
	SELECT 
	m.module_id,
-- counts all the exams in the exam table and returns as total_exams_written    
    (SELECT COUNT(*) FROM exam 
    WHERE module_id = m.module_id) AS total_exams_written,
-- counts all the exams in that passed and returns as total_passes    
    (SELECT COUNT(*) FROM exam 
    WHERE module_id = m.module_id AND marks >= 50 AND marks < 80) AS total_passes,
-- counts all the exams that failed and returns as total_fails    
    (SELECT COUNT(*) FROM exam 
    WHERE module_id = m.module_id AND marks < 50) AS total_fails,
-- counts all the exams with distinctions and returns as total_distictions
    (SELECT COUNT(*) FROM exam 
    WHERE module_id = m.module_id AND marks >= 80) AS total_distinctions,
-- gets the average mark of the exams and retuns as average_mark    
    (SELECT ROUND(AVG(marks), 2) FROM exam 
    WHERE module_id = m.module_id) AS average_mark
	FROM module m;
-- End the procedure once done    
END //
DELIMITER ;

-- Creating procedure to safely insert a students' exam records only if they are in that course using a function
-- First create a function that validates if the student is enrolled or not
DELIMITER //
CREATE FUNCTION fn_Is_Student_Enrolled
(
    p_student_id INT,
    p_module_id VARCHAR(6)
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
-- checks to see if the student is enrolled
    RETURN (
        SELECT EXISTS (
            SELECT 1 FROM student_course
            WHERE student_id = p_student_id 
                AND module_id = p_module_id 
                AND status = 'Enrolled'));
END //
DELIMITER ;

-- Next create a procedure to insert to enrolled student ensuring they have been validated from the preivous function
DELIMITER //
CREATE PROCEDURE sp_Insert_Exam_With_Validation
(
    IN p_student_id INT,
    IN p_module_id VARCHAR(6),
    IN p_exam_name VARCHAR(50),
    IN p_exam_date DATE,
    IN p_marks DECIMAL(5,2),
    IN p_exam_type ENUM('Assignment', 'Test', 'Final')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
	
-- use implicit locking on the student_course to prevent dirty reads when retrieving the data
    SELECT 1 FROM student_course
    WHERE student_id = p_student_id 
        AND module_id = p_module_id 
    FOR UPDATE;

    IF NOT fn_Is_Student_Enrolled(p_student_id, p_module_id) THEN
        ROLLBACK; 	                 -- If the function has dtermined that  the student is not enrolled,
        SIGNAL SQLSTATE '45000'      -- then it sends an error message and rollsback to the start of the transaction
            SET MESSAGE_TEXT = 'Student is not enrolled in this module';
    END IF;
    
-- Once everything is verified we can add the exam record to the exam table
    INSERT INTO exam (student_id, module_id, exam_name, exam_date, marks, exam_type)
    VALUES (p_student_id, p_module_id, p_exam_name, p_exam_date, p_marks, p_exam_type);

    COMMIT;
END //
DELIMITER ;


-- Create procedure to count distinctions per module 
DELIMITER // 
CREATE PROCEDURE sp_Distinctions_Per_Module()
BEGIN
    SELECT 
        m.module_id,
        m.module_name,
        (SELECT COUNT(*) FROM exam 
        WHERE module_id = m.module_id AND marks >= 80) AS total_distinctions,
        (SELECT ROUND(AVG(marks), 2) FROM exam 
        WHERE module_id = m.module_id AND marks >= 80) AS average_distinction_mark
    FROM module m;
END //
DELIMITER ;

-- =================================================================
-- FUNCTIONS SECTION
-- =================================================================

-- Create function to identify the top preforming students over the last 30 days
DELIMITER //
CREATE FUNCTION fn_Top_Student_Last30Days()
RETURNS VARCHAR(200)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_top_student VARCHAR(200);
    
    SELECT CONCAT(s.first_name, ' ', s.last_name)
    INTO v_top_student
    FROM students s
    INNER JOIN exam e ON s.student_id = e.student_id
    WHERE e.exam_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    GROUP BY s.student_id
    HAVING AVG(e.marks) = (
        SELECT MAX(avg_marks) FROM 
			(SELECT AVG(marks) as avg_marks
            FROM exam
            WHERE exam_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
            GROUP BY student_id) as student_avgs)
    LIMIT 1; -- Only displays 1 student that did the best
    
-- Now to insert the data into the top_performers table
    IF v_top_student IS NOT NULL THEN
        INSERT INTO top_performers (student_id, module_id, exam_id, marks, exam_date, recorded_at)
        SELECT 
            e.student_id, 
            e.module_id, 
            e.exam_id, 
            e.marks, 
            e.exam_date, 
            NOW()
        FROM exam e
        WHERE e.student_id = v_student_id
        AND e.exam_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
        AND e.marks >= 90  
        AND NOT EXISTS (
            SELECT 1 FROM top_performers tp
            WHERE tp.student_id = e.student_id 
            AND tp.module_id = e.module_id 
            AND tp.exam_id = e.exam_id);
    END IF;
    
    RETURN IFNULL(v_top_student, 'No students found');
END //
DELIMITER ;

-- =================================================================
-- TRIGGER CREATION SECTION
-- Author: John Wesley Williams
-- Date: 2025/08/27-29
-- Description: Creating triggers
-- =================================================================

-- Creating a trigger to update the exam_audit table
-- Berfore update trigger is for logging the new and old exams
DELIMITER //
CREATE TRIGGER trg_exam_before_update
BEFORE UPDATE ON exam
FOR EACH ROW
BEGIN
    DECLARE v_change_type ENUM('INSERT', 'UPDATE', 'DELETE') DEFAULT 'UPDATE';
    DECLARE v_user_name VARCHAR(50) DEFAULT USER();
-- Adding the old and new marks to the audit table
    INSERT INTO exam_audit (student_id, module_id, exam_id, old_mark, new_mark, change_type) VALUES 
    (OLD.student_id, OLD.module_id, OLD.exam_id, OLD.marks, NEW.marks, v_change_type);
END //

-- After update trigger is for add students that got 90% into the top preformers table
CREATE TRIGGER trg_exam_after_insert
AFTER INSERT ON exam
FOR EACH ROW
BEGIN 
    DECLARE v_distinction_mark DECIMAL(5,2) DEFAULT 90.00;
-- If the student got 90% or higher they are then add to the top preformers table    
    IF NEW.marks >= v_distinction_mark THEN
        INSERT INTO top_performers (student_id, module_id, exam_id, marks, exam_date, recorded_at) VALUES 
        (NEW.student_id, NEW.module_id, NEW.exam_id, NEW.marks, NEW.exam_date, NOW());
    END IF;
END //
DELIMITER ;

-- =================================================================
-- VIEWS CREATION SECTION
-- Author: John Wesley Williams
-- Date: 2025/08/27-29
-- Description: Creating views 
-- =================================================================

-- View to see student stats based on their marks
CREATE VIEW vw_status AS
SELECT 
    e.student_id,
    (SELECT CONCAT(first_name, ' ', last_name) FROM students 
    WHERE student_id = e.student_id) AS student,
    e.module_id,
    (SELECT module_name FROM module 
    WHERE module_id = e.module_id) AS module_name,
    e.marks,
    CASE 
        WHEN e.marks >= 80 THEN 'Distinction'
        WHEN e.marks >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS status
FROM exam e;

CREATE VIEW vw_avg_marks_by_city AS
SELECT
    city_stats.city,
    city_stats.total_students,
    exam_stats.total_exams,
    exam_stats.average_mark,
    exam_stats.distinctions,
    exam_stats.passes,
    exam_stats.fails
	FROM (SELECT city, COUNT(*) AS total_students FROM students
    GROUP BY city) AS city_stats
LEFT JOIN (SELECT 
        s.city,
        COUNT(e.exam_id) AS total_exams,
        ROUND(AVG(e.marks), 2) AS average_mark,
        COUNT(CASE WHEN e.marks >= 80 THEN 1 END) AS distinctions,
        COUNT(CASE WHEN e.marks >= 50 AND e.marks < 80 THEN 1 END) AS passes,
        COUNT(CASE WHEN e.marks < 50 THEN 1 END) AS fails
    FROM students s
    LEFT JOIN exam e ON s.student_id = e.student_id
    GROUP BY s.city
)	AS exam_stats ON city_stats.city = exam_stats.city;


-- =================================================================
-- TESTING SECTION
-- Author: John Wesley Williams
-- Date: 2025/08/28
-- Description: Testing all views, triggers, cursors, functions and the structure of the database
-- =================================================================

-- Populate module statistics
CALL sp_Populate_Module_Stats();

-- Display module statistics
SELECT 'MODULE STATISTICS' AS section;
SELECT * FROM module_stats ORDER BY average_mark DESC;

-- Get overall exam statistics
SELECT 'OVERALL EXAM STATISTICS' AS section;
CALL sp_Exam_Stats();

-- Show distinctions per module
SELECT 'DISTINCTIONS PER MODULE' AS section;
CALL sp_Distinctions_Per_Module();

-- Test the top student function
SELECT 'TOP STUDENT LAST 30 DAYS' AS section;
SELECT fn_Top_Student_Last30Days() AS top_performer;

-- Display views
SELECT 'STUDENT STATUS VIEW' AS section;
SELECT * FROM vw_status;

SELECT 'AVERAGE MARKS BY CITY VIEW' AS section;
SELECT * FROM vw_avg_marks_by_city;

-- =================================================================
-- TESTING VALIDATION AND TRIGGERS
-- =================================================================

-- Test 1: Try to insert exam for non-enrolled student (should fail)
SELECT 'TESTING VALIDATION - This should fail:' AS test_section;
-- Uncomment the line below to test validation failure
-- CALL sp_Insert_Exam_With_Validation(99, 'CS101', '2025-08-18', 75.00, 'Test');

-- Test 2: Insert valid exam (should succeed)
SELECT 'TESTING VALIDATION - This should succeed:' AS test_section;
CALL sp_Insert_Exam_With_Validation(1, 'CS101', 'MATHSPAPER1', '2025-08-18', 87.50, 'Test');

-- Test 3: Update an exam mark to trigger audit
SELECT 'TESTING AUDIT TRIGGER' AS test_section;
UPDATE exam SET marks = 90.00 WHERE exam_id = 1;

-- Show audit results
SELECT 'AUDIT TRAIL' AS section;
SELECT * FROM exam_audit ORDER BY change_date DESC LIMIT 5;

-- Show top performers
SELECT 'TOP PERFORMERS (>90%)' AS section;
SELECT 
    tp.performer_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    tp.module_id,
    tp.marks,
    tp.exam_date
FROM top_performers tp
INNER JOIN students s ON tp.student_id = s.student_id
ORDER BY tp.marks DESC;