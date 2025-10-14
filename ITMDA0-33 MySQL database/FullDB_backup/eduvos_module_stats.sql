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
-- Table structure for table `module_stats`
--

DROP TABLE IF EXISTS `module_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_stats` (
  `stat_id` int NOT NULL AUTO_INCREMENT,
  `module_id` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_attempts` int DEFAULT '0',
  `total_passes` int DEFAULT '0',
  `total_fails` int DEFAULT '0',
  `total_distinctions` int DEFAULT '0',
  `average_mark` decimal(5,2) DEFAULT (0.00),
  `exam_type` enum('Assignment','Test','Final') COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`stat_id`),
  UNIQUE KEY `module_id` (`module_id`,`exam_type`),
  CONSTRAINT `module_stats_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_attempts` CHECK ((`total_attempts` >= 0)),
  CONSTRAINT `chk_distinctions` CHECK ((`total_distinctions` >= 0)),
  CONSTRAINT `chk_fails` CHECK ((`total_fails` >= 0)),
  CONSTRAINT `chk_passes` CHECK ((`total_passes` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_stats`
--

LOCK TABLES `module_stats` WRITE;
/*!40000 ALTER TABLE `module_stats` DISABLE KEYS */;
INSERT INTO `module_stats` VALUES (1,'BIO01',3,0,0,3,0.00,'Final','2025-08-29 09:25:55'),(2,'BIO02',1,0,0,1,0.00,'Final','2025-08-29 09:25:55'),(3,'CHEM01',2,0,0,2,0.00,'Final','2025-08-29 09:25:55'),(4,'CHEM02',1,0,0,1,0.00,'Final','2025-08-29 09:25:55'),(5,'COMP01',3,0,0,3,0.00,'Final','2025-08-29 09:25:55'),(6,'COMP02',2,0,0,2,0.00,'Final','2025-08-29 09:25:55'),(7,'MATH01',4,0,0,4,0.00,'Final','2025-08-29 09:25:55'),(8,'MATH02',1,0,0,1,0.00,'Final','2025-08-29 09:25:55'),(9,'PHYS01',3,1,0,2,0.00,'Final','2025-08-29 09:25:55'),(10,'PHYS02',1,0,0,1,0.00,'Final','2025-08-29 09:25:55');
/*!40000 ALTER TABLE `module_stats` ENABLE KEYS */;
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
