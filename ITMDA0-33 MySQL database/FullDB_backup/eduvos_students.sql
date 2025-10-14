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
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enrollment_date` date NOT NULL DEFAULT (curdate()),
  `status` enum('Active','Inactive','Graduated') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_students_city` (`city`),
  KEY `idx_students_enrollment_date` (`enrollment_date`),
  CONSTRAINT `chk_email_format` CHECK ((`email` like _utf8mb4'%@%.edu%'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'John','Smith','2000-05-15','Cape Town','john.smith@harvard.edu','2022-09-01','Active'),(2,'Emma','Johnson','2001-02-28','Johannesburg','emma.johnson@harvard.edu','2022-09-01','Active'),(3,'Michael','Brown','1999-11-10','Durban','michael.brown@harvard.edu','2021-09-01','Active'),(4,'Sophia','Davis','2000-08-22','Pretoria','sophia.davis@harvard.edu','2022-09-01','Active'),(5,'James','Wilson','2001-03-17','Pretoria','james.wilson@harvard.edu','2022-09-01','Active'),(6,'Olivia','Taylor','2000-12-05','Cape Town','olivia.taylor@harvard.edu','2022-09-01','Active'),(7,'William','Anderson','1999-07-30','Durban','william.anderson@harvard.edu','2021-09-01','Active'),(8,'Isabella','Thomas','2000-04-12','Johannesburg','isabella.thomas@harvard.edu','2022-09-01','Active'),(9,'Benjamin','Jackson','2001-01-25','Pretoria','benjamin.jackson@harvard.edu','2022-09-01','Active'),(10,'Charlotte','White','2000-09-18','Cape Town','charlotte.white@harvard.edu','2022-09-01','Active');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
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
