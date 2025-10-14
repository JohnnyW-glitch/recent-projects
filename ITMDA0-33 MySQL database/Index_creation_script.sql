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