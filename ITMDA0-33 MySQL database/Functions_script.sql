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

SELECT * FROM top_performers;