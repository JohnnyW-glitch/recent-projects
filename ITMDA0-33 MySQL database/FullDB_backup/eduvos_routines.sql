-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: eduvos
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `vw_status`
--

DROP TABLE IF EXISTS `vw_status`;
/*!50001 DROP VIEW IF EXISTS `vw_status`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_status` AS SELECT 
 1 AS `student_id`,
 1 AS `student`,
 1 AS `module_id`,
 1 AS `module_name`,
 1 AS `marks`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_avg_marks_by_city`
--

DROP TABLE IF EXISTS `vw_avg_marks_by_city`;
/*!50001 DROP VIEW IF EXISTS `vw_avg_marks_by_city`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_avg_marks_by_city` AS SELECT 
 1 AS `city`,
 1 AS `total_students`,
 1 AS `total_exams`,
 1 AS `average_mark`,
 1 AS `distinctions`,
 1 AS `passes`,
 1 AS `fails`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_status`
--

/*!50001 DROP VIEW IF EXISTS `vw_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_status` AS select `e`.`student_id` AS `student_id`,(select concat(`students`.`first_name`,' ',`students`.`last_name`) from `students` where (`students`.`student_id` = `e`.`student_id`)) AS `student`,`e`.`module_id` AS `module_id`,(select `module`.`module_name` from `module` where (`module`.`module_id` = `e`.`module_id`)) AS `module_name`,`e`.`marks` AS `marks`,(case when (`e`.`marks` >= 80) then 'Distinction' when (`e`.`marks` >= 50) then 'Pass' else 'Fail' end) AS `status` from `exam` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_avg_marks_by_city`
--

/*!50001 DROP VIEW IF EXISTS `vw_avg_marks_by_city`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_avg_marks_by_city` AS select `city_stats`.`city` AS `city`,`city_stats`.`total_students` AS `total_students`,`exam_stats`.`total_exams` AS `total_exams`,`exam_stats`.`average_mark` AS `average_mark`,`exam_stats`.`distinctions` AS `distinctions`,`exam_stats`.`passes` AS `passes`,`exam_stats`.`fails` AS `fails` from ((select `students`.`city` AS `city`,count(0) AS `total_students` from `students` group by `students`.`city`) `city_stats` left join (select `s`.`city` AS `city`,count(`e`.`exam_id`) AS `total_exams`,round(avg(`e`.`marks`),2) AS `average_mark`,count((case when (`e`.`marks` >= 80) then 1 end)) AS `distinctions`,count((case when ((`e`.`marks` >= 50) and (`e`.`marks` < 80)) then 1 end)) AS `passes`,count((case when (`e`.`marks` < 50) then 1 end)) AS `fails` from (`students` `s` left join `exam` `e` on((`s`.`student_id` = `e`.`student_id`))) group by `s`.`city`) `exam_stats` on((`city_stats`.`city` = `exam_stats`.`city`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'eduvos'
--

--
-- Dumping routines for database 'eduvos'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_Is_Student_Enrolled` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_Is_Student_Enrolled`(
    p_student_id INT,
    p_module_id VARCHAR(6)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
-- checks to see if the student is enrolled
    RETURN (
        SELECT EXISTS (
            SELECT 1 FROM student_course
            WHERE student_id = p_student_id 
                AND module_id = p_module_id 
                AND status = 'Enrolled'));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_Top_Student_Last30Days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_Top_Student_Last30Days`() RETURNS varchar(200) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    READS SQL DATA
    DETERMINISTIC
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
        AND e.marks >= 90  -- Only insert distinctions
        AND NOT EXISTS (
            SELECT 1 FROM top_performers tp
            WHERE tp.student_id = e.student_id 
            AND tp.module_id = e.module_id 
            AND tp.exam_id = e.exam_id);
    END IF;
    
    RETURN IFNULL(v_top_student, 'No students found');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Distinctions_Per_Module` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Distinctions_Per_Module`()
BEGIN
    SELECT 
        m.module_id,
        m.module_name,
        (SELECT COUNT(*) FROM exam 
        WHERE module_id = m.module_id AND marks >= 80) AS total_distinctions,
        (SELECT ROUND(AVG(marks), 2) FROM exam 
        WHERE module_id = m.module_id AND marks >= 80) AS average_distinction_mark
    FROM module m;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Exam_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Exam_Stats`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Exam_With_Validation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Exam_With_Validation`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Populate_Module_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Populate_Module_Stats`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-29 12:21:04
