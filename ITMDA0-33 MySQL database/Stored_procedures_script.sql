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

