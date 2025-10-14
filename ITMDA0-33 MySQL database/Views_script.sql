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
