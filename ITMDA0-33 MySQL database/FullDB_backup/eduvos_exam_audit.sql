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
-- Table structure for table `exam_audit`
--

DROP TABLE IF EXISTS `exam_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_audit` (
  `audit_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `module_id` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_id` int NOT NULL,
  `old_mark` decimal(5,2) DEFAULT NULL,
  `new_mark` decimal(5,2) DEFAULT NULL,
  `change_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change_type` enum('INSERT','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `exam_id` (`exam_id`),
  KEY `student_id` (`student_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `exam_audit_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`) ON DELETE CASCADE,
  CONSTRAINT `exam_audit_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `exam_audit_ibfk_3` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_audit`
--

LOCK TABLES `exam_audit` WRITE;
/*!40000 ALTER TABLE `exam_audit` DISABLE KEYS */;
INSERT INTO `exam_audit` VALUES (1,1,'MATH01',1,88.50,90.00,'2025-08-29 09:33:23','UPDATE');
/*!40000 ALTER TABLE `exam_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-29 12:21:03
