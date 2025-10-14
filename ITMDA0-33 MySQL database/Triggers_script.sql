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