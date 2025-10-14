-- =============================================
-- User Documentation
-- Author: John Wesley Williams
-- Date: 2025/08/29
-- Purpose: Complete documentation of the eduvos database
-- =============================================

/*
EDUVOS MANAGEMENT SYSTEM - USER DOCUMENTATION

1. SYSTEM OVERVIEW:
   - Prevents unregistored students from entering exam records
   - Logs new records of existing students
   - Provides comprehensive reporting capabilities

2. KEY TABLES:
   - students: Stores student information
   - module: Stores module information
   - student_course: Stores infromation on students and what modules they are taking
   - exam: Stores information on the exams that students write
   - module_stats: stores statistics about the various exams such as how many students passed/failed a module
   - exam_audit: Stores old data and changes to exam marks
   - top_preformers: - Stores data on the top ranked students

3. MAIN PROCEDURES:
   - sp_Populate_Module_Stats: Inserts data from exam table into module_stats table
   - sp_Exam_stats: procedure to get the exam summary report
   - sp_Insert_Exam_With_Validation: A procedure to safely insert a students' exam records only if they are in that course using a function
   - sp_Distinctions_Per_Module: A procedure to count distinctions per module 

4. FUNCTIONS
   - fn_Top_Student_Last30Days: A function to identify the top preforming students over the last 30 days and insert them into the top_performers table
   
5. TRIGGERS:   
	-trg_exam_before_update: A trigger to update the exam_audit table
   -trg_exam_after_insert: A trigger to add the top students to the top_performers table
   
6. VIEWS:   
   - vw_stats: A view to see student stats based on their marks
   - vw_vw_avg_marks_by_city: A view to see the average marks based on the city
*/