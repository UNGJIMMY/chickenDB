CREATE DATABASE  IF NOT EXISTS `chicken` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chicken`;
-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (arm64)
--
-- Host: localhost    Database: chicken
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Salary` int DEFAULT NULL,
  `Contract_Start_Date` datetime DEFAULT NULL,
  `Contract_End_Date` datetime DEFAULT NULL,
  `Date_of_Birth` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `administrator_chk_1` CHECK ((`Contract_Start_Date` <= `Contract_End_Date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES (1,'Michael Scott',55000,'2021-06-01 00:00:00','2024-05-31 00:00:00','1975-03-15 00:00:00'),(2,'Jim Halpert',62000,'2022-01-15 00:00:00','2025-01-14 00:00:00','1985-10-01 00:00:00'),(3,'Pam Beesly',48000,'2020-09-01 00:00:00','2023-08-31 00:00:00','1986-03-25 00:00:00'),(4,'Dwight Schrute',70000,'2023-03-01 00:00:00','2026-02-28 00:00:00','1978-01-20 00:00:00'),(5,'Angela Martin',53000,'2021-11-01 00:00:00','2024-10-31 00:00:00','1979-06-06 00:00:00'),(6,'Kevin Malone',46000,'2019-07-15 00:00:00','2022-07-14 00:00:00','1982-08-12 00:00:00'),(7,'Stanley Hudson',68000,'2022-04-01 00:00:00','2025-03-31 00:00:00','1968-02-19 00:00:00'),(8,'Ryan Howard',52000,'2020-12-01 00:00:00','2023-11-30 00:00:00','1987-04-10 00:00:00'),(9,'Kelly Kapoor',50000,'2023-01-01 00:00:00','2025-12-31 00:00:00','1989-09-25 00:00:00'),(10,'Toby Flenderson',60000,'2021-02-01 00:00:00','2024-01-31 00:00:00','1974-11-02 00:00:00');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Content`
--

DROP TABLE IF EXISTS `Content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Content` (
  `Title` varchar(45) NOT NULL,
  `Director` varchar(45) NOT NULL,
  `Published_Date` datetime DEFAULT NULL,
  `Expired_Date` datetime DEFAULT NULL,
  `Administrator_ID` int NOT NULL,
  `Original_Content_Producer_ID` int DEFAULT NULL,
  `Distributor_ID` int DEFAULT NULL,
  PRIMARY KEY (`Title`,`Director`,`Administrator_ID`),
  KEY `Administrator_ID` (`Administrator_ID`),
  KEY `Original_Content_Producer_ID` (`Original_Content_Producer_ID`),
  KEY `Distributor_ID` (`Distributor_ID`),
  CONSTRAINT `content_ibfk_1` FOREIGN KEY (`Administrator_ID`) REFERENCES `administrator` (`ID`),
  CONSTRAINT `content_ibfk_2` FOREIGN KEY (`Original_Content_Producer_ID`) REFERENCES `original_content_producer` (`ID`),
  CONSTRAINT `content_ibfk_3` FOREIGN KEY (`Distributor_ID`) REFERENCES `distributor` (`ID`),
  CONSTRAINT `content_chk_1` CHECK ((`published_date` <= `Expired_date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Content`
--

LOCK TABLES `Content` WRITE;
/*!40000 ALTER TABLE `Content` DISABLE KEYS */;
INSERT INTO `Content` VALUES ('Blue Circuit','Chloe Ryu','2023-05-22 00:00:00','2026-05-21 00:00:00',2,NULL,3),('Broken Synthesis','Ella Min','2020-07-30 00:00:00','2023-07-29 00:00:00',1,NULL,4),('Celestial Loop','Zoe Chae','2023-02-27 00:00:00','2026-02-26 00:00:00',9,NULL,2),('Crystal Path','Olivia Jung','2021-06-05 00:00:00','2024-06-04 00:00:00',6,NULL,1),('Dark Parallax','Chris Oh','2023-06-15 00:00:00','2026-06-14 00:00:00',5,NULL,5),('Digital Horizon','Sarah Lee','2022-01-25 00:00:00','2025-01-24 00:00:00',5,NULL,4),('Echo Valley','Nathan Seo','2021-08-01 00:00:00','2023-07-31 00:00:00',10,NULL,1),('Edge Protocol','Hailey Shim','2021-07-03 00:00:00','2024-07-02 00:00:00',3,NULL,1),('Eternal Flame','John Kim','2021-03-12 00:00:00','2024-03-11 00:00:00',2,NULL,1),('Fractal Dream','Sophia Cho','2022-04-14 00:00:00','2025-04-13 00:00:00',8,NULL,4),('Frozen Signal','Brian Lee','2023-01-19 00:00:00','2025-01-18 00:00:00',3,NULL,1),('Hidden Nova','Grace Park','2022-08-05 00:00:00','2024-08-04 00:00:00',6,NULL,3),('Hypertrace','Lucas Noh','2022-12-09 00:00:00','2025-12-08 00:00:00',8,NULL,1),('Last Frequency','Josh Lim','2021-01-01 00:00:00','2023-12-31 00:00:00',7,NULL,2),('Lumina Pulse','Ethan Baek','2021-09-30 00:00:00','2024-09-29 00:00:00',10,NULL,4),('Midnight Waves','Henry Shin','2022-10-15 00:00:00','2025-10-14 00:00:00',4,NULL,2),('Neon Skyline','David Han','2022-11-20 00:00:00','2024-11-20 00:00:00',9,NULL,2),('Neural Wake','Jake Moon','2020-06-25 00:00:00','2023-06-24 00:00:00',9,NULL,5),('Nova Colony','Caleb Koo','2022-06-30 00:00:00','2025-06-29 00:00:00',1,NULL,5),('Orbital Drift','Mia Lim','2020-08-08 00:00:00','2023-08-07 00:00:00',10,NULL,4),('Paradox Flame','Luna Jang','2023-01-07 00:00:00','2026-01-06 00:00:00',3,NULL,1),('Phantom Logic','Eric Hwang','2021-10-05 00:00:00','2024-10-04 00:00:00',6,NULL,4),('Quantum Drift','James Yoo','2023-02-18 00:00:00','2025-02-18 00:00:00',8,NULL,5),('Riftwalker','Eleanor Jang','2023-03-10 00:00:00','2025-03-10 00:00:00',1,NULL,2),('Shadow Dancer','Ava Kim','2020-12-12 00:00:00','2023-12-11 00:00:00',5,NULL,5),('Silent Theory','Leo Yoon','2020-11-21 00:00:00','2023-11-20 00:00:00',2,NULL,2),('Static Bloom','Mason Song','2021-04-18 00:00:00','2024-04-17 00:00:00',2,NULL,3),('The Forgotten Echo','Liam Park','2023-04-10 00:00:00','2026-04-09 00:00:00',7,NULL,3),('Timeless Glow','Irene Kwon','2022-02-11 00:00:00','2025-02-10 00:00:00',4,NULL,5),('Violet Reboot','Nicole Jung','2020-05-10 00:00:00','2023-05-09 00:00:00',7,NULL,3),('Whispering Shadows','Emily Choi','2020-09-01 00:00:00','2023-08-31 00:00:00',3,NULL,5);
/*!40000 ALTER TABLE `Content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContentGenre`
--

DROP TABLE IF EXISTS `ContentGenre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContentGenre` (
  `Genre_ID` int NOT NULL,
  `Content_Administrator_ID` int NOT NULL,
  `Content_Title` varchar(45) NOT NULL,
  `Content_Director` varchar(45) NOT NULL,
  PRIMARY KEY (`Genre_ID`,`Content_Administrator_ID`,`Content_Title`,`Content_Director`),
  KEY `Content_Title` (`Content_Title`,`Content_Director`,`Content_Administrator_ID`),
  CONSTRAINT `contentgenre_ibfk_1` FOREIGN KEY (`Genre_ID`) REFERENCES `genre` (`ID`),
  CONSTRAINT `contentgenre_ibfk_2` FOREIGN KEY (`Content_Title`, `Content_Director`, `Content_Administrator_ID`) REFERENCES `content` (`Title`, `Director`, `Administrator_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContentGenre`
--

LOCK TABLES `ContentGenre` WRITE;
/*!40000 ALTER TABLE `ContentGenre` DISABLE KEYS */;
INSERT INTO `ContentGenre` VALUES (1,2,'Blue Circuit','Chloe Ryu'),(1,1,'Broken Synthesis','Ella Min'),(5,9,'Celestial Loop','Zoe Chae'),(3,6,'Crystal Path','Olivia Jung'),(8,6,'Crystal Path','Olivia Jung'),(3,5,'Dark Parallax','Chris Oh'),(7,5,'Dark Parallax','Chris Oh'),(3,5,'Digital Horizon','Sarah Lee'),(7,5,'Digital Horizon','Sarah Lee'),(5,10,'Echo Valley','Nathan Seo'),(2,3,'Edge Protocol','Hailey Shim'),(7,3,'Edge Protocol','Hailey Shim'),(1,2,'Eternal Flame','John Kim'),(4,8,'Fractal Dream','Sophia Cho'),(8,8,'Fractal Dream','Sophia Cho'),(2,3,'Frozen Signal','Brian Lee'),(7,3,'Frozen Signal','Brian Lee'),(4,6,'Hidden Nova','Grace Park'),(8,6,'Hidden Nova','Grace Park'),(5,8,'Hypertrace','Lucas Noh'),(4,7,'Last Frequency','Josh Lim'),(8,7,'Last Frequency','Josh Lim'),(5,10,'Lumina Pulse','Ethan Baek'),(3,4,'Midnight Waves','Henry Shin'),(7,4,'Midnight Waves','Henry Shin'),(5,9,'Neon Skyline','David Han'),(5,9,'Neural Wake','Jake Moon'),(1,1,'Nova Colony','Caleb Koo'),(6,10,'Orbital Drift','Mia Lim'),(2,3,'Paradox Flame','Luna Jang'),(7,3,'Paradox Flame','Luna Jang'),(4,6,'Phantom Logic','Eric Hwang'),(8,6,'Phantom Logic','Eric Hwang'),(5,8,'Quantum Drift','James Yoo'),(1,1,'Riftwalker','Eleanor Jang'),(3,5,'Shadow Dancer','Ava Kim'),(8,5,'Shadow Dancer','Ava Kim'),(2,2,'Silent Theory','Leo Yoon'),(2,2,'Static Bloom','Mason Song'),(4,7,'The Forgotten Echo','Liam Park'),(8,7,'The Forgotten Echo','Liam Park'),(3,4,'Timeless Glow','Irene Kwon'),(7,4,'Timeless Glow','Irene Kwon'),(4,7,'Violet Reboot','Nicole Jung'),(8,7,'Violet Reboot','Nicole Jung'),(2,3,'Whispering Shadows','Emily Choi'),(7,3,'Whispering Shadows','Emily Choi');
/*!40000 ALTER TABLE `ContentGenre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distributor`
--

DROP TABLE IF EXISTS `distributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `distributor` (
  `ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distributor`
--

LOCK TABLES `distributor` WRITE;
/*!40000 ALTER TABLE `distributor` DISABLE KEYS */;
INSERT INTO `distributor` VALUES (1,'Junho\r'),(2,'Minho\r'),(3,'Ungjin\r'),(4,'Cheese\r'),(5,'Conanh');
/*!40000 ALTER TABLE `distributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Happy\r'),(2,'Comedy\r'),(3,'Funny\r'),(4,'Refresh\r'),(5,'Romance\r'),(6,'Fantasy\r'),(7,'Weird\r'),(8,'Horror');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Date_of_Birth` datetime DEFAULT NULL,
  `Subscription_Start_Date` datetime DEFAULT NULL,
  `Subscription_End_Date` datetime DEFAULT NULL,
  `Subscription_ID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Subscription_ID` (`Subscription_ID`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`Subscription_ID`) REFERENCES `subscription` (`ID`),
  CONSTRAINT `member_chk_1` CHECK ((`subscription_start_date` <= `subscription_end_date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'John Smith','john.smith@example.com','1985-07-12 00:00:00','2024-01-01 00:00:00','2025-01-01 00:00:00',1),(2,'Emily Davis','emily.davis@example.com','1990-03-22 00:00:00',NULL,NULL,NULL),(3,'Michael Johnson','michael.johnson@example.com','1978-11-30 00:00:00','2023-05-15 00:00:00','2024-05-15 00:00:00',2),(4,'Sarah Wilson','sarah.wilson@example.com','1995-06-18 00:00:00',NULL,NULL,NULL),(5,'David Martinez','david.martinez@example.com','1982-09-09 00:00:00','2023-08-01 00:00:00','2024-08-01 00:00:00',3),(6,'Linda Taylor','linda.taylor@example.com','1987-12-27 00:00:00',NULL,NULL,NULL),(7,'James Anderson','james.anderson@example.com','1991-01-04 00:00:00','2024-03-10 00:00:00','2025-03-10 00:00:00',4),(8,'Patricia Thomas','patricia.thomas@example.com','1983-05-23 00:00:00',NULL,NULL,NULL),(9,'Robert Jackson','robert.jackson@example.com','1979-10-14 00:00:00',NULL,NULL,NULL),(10,'Mary White','mary.white@example.com','1986-08-30 00:00:00','2023-11-20 00:00:00','2024-11-20 00:00:00',2),(11,'William Harris','william.harris@example.com','1992-04-16 00:00:00',NULL,NULL,NULL),(12,'Barbara Martin','barbara.martin@example.com','1984-07-05 00:00:00','2024-02-01 00:00:00','2025-02-01 00:00:00',1),(13,'Charles Thompson','charles.thompson@example.com','1977-03-28 00:00:00',NULL,NULL,NULL),(14,'Susan Garcia','susan.garcia@example.com','1993-09-12 00:00:00',NULL,NULL,NULL),(15,'Joseph Martinez','joseph.martinez@example.com','1980-01-20 00:00:00','2023-06-15 00:00:00','2024-06-15 00:00:00',3),(16,'Karen Robinson','karen.robinson@example.com','1988-11-08 00:00:00',NULL,NULL,NULL),(17,'Daniel Clark','daniel.clark@example.com','1994-02-25 00:00:00',NULL,NULL,NULL),(18,'Nancy Rodriguez','nancy.rodriguez@example.com','1981-10-07 00:00:00','2024-04-10 00:00:00','2025-04-10 00:00:00',4),(19,'Matthew Lewis','matthew.lewis@example.com','1976-05-29 00:00:00',NULL,NULL,NULL),(20,'Lisa Lee','lisa.lee@example.com','1990-12-17 00:00:00',NULL,NULL,NULL),(21,'Mark Walker','mark.walker@example.com','1983-03-14 00:00:00','2023-07-01 00:00:00','2024-07-01 00:00:00',1),(22,'Sandra Hall','sandra.hall@example.com','1989-09-03 00:00:00',NULL,NULL,NULL),(23,'Steven Allen','steven.allen@example.com','1978-06-11 00:00:00',NULL,NULL,NULL),(24,'Donna Young','donna.young@example.com','1991-08-21 00:00:00',NULL,NULL,NULL),(25,'Kevin Hernandez','kevin.hernandez@example.com','1982-11-02 00:00:00','2023-09-15 00:00:00','2024-09-15 00:00:00',2),(26,'Maria King','maria.king@example.com','1985-04-19 00:00:00',NULL,NULL,NULL),(27,'George Wright','george.wright@example.com','1977-07-27 00:00:00',NULL,NULL,NULL),(28,'Ashley Scott','ashley.scott@example.com','1993-01-10 00:00:00','2024-05-05 00:00:00','2025-05-05 00:00:00',3),(29,'Joshua Green','joshua.green@example.com','1980-10-22 00:00:00',NULL,NULL,NULL),(30,'Michelle Baker','michelle.baker@example.com','1986-06-06 00:00:00',NULL,NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_engagement`
--

DROP TABLE IF EXISTS `member_engagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_engagement` (
  `First_Watch_Date` datetime DEFAULT NULL,
  `Watch_Time` int DEFAULT NULL,
  `completed` tinyint DEFAULT NULL,
  `Replay_Count` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Bookmark` tinyint DEFAULT NULL,
  `member_id` int NOT NULL,
  `content_administrator_id` int NOT NULL,
  `content_title` varchar(45) NOT NULL,
  `content_director` varchar(45) NOT NULL,
  PRIMARY KEY (`member_id`,`content_administrator_id`,`content_title`,`content_director`),
  KEY `content_title` (`content_title`,`content_director`,`content_administrator_id`),
  CONSTRAINT `member_engagement_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`ID`),
  CONSTRAINT `member_engagement_ibfk_2` FOREIGN KEY (`content_title`, `content_director`, `content_administrator_id`) REFERENCES `content` (`Title`, `Director`, `Administrator_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_engagement`
--

LOCK TABLES `member_engagement` WRITE;
/*!40000 ALTER TABLE `member_engagement` DISABLE KEYS */;
INSERT INTO `member_engagement` VALUES ('2023-09-01 14:23:00',112,1,1,3,1,1,2,'Eternal Flame','John Kim'),('2023-06-10 13:25:00',91,0,NULL,NULL,0,1,5,'Digital Horizon','Sarah Lee'),('2023-11-11 10:10:00',88,0,NULL,NULL,0,2,5,'Digital Horizon','Sarah Lee'),('2023-08-15 17:05:00',87,1,1,NULL,1,2,7,'The Forgotten Echo','Liam Park'),('2024-01-20 12:00:00',101,1,2,NULL,1,2,9,'Neon Skyline','David Han'),('2024-02-28 18:50:00',72,0,NULL,NULL,1,3,3,'Whispering Shadows','Emily Choi'),('2023-06-15 09:45:00',134,1,1,2,1,3,7,'The Forgotten Echo','Liam Park'),('2023-07-03 22:20:00',77,0,NULL,NULL,0,4,6,'Crystal Path','Olivia Jung'),('2023-09-12 15:20:00',75,1,1,2,1,4,9,'Neon Skyline','David Han'),('2024-01-25 16:00:00',97,0,NULL,NULL,1,5,6,'Crystal Path','Olivia Jung'),('2023-08-12 15:05:00',95,1,1,3,1,5,8,'Quantum Drift','James Yoo'),('2023-05-22 07:35:00',110,0,NULL,NULL,1,6,1,'Broken Synthesis','Ella Min'),('2023-12-11 11:45:00',130,1,2,1,1,6,8,'Quantum Drift','James Yoo'),('2023-07-27 10:10:00',78,0,NULL,NULL,0,7,1,'Broken Synthesis','Ella Min'),('2023-10-01 16:45:00',83,0,NULL,NULL,0,7,4,'Midnight Waves','Henry Shin'),('2024-03-03 11:15:00',99,1,1,2,1,8,2,'Blue Circuit','Chloe Ryu'),('2023-10-22 20:35:00',94,1,1,2,1,8,4,'Midnight Waves','Henry Shin'),('2023-11-09 18:15:00',104,1,1,3,0,9,2,'Blue Circuit','Chloe Ryu'),('2023-09-11 17:55:00',68,0,NULL,NULL,0,9,10,'Echo Valley','Nathan Seo'),('2023-11-21 20:20:00',105,0,NULL,NULL,1,10,5,'Shadow Dancer','Ava Kim'),('2023-08-06 08:55:00',85,0,NULL,NULL,0,10,10,'Echo Valley','Nathan Seo'),('2023-09-25 07:45:00',92,1,1,2,1,11,5,'Shadow Dancer','Ava Kim'),('2023-12-05 08:30:00',118,1,2,3,0,11,7,'Last Frequency','Josh Lim'),('2023-12-01 09:20:00',111,0,NULL,NULL,0,12,7,'Last Frequency','Josh Lim'),('2023-06-18 13:40:00',76,0,NULL,NULL,1,12,8,'Fractal Dream','Sophia Cho'),('2023-10-30 19:10:00',90,0,NULL,NULL,0,13,3,'Frozen Signal','Brian Lee'),('2023-11-18 10:40:00',423,1,4,3,1,13,8,'Fractal Dream','Sophia Cho'),('2024-03-05 08:00:00',116,0,NULL,NULL,1,14,3,'Frozen Signal','Brian Lee'),('2024-04-01 14:00:00',128,1,2,1,1,14,6,'Hidden Nova','Grace Park'),('2023-07-02 11:30:00',69,1,1,1,0,15,6,'Hidden Nova','Grace Park'),('2023-08-28 10:50:00',102,1,1,2,1,15,9,'Neural Wake','Jake Moon'),('2023-07-07 18:30:00',84,0,NULL,NULL,0,16,1,'Riftwalker','Eleanor Jang'),('2023-10-28 12:10:00',123,0,NULL,NULL,1,16,9,'Neural Wake','Jake Moon'),('2023-09-08 19:00:00',90,1,1,2,1,17,1,'Riftwalker','Eleanor Jang'),('2023-09-20 21:10:00',89,0,NULL,NULL,1,17,10,'Lumina Pulse','Ethan Baek'),('2023-06-25 12:25:00',115,1,1,2,1,18,4,'Timeless Glow','Irene Kwon'),('2023-06-30 16:25:00',82,1,1,3,1,18,10,'Lumina Pulse','Ethan Baek'),('2023-08-05 11:30:00',93,0,NULL,NULL,0,19,2,'Silent Theory','Leo Yoon'),('2023-08-17 14:05:00',108,0,NULL,NULL,0,19,4,'Timeless Glow','Irene Kwon'),('2023-11-29 17:55:00',117,0,NULL,NULL,0,20,2,'Silent Theory','Leo Yoon'),('2023-11-03 17:45:00',96,0,NULL,NULL,1,20,3,'Edge Protocol','Hailey Shim'),('2023-09-27 10:35:00',74,1,1,1,1,21,3,'Edge Protocol','Hailey Shim'),('2024-01-12 13:10:00',109,1,1,3,0,21,5,'Dark Parallax','Chris Oh'),('2023-07-22 09:15:00',86,1,1,2,1,22,5,'Dark Parallax','Chris Oh'),('2023-07-18 15:55:00',79,1,1,1,1,22,7,'Violet Reboot','Nicole Jung'),('2023-05-25 16:30:00',70,0,NULL,NULL,0,23,6,'Phantom Logic','Eric Hwang'),('2023-12-08 15:30:00',125,0,NULL,NULL,0,23,7,'Violet Reboot','Nicole Jung'),('2023-08-03 13:50:00',122,1,2,3,1,24,6,'Phantom Logic','Eric Hwang'),('2023-10-15 14:20:00',98,1,1,2,1,24,8,'Hypertrace','Lucas Noh'),('2023-10-18 20:25:00',112,0,NULL,NULL,1,25,8,'Hypertrace','Lucas Noh'),('2023-09-30 08:15:00',103,1,1,1,0,25,9,'Celestial Loop','Zoe Chae'),('2023-12-25 09:00:00',80,0,NULL,NULL,0,26,2,'Static Bloom','Mason Song'),('2023-09-05 18:45:00',81,1,1,2,1,26,9,'Celestial Loop','Zoe Chae'),('2023-07-14 14:30:00',99,0,NULL,NULL,0,27,2,'Static Bloom','Mason Song'),('2024-01-18 10:50:00',107,1,1,3,1,27,10,'Orbital Drift','Mia Lim'),('2023-07-09 11:35:00',73,0,NULL,NULL,0,28,1,'Nova Colony','Caleb Koo'),('2023-11-14 10:10:00',88,1,1,3,1,28,10,'Orbital Drift','Mia Lim'),('2024-01-08 08:45:00',89,0,NULL,NULL,1,29,1,'Nova Colony','Caleb Koo'),('2023-11-05 12:45:00',100,0,NULL,NULL,1,29,3,'Paradox Flame','Luna Jang'),('2024-02-01 14:40:00',106,1,1,2,1,30,2,'Eternal Flame','John Kim'),('2023-09-03 13:35:00',102,1,1,2,0,30,3,'Paradox Flame','Luna Jang');
/*!40000 ALTER TABLE `member_engagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `original_content_producer`
--

DROP TABLE IF EXISTS `original_content_producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `original_content_producer` (
  `ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `original_content_producer`
--

LOCK TABLES `original_content_producer` WRITE;
/*!40000 ALTER TABLE `original_content_producer` DISABLE KEYS */;
INSERT INTO `original_content_producer` VALUES (1,'Luka\r'),(2,'Doncic\r'),(3,'Jimmy\r'),(4,'Butler\r'),(5,'Bruce');
/*!40000 ALTER TABLE `original_content_producer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `ID` int NOT NULL,
  `Grade` varchar(45) NOT NULL,
  `Concurrent_Streams` int NOT NULL,
  `View_Quality` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,'Super',4,'4K\r'),(2,'Gold',4,'1080p\r'),(3,'Silver',2,'1080p\r'),(4,'Bronze',1,'720p');
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-16 14:14:54
