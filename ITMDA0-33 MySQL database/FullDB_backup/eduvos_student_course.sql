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
-- Table structure for table `student_course`
--

DROP TABLE IF EXISTS `student_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_course` (
  `student_id` int NOT NULL,
  `module_id` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enrollment_date` date NOT NULL DEFAULT (curdate()),
  `status` enum('Enrolled','Suspended','Graduated') COLLATE utf8mb4_unicode_ci DEFAULT 'Enrolled',
  PRIMARY KEY (`student_id`,`module_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `student_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `student_course_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course`
--

LOCK TABLES `student_course` WRITE;
/*!40000 ALTER TABLE `student_course` DISABLE KEYS */;
INSERT INTO `student_course` VALUES (1,'COMP01','2022-09-01','Enrolled'),(1,'MATH01','2022-09-01','Enrolled'),(1,'PHYS01','2022-09-01','Enrolled'),(2,'CHEM01','2022-09-01','Enrolled'),(2,'MATH01','2022-09-01','Enrolled'),(2,'PHYS01','2022-09-01','Enrolled'),(3,'COMP01','2021-09-01','Enrolled'),(3,'COMP02','2022-01-15','Enrolled'),(4,'BIO01','2022-09-01','Enrolled'),(4,'CHEM01','2022-09-01','Enrolled'),(5,'MATH02','2022-09-01','Enrolled'),(5,'PHYS02','2022-09-01','Enrolled'),(6,'BIO01','2022-09-01','Enrolled'),(6,'BIO02','2022-09-01','Enrolled'),(7,'COMP01','2021-09-01','Enrolled'),(7,'MATH01','2021-09-01','Enrolled'),(8,'CHEM02','2022-09-01','Enrolled'),(8,'PHYS01','2022-09-01','Enrolled'),(9,'COMP02','2022-09-01','Enrolled'),(10,'MATH01','2022-09-01','Enrolled');
/*!40000 ALTER TABLE `student_course` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-29 12:21:04
