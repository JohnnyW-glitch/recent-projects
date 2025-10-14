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
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `module` (
  `module_id` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `faculty` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_points` int NOT NULL DEFAULT '1',
  `term` int NOT NULL,
  PRIMARY KEY (`module_id`),
  KEY `idx_module_faculty` (`faculty`),
  KEY `idx_module_term` (`term`),
  KEY `idx_module_points` (`module_points`),
  CONSTRAINT `chk_module_points` CHECK ((`module_points` between 1 and 10)),
  CONSTRAINT `chk_term` CHECK ((`term` between 1 and 4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES ('BIO01','Cell Biology','Biology','CELL101',3,1),('BIO02','Genetics','Biology','GENE102',3,2),('CHEM01','Organic Chemistry','Chemistry','ORGC101',4,1),('CHEM02','Physical Chemistry','Chemistry','PHYC102',4,2),('COMP01','Programming Fundamentals','Computer Science','PROG101',6,1),('COMP02','Data Structures','Computer Science','DATA102',6,2),('MATH01','Calculus I','Mathematics','CAL101',5,1),('MATH02','Linear Algebra','Mathematics','LINAL102',4,2),('PHYS01','Classical Mechanics','Physics','MECH101',5,1),('PHYS02','Electromagnetism','Physics','ELEC102',5,2);
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
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
