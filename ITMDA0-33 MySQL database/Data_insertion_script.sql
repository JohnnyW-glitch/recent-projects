-- =================================================================
-- SAMPLE DATA INSERTION
-- Author: John Wesley Williams
-- Date: 2025/08/24-29
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
