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