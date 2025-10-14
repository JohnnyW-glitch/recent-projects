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
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `module_id` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marks` decimal(5,2) NOT NULL,
  `exam_date` date NOT NULL,
  `exam_type` enum('Assignment','Test','Final') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `idx_exam_student_id` (`student_id`),
  KEY `idx_exam_module_id` (`module_id`),
  KEY `idx_exam_exam_date` (`exam_date`),
  KEY `idx_exam_exam_type` (`exam_type`),
  KEY `idx_exam_marks` (`marks`),
  CONSTRAINT `exam_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `exam_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_marks` CHECK ((`marks` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` VALUES (1,1,'MATH01','Calculus Midterm Exam',90.00,'2024-03-05','Test'),(2,1,'COMP01','Programming Assignment 3',92.00,'2024-03-12','Assignment'),(3,2,'MATH01','Algebra Weekly Test',85.75,'2024-03-03','Test'),(4,2,'PHYS01','Mechanics Lab Report',90.25,'2024-03-15','Assignment'),(5,3,'COMP02','Data Structures Quiz',87.00,'2024-03-08','Test'),(6,4,'CHEM01','Organic Chemistry Midterm',82.75,'2024-03-10','Test'),(7,4,'BIO01','Cell Biology Assignment',91.00,'2024-03-20','Assignment'),(8,5,'MATH02','Linear Algebra Test',89.25,'2024-03-02','Test'),(9,5,'PHYS02','Electromagnetism Quiz',86.50,'2024-03-18','Test'),(10,6,'BIO02','Genetics Midterm',83.75,'2024-03-06','Test'),(11,6,'BIO01','Biology Lab Report',95.00,'2024-03-14','Assignment'),(12,7,'COMP01','Programming Final',88.00,'2024-03-09','Final'),(13,7,'MATH01','Calculus Assignment',84.25,'2024-03-22','Assignment'),(14,8,'CHEM02','Physical Chemistry Test',90.75,'2024-03-04','Test'),(15,9,'COMP02','Algorithms Assignment',93.50,'2024-03-11','Assignment'),(16,10,'MATH01','Mathematics Quiz',81.50,'2024-03-07','Test'),(17,1,'PHYS01','Physics Final Exam',79.25,'2024-01-20','Final'),(18,2,'CHEM01','Chemistry Final',87.75,'2024-01-18','Final'),(19,3,'COMP01','Programming Midterm',94.50,'2024-01-15','Test'),(20,8,'PHYS01','Mechanics Test',92.50,'2024-01-22','Test'),(21,4,'BIO01','Biology Final Exam',89.00,'2024-01-25','Final');
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_exam_after_insert` AFTER INSERT ON `exam` FOR EACH ROW BEGIN 
    DECLARE v_distinction_mark DECIMAL(5,2) DEFAULT 90.00;
-- If the student got 90% or higher they are then add to the top preformers table    
    IF NEW.marks >= v_distinction_mark THEN
        INSERT INTO top_performers (student_id, module_id, exam_id, marks, exam_date, recorded_at) VALUES 
        (NEW.student_id, NEW.module_id, NEW.exam_id, NEW.marks, NEW.exam_date, NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_exam_before_update` BEFORE UPDATE ON `exam` FOR EACH ROW BEGIN
    DECLARE v_change_type ENUM('INSERT', 'UPDATE', 'DELETE') DEFAULT 'UPDATE';
    DECLARE v_user_name VARCHAR(50) DEFAULT USER();
-- Adding the old and new marks to the audit table
    INSERT INTO exam_audit (student_id, module_id, exam_id, old_mark, new_mark, change_type) VALUES 
    (OLD.student_id, OLD.module_id, OLD.exam_id, OLD.marks, NEW.marks, v_change_type);
END */;;
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

-- Dump completed on 2025-08-29 12:21:03
