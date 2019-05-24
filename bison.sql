-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: bison
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `amz_account_login_cookies`
--

DROP TABLE IF EXISTS `amz_account_login_cookies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_account_login_cookies` (
  `account_name` varchar(200) NOT NULL,
  `domain` varchar(200) NOT NULL,
  `cookie_name` varchar(200) NOT NULL,
  `cookies_bytes` blob,
  `utime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_name`,`domain`,`cookie_name`),
  KEY `fk_cookie_account_id_idx` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_account_login_cookies`
--

LOCK TABLES `amz_account_login_cookies` WRITE;
/*!40000 ALTER TABLE `amz_account_login_cookies` DISABLE KEYS */;
/*!40000 ALTER TABLE `amz_account_login_cookies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amz_inventory_region`
--

DROP TABLE IF EXISTS `amz_inventory_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_inventory_region` (
  `amz_inventory_region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '库存区域ID',
  `amz_inventory_region_name` varchar(45) NOT NULL COMMENT '库存区域名称',
  PRIMARY KEY (`amz_inventory_region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_inventory_region`
--

LOCK TABLES `amz_inventory_region` WRITE;
/*!40000 ALTER TABLE `amz_inventory_region` DISABLE KEYS */;
INSERT INTO `amz_inventory_region` VALUES (1,'EU'),(2,'CA'),(3,'US'),(4,'JP'),(6,'Unclassify');
/*!40000 ALTER TABLE `amz_inventory_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amz_region`
--

DROP TABLE IF EXISTS `amz_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_region` (
  `amz_region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `amz_region_name` varchar(45) NOT NULL COMMENT '区域名称',
  `amz_region_default_url` varchar(255) NOT NULL COMMENT '区域的代表站点域名',
  `amz_region_code` varchar(45) DEFAULT NULL,
  `amz_region_mws_url` varchar(255) DEFAULT '',
  PRIMARY KEY (`amz_region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_region`
--

LOCK TABLES `amz_region` WRITE;
/*!40000 ALTER TABLE `amz_region` DISABLE KEYS */;
INSERT INTO `amz_region` VALUES (1,'Europe','amazon.co.uk','EU','https://mws-eu.amazonservices.com'),(2,'North American','amazon.com','NA','https://mws.amazonservices.com'),(3,'Japan','amazon.co.jp','JP','https://mws.amazonservices.jp'),(4,'China','amazon.cn','CN','https://mws.amazonservices.com.cn'),(5,'Brazil','amazon.com.br','BR','https://mws.amazonservices.com'),(6,'India','amazon.in','IN','https://mws.amazonservices.in'),(7,'Australia','amazon.com.au','AU','https://mws.amazonservices.com.au');
/*!40000 ALTER TABLE `amz_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amz_seller`
--

DROP TABLE IF EXISTS `amz_seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_seller` (
  `seller_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `amz_seller_id` varchar(200) NOT NULL COMMENT '亚马逊分配给卖家的指定ID',
  `brand_id` int(11) DEFAULT NULL,
  `amazon_region_id` int(11) NOT NULL DEFAULT '1',
  `seller_name` varchar(200) NOT NULL COMMENT '卖家在亚马逊的名称',
  `sales_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '卖家在亚马逊开始售卖的时间,供模块获取数据当做起始时间',
  `utime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据最后更新时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_seller`
--

LOCK TABLES `amz_seller` WRITE;
/*!40000 ALTER TABLE `amz_seller` DISABLE KEYS */;
INSERT INTO `amz_seller` VALUES (1,'A2DGIQMFD2NGBK',1,1,'EU - Syncwire','2018-06-19 08:59:45','2017-10-11 04:09:00','2017-10-10 16:00:00'),(2,'A2J23IQCWX8J90',1,1,'EU - SyncwireUK','2018-06-19 08:59:45','2017-10-11 04:09:00','2017-10-10 16:00:00'),(3,'A36JITAU1BVS0F',1,2,'NA - Syncwire Products','2018-06-19 08:59:45','2017-11-06 03:14:43','2017-11-06 03:14:43'),(4,'A110EVM68XKOQ1',1,3,'JP - Syncwire Direct','2018-06-19 08:59:45','2017-11-03 04:14:06','2017-11-02 06:47:52'),(5,'A28PMDXZ0EPKRV',2,1,'EU - Atumtek','2018-06-19 08:59:45','2018-03-27 07:01:00','2018-03-27 07:01:00'),(6,'A1CUADUCF6B22Y',3,1,'EU - Gomum','2018-06-19 08:59:46','2018-05-28 06:31:35','2018-05-28 06:31:35'),(7,'A1CAYR7I5DIHYL',3,2,'NA - Gomum','2018-05-28 06:31:35','2018-05-28 06:31:35','2018-05-28 06:31:35'),(8,'A175MDKTTJOJK2',4,1,'EU - Addsfit','2018-05-28 06:31:35','2018-05-28 06:31:35','2018-05-28 06:31:35'),(9,'AISQ4VYY49GD9',4,3,'JP - Addsfit','2018-05-28 06:31:35','2018-05-28 06:31:35','2018-05-28 06:31:35'),(10,'A2V1U1CUCEL545',5,1,'EU - Fansful','2018-06-19 08:59:45','2017-11-06 03:14:43','2017-11-06 03:14:43'),(11,'ATYMHEFK4P6EE',5,2,'NA - Fansful','2018-06-26 09:28:49','2018-06-26 09:28:49','2018-06-26 09:28:49'),(12,'ASN6A9AK547XX',5,3,'JP - Fansful','2018-06-26 09:29:15','2018-06-26 09:29:15','2018-06-26 09:29:15'),(13,'A1UERP56BVZ9YE',2,2,'NA - Atumtek','2018-06-26 09:35:02','2018-06-26 09:35:02','2018-06-26 09:35:02'),(14,'A1SOS4XXDVLBTW',2,3,'JP - Atumtek','2018-06-26 09:35:02','2018-06-26 09:35:02','2018-06-26 09:35:02'),(15,'A2CH5O2BA3JGGJ',3,3,'JP - Gomum','2018-06-26 09:39:38','2018-06-26 09:39:38','2018-06-26 09:39:38');
/*!40000 ALTER TABLE `amz_seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amz_seller_account`
--

DROP TABLE IF EXISTS `amz_seller_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_seller_account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `seller_id` int(11) NOT NULL COMMENT '与amz_seller的关系字段,与seller_id做外键',
  `account_name` varchar(200) NOT NULL COMMENT '卖家登录Sellercentral的账号名',
  `account_password` varchar(200) NOT NULL COMMENT '卖家登录Sellercentral的密码,经过可逆的加密存储',
  `two_step_code` varchar(300) DEFAULT NULL,
  `utime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录的最后更新时间',
  `ctime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录的创建时间',
  `is_amz_adv_authorize` tinyint(1) NOT NULL DEFAULT '0' COMMENT '亚马逊广告api授权',
  `remote_server` varchar(45) DEFAULT NULL,
  `remote_file_port` int(11) DEFAULT NULL,
  `remote_browser_port` int(11) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_seller_account`
--

LOCK TABLES `amz_seller_account` WRITE;
/*!40000 ALTER TABLE `amz_seller_account` DISABLE KEYS */;
INSERT INTO `amz_seller_account` VALUES (1,8,'addsfit_getter@outlook.com','addsfitgetter','ZYP3 YXAX 3OKY UJ2G OY3T H4NU CXPG EVQD Q2GI LNU3 JIJR IHQW HRWQ','2019-04-10 03:15:07','2019-04-10 03:15:07',0,'afhkrdp.leaderment.com',4440,4444);
/*!40000 ALTER TABLE `amz_seller_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amz_seller_mws`
--

DROP TABLE IF EXISTS `amz_seller_mws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_seller_mws` (
  `mws_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `seller_id` int(11) NOT NULL COMMENT '与amz_seller关联字段,与seller_id做外键,此记录与amz_seller为一对一关系',
  `region_id` int(11) NOT NULL COMMENT '此MWS资料的作用地区字段,与county_region.region_id做外键',
  `mws_app_name` varchar(45) NOT NULL DEFAULT 'AmazonJavascriptScratchpad',
  `amz_seller_id` varchar(200) NOT NULL COMMENT '亚马逊分配给seller的ID',
  `mws_auth_token` varchar(200) NOT NULL COMMENT '亚马逊分配的MWS Authorisation Token',
  `access_key_id` varchar(200) NOT NULL COMMENT '亚马逊分配的AWS Access Key ID',
  `secret_key` varchar(400) NOT NULL COMMENT '亚马逊分配的Secret Key',
  `utime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  `ctime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录的创建时间',
  PRIMARY KEY (`mws_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_seller_mws`
--

LOCK TABLES `amz_seller_mws` WRITE;
/*!40000 ALTER TABLE `amz_seller_mws` DISABLE KEYS */;
INSERT INTO `amz_seller_mws` VALUES (1,1,1,'Ldm','A2DGIQMFD2NGBK','amzn.mws.a2a78ddb-350b-6e79-684a-c641ae32b3a7','n80Vhq7qrWVkdwkhXdtkkyEfHY37BPptATjuueln','n80Vhq7qrWVkdwkhXdtkkyEfHY37BPptATjuueln','2018-02-28 06:31:23','2017-11-01 09:01:12'),(2,2,1,'SyncwireDev','A2J23IQCWX8J90','amzn.mws.64af7fe1-52da-3240-d9c8-ad561fa42566','AKIAITGBOLPWACPLH2DQ','1t7NfRIqA2xHEFK+JPIwQ47h/xVS3mlmrb2+LaIG','2017-11-02 09:50:37','2017-11-02 09:44:03'),(3,3,2,'Ldm','A36JITAU1BVS0F','amzn.mws.06a43e2e-d5fb-408c-9dec-5310340000f1','AKIAJBWBY33YKHHHBYYQ','h1AH2uNswtJEG8ocjZ25uzNwWGR+s2WGlospSIJB','2017-11-02 09:52:31','2017-11-02 03:35:38'),(4,4,3,'Ldm','A110EVM68XKOQ1','amzn.mws.a8a9963c-689f-7dcd-cba1-04fb3148d4e0','AKIAJL5EDVGSTR44LU6Q','SWSESnO9D5jI60kZewUQ+wzuZP+eJ2Gp71NH1yre','2017-11-02 09:41:26','2017-11-02 09:25:12'),(5,5,1,'Atumtek System','A28PMDXZ0EPKRV','amzn.mws.c8b12b1f-4fa6-c536-2f89-0373eb59c672','AKIAJGV7EIP6YA72S2YA','R4+1aZ2n+gwnEdsQ2sSHfja11ihSk+yUqv17eWjv','2018-03-27 07:01:00','2018-03-27 07:01:00'),(6,6,1,'Sales Data module','A1CUADUCF6B22Y','amzn.mws.6cb1d26f-342a-ec1b-5a18-69cac17d698d','AKIAIKI54BCE3HCNE5PA','HTZT+cGr576PBR4TGRhOZMe/J6dUlVzj5x+UJYjw','2018-05-28 06:42:45','2018-03-27 07:01:00'),(7,7,2,'Sales Data module','A1CAYR7I5DIHYL','amzn.mws.30b20b99-1b12-7ddd-a464-beb0e168af35','AKIAJ2QDTNPFIZZTLLCQ','1IR8bkpEMxAhTVMToc//LREOquiZ6EeNN1AYh+no','2018-06-19 09:06:18','2018-03-27 07:01:00'),(8,8,1,'AmazonPlugIn','A175MDKTTJOJK2','amzn.mws.6eb1e7b6-cda4-2c38-4c4c-fe37b639e4a8','AKIAJCWNMCO2JG7F5X6A','pmzEq5PEI2rwCvzW+n6lkDJVaKPJA0enydsoJa2/','2018-06-19 09:06:18','2018-03-27 07:01:00'),(9,9,3,'AmazonPlugIn','AISQ4VYY49GD9','amzn.mws.22b210ed-c5f2-7990-fc39-2492803252d6','AKIAIXPIALCYUIAVKGZQ','hFAk91DBhQeC8l4MoryPQXdSJWActvHmsNeAtVF4','2018-06-19 09:06:18','2018-03-27 07:01:00'),(10,10,1,'Amazon Interface module','A2V1U1CUCEL545','amzn.mws.04b21d95-038e-1347-76fb-7ee08ef750c2','AKIAJXM7BOPIOIXO2UUA','aci5aasN+9vdSZwFpcsTPM3kimsNVI7hiRT+N7TF','2018-06-26 09:23:27','2018-06-26 09:23:27'),(11,11,2,'Amazon Interface module','ATYMHEFK4P6EE','amzn.mws.c0b21d96-7053-dd7b-3c9d-07d856403c07','AKIAIFC472YFBALMU2MA','aeBwHOYrzurPnqql43xZKvbgsB2AzgfqFXPWuuEO','2018-06-26 09:32:20','2018-06-26 09:32:20'),(12,12,3,'Amazon Interface module','ASN6A9AK547XX','amzn.mws.dcb21d98-2d26-d40e-812c-3206f204e6fb','AKIAJCL3RCBMFRNMZ6TQ','Lbf7vdnk34ZKcHsH3QSj5E9cteFimvFeC1rCjhbp','2018-06-26 09:32:20','2018-06-26 09:32:20'),(13,13,2,'Atumtek System','A1UERP56BVZ9YE','amzn.mws.a4b20dee-8820-f7fe-5aaa-7d3357bc992d','AKIAI7OL2LAUDJTP32TA','hVRFQwYbOnbWDB1/+Jk/qlm2vEQCwz/5XPdSJ4rD','2018-06-26 09:38:00','2018-06-26 09:38:00'),(14,14,3,'Atumtek System','A1SOS4XXDVLBTW','amzn.mws.4cb21d74-f237-ceae-a248-7326d8285c34','AKIAJGTT4KYUM5DAODAQ','7N3CaDHYJdDVJ1RMFXnATSj9Dwq2m/7JES9lFuV2','2018-06-26 09:38:00','2018-06-26 09:38:00'),(15,15,3,'Sales Data module','A2CH5O2BA3JGGJ','amzn.mws.96b21d7e-d8c7-697b-5be6-a25444e60e34','AKIAIAY3UCNLSXI3LF4Q','prpAHrGt+RnmY2sVkTVvr0VOfvOK3dKoE5y7UKEY','2018-06-26 09:41:27','2018-06-26 09:41:27'),(16,16,2,'AmazonPlugIn','AHDHXYY1ZH54F','xxx','xxxx','xxx','2018-06-26 09:41:27','2018-06-26 09:41:27');
/*!40000 ALTER TABLE `amz_seller_mws` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amz_seller_sale_country`
--

DROP TABLE IF EXISTS `amz_seller_sale_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amz_seller_sale_country` (
  `seller_id` int(11) NOT NULL COMMENT '系统卖家Id',
  `country_id` int(10) unsigned NOT NULL,
  `vat_no` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '税号',
  PRIMARY KEY (`seller_id`,`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amz_seller_sale_country`
--

LOCK TABLES `amz_seller_sale_country` WRITE;
/*!40000 ALTER TABLE `amz_seller_sale_country` DISABLE KEYS */;
INSERT INTO `amz_seller_sale_country` VALUES (1,1,''),(1,3,''),(1,4,''),(1,5,''),(2,1,'DE312560982'),(2,2,''),(2,3,'GB248242896'),(2,4,'FR03830011052'),(2,5,'ESN8267964H'),(3,7,''),(3,8,''),(4,6,''),(5,1,''),(5,2,''),(5,3,''),(5,4,''),(5,5,''),(6,1,''),(7,1,''),(7,2,''),(7,3,''),(7,4,''),(7,5,''),(8,1,''),(8,2,''),(8,3,''),(8,4,''),(8,5,'');
/*!40000 ALTER TABLE `amz_seller_sale_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Syncwire'),(2,'SyncwireUK'),(3,'Atumtek'),(4,'Gomum'),(5,'Addsfit'),(6,'Fansful');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_unit`
--

DROP TABLE IF EXISTS `business_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_unit` (
  `business_unit_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_unit` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_unit_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`business_unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_unit`
--

LOCK TABLES `business_unit` WRITE;
/*!40000 ALTER TABLE `business_unit` DISABLE KEYS */;
INSERT INTO `business_unit` VALUES (1,'SYNCWIRE１',NULL);
/*!40000 ALTER TABLE `business_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_unit_user_rel`
--

DROP TABLE IF EXISTS `business_unit_user_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_unit_user_rel` (
  `business_unit_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`business_unit_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_unit_user_rel`
--

LOCK TABLES `business_unit_user_rel` WRITE;
/*!40000 ALTER TABLE `business_unit_user_rel` DISABLE KEYS */;
INSERT INTO `business_unit_user_rel` VALUES (1,1),(1,47),(1,48);
/*!40000 ALTER TABLE `business_unit_user_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries3166`
--

DROP TABLE IF EXISTS `countries3166`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries3166` (
  `alpha2` varchar(2) CHARACTER SET latin1 NOT NULL COMMENT '国家的简写',
  `country_name` varchar(50) CHARACTER SET latin1 NOT NULL COMMENT '对应的国家全称',
  PRIMARY KEY (`alpha2`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries3166`
--

LOCK TABLES `countries3166` WRITE;
/*!40000 ALTER TABLE `countries3166` DISABLE KEYS */;
INSERT INTO `countries3166` VALUES ('AD','Andorra'),('AE','United Arab Emirates'),('AF','Afghanistan'),('AG','Antigua & Barbuda'),('AI','Anguilla'),('AL','Albania'),('AM','Armenia'),('AO','Angola'),('AQ','Antarctica'),('AR','Argentina'),('AS','American Samoa'),('AT','Austria'),('AU','Australia'),('AW','Aruba'),('AX','?aland Island'),('AZ','Azerbaijan'),('BA','Bosnia & Herzegovina'),('BB','Barbados'),('BD','Bangladesh'),('BE','Belgium'),('BF','Burkina'),('BG','Bulgaria'),('BH','Bahrain'),('BI','Burundi'),('BJ','Benin'),('BL','Saint Barthélemy'),('BM','Bermuda'),('BN','Brunei'),('BO','Bolivia'),('BQ','Caribbean Netherlands'),('BR','Brazil'),('BS','The Bahamas'),('BT','Bhutan'),('BV','Bouvet Island'),('BW','Botswana'),('BY','Belarus'),('BZ','Belize'),('CA','Canada'),('CC','Cocos (Keeling) Islands'),('CD','Democratic Republic of the Congo'),('CF','Central African Republic'),('CG','Republic of the Congo'),('CH','Switzerland'),('CI','C?te d\'Ivoire'),('CK','Cook Islands'),('CL','Chile'),('CM','Cameroon'),('CN','China'),('CO','Colombia'),('CR','Costa Rica'),('CU','Cuba'),('CV','Cape Verde'),('CX','Christmas Island'),('CY','Cyprus'),('CZ','Czech Republic'),('DE','Germany'),('DJ','Djibouti'),('DK','Denmark'),('DM','Dominica'),('DO','Dominican Republic'),('DZ','Algeria'),('EC','Ecuador'),('EE','Estonia'),('EG','Egypt'),('EH','Western Sahara'),('ER','Eritrea'),('ES','Spain'),('ET','Ethiopia'),('FI','Finland'),('FJ','Fiji'),('FK','Falkland Islands'),('FM','Federated States of Micronesia'),('FO','Faroe Islands'),('FR','France'),('GA','Gabon'),('GB','Great Britain (United Kingdom; England)'),('GD','Grenada'),('GE','Georgia'),('GF','French Guiana'),('GG','Guernsey'),('GH','Ghana'),('GI','Gibraltar'),('GL','Greenland'),('GM','Gambia'),('GN','Guinea'),('GP','Guadeloupe'),('GQ','Equatorial Guinea'),('GR','Greece'),('GS','South Georgia and the South Sandwich Islands'),('GT','Guatemala'),('GU','Guam'),('GW','Guinea-Bissau'),('GY','Guyana'),('HK','Hong Kong'),('HM','Heard Island and McDonald Islands'),('HN','Honduras'),('HR','Croatia'),('HT','Haiti'),('HU','Hungary'),('ID','Indonesia'),('IE','Ireland'),('IL','Israel'),('IM','Isle of Man'),('IN','India'),('IO','British Indian Ocean Territory'),('IQ','Iraq'),('IR','Iran'),('IS','Iceland'),('IT','Italy'),('JE','Jersey'),('JM','Jamaica'),('JO','Jordan'),('JP','Japan'),('KE','Kenya'),('KG','Kyrgyzstan'),('KH','Cambodia'),('KI','Kiribati'),('KM','The Comoros'),('KN','St. Kitts & Nevis'),('KP','North Korea'),('KR','South Korea'),('KW','Kuwait'),('KY','Cayman Islands'),('KZ','Kazakhstan'),('LA','Laos'),('LB','Lebanon'),('LC','St. Lucia'),('LI','Liechtenstein'),('LK','Sri Lanka'),('LR','Liberia'),('LS','Lesotho'),('LT','Lithuania'),('LU','Luxembourg'),('LV','Latvia'),('LY','Libya'),('MA','Morocco'),('MC','Monaco'),('MD','Moldova'),('ME','Montenegro'),('MF','Saint Martin (France)'),('MG','Madagascar'),('MH','Marshall islands'),('MK','Republic of Macedonia (FYROM)'),('ML','Mali'),('MM','Myanmar (Burma)'),('MN','Mongolia'),('MO','Macao'),('MP','Northern Mariana Islands'),('MQ','Martinique'),('MR','Mauritania'),('MS','Montserrat'),('MT','Malta'),('MU','Mauritius'),('MV','Maldives'),('MW','Malawi'),('MX','Mexico'),('MY','Malaysia'),('MZ','Mozambique'),('NA','Namibia'),('NC','New Caledonia'),('NE','Niger'),('NF','Norfolk Island'),('NG','Nigeria'),('NI','Nicaragua'),('NL','Netherlands'),('NO','Norway'),('NP','Nepal'),('NR','Nauru'),('NU','Niue'),('NZ','New Zealand'),('OM','Oman'),('PA','Panama'),('PE','Peru'),('PF','French polynesia'),('PG','Papua New Guinea'),('PH','The Philippines'),('PK','Pakistan'),('PL','Poland'),('PM','Saint-Pierre and Miquelon'),('PN','Pitcairn Islands'),('PR','Puerto Rico'),('PS','Palestinian territories'),('PT','Portugal'),('PW','Palau'),('PY','Paraguay'),('QA','Qatar'),('RE','Réunion'),('RO','Romania'),('RS','Serbia'),('RU','Russian Federation'),('RW','Rwanda'),('SA','Saudi Arabia'),('SB','Solomon Islands'),('SC','Seychelles'),('SD','Sudan'),('SE','Sweden'),('SG','Singapore'),('SH','St. Helena & Dependencies'),('SI','Slovenia'),('SJ','Template:Country data SJM Svalbard'),('SK','Slovakia'),('SL','Sierra Leone'),('SM','San Marino'),('SN','Senegal'),('SO','Somalia'),('SR','Suriname'),('SS','South Sudan'),('ST','Sao Tome & Principe'),('SV','El Salvador'),('SY','Syria'),('SZ','Swaziland'),('TC','Turks & Caicos Islands'),('TD','Chad'),('TF','French Southern Territories'),('TG','Togo'),('TH','Thailand'),('TJ','Tajikistan'),('TK','Tokelau'),('TL','Timor-Leste (East Timor)'),('TM','Turkmenistan'),('TN','Tunisia'),('TO','Tonga'),('TR','Turkey'),('TT','Trinidad & Tobago'),('TV','Tuvalu'),('TW','Taiwan'),('TZ','Tanzania'),('UA','Ukraine'),('UG','Uganda'),('UM','United States Minor Outlying Islands'),('US','United States of America (USA)'),('UY','Uruguay'),('UZ','Uzbekistan'),('VA','Vatican City (The Holy See)'),('VC','St. Vincent & the Grenadines'),('VE','Venezuela'),('VG','British Virgin Islands'),('VI','United States Virgin Islands'),('VN','Vietnam'),('VU','Vanuatu'),('WF','Wallis and Futuna'),('WS','Samoa'),('YE','Yemen'),('YT','Mayotte'),('ZA','South Africa'),('ZM','Zambia'),('ZW','Zimbabwe');
/*!40000 ALTER TABLE `countries3166` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '国家id 主键自增',
  `amazon_region_id` int(10) NOT NULL,
  `amazon_inventory_region_id` int(11) NOT NULL,
  `country_name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国家名称',
  `alpha_code` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国家名称的两个字母缩写',
  `country_URL` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '对应的亚马逊URL访问域名',
  `capital` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marketplace` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '亚马逊的站点编码',
  `currency_id` int(11) NOT NULL,
  `utime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sellercentral_date_format` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,1,0,'Germany','DE','amazon.de','berlin','19','A1PA6795UKMFR9',2,'2019-04-15 06:31:22','dd/MM/yyyy'),(2,1,0,'UK','GB','amazon.co.uk','london','20','A1F83G8C2ARO7P',1,'2019-04-15 06:31:22','dd/MM/yyyy'),(3,1,0,'Italy','IT','amazon.it','rome','22','APJ6JRA9NG5V4',2,'2019-04-15 06:31:22','dd/MM/yyyy'),(4,1,0,'France','FR','amazon.fr','paris','20','A13V1IB3VIYZZH',2,'2019-04-15 06:31:22','dd/MM/yyyy'),(5,1,0,'Spain','ES','amazon.es','madrid','22','A1RKKUPIHCS9HS',2,'2019-04-15 06:31:22','dd/MM/yyyy'),(6,3,0,'Japan','JP','amazon.co.jp','tokyo','20','A1VC38T7YXB528',3,'2019-04-15 06:31:22','MM/dd/yyyy'),(7,2,0,'US','US','amazon.com','washington-dc','20','ATVPDKIKX0DER',4,'2019-04-15 06:31:22','MM/dd/yyyy'),(8,2,0,'Canada','CA','amazon.ca','ottawa','20','A2EUQ1WTGCTBG2',5,'2019-04-15 06:31:22','MM/dd/yyyy'),(9,2,0,'Mexico','MX','amazon.com.mx','mexico-city','20','A1AM78C64UM0Y8',4,'2019-04-15 06:31:22','MM/dd/yyyy'),(10,4,0,'China','CN','amazon.cn','beijing','20','AAHKV2X7AFYLW',1,'2018-06-21 10:46:40',NULL),(11,5,0,'Brazil','BR','amazon.com.br','brasilia','20','A2Q3Y263D00KWC',1,'2018-06-21 04:37:12',NULL),(12,6,0,'India','IN','amazon.in','new-delhi','20','A21TJRUUN4KGV',1,'2018-06-21 10:46:04',NULL),(14,7,0,'Australia','AU','amazon.com.au','canberra','20','A39IBJ37TRP1C6',1,'2018-06-21 10:46:00',NULL);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `currency_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `currency_name` varchar(45) NOT NULL COMMENT '货币简称',
  `currency_code` varchar(45) NOT NULL DEFAULT '' COMMENT '货币符号',
  `exchange_update` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'GBP','£',1),(2,'EUR','€',1),(3,'JPY','¥',1),(4,'USD','$',1),(5,'CAD','CAD$',1),(6,'RMB','¥',0);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_exchange_rate`
--

DROP TABLE IF EXISTS `currency_exchange_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_exchange_rate` (
  `currency_exchange_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `currency_id` int(11) NOT NULL COMMENT '货币id',
  `exchange` float NOT NULL COMMENT '汇率',
  `u_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`currency_exchange_rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_exchange_rate`
--

LOCK TABLES `currency_exchange_rate` WRITE;
/*!40000 ALTER TABLE `currency_exchange_rate` DISABLE KEYS */;
INSERT INTO `currency_exchange_rate` VALUES (1,1,8.66934,'2019-04-17 07:17:59'),(2,2,7.63696,'2019-04-17 07:17:59'),(3,3,0.059856,'2019-04-17 07:17:59'),(4,4,6.5991,'2019-04-17 07:17:59'),(5,5,4.95763,'2019-04-17 07:17:59'),(6,6,1,'2019-04-17 07:17:59');
/*!40000 ALTER TABLE `currency_exchange_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  `business_unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'理德铭',0,NULL),(2,'总经办',1,NULL),(29,'SYNCWIRE１',2,1),(30,'亚马逊运营部',29,1),(31,'运营A组',30,1),(32,'产品部',29,1),(33,'研发部',32,1),(34,'项目部',32,1),(36,'设计部',2,1),(39,'系统部',29,1);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `module_name` varchar(45) DEFAULT NULL COMMENT '模块名称',
  `module_url_path` varchar(400) DEFAULT NULL COMMENT '模块调用的相对路径, 项目的controller',
  `utime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录的更新时间',
  `ctime` timestamp NULL DEFAULT NULL COMMENT '记录的创建时间',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=704 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES (28,'Advertising-Sync','/bison-advertising-sync/report','2017-12-05 12:39:14','2017-12-05 12:40:24'),(29,'MWS-SearchTerm','/bison-mws-advertising/searchTermReport','2017-12-05 15:01:09','2017-12-05 15:02:20'),(30,'Advertising-Update','/bison-advertising-sync/dataUpdate','2017-12-05 23:05:15','2017-12-05 23:06:27'),(39,'Advertising-Adjust','/bison-advertising-adjust/bidAutoAdjust','2017-12-17 21:30:22','2017-12-17 21:29:37'),(40,'Advertising-Report-Syncwire','/bison-sc-advertising-report/reportAD','2018-11-19 07:30:22','2018-11-19 07:29:37'),(41,'Advertising-Report-SyncwireUK','/bison-sc-advertising-report/reportAD','2018-11-19 07:30:22','2018-11-19 07:29:37'),(42,'Advertising-Report-Atumtek','/bison-sc-advertising-report/reportAD','2018-11-19 07:30:22','2018-11-19 07:29:37'),(43,'Advertising-Report-Gomum','/bison-sc-advertising-report/reportAD','2018-11-19 07:30:22','2018-11-19 07:29:37'),(44,'Advertising-Report-Addsfit','/bison-sc-advertising-report/reportAD','2018-11-19 07:30:22','2018-11-19 07:29:37'),(45,'Advertising-Report-Fansful','/bison-sc-advertising-report/reportAD','2018-11-19 07:30:22','2018-11-19 07:29:37'),(101,'Inventory','/bison-product/inventory','2017-10-23 15:38:49','2017-12-17 21:29:37'),(102,'SellerAsin','/bison-product/sellerAsin','2017-11-02 13:40:59','2017-11-02 13:41:29'),(103,'AsinDetail','/bison-product/sellerAsinDetail','2017-11-14 19:02:31','2017-11-14 19:02:53'),(104,'AsinPrice','/bison-product/sellerAsinPrice','2017-11-14 19:03:33','2017-11-14 19:03:55'),(105,'Tracking','/bison-product/sellerTracking','2017-11-12 17:17:16','2017-11-12 17:17:29'),(106,'Shipment','/bison-product/shipment','2017-11-06 12:29:01','2017-11-06 12:29:51'),(107,'InventoryByCountry','/bison-product/inventoryByCountry','2018-06-14 01:32:48',NULL),(201,'Conversion','/bison-conversion/conversion','2017-11-01 20:29:43','2017-12-17 21:29:37'),(202,'Financial-SC-Payment','/bison-sc-finance/financialTransactionReport','2018-01-12 18:53:46','2018-01-12 18:53:46'),(203,'Advertising-SC-Report','/bison-sc-advertising/report','2018-01-05 17:32:18','2018-01-05 17:33:34'),(204,'Financial-MWS-Payment','/bison-mws-finance/financeEvents','2018-06-14 01:32:48','2018-05-18 01:32:49'),(301,'UpdateOrder','/bison-order/updateOrder','2018-01-03 14:37:27','2018-01-03 14:38:32'),(302,'FulfilledOrder','/bison-order/downLoadOrder','2018-01-03 14:37:55','2018-01-03 14:39:00'),(303,'OrderRefund','/bison-order/downLoadReturn','2018-01-03 14:38:16','2018-01-03 14:39:21'),(304,'EdaYunInventory','/bison-edayun-inventory/inventory','2018-06-14 01:32:48','2018-05-18 01:32:49'),(305,'WinitInventory','/bison-winit-inventory/queryInventoryJob','2018-06-14 01:32:48','2018-05-18 01:32:49'),(306,'UpdateOrderSpecifyDate','/bison-order/updateOrder/specifyDate?mwsId=&startDate=&endDate=','2018-09-29 07:18:09','2018-09-29 07:18:09'),(307,'OrderSaleReport','/bison-order/updateOrder','2018-10-08 09:51:18','2018-10-08 09:51:19'),(401,'Counterfeit','/bison-counterfeit/counterfeit','2017-11-12 18:40:59','2017-12-17 21:29:37'),(402,'GoodReview-SC-Task','/bison-sc-good-review/bison-good-review-task','2017-11-19 14:14:10','2017-11-19 14:14:39'),(403,'GoodReview-SC-Corn','/bison-sc-good-review/bison-good-review-corn-job','2018-06-01 03:30:14',NULL),(501,'MailReply','/invoice-mail-reply/mailreply','2018-01-12 18:53:46','2018-01-12 18:55:23'),(601,'SearchKeyword','/bison-keyword-queue/searchKeyword','2018-05-17 07:13:14','2018-05-17 07:13:14'),(602,'AdvertisingKeyword','/bison-keyword-queue/advertKeyword','2018-05-17 07:25:17','2018-05-17 07:25:17'),(603,'CleanProxyIP','/bison-proxy/cleanProxy','2018-05-18 01:32:28','2018-05-18 01:32:28'),(604,'CheckProxyExpire','/bison-proxy/checkProxyExpire','2018-05-18 01:32:48','2018-05-18 01:32:49'),(605,'AsinForReview','/bison-crawler-queue/sellerAsinForReviewJob','2018-06-14 01:32:48','2018-05-18 01:32:49'),(701,'Event2Report','/bison-event2report/Report','2019-02-13 01:46:32','2019-02-13 01:46:32'),(702,'DailyReport','/bison-dailyReport/DailyReport','2019-02-13 03:40:46','2019-02-13 03:40:46'),(703,'receiveMail','/UB-ReveiceMail/reveiceMail','2019-04-12 09:40:50','2019-04-12 09:40:50');
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_sc_report_period`
--

DROP TABLE IF EXISTS `module_sc_report_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_sc_report_period` (
  `report_period_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模块从sellercentral里请求的报告列表,区分是否程序请求的报告,以及处理情况',
  `module_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `report_period` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '从亚马逊后台获取的报告表格的日期范围',
  `self_request` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否为程序请求的报告',
  `imported` int(11) NOT NULL DEFAULT '0' COMMENT '报告是否已经导入过',
  `report_status` int(11) NOT NULL DEFAULT '0' COMMENT '亚马逊报告状态',
  `report_url` text COLLATE utf8mb4_unicode_ci,
  `utime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_period_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_sc_report_period`
--

LOCK TABLES `module_sc_report_period` WRITE;
/*!40000 ALTER TABLE `module_sc_report_period` DISABLE KEYS */;
INSERT INTO `module_sc_report_period` VALUES (46,302,8,1,'19/04/2019 03:09 - 24/04/2019 03:09',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:16:58'),(47,302,8,1,'15/04/2019 00:00 - 03/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:17:04'),(48,302,8,1,'18/04/2019 00:00 - 30/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:23:32'),(49,302,8,1,'18/04/2019 19:06 - 23/04/2019 19:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:24:18'),(50,302,8,1,'17/04/2019 00:00 - 29/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:25:04'),(51,302,8,1,'20/04/2019 01:00 - 27/04/2019 00:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:25:50'),(52,302,8,1,'23/04/2019 00:00 - 23/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:26:38'),(53,302,8,1,'18/04/2019 11:06 - 23/04/2019 11:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:27:27'),(54,302,8,1,'18/04/2019 03:06 - 23/04/2019 03:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:28:13'),(55,302,8,1,'17/04/2019 19:05 - 22/04/2019 19:05',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:29:01'),(56,302,8,2,'19/04/2019 02:09 - 24/04/2019 02:09',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:30:18'),(57,302,8,2,'14/04/2019 23:00 - 03/05/2019 22:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:31:04'),(58,302,8,2,'17/04/2019 23:00 - 30/04/2019 22:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:31:50'),(59,302,8,2,'18/04/2019 18:06 - 23/04/2019 18:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:32:36'),(60,302,8,2,'16/04/2019 23:00 - 29/04/2019 22:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:33:23'),(61,302,8,2,'20/04/2019 00:00 - 26/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:35:59'),(62,302,8,2,'22/04/2019 23:00 - 23/04/2019 22:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:36:45'),(63,302,8,2,'18/04/2019 10:06 - 23/04/2019 10:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:37:30'),(64,302,8,2,'18/04/2019 02:06 - 23/04/2019 02:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:38:17'),(65,302,8,2,'17/04/2019 18:05 - 22/04/2019 18:05',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:39:03'),(66,302,8,3,'19/04/2019 03:09 - 24/04/2019 03:09',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:40:18'),(67,302,8,3,'15/04/2019 00:00 - 03/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:41:03'),(68,302,8,3,'18/04/2019 00:00 - 30/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:41:48'),(69,302,8,3,'18/04/2019 19:06 - 23/04/2019 19:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:42:35'),(70,302,8,3,'17/04/2019 00:00 - 29/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:43:22'),(71,302,8,3,'20/04/2019 01:00 - 27/04/2019 00:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:44:08'),(72,302,8,3,'23/04/2019 00:00 - 23/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:44:54'),(73,302,8,3,'18/04/2019 11:06 - 23/04/2019 11:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:45:39'),(74,302,8,3,'18/04/2019 03:06 - 23/04/2019 03:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:46:25'),(75,302,8,3,'17/04/2019 19:05 - 22/04/2019 19:05',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:47:12'),(76,302,8,4,'19/04/2019 03:09 - 24/04/2019 03:09',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:48:29'),(77,302,8,4,'15/04/2019 00:00 - 03/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:49:15'),(78,302,8,4,'18/04/2019 00:00 - 30/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:50:00'),(79,302,8,4,'18/04/2019 19:06 - 23/04/2019 19:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:50:47'),(80,302,8,4,'17/04/2019 00:00 - 29/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:51:32'),(81,302,8,4,'20/04/2019 01:00 - 27/04/2019 00:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:52:18'),(82,302,8,4,'23/04/2019 00:00 - 23/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:53:06'),(83,302,8,4,'18/04/2019 11:06 - 23/04/2019 11:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:53:52'),(84,302,8,4,'18/04/2019 03:06 - 23/04/2019 03:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:54:38'),(85,302,8,4,'17/04/2019 19:05 - 22/04/2019 19:05',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:55:25'),(86,302,8,5,'19/04/2019 03:09 - 24/04/2019 03:09',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:56:40'),(87,302,8,5,'15/04/2019 00:00 - 03/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15912403613018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 04:29:30'),(88,302,8,5,'18/04/2019 00:00 - 30/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:58:12'),(89,302,8,5,'18/04/2019 19:06 - 23/04/2019 19:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:58:58'),(90,302,8,5,'17/04/2019 00:00 - 29/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 02:59:45'),(91,302,8,5,'20/04/2019 01:00 - 27/04/2019 00:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:00:31'),(92,302,8,5,'23/04/2019 00:00 - 23/04/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:01:16'),(93,302,8,5,'18/04/2019 11:06 - 23/04/2019 11:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:02:02'),(94,302,8,5,'18/04/2019 03:06 - 23/04/2019 03:06',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:02:48'),(95,302,8,5,'17/04/2019 19:05 - 22/04/2019 19:05',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15910311323018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:03:34'),(96,302,8,5,'12/04/2019 00:00 - 06/05/2019 23:59',1,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15912403613018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:03:44'),(97,302,8,1,'12/04/2019 00:00 - 06/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15912403613018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:17:13'),(98,302,8,2,'11/04/2019 23:00 - 06/05/2019 22:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15912403613018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:20:40'),(99,302,8,3,'12/04/2019 00:00 - 06/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15912403613018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 04:29:46'),(100,302,8,4,'12/04/2019 00:00 - 06/05/2019 23:59',0,1,1,'https://sellercentral.amazon.de/gp/ssof/reports/documents/_GET_AMAZON_FULFILLED_SHIPMENTS_DATA__15912403613018010.txt?ie=UTF8&contentType=text%2Fplain','2019-04-24 03:27:50');
/*!40000 ALTER TABLE `module_sc_report_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_subscribe`
--

DROP TABLE IF EXISTS `module_subscribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_subscribe` (
  `subscribe_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `module_id` int(11) NOT NULL COMMENT '模块管理字段,外键于module.module_id\n属于哪个模块的记录',
  `seller_id` int(11) NOT NULL COMMENT '卖家关联字段,外键于amz_seller.seller_id\n属于哪个卖家',
  `account_id` int(11) NOT NULL DEFAULT '0' COMMENT '模块使用的account_id, 与amz_seller_account.account_id关联外键',
  `mws_id` int(11) DEFAULT '0' COMMENT '模块使用的mws_id, 与amz_seller_mws.mws_id关联外键',
  `module_server_url` text COMMENT '指定此用户使用一个seller订阅的模块运行服务器路径\n此字段格式为:http:\\\\domain:port\\project_name\n1.http:\\\\或https:\\\\协议开头\n2.服务器域名或IP\n3.端口号\n4.项目名[可选]',
  `module_settings` text COMMENT '关联的卖家在此模块中使用的设置,\n运行此模块的服务读取此字段的值,\n建议存储JSON或XML等结构清晰的数据格式',
  `expired_time` timestamp NULL DEFAULT NULL COMMENT '此用户的订阅过期时间',
  `last_execute_status` int(11) DEFAULT NULL,
  `last_execute_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '此模块的开始执行时间',
  `last_finish_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '此模块运行结束时间',
  `utime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '此订阅记录的内容最后修改时间',
  `ctime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '此订阅的创建时间',
  PRIMARY KEY (`subscribe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_subscribe`
--

LOCK TABLES `module_subscribe` WRITE;
/*!40000 ALTER TABLE `module_subscribe` DISABLE KEYS */;
INSERT INTO `module_subscribe` VALUES (1,101,3,3,3,'http://localhost:8080','','2030-12-30 16:00:00',200,'2019-03-27 04:19:03','2019-03-27 04:19:03','2019-03-27 04:19:03','2019-03-27 04:19:03'),(2,1001,8,1,0,'http://localhost:8080',NULL,'2030-12-30 16:00:00',200,'2030-12-30 16:00:00','2030-12-30 16:00:00','2019-04-10 03:15:58','2019-04-10 03:15:58');
/*!40000 ALTER TABLE `module_subscribe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_subscribe_record`
--

DROP TABLE IF EXISTS `module_subscribe_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_subscribe_record` (
  `record_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '模块订阅的数据获取情况',
  `module_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `executed_status` int(11) DEFAULT NULL,
  `source_value` int(11) DEFAULT NULL,
  `utime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_time`,`module_id`,`seller_id`,`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_subscribe_record`
--

LOCK TABLES `module_subscribe_record` WRITE;
/*!40000 ALTER TABLE `module_subscribe_record` DISABLE KEYS */;
INSERT INTO `module_subscribe_record` VALUES ('2017-12-31 16:00:00',101,2,1,200,744,'2019-04-19 09:10:57'),('2017-12-31 16:00:00',101,2,2,200,744,'2019-04-19 09:10:57'),('2017-12-31 16:00:00',101,2,3,200,744,'2019-04-19 09:10:57'),('2017-12-31 16:00:00',101,2,4,200,744,'2019-04-19 09:10:57'),('2017-12-31 16:00:00',101,2,5,200,744,'2019-04-19 09:10:57'),('2017-12-31 16:00:00',302,2,1,200,1815,'2019-04-23 11:28:08'),('2017-12-31 16:00:00',302,2,2,200,2334,'2019-04-23 11:28:08'),('2017-12-31 16:00:00',302,2,3,200,223,'2019-04-23 11:28:08'),('2017-12-31 16:00:00',302,2,4,200,466,'2019-04-23 11:28:08'),('2017-12-31 16:00:00',302,2,5,200,113,'2019-04-23 11:28:08'),('2018-01-01 16:00:00',101,2,1,200,620,'2019-04-19 09:10:57'),('2018-01-01 16:00:00',101,2,2,200,620,'2019-04-19 09:10:57'),('2018-01-01 16:00:00',101,2,3,200,558,'2019-04-19 09:10:57'),('2018-01-01 16:00:00',101,2,4,200,558,'2019-04-19 09:10:57'),('2018-01-01 16:00:00',101,2,5,200,558,'2019-04-19 09:10:57'),('2018-01-01 16:00:00',302,2,1,200,2546,'2019-04-23 11:28:08'),('2018-01-01 16:00:00',302,2,2,200,2769,'2019-04-23 11:28:08'),('2018-01-01 16:00:00',302,2,3,200,402,'2019-04-23 11:28:08'),('2018-01-01 16:00:00',302,2,4,200,729,'2019-04-23 11:28:08'),('2018-01-01 16:00:00',302,2,5,200,223,'2019-04-23 11:28:08'),('2018-11-11 16:00:00',107,2,1,200,776,'2019-04-19 09:19:00'),('2018-11-11 16:00:00',107,2,2,200,736,'2019-04-19 09:19:00'),('2018-11-11 16:00:00',107,2,3,200,637,'2019-04-19 09:19:00'),('2018-11-11 16:00:00',107,2,4,200,632,'2019-04-19 09:19:00'),('2018-11-11 16:00:00',107,2,5,200,593,'2019-04-19 09:19:00'),('2019-03-18 16:00:00',201,8,1,200,4,'2019-04-19 06:29:19'),('2019-03-18 16:00:00',201,8,2,200,238,'2019-04-19 06:32:44'),('2019-03-18 16:00:00',201,8,3,200,287,'2019-04-19 06:36:10'),('2019-03-18 16:00:00',201,8,4,200,60,'2019-04-19 06:39:39'),('2019-03-18 16:00:00',201,8,5,200,16,'2019-04-19 06:42:54'),('2019-03-19 16:00:00',201,8,1,200,1,'2019-04-19 06:29:25'),('2019-03-19 16:00:00',201,8,2,200,241,'2019-04-19 06:32:50'),('2019-03-19 16:00:00',201,8,3,200,351,'2019-04-19 06:36:16'),('2019-03-19 16:00:00',201,8,4,200,57,'2019-04-19 06:39:45'),('2019-03-19 16:00:00',201,8,5,200,6,'2019-04-19 06:42:59'),('2019-03-20 16:00:00',201,8,1,200,13,'2019-04-19 06:29:31'),('2019-03-20 16:00:00',201,8,2,200,249,'2019-04-19 06:32:56'),('2019-03-20 16:00:00',201,8,3,200,280,'2019-04-19 06:36:22'),('2019-03-20 16:00:00',201,8,4,200,53,'2019-04-19 06:39:50'),('2019-03-20 16:00:00',201,8,5,200,9,'2019-04-19 06:43:05'),('2019-03-21 16:00:00',201,8,1,200,10,'2019-04-19 06:29:38'),('2019-03-21 16:00:00',201,8,2,200,178,'2019-04-19 06:33:02'),('2019-03-21 16:00:00',201,8,3,200,258,'2019-04-19 06:36:28'),('2019-03-21 16:00:00',201,8,4,200,38,'2019-04-19 06:39:56'),('2019-03-21 16:00:00',201,8,5,200,5,'2019-04-19 06:43:11'),('2019-03-22 16:00:00',201,8,1,200,4,'2019-04-19 06:29:44'),('2019-03-22 16:00:00',201,8,2,200,173,'2019-04-19 06:33:08'),('2019-03-22 16:00:00',201,8,3,200,170,'2019-04-19 06:36:34'),('2019-03-22 16:00:00',201,8,4,200,55,'2019-04-19 06:40:02'),('2019-03-22 16:00:00',201,8,5,200,1,'2019-04-19 06:43:16'),('2019-03-23 16:00:00',201,8,1,200,5,'2019-04-19 06:29:49'),('2019-03-23 16:00:00',201,8,2,200,183,'2019-04-19 06:33:14'),('2019-03-23 16:00:00',201,8,3,200,224,'2019-04-19 06:36:40'),('2019-03-23 16:00:00',201,8,4,200,50,'2019-04-19 06:40:07'),('2019-03-23 16:00:00',201,8,5,200,3,'2019-04-19 06:43:22'),('2019-03-24 16:00:00',201,8,1,200,6,'2019-04-19 06:29:55'),('2019-03-24 16:00:00',201,8,2,200,218,'2019-04-19 06:33:20'),('2019-03-24 16:00:00',201,8,3,200,420,'2019-04-19 06:36:46'),('2019-03-24 16:00:00',201,8,4,200,53,'2019-04-19 06:40:13'),('2019-03-25 16:00:00',201,8,1,200,3,'2019-04-19 06:30:01'),('2019-03-25 16:00:00',201,8,2,200,198,'2019-04-19 06:33:26'),('2019-03-25 16:00:00',201,8,3,200,437,'2019-04-19 06:36:52'),('2019-03-25 16:00:00',201,8,4,200,61,'2019-04-19 06:40:18'),('2019-03-25 16:00:00',201,8,5,200,13,'2019-04-19 06:43:33'),('2019-03-26 16:00:00',201,8,1,200,6,'2019-04-19 06:30:08'),('2019-03-26 16:00:00',201,8,2,200,185,'2019-04-19 06:33:32'),('2019-03-26 16:00:00',201,8,3,200,418,'2019-04-19 06:36:58'),('2019-03-26 16:00:00',201,8,4,200,63,'2019-04-19 06:40:24'),('2019-03-26 16:00:00',201,8,5,200,18,'2019-04-19 06:43:39'),('2019-03-27 16:00:00',201,8,1,200,4,'2019-04-19 06:30:13'),('2019-03-27 16:00:00',201,8,2,200,186,'2019-04-19 06:33:38'),('2019-03-27 16:00:00',201,8,3,200,469,'2019-04-19 06:37:04'),('2019-03-27 16:00:00',201,8,4,200,88,'2019-04-19 06:40:30'),('2019-03-27 16:00:00',201,8,5,200,7,'2019-04-19 06:43:44'),('2019-03-28 16:00:00',201,8,1,200,6,'2019-04-19 06:30:19'),('2019-03-28 16:00:00',201,8,2,200,245,'2019-04-19 06:33:44'),('2019-03-28 16:00:00',201,8,3,200,291,'2019-04-19 06:37:10'),('2019-03-28 16:00:00',201,8,4,200,68,'2019-04-19 06:40:35'),('2019-03-28 16:00:00',201,8,5,200,2,'2019-04-19 06:43:50'),('2019-03-29 16:00:00',201,8,1,200,67,'2019-04-19 06:30:25'),('2019-03-29 16:00:00',201,8,2,200,199,'2019-04-19 06:33:50'),('2019-03-29 16:00:00',201,8,3,200,234,'2019-04-19 06:37:16'),('2019-03-29 16:00:00',201,8,4,200,62,'2019-04-19 06:40:41'),('2019-03-29 16:00:00',201,8,5,200,3,'2019-04-19 06:43:55'),('2019-03-30 16:00:00',201,8,1,200,91,'2019-04-19 06:30:31'),('2019-03-30 16:00:00',201,8,2,200,275,'2019-04-19 06:33:56'),('2019-03-30 16:00:00',201,8,3,200,267,'2019-04-19 06:37:22'),('2019-03-30 16:00:00',201,8,4,200,69,'2019-04-19 06:40:47'),('2019-03-31 16:00:00',201,8,1,200,117,'2019-04-19 06:30:37'),('2019-03-31 16:00:00',201,8,2,200,264,'2019-04-19 06:34:02'),('2019-03-31 16:00:00',201,8,3,200,591,'2019-04-19 06:37:28'),('2019-03-31 16:00:00',201,8,4,200,78,'2019-04-19 06:40:52'),('2019-03-31 16:00:00',201,8,5,200,5,'2019-04-19 06:44:06'),('2019-04-01 16:00:00',201,8,1,200,101,'2019-04-19 06:30:43'),('2019-04-01 16:00:00',201,8,2,200,277,'2019-04-19 06:34:08'),('2019-04-01 16:00:00',201,8,3,200,573,'2019-04-19 06:37:35'),('2019-04-01 16:00:00',201,8,4,200,90,'2019-04-19 06:40:58'),('2019-04-02 16:00:00',201,8,1,200,132,'2019-04-19 06:30:49'),('2019-04-02 16:00:00',201,8,2,200,294,'2019-04-19 06:34:14'),('2019-04-02 16:00:00',201,8,3,200,545,'2019-04-19 06:37:41'),('2019-04-02 16:00:00',201,8,4,200,90,'2019-04-19 06:41:03'),('2019-04-03 16:00:00',201,8,1,200,198,'2019-04-19 06:30:55'),('2019-04-03 16:00:00',201,8,2,200,258,'2019-04-19 06:34:20'),('2019-04-03 16:00:00',201,8,3,200,480,'2019-04-19 06:37:47'),('2019-04-03 16:00:00',201,8,4,200,84,'2019-04-19 06:41:09'),('2019-04-03 16:00:00',201,8,5,200,23,'2019-04-19 06:44:23'),('2019-04-04 16:00:00',201,8,1,200,173,'2019-04-19 06:31:01'),('2019-04-04 16:00:00',201,8,2,200,181,'2019-04-19 06:34:26'),('2019-04-04 16:00:00',201,8,3,200,406,'2019-04-19 06:37:53'),('2019-04-04 16:00:00',201,8,4,200,64,'2019-04-19 06:41:14'),('2019-04-04 16:00:00',201,8,5,200,3,'2019-04-19 06:44:29'),('2019-04-05 16:00:00',201,8,1,200,119,'2019-04-19 06:31:07'),('2019-04-05 16:00:00',201,8,2,200,194,'2019-04-19 06:34:32'),('2019-04-05 16:00:00',201,8,3,200,346,'2019-04-19 06:37:59'),('2019-04-05 16:00:00',201,8,4,200,87,'2019-04-19 06:41:20'),('2019-04-05 16:00:00',201,8,5,200,0,'2019-04-19 06:44:34'),('2019-04-06 16:00:00',201,8,1,200,201,'2019-04-19 06:31:13'),('2019-04-06 16:00:00',201,8,2,200,234,'2019-04-19 06:34:38'),('2019-04-06 16:00:00',201,8,3,200,471,'2019-04-19 06:38:05'),('2019-04-06 16:00:00',201,8,4,200,55,'2019-04-19 06:41:26'),('2019-04-06 16:00:00',201,8,5,200,2,'2019-04-19 06:44:40'),('2019-04-07 16:00:00',201,8,1,200,189,'2019-04-19 06:31:18'),('2019-04-07 16:00:00',201,8,2,200,256,'2019-04-19 06:34:44'),('2019-04-07 16:00:00',201,8,3,200,827,'2019-04-19 06:38:11'),('2019-04-07 16:00:00',201,8,4,200,32,'2019-04-19 06:41:31'),('2019-04-07 16:00:00',201,8,5,200,3,'2019-04-19 06:44:45'),('2019-04-08 16:00:00',201,8,1,200,198,'2019-04-19 06:31:24'),('2019-04-08 16:00:00',201,8,2,200,248,'2019-04-19 06:34:50'),('2019-04-08 16:00:00',201,8,3,200,614,'2019-04-19 06:38:17'),('2019-04-08 16:00:00',201,8,4,200,50,'2019-04-19 06:41:37'),('2019-04-08 16:00:00',302,8,2,200,3,'2019-04-24 03:03:56'),('2019-04-08 16:00:00',302,8,3,200,4,'2019-04-24 03:03:56'),('2019-04-09 16:00:00',201,8,1,200,210,'2019-04-19 06:31:30'),('2019-04-09 16:00:00',201,8,2,200,180,'2019-04-19 06:34:56'),('2019-04-09 16:00:00',201,8,3,200,611,'2019-04-19 06:38:23'),('2019-04-09 16:00:00',201,8,4,200,43,'2019-04-19 06:41:42'),('2019-04-09 16:00:00',201,8,5,200,2,'2019-04-19 06:44:56'),('2019-04-09 16:00:00',302,8,1,200,3,'2019-04-24 03:03:56'),('2019-04-09 16:00:00',302,8,2,200,33,'2019-04-24 03:03:56'),('2019-04-09 16:00:00',302,8,3,200,13,'2019-04-24 03:03:56'),('2019-04-09 16:00:00',302,8,4,200,1,'2019-04-24 03:03:56'),('2019-04-10 16:00:00',201,8,1,200,155,'2019-04-19 06:31:36'),('2019-04-10 16:00:00',201,8,2,200,189,'2019-04-19 06:35:01'),('2019-04-10 16:00:00',201,8,3,200,633,'2019-04-19 06:38:29'),('2019-04-10 16:00:00',201,8,4,200,46,'2019-04-19 06:41:48'),('2019-04-10 16:00:00',201,8,5,200,4,'2019-04-19 06:45:02'),('2019-04-10 16:00:00',302,8,1,200,40,'2019-04-24 03:03:56'),('2019-04-10 16:00:00',302,8,2,200,30,'2019-04-24 03:03:56'),('2019-04-10 16:00:00',302,8,3,200,144,'2019-04-24 03:03:56'),('2019-04-10 16:00:00',302,8,4,200,13,'2019-04-24 03:03:56'),('2019-04-11 16:00:00',201,8,1,200,146,'2019-04-19 06:31:42'),('2019-04-11 16:00:00',201,8,2,200,152,'2019-04-19 06:35:07'),('2019-04-11 16:00:00',201,8,3,200,516,'2019-04-19 06:38:36'),('2019-04-11 16:00:00',201,8,4,200,42,'2019-04-19 06:41:53'),('2019-04-11 16:00:00',201,8,5,200,0,'2019-04-19 06:45:07'),('2019-04-11 16:00:00',302,8,1,200,51,'2019-04-24 01:54:19'),('2019-04-11 16:00:00',302,8,2,200,45,'2019-04-24 01:54:19'),('2019-04-11 16:00:00',302,8,3,200,200,'2019-04-24 01:54:19'),('2019-04-11 16:00:00',302,8,4,200,13,'2019-04-24 01:54:19'),('2019-04-11 16:00:00',302,8,5,200,1,'2019-04-24 01:54:19'),('2019-04-12 16:00:00',201,8,1,200,108,'2019-04-19 06:31:48'),('2019-04-12 16:00:00',201,8,2,200,163,'2019-04-19 06:35:13'),('2019-04-12 16:00:00',201,8,3,200,462,'2019-04-19 06:38:43'),('2019-04-12 16:00:00',201,8,4,200,35,'2019-04-19 06:41:59'),('2019-04-12 16:00:00',201,8,5,200,3,'2019-04-19 06:45:13'),('2019-04-12 16:00:00',302,8,1,200,53,'2019-04-24 01:54:19'),('2019-04-12 16:00:00',302,8,2,200,45,'2019-04-24 01:54:19'),('2019-04-12 16:00:00',302,8,3,200,224,'2019-04-24 01:54:19'),('2019-04-12 16:00:00',302,8,4,200,7,'2019-04-24 01:54:19'),('2019-04-12 16:00:00',302,8,5,200,1,'2019-04-24 01:54:19'),('2019-04-13 16:00:00',201,8,1,200,164,'2019-04-19 06:31:54'),('2019-04-13 16:00:00',201,8,2,200,129,'2019-04-19 06:35:19'),('2019-04-13 16:00:00',201,8,3,200,755,'2019-04-19 06:38:49'),('2019-04-13 16:00:00',201,8,4,200,41,'2019-04-19 06:42:04'),('2019-04-13 16:00:00',201,8,5,200,1,'2019-04-19 06:45:18'),('2019-04-13 16:00:00',302,8,1,200,56,'2019-04-23 12:28:23'),('2019-04-13 16:00:00',302,8,2,200,37,'2019-04-23 12:28:23'),('2019-04-13 16:00:00',302,8,3,200,366,'2019-04-23 12:28:23'),('2019-04-13 16:00:00',302,8,4,200,8,'2019-04-24 01:54:19'),('2019-04-13 16:00:00',302,8,5,200,1,'2019-04-24 01:54:19'),('2019-04-14 16:00:00',201,8,1,200,171,'2019-04-19 06:32:00'),('2019-04-14 16:00:00',201,8,2,200,101,'2019-04-19 06:35:25'),('2019-04-14 16:00:00',201,8,3,200,852,'2019-04-19 06:38:55'),('2019-04-14 16:00:00',201,8,4,200,41,'2019-04-19 06:42:10'),('2019-04-14 16:00:00',201,8,5,200,3,'2019-04-19 06:45:24'),('2019-04-14 16:00:00',302,8,1,200,48,'2019-04-23 12:28:23'),('2019-04-14 16:00:00',302,8,2,200,38,'2019-04-23 12:28:23'),('2019-04-14 16:00:00',302,8,3,200,389,'2019-04-23 12:28:23'),('2019-04-14 16:00:00',302,8,4,200,8,'2019-04-23 12:28:23'),('2019-04-14 16:00:00',302,8,5,200,1,'2019-04-23 12:28:23'),('2019-04-15 16:00:00',201,8,1,200,66,'2019-04-19 06:32:06'),('2019-04-15 16:00:00',201,8,2,200,149,'2019-04-19 06:35:31'),('2019-04-15 16:00:00',201,8,3,200,565,'2019-04-19 06:39:01'),('2019-04-15 16:00:00',201,8,4,200,32,'2019-04-19 06:42:16'),('2019-04-15 16:00:00',302,8,1,200,20,'2019-04-23 12:28:23'),('2019-04-15 16:00:00',302,8,2,200,44,'2019-04-23 12:28:23'),('2019-04-15 16:00:00',302,8,3,200,257,'2019-04-23 12:28:23'),('2019-04-15 16:00:00',302,8,4,200,13,'2019-04-23 12:28:23'),('2019-04-16 16:00:00',201,8,2,200,236,'2019-04-19 06:35:37'),('2019-04-16 16:00:00',201,8,3,200,618,'2019-04-19 06:39:07'),('2019-04-16 16:00:00',201,8,4,200,32,'2019-04-19 06:42:21'),('2019-04-16 16:00:00',302,8,2,200,61,'2019-04-23 12:19:10'),('2019-04-16 16:00:00',302,8,3,200,250,'2019-04-23 12:19:10'),('2019-04-16 16:00:00',302,8,4,200,7,'2019-04-23 12:28:23'),('2019-04-17 16:00:00',201,8,2,200,0,'2019-04-19 06:35:43'),('2019-04-17 16:00:00',302,8,2,200,39,'2019-04-23 12:19:10'),('2019-04-17 16:00:00',302,8,3,200,203,'2019-04-23 12:19:10'),('2019-04-17 16:00:00',302,8,4,200,10,'2019-04-23 12:19:10'),('2019-04-17 16:00:00',302,8,5,200,3,'2019-04-23 12:19:10'),('2019-04-18 16:00:00',302,8,2,200,25,'2019-04-23 12:19:10'),('2019-04-18 16:00:00',302,8,3,200,134,'2019-04-23 12:19:10'),('2019-04-18 16:00:00',302,8,4,200,3,'2019-04-23 12:19:10'),('2019-04-18 16:00:00',302,8,5,200,5,'2019-04-23 12:19:10'),('2019-04-19 16:00:00',302,8,2,200,27,'2019-04-23 10:34:24'),('2019-04-19 16:00:00',302,8,3,200,103,'2019-04-23 10:34:24'),('2019-04-19 16:00:00',302,8,4,200,5,'2019-04-23 10:34:24'),('2019-04-19 16:00:00',302,8,5,200,1,'2019-04-23 12:19:10'),('2019-04-20 16:00:00',302,8,2,200,22,'2019-04-23 10:34:24'),('2019-04-20 16:00:00',302,8,3,200,127,'2019-04-23 10:34:24'),('2019-04-20 16:00:00',302,8,4,200,6,'2019-04-23 10:34:24'),('2019-04-20 16:00:00',302,8,5,200,6,'2019-04-23 10:34:24'),('2019-04-21 16:00:00',302,8,2,200,24,'2019-04-23 10:34:24'),('2019-04-21 16:00:00',302,8,3,200,163,'2019-04-23 10:34:24'),('2019-04-21 16:00:00',302,8,4,200,9,'2019-04-23 10:34:24'),('2019-04-22 16:00:00',302,8,2,200,11,'2019-04-24 01:43:33'),('2019-04-22 16:00:00',302,8,3,200,156,'2019-04-23 12:16:05'),('2019-04-22 16:00:00',302,8,4,200,3,'2019-04-24 01:43:33'),('2019-04-22 16:00:00',302,8,5,200,1,'2019-04-24 01:43:33');
/*!40000 ALTER TABLE `module_subscribe_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `permission_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `permission_name` varchar(100) NOT NULL COMMENT '权限名称',
  `permission_url` varchar(100) NOT NULL COMMENT '权限路径',
  `request_type` int(10) NOT NULL COMMENT '请求类型，1为GET,2为POST,3为PUT,4为DELETE',
  `permission_title` varchar(45) NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'suplier_manager','/buManager/*',1,'供应商管理'),(2,'product_cost_price','/costPrice/*',1,'产品价格'),(3,'role_manager','/permisson/*',1,'角色管理'),(4,'permission_manager','/permissionManager/*',1,'权限管理');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_access_drw`
--

DROP TABLE IF EXISTS `permission_access_drw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_access_drw` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `access_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_access_drw`
--

LOCK TABLES `permission_access_drw` WRITE;
/*!40000 ALTER TABLE `permission_access_drw` DISABLE KEYS */;
INSERT INTO `permission_access_drw` VALUES (1,'浏览权限'),(2,'编辑权限'),(3,'无');
/*!40000 ALTER TABLE `permission_access_drw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `product_model_number` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公司内部商品model number',
  `business_unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属BU',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌id',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品类型',
  `product_long` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '长',
  `product_width` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '宽',
  `product_height` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '高',
  `product_volume` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '体积',
  `product_netweight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '净重',
  `product_grossweight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '毛重',
  `product_material` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '主要材质',
  `product_package_contains` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '包装附件内容',
  `product_order_defect` decimal(10,2) NOT NULL COMMENT '产品退换货率',
  `product_u8_code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品u8编码',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '产品状态(1:激活,0:未激活,-1:删除)',
  `product_certification` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品认证',
  `product_description_chs` text COLLATE utf8mb4_unicode_ci COMMENT '中文描述',
  `product_description_en` text COLLATE utf8mb4_unicode_ci COMMENT '英文描述',
  `user_id` int(11) NOT NULL COMMENT '录入商品的用户id(与User表关联)',
  `c_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_img_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品图片（默认橱窗图第一张）',
  `total_safety_day` int(11) DEFAULT NULL COMMENT '总安全天数 = [亚马逊安全天数+深圳仓安全天数+供应商安全天数]',
  `amz_safety_day` int(11) DEFAULT NULL COMMENT '亚马逊安全库存天数',
  `est_units_avg_day_ratio` decimal(10,2) DEFAULT '0.00' COMMENT '加权预测日均比率  (est_units_avg_day_ratio+last_units_avg_day_ratio=1)',
  `last_units_avg_day_ratio` decimal(10,2) DEFAULT '0.00' COMMENT '加权历史日均的比率  (est_units_avg_day_ratio+last_units_avg_day_ratio=1)',
  `big_last_units_avg_day` int(11) DEFAULT NULL COMMENT '库存设置提醒 大于方向 历史日均',
  `big_est_unitis_avg_day_ratio` decimal(10,2) DEFAULT NULL COMMENT '库存设置提醒 大于方向 预测日均比率',
  `big_item_key_id` int(11) DEFAULT NULL COMMENT '库存设置提醒 大于方向 对应 item_key_id',
  `samll_last_units_avg_day` int(11) DEFAULT NULL COMMENT '库存设置提醒 小于方向 对应 历史日均天数',
  `samll_est_units_avg_day_ratio` decimal(10,2) DEFAULT NULL COMMENT '库存设置提醒 小于方向 对应 预测日均比率',
  `samll_item_key_id` int(11) DEFAULT NULL COMMENT '库存设置提醒 小于方向 对应 item_key_id',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (2,'product_a',1,1,777,5.00,5.00,3.00,27.00,3.33,3.33,'16549549845198','54648451231',0.02,'001000100001',1,'55687654316','12312312312312312','333333333333333333',0,'2019-04-22 06:44:16',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'product_b',1,1,777,3.33,3.33,3.33,0.00,3.33,3.33,'111111','3333',0.00,'0',0,'22222','222222222222222','333333333333333333',0,'2019-04-02 08:10:13',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'product_c',1,1,777,3.33,3.33,3.33,0.00,3.33,3.33,'0000','00000',0.00,'',1,'1111111111','222222222222222','333333333333333333',0,'2019-03-19 06:10:12',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'product_d',1,1,777,3.33,3.33,3.33,0.00,3.33,3.33,'0000','00000',0.00,'',1,'1111111111','222222222222222','333333333333333333',0,'2019-03-19 06:22:29',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'product_e',1,1,777,3.33,3.33,3.33,0.00,3.33,3.33,'0000','00000',0.00,'',1,'1111111111','222222222222222','333333333333333333',0,'2019-03-19 06:54:51',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'Capshi 001',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-28 09:08:55',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'SWLC249UPC',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-28 09:20:39',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'SWLC279',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-28 09:26:37',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'SWLC280',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-28 09:28:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'SWLC306',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 01:51:54',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'SWLC309',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:11:06',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,'SWLC312',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,'SWLC315',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,'SWLC318',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,'SWLC321',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,'SWLC324',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,'SWLC327',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,'SWLC330',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,'SWLC333',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:26',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,'SWSP242',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:27',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,'SWSP243',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:27',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,'SWSP244',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:27',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'SWSP354',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:27',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,'SWSP355',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,'SWSP356',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,'SWSP357',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,'SWSP358',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,'TENINYU',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,'UGREEN',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,'UGREEN0001',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,'ivanky',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 02:28:28',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,'SWSP122-001B',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-03-29 11:45:40',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,'SWSP188-001B',1,1,777,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-01 01:47:12',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,'141414141414',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,'','',0.00,'0',0,'','','',0,'2019-04-02 08:05:06',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,'59-93R3-PUJS',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 07:34:46',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,'UBAL075ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,'UBBT117UPC',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,'UBBT118ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,'UBCH134ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,'UBET122ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,'UBET123ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,'UBLD113ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,'UBLD114ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:07',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,'UBLD115ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,'UBLD116ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,'UBMU063ADDFN',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,'UBMU064ADDFN',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,'UBMU065ADDFN',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,'UBMU066ADDFN',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,'UBMU067ADDFN',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,'UBMU082ADDFN',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,'UBMU083',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,'UBMU084',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,'UBMU124ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:08',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,'UBMU125ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(59,'UBMU126ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,'UBMU127ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,'UBNU119ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(62,'UBZT128ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,'UBZT129ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,'UBZT130ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,'UBZT131ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,'UBZT132ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,'UBZT133ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:31:09',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,'UBMU137ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:35:33',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,'UBZT135ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:35:33',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,'UBZT136ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 08:35:33',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,'UBBT138ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 10:04:57',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(72,'UBBT139ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 10:04:57',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,'UBBT140ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 10:04:57',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,'UBBT141ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 10:04:57',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(75,'UBET142ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 10:04:57',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(76,'UBET143ADD',1,1,1,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0.00,'',1,NULL,NULL,NULL,1,'2019-04-10 10:04:57',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_category` (
  `product_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_category` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品系列',
  PRIMARY KEY (`product_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5557 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'aaa'),(777,'UPDATE'),(888,'hhh'),(4444,'zzz'),(5555,'LLL'),(5556,'ADD');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_document`
--

DROP TABLE IF EXISTS `product_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_document` (
  `product_document_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `product_document_url` varchar(255) NOT NULL COMMENT '产品文档路径',
  `product_document_name` varchar(45) NOT NULL COMMENT '文件名称（原始名称）',
  `product_document_type_id` int(11) NOT NULL COMMENT '产品文档类型',
  `u_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `c_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '产品id',
  `status` int(11) NOT NULL COMMENT '产品文档状态(1:激活,0:未激活,-1:删除)',
  PRIMARY KEY (`product_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_document`
--

LOCK TABLES `product_document` WRITE;
/*!40000 ALTER TABLE `product_document` DISABLE KEYS */;
INSERT INTO `product_document` VALUES (5,0,'/static/DOCUMENT/2019.4/c47c3aa1f1a846ac820f227bc9d6a6ae.html','',1,'2019-04-04 10:07:51','2019-04-04 10:07:51',1),(9,1,'/static/DOCUMENT/2019.4/e0cac4440b8840be848bc40390ae1e06.txt','',1,'2019-04-09 06:47:55','2019-04-09 06:47:55',1),(10,1,'/static/DOCUMENT/2019.4/2d6250a7a77c40f99b3a3fe8447250c6.xls','',1,'2019-04-09 06:47:55','2019-04-09 06:47:55',1),(11,1,'/static/DOCUMENT/2019.4/ca99be17812b45d78ade19c7a6ac92e5.txt','',1,'2019-04-09 06:49:22','2019-04-09 06:49:22',1),(12,1,'/static/DOCUMENT/2019.4/47e1df37719446e1a682f6d0cf948093.xls','',1,'2019-04-09 06:49:31','2019-04-09 06:49:31',1),(13,1,'/static/DOCUMENT/2019.4/3d6e25f4ac764fafb65f67c40a417f95.txt','',1,'2019-04-09 06:53:45','2019-04-09 06:53:45',1),(14,1,'/static/DOCUMENT/2019.4/c27e52fd15664fd5885b1d412c16ebb7.xls','',1,'2019-04-09 06:53:47','2019-04-09 06:53:47',1),(15,1,'/static/DOCUMENT/2019.4/6b7b6c384dd646c29b7c77eff514829f.txt','',1,'2019-04-09 07:05:59','2019-04-09 07:05:59',1),(16,1,'/static/DOCUMENT/2019.4/0ee729d590e04c3490673a0f78e2874d.xls','',1,'2019-04-09 07:06:11','2019-04-09 07:06:11',1),(17,1,'/static/DOCUMENT/2019.4/04e693a51eed4335960e23e909cae3cf.txt','Connections_incoming',1,'2019-04-09 07:13:18','2019-04-09 07:13:18',1),(18,1,'/static/DOCUMENT/2019.4/4aafc8ca785e41aeb366346ac486d7ce.xls','Connections_incoming',1,'2019-04-09 07:13:18','2019-04-09 07:13:18',1),(19,1,'/static/DOCUMENT/2019.4/6096ef4655c04e06900ce8ab88382603.docx','Connections_incoming',1,'2019-04-09 07:15:01','2019-04-09 07:15:01',1),(20,1,'/static/DOCUMENT/2019.4/231bc0e465614aa39d184832d8ed5d18.xls','Connections_incoming',1,'2019-04-09 07:15:01','2019-04-09 07:15:01',1),(21,1,'/static/DOCUMENT/2019.4/5f4ac54aa25c45209cd7bb3657656a98.docx','Connections_incoming',1,'2019-04-09 07:19:16','2019-04-09 07:19:16',1),(22,1,'/static/DOCUMENT/2019.4/ea0a48d99bf544f492c60d366789f4ac.xls','Connections_incoming',1,'2019-04-09 07:19:16','2019-04-09 07:19:16',1),(23,1,'/static/DOCUMENT/2019.4/2091f7c6f4b14545bbfa296dcc599118.docx','svn軟件安裝',1,'2019-04-09 07:20:03','2019-04-09 07:20:03',1),(24,1,'/static/DOCUMENT/2019.4/c6727833725747e688ef65b813439d02.docx','svn軟件安裝',1,'2019-04-09 07:22:52','2019-04-09 07:22:52',1),(25,1,'/static/DOCUMENT/2019.4/efff4724738748298ffbbe8683dc9d02.docx','svn軟件安裝',1,'2019-04-09 07:24:36','2019-04-09 07:24:36',1),(26,1,'/static/DOCUMENT/2019.4/15ee32dddf91467ebf39fb55a9ad3252.xls','专项附加扣除信息采集(2)(1)',1,'2019-04-09 07:24:39','2019-04-09 07:24:39',1),(27,1,'/static/DOCUMENT/2019.4/f1c30fbd3cda4c02b66863ba77d532e4.txt','模板引擎-Thymeleaf',1,'2019-04-09 07:30:49','2019-04-09 07:30:49',1),(28,1,'/static/DOCUMENT/2019.4/ca65c860fa4c4785861709b2bed8a38b.txt','模板引擎-Thymeleaf',1,'2019-04-09 07:31:26','2019-04-09 07:31:26',1),(29,1,'/static/DOCUMENT/2019.4/d7d299810ffb49efa089424c2a305aa1.txt','模板引擎-Thymeleaf',1,'2019-04-09 07:32:29','2019-04-09 07:32:29',1),(30,1,'/static/DOCUMENT/2019.4/399193dcaaef401eb00d658271c2231d.txt','模板引擎-Thymeleaf',1,'2019-04-09 07:39:00','2019-04-09 07:39:00',1),(31,1,'/static/DOCUMENT/2019.4/6fe35d9cc1c14792b3fd1d471f64d06b.md','模板引擎-Thymeleaf',1,'2019-04-09 07:44:07','2019-04-09 07:44:07',1),(32,1,'/static/DOCUMENT/2019.4/20145d242a0044029ecc0315ae4b2cbc.txt','0409',1,'2019-04-09 07:44:23','2019-04-09 07:44:23',1),(33,2,'/static/DOCUMENT/2019.4/c2ca1f7f423c41a8a8b0648304812c11.html','link',1,'2019-04-10 09:10:35','2019-04-09 07:51:11',-1),(34,2,'/static/DOCUMENT/2019.4/c4670cf910ca4bcfafbda5e82c32157e.html','link (1)',1,'2019-04-10 09:10:35','2019-04-10 02:01:23',-1),(35,2,'/static/DOCUMENT/2019.4/4bf1b89102a34dd5b63fa148b5ac2ef9.html','link (2)',2,'2019-04-10 09:09:17','2019-04-10 02:02:20',-1),(36,2,'/static/DOCUMENT/2019.4/7e422af822b34195bb63ae64706d99ee.html','link (3)',2,'2019-04-10 09:09:17','2019-04-10 02:02:20',-1),(37,2,'/static/DOCUMENT/2019.4/7d8020dc0146499ebd55ce5470a4076a.txt','link (1)',4,'2019-04-10 02:04:13','2019-04-10 02:04:13',1),(48,2,'/static/DOCUMENT/2019.4/766cb4bb9d5c4dffb7f72d0759ff0b62.html','产品模块需准备接口',6,'2019-04-10 02:21:14','2019-04-10 02:21:14',1),(49,2,'/static/DOCUMENT/2019.4/d75c89c798a44c4687f30a7f8104fbb7.txt','产品模块需准备接口',6,'2019-04-10 02:21:14','2019-04-10 02:21:14',1),(50,2,'/static/DOCUMENT/2019.4/b00022d859c5400baa8363061a7286d4.txt','产品模块需准备接口',6,'2019-04-10 02:21:14','2019-04-10 02:21:14',1),(51,2,'/static/DOCUMENT/2019.4/1f3af187e1f94b46aa726a90e42456bb.txt','产品模块需准备接口',3,'2019-04-10 02:31:46','2019-04-10 02:31:46',1),(52,2,'/static/DOCUMENT/2019.4/6b5c9ac8fc7f4af9aedcec86132c9543.txt','产品模块需准备接口',5,'2019-04-10 02:42:49','2019-04-10 02:42:49',1),(53,2,'/static/DOCUMENT/2019.4/d09c31aff2c9413eb25e2f722312786c.txt','产品模块需准备接口',5,'2019-04-10 02:42:49','2019-04-10 02:42:49',1),(54,2,'/static/DOCUMENT/2019.4/868f3c8a5a614e769de0f6ee7cc3ca25.txt','产品模块需准备接口',6,'2019-04-10 02:44:54','2019-04-10 02:44:54',1),(55,2,'/static/DOCUMENT/2019.4/32f81d0bf8174b8faa3389f4c0d762d9.txt','产品模块需准备接口',6,'2019-04-10 02:44:54','2019-04-10 02:44:54',1),(60,2,'/static/DOCUMENT/2019.4/32bd3edfe287419d9eded470952c8121.txt','新建文本文档',7,'2019-04-10 02:55:37','2019-04-10 02:55:37',1),(61,2,'/static/DOCUMENT/2019.4/cb24c90c72b34cff9e080049616c42b5.txt','新建文本文档',7,'2019-04-10 02:55:37','2019-04-10 02:55:37',1),(62,2,'/static/DOCUMENT/2019.4/d012a272f7c943d8a050c3051d691e3f.txt','产品模块需准备接口',7,'2019-04-10 02:56:07','2019-04-10 02:56:07',1),(63,2,'/static/DOCUMENT/2019.4/a1cb7dbc78a641e2ba6b6c1a40abad66.html','产品模块需准备接口',7,'2019-04-10 02:56:07','2019-04-10 02:56:07',1),(64,2,'/static/DOCUMENT/2019.4/8f357384379f4418b7c73c01bc2f1a4a.txt','产品模块需准备接口',7,'2019-04-10 02:56:07','2019-04-10 02:56:07',1),(65,1,'/static/DOCUMENT/2019.4/df95d59b72bc45dfb3df75ed0a5584d7.md','模板引擎-Thymeleaf',1,'2019-04-10 03:28:30','2019-04-10 03:28:29',1),(66,1,'/static/DOCUMENT/2019.4/d38f19db5f334220a9764ced0f90f440.txt','0409',1,'2019-04-10 03:28:48','2019-04-10 03:28:48',1),(67,1,'/static/DOCUMENT/2019.4/dd0f9d64e66b4fb09816bcb6769ca518.md','模板引擎-Thymeleaf',1,'2019-04-10 03:46:19','2019-04-10 03:46:19',1),(68,1,'/static/DOCUMENT/2019.4/9798d90a7e9a40fab088834de27d245b.txt','0409',1,'2019-04-10 03:46:21','2019-04-10 03:46:21',1),(69,2,'/static/DOCUMENT/2019.4/95377e9e4fa04b618169bd6d486621e9.txt','新建文本文档',4,'2019-04-10 03:49:35','2019-04-10 03:49:35',1),(70,2,'/static/DOCUMENT/2019.4/a6f32dfe2c594b79828deb4457fe0286.txt','新建文本文档',4,'2019-04-10 03:49:35','2019-04-10 03:49:35',1),(71,1,'/static/DOCUMENT/2019.4/f43d0d97572f451686e946d33467667e.md','模板引擎-Thymeleaf',1,'2019-04-10 03:51:12','2019-04-10 03:51:12',1),(72,1,'/static/DOCUMENT/2019.4/2cbb0088b4aa456abbbfada890f9e03d.txt','0409',1,'2019-04-10 03:51:13','2019-04-10 03:51:13',1),(73,1,'/static/DOCUMENT/2019.4/fe8560b203d448af9a2338b997c35a6f.docx','svn軟件安裝',1,'2019-04-10 03:51:14','2019-04-10 03:51:14',1),(74,2,'/static/DOCUMENT/2019.4/4c2bdfd60574423a8d5836585741b776.txt','产品模块需准备接口',2,'2019-04-10 09:10:21','2019-04-10 03:52:16',-1),(75,2,'/static/DOCUMENT/2019.4/cfbd1b1556654bfd8ffd9e42a52ca949.txt','产品模块需准备接口',2,'2019-04-10 09:10:21','2019-04-10 03:52:16',-1),(76,2,'/static/DOCUMENT/2019.4/0ec04bd4819f46198e0bc267f91c2a3b.txt','新建文本文档',3,'2019-04-10 03:55:25','2019-04-10 03:55:25',1),(77,2,'/static/DOCUMENT/2019.4/9e99b39cfcef4bd7b50d95513b3714ad.txt','新建文本文档',3,'2019-04-10 03:55:25','2019-04-10 03:55:25',1),(78,2,'/static/DOCUMENT/2019.4/06294f081b5745eab68b531c638753eb.txt','link (1)',1,'2019-04-10 10:30:22','2019-04-10 04:00:35',-1),(79,2,'/static/DOCUMENT/2019.4/f348c50d8ba44ddd8cc8c20331b4b6fe.html','link (1)',1,'2019-04-10 10:30:22','2019-04-10 04:00:35',-1),(80,2,'/static/DOCUMENT/2019.4/a48cd50b730c4d1fbd4d65ab4683c444.txt','link (1)',1,'2019-04-10 10:30:22','2019-04-10 04:00:35',-1),(81,2,'/static/DOCUMENT/2019.4/dbcd25024c644dec9e687f4f414df902.txt','新建文本文档',1,'2019-04-10 09:10:42','2019-04-10 04:03:56',-1),(82,2,'/static/DOCUMENT/2019.4/eedfff5845aa4fe5b12dcb5cb7693335.txt','新建文本文档',1,'2019-04-10 09:10:42','2019-04-10 04:03:56',-1),(83,2,'/static/DOCUMENT/2019.4/a0bc2f62aacc4cb0b23bcfb9225335b9.html','新建文本文档',1,'2019-04-10 04:05:30','2019-04-10 04:05:30',1),(84,2,'/static/DOCUMENT/2019.4/9c90977a4d434de3b2a30d066ef7d41a.txt','新建文本文档',1,'2019-04-10 04:07:11','2019-04-10 04:07:11',1),(85,1,'/static/DOCUMENT/2019.4/1c85cdf295b5444ea1a6479a02da35c1.md','新建文本文档',1,'2019-04-10 04:09:37','2019-04-10 04:09:37',1),(86,1,'/static/DOCUMENT/2019.4/196561c72b0c41a9b84613b0f62a14da.txt','产品模块需准备接口',1,'2019-04-10 04:09:44','2019-04-10 04:09:44',1),(87,1,'/static/DOCUMENT/2019.4/6c7aa47db7c3489fab29f98254620090.docx','产品模块需准备接口',1,'2019-04-10 04:09:48','2019-04-10 04:09:48',1),(88,1,'/static/DOCUMENT/2019.4/2206c2cfac95489383344ba889cd1ce5.md','模板引擎-Thymeleaf',1,'2019-04-10 04:10:25','2019-04-10 04:10:25',1),(89,1,'/static/DOCUMENT/2019.4/166c2b9f84fc487b9524fa585a6b20d8.txt','0409',1,'2019-04-10 04:10:25','2019-04-10 04:10:25',1),(90,1,'/static/DOCUMENT/2019.4/a995f34ffc9440b4b24bf4db9eac8890.docx','svn軟件安裝',1,'2019-04-10 04:10:25','2019-04-10 04:10:25',1),(91,1,'/static/DOCUMENT/2019.4/883f13d8fcd04d78a595cf81a3f762a2.md','新建文本文档',1,'2019-04-10 04:11:44','2019-04-10 04:11:44',1),(92,1,'/static/DOCUMENT/2019.4/e3413a1528104f719c192eb1544907ef.txt','产品模块需准备接口',1,'2019-04-10 04:11:44','2019-04-10 04:11:44',1),(93,1,'/static/DOCUMENT/2019.4/9925aac540834c419f341a74efcb9ca2.docx','产品模块需准备接口',1,'2019-04-10 04:11:44','2019-04-10 04:11:44',1),(94,1,'/static/DOCUMENT/2019.4/cceeb86280184943a9de574422a8811b.md','模板引擎-Thymeleaf',1,'2019-04-10 04:12:04','2019-04-10 04:12:04',1),(95,1,'/static/DOCUMENT/2019.4/8a0a4ba5ade24876876f9e8a9f58f763.txt','0409',1,'2019-04-10 04:12:04','2019-04-10 04:12:04',1),(96,1,'/static/DOCUMENT/2019.4/20c45081a42149fa99d69caeb6472d58.docx','svn軟件安裝',1,'2019-04-10 04:12:04','2019-04-10 04:12:04',1),(97,2,'/static/DOCUMENT/2019.4/08bae3cb517d458aa513e2b8a88f19b9.txt','产品模块需准备接口',2,'2019-04-10 09:10:27','2019-04-10 04:17:29',-1),(98,2,'/static/DOCUMENT/2019.4/1acce043eb59485d9b92d22738b6dbd2.txt','产品模块需准备接口',2,'2019-04-10 04:17:29','2019-04-10 04:17:29',1),(99,2,'/static/DOCUMENT/2019.4/5b19da96b80b478c9aedd96704362482.html','link',7,'2019-04-10 04:19:03','2019-04-10 04:19:03',1),(100,2,'/static/DOCUMENT/2019.4/6ce491b555a24204ad93d8db7b770731.html','link',7,'2019-04-10 04:19:03','2019-04-10 04:19:03',1),(101,2,'/static/DOCUMENT/2019.4/8c8b4ab59aad4582b53b67834bbfb07f.html','link',6,'2019-04-10 04:21:28','2019-04-10 04:21:28',1),(102,2,'/static/DOCUMENT/2019.4/53d43e8eff7a4c91a19609982c4fb7a5.html','link',6,'2019-04-10 04:21:33','2019-04-10 04:21:33',1),(103,1,'/static/DOCUMENT/2019.4/eb66a9f45b934777b90463edb4656a0e.md','模板引擎-Thymeleaf',1,'2019-04-10 04:25:46','2019-04-10 04:25:46',1),(104,1,'/static/DOCUMENT/2019.4/0a5f17f762534af0bb7f35704f0aba22.txt','0409',1,'2019-04-10 04:25:49','2019-04-10 04:25:49',1),(105,1,'/static/DOCUMENT/2019.4/3d456e2dc8e04aebacc1cd7327f46393.docx','svn軟件安裝',1,'2019-04-10 04:26:04','2019-04-10 04:26:04',1),(106,1,'/static/DOCUMENT/2019.4/1010b70acb9c420d9b0994055ef9b512.md','模板引擎-Thymeleaf',1,'2019-04-10 04:28:23','2019-04-10 04:28:23',1),(107,1,'/static/DOCUMENT/2019.4/d97d48380a824177825b658e86b30558.txt','0409',1,'2019-04-10 04:28:28','2019-04-10 04:28:28',1),(108,1,'/static/DOCUMENT/2019.4/ec1b8331bae54dbaa6061e5e4b284dfc.docx','svn軟件安裝',1,'2019-04-10 04:28:30','2019-04-10 04:28:30',1),(109,1,'/static/DOCUMENT/2019.4/1db21e28b0094c579affa6f0adcc154d_模板引擎-Thymeleaf.md','模板引擎-Thymeleaf',1,'2019-04-10 06:14:07','2019-04-10 06:14:07',1),(110,1,'/static/DOCUMENT/2019.4/24307b20b17b4c86a3d91ad35a6dd76b_0409.txt','0409',1,'2019-04-10 06:14:08','2019-04-10 06:14:08',1),(111,1,'/static/DOCUMENT/2019.4/06fa918509454607b421a2944b0f5419_svn軟件安裝.docx','svn軟件安裝',1,'2019-04-10 06:14:08','2019-04-10 06:14:08',1),(112,2,'/static/DOCUMENT/2019.4/b4a193f2f40f4e84a653afa1cae279ac_文案.docx','文案',1,'2019-04-10 10:29:36','2019-04-10 10:29:36',1);
/*!40000 ALTER TABLE `product_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_document_type`
--

DROP TABLE IF EXISTS `product_document_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_document_type` (
  `product_document_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_document_type_name` varchar(45) NOT NULL COMMENT '产品文档类型名称(认证文件,产品定义文件等等)',
  PRIMARY KEY (`product_document_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_document_type`
--

LOCK TABLES `product_document_type` WRITE;
/*!40000 ALTER TABLE `product_document_type` DISABLE KEYS */;
INSERT INTO `product_document_type` VALUES (1,'产品listing文案'),(2,'产品定义文档'),(3,'认证文件'),(4,'结构文件'),(5,'立项资料'),(6,'申述文件'),(7,'其他');
/*!40000 ALTER TABLE `product_document_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_img`
--

DROP TABLE IF EXISTS `product_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_img` (
  `product_img_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `product_img_url` varchar(255) NOT NULL COMMENT '产品图片路径',
  `product_img_type_id` int(11) NOT NULL COMMENT '产品图片类型id',
  `u_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `c_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `status` int(11) NOT NULL COMMENT '图片状态(1:激活,0:未激活,-1:删除)',
  PRIMARY KEY (`product_img_id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_img`
--

LOCK TABLES `product_img` WRITE;
/*!40000 ALTER TABLE `product_img` DISABLE KEYS */;
INSERT INTO `product_img` VALUES (114,2,'/static/IMAGE/2019.4/789760a724dd4d31a4fbb83d8383ed17.jpg',1,'2019-04-12 10:17:06','2019-04-12 10:17:06',1),(115,2,'/static/IMAGE/2019.4/18759cc22f054a9195c749506ff2bab5.png',1,'2019-04-15 09:08:55','2019-04-15 09:08:55',1),(116,2,'/static/IMAGE/2019.4/62804f12c823490dab84ffb50eab8c72.png',1,'2019-04-15 09:08:55','2019-04-15 09:08:55',1),(117,2,'/static/IMAGE/2019.4/a6acef3264dd4cf1bb50552d551d4141.png',1,'2019-04-15 09:08:55','2019-04-15 09:08:55',1),(118,2,'/static/IMAGE/2019.4/66aa2755c0d64fc7b4ef50afe732af47.png',1,'2019-04-15 09:09:09','2019-04-15 09:09:09',1),(119,2,'/static/IMAGE/2019.4/6f375bb1cadb4333bdafe61d3003b527.png',1,'2019-04-15 09:09:10','2019-04-15 09:09:10',1),(120,2,'/static/IMAGE/2019.4/bdd8d68414c04ab6807827eca6ef10af.png',1,'2019-04-15 09:09:10','2019-04-15 09:09:10',1),(121,2,'/static/IMAGE/2019.4/ea062c7c6d814a69aa84cebdfafc4c35.png',1,'2019-04-15 09:29:17','2019-04-15 09:29:17',1),(122,2,'/static/IMAGE/2019.4/41c6a8bf197f4d578c77a6b7c517fa3f.png',1,'2019-04-15 09:29:18','2019-04-15 09:29:18',1),(123,2,'/static/IMAGE/2019.4/c6be1682622847129fdc3bee02af4bab.png',1,'2019-04-15 09:29:18','2019-04-15 09:29:18',1),(124,2,'/static/IMAGE/2019.4/d78c0adeed2f4867a855b5589956066e.png',1,'2019-04-15 09:46:41','2019-04-15 09:46:41',1),(125,2,'/static/IMAGE/2019.4/9aac5033319e4ad881852faa6f57614b.png',1,'2019-04-15 09:46:42','2019-04-15 09:46:42',1),(126,2,'/static/IMAGE/2019.4/d9e46914397643c69f4e718672bec48e.png',1,'2019-04-15 09:46:42','2019-04-15 09:46:42',1);
/*!40000 ALTER TABLE `product_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_img_type`
--

DROP TABLE IF EXISTS `product_img_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_img_type` (
  `product_img_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_img_type_name` varchar(45) NOT NULL COMMENT '产品图片类型名称',
  PRIMARY KEY (`product_img_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_img_type`
--

LOCK TABLES `product_img_type` WRITE;
/*!40000 ALTER TABLE `product_img_type` DISABLE KEYS */;
INSERT INTO `product_img_type` VALUES (1,'橱窗图'),(2,'EBC'),(3,'品牌推广图'),(4,'实物图'),(5,'包装图片'),(6,'说明书图片'),(7,'其他');
/*!40000 ALTER TABLE `product_img_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_listing_event`
--

DROP TABLE IF EXISTS `product_listing_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_listing_event` (
  `product_listing_event_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Listing事件',
  `country_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `seller_id` int(11) NOT NULL COMMENT '账号',
  `product_listing_event_description` text NOT NULL COMMENT '事件',
  `product_listing_event_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '时间',
  `product_listing_event_processing_record` text NOT NULL COMMENT '处理记录',
  `product_listing_event_record_user` varchar(45) NOT NULL COMMENT '记录人',
  `u_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `c_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `status` int(11) NOT NULL COMMENT '事件状态(1:激活,0:未激活,-1:删除)',
  PRIMARY KEY (`product_listing_event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_listing_event`
--

LOCK TABLES `product_listing_event` WRITE;
/*!40000 ALTER TABLE `product_listing_event` DISABLE KEYS */;
INSERT INTO `product_listing_event` VALUES (1,1,1,3,'4444','2019-03-28 07:38:38','4444','str1111ing','2019-03-28 07:46:55','2019-03-28 07:38:59',1),(2,1,2,2,'a','2019-04-01 02:43:07','Listting处理记录12412352345','当前用户','2019-04-11 06:14:29','2019-04-01 02:43:23',1),(3,2,1,1,'新增 事件 修改111','2019-04-01 03:26:42','新增记录 处理记录','当前用户','2019-04-02 03:05:10','2019-04-01 03:27:06',1),(4,1,2,1,'addbbbbb','2019-04-22 04:00:00','add','当前用户','2019-04-11 03:13:30','2019-04-03 07:40:27',1),(5,1,2,1,'enioaheingiae gi','2019-04-08 04:00:00','nei9ugnianeg ','当前用户','2019-04-10 10:34:10','2019-04-10 10:34:10',1),(6,1,2,1,'aaaa','2019-04-11 04:04:16','bbbbb','当前用户','2019-04-11 04:04:27','2019-04-11 04:04:27',1),(7,1,2,1,'bb','2019-04-12 06:52:10','bb','当前用户','2019-04-12 06:54:46','2019-04-12 06:52:56',1);
/*!40000 ALTER TABLE `product_listing_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_supplier`
--

DROP TABLE IF EXISTS `product_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_supplier` (
  `product_supplier_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键(供应商)',
  `product_supplier_name` varchar(45) NOT NULL COMMENT '供应商',
  `product_supplier_address` varchar(255) NOT NULL,
  `product_supplier_contact` varchar(45) NOT NULL COMMENT '联系人',
  `product_supplier_contact_phone` varchar(45) NOT NULL COMMENT '联系电话',
  `product_supplier_contact_mail` varchar(45) NOT NULL COMMENT '联系邮箱',
  `product_supplier_transaction_currency` varchar(45) NOT NULL COMMENT '交易货币',
  `user_id` int(11) NOT NULL COMMENT '采购负责人',
  `product_supplier_record_user` varchar(45) NOT NULL COMMENT '记录人',
  `u_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `c_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `remark` varchar(45) NOT NULL COMMENT '备注',
  `status` int(11) NOT NULL COMMENT '状态(1:激活,0:未激活,-1:删除)',
  PRIMARY KEY (`product_supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_supplier`
--

LOCK TABLES `product_supplier` WRITE;
/*!40000 ALTER TABLE `product_supplier` DISABLE KEYS */;
INSERT INTO `product_supplier` VALUES (1,'str3300ing','str333333ing','str3333ing','stri3333ng','stri33333ng','str3333ing',333,'当前用户','2019-04-12 09:49:56','2019-04-12 09:49:56','2str33333ingaa',1),(2,'1122','深圳龙华','stri111ng','stri1111ng','str111ing','RMB',2,'当前用户','2019-04-02 03:11:22','2019-04-02 03:11:22','修改后333',1),(3,'供应商1','广东省深圳市','联系人1','123','123@.com','USD',1,'当前用户','2019-04-02 03:11:27','2019-04-02 03:11:27','新增供应商 备注',1),(4,'修改后','广东省深圳市','联系人1','123','123@.com','RMB',1,'当前用户','2019-04-02 03:11:30','2019-04-02 03:11:30','新增供应商 备注',1),(5,'444','555','555','555','555','USD',5,'当前用户','2019-04-01 10:32:03','2019-04-01 10:32:03','3333',1),(6,'777','22','22','33','6667','RMB',5,'当前用户','2019-04-01 10:50:25','2019-04-01 10:50:25','66',1),(7,'aaa','c1111','bbbb','bbbb','ccc','RMB',2,'当前用户','2019-04-08 11:59:38','2019-04-08 11:59:38','1',1),(8,'123','1231231231231','1231','1231','123','RMB',1,'当前用户','2019-04-10 10:34:44','2019-04-10 10:34:44','dfbvergreg',1),(9,'123456','123456','123456','123456','123456','RMB',1,'当前用户','2019-04-11 03:10:45','2019-04-11 03:10:45','123456',1),(10,'111','1111','111','222','222','USD',5,'当前用户','2019-04-12 06:55:22','2019-04-12 06:55:22','111',1),(11,'str4444444ing','stri444ng','string444','stri44ng','stri44ng','stri444ng',1,'str444ing','2019-04-12 09:35:25','2019-04-12 09:35:25','st4444ring',1);
/*!40000 ALTER TABLE `product_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_supplier_rel`
--

DROP TABLE IF EXISTS `product_supplier_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_supplier_rel` (
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `product_supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `product_supplier_production_costs` varchar(45) NOT NULL COMMENT '采购成本',
  `product_supplier_MOQ` int(11) NOT NULL COMMENT '产品最小起订量',
  `product_supplier_capactity` int(11) NOT NULL COMMENT '产能(K/day)',
  `product_supplier_minimum_carton_quantity` int(11) NOT NULL COMMENT '最小包(出厂装箱每箱的最小数量)',
  PRIMARY KEY (`product_id`,`product_supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_supplier_rel`
--

LOCK TABLES `product_supplier_rel` WRITE;
/*!40000 ALTER TABLE `product_supplier_rel` DISABLE KEYS */;
INSERT INTO `product_supplier_rel` VALUES (1,2,'str111ing',100,100,1000),(1,3,'1000',10,1000,10),(1,4,'1000',10,1000,10),(1,5,'555',555,555,555),(1,6,'22',22,33,22),(2,1,'s3333tring',30,3000,3000),(2,7,'1',1,1,1),(2,8,'12',123123,123123,123),(2,9,'123456',123456,123456,123456),(2,10,'111',111,111,111),(2,11,'str44ing',44,444,444);
/*!40000 ALTER TABLE `product_supplier_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(50) NOT NULL COMMENT '角色名称',
  `parent_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'总经办',0),(2,'UB合伙人',1),(3,'syncwire合伙人',1),(6,'采购主管',3),(7,'采购副主管',6),(9,'UB主管',2),(10,'UB副主管',9),(17,'UKNOW合伙人',1),(19,'Syncwire成员',7),(24,'初级运营专员',10),(25,'UB采购主管',2),(26,'UB采购副主管',25),(27,'UB采购前采专员',26),(28,'UB采购后采专员',26),(29,'中级运营专员',10),(33,'产品部主管',2),(43,'设计部主管',1),(44,'设计部副主管',43),(52,'asdf',6);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission_rel`
--

DROP TABLE IF EXISTS `role_permission_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission_rel` (
  `role_id` int(10) NOT NULL COMMENT '角色id',
  `permission_id` int(10) NOT NULL COMMENT '权限id',
  `is_access` int(10) NOT NULL DEFAULT '3' COMMENT '1代表可读，2代表可编辑，3代表无权限',
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission_rel`
--

LOCK TABLES `role_permission_rel` WRITE;
/*!40000 ALTER TABLE `role_permission_rel` DISABLE KEYS */;
INSERT INTO `role_permission_rel` VALUES (1,1,1),(1,2,3),(1,3,1),(1,4,1),(2,2,2),(2,3,2),(3,1,2),(6,2,2),(6,3,1),(7,3,2),(9,2,2),(10,2,2),(24,1,1),(25,3,3),(28,3,1),(29,2,1);
/*!40000 ALTER TABLE `role_permission_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段,主键',
  `user_name` varchar(45) NOT NULL COMMENT '用户登录系统的名称',
  `user_password` varchar(45) DEFAULT NULL COMMENT '用户登录系统的密码',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `department_id` int(11) DEFAULT NULL COMMENT '部门id',
  `business_unit_id` int(11) DEFAULT NULL,
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `remark` varchar(45) DEFAULT NULL COMMENT '备注',
  `user_display_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'leaderment','123',1,1,1,'2019-03-29 01:51:30','aa','leaderment'),(6,'123456','111',3,1,0,'2019-03-29 07:28:56','anotherTime','123456'),(39,'Ben','Leaderment01',1,1,0,'2019-04-04 08:08:32','firstTime','李纯滨'),(40,'LV','Leaderment01',2,2,0,'2019-04-04 08:18:51','anotherTime','卢丽婷'),(41,'Tom','Leaderment01',1,2,0,'2019-04-04 08:19:09','firstTime','张洪华'),(47,'123','123',24,30,1,'2019-04-11 07:00:07','firstTime','123.'),(48,'xiaobin','123',24,31,1,'2019-04-11 10:49:01','firstTime','小彬');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_country_product_rel`
--

DROP TABLE IF EXISTS `user_country_product_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_country_product_rel` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `country_id` int(11) NOT NULL COMMENT '国家id',
  `product_id` int(11) NOT NULL COMMENT '用户国家商品表(采购订单)',
  `record` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '记录人',
  `u_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remark` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`,`country_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_country_product_rel`
--

LOCK TABLES `user_country_product_rel` WRITE;
/*!40000 ALTER TABLE `user_country_product_rel` DISABLE KEYS */;
INSERT INTO `user_country_product_rel` VALUES (1,1,2,'当前用户','2019-04-09 12:03:41','ccc'),(1,2,1,NULL,'0000-00-00 00:00:00',NULL),(1,2,2,'当前用户','2019-04-08 12:08:47','aaa'),(1,3,1,NULL,'2019-04-02 07:27:17',NULL),(2,1,2,'当前用户','2019-04-11 01:58:57','bbb'),(2,3,2,'当前用户','2019-04-11 02:04:42','3333'),(2,4,2,'当前用户','2019-04-10 10:32:25',''),(2,5,2,'当前用户','2019-04-10 10:40:37','qqq'),(2,6,2,'当前用户','2019-04-10 03:47:07','1111'),(2,7,2,'当前用户','2019-04-10 03:45:41','222'),(3,1,5,NULL,'0000-00-00 00:00:00',NULL),(4,1,1,NULL,'0000-00-00 00:00:00',NULL),(10,12,12,NULL,'0000-00-00 00:00:00',NULL),(11,12,12,NULL,'0000-00-00 00:00:00',NULL),(12,12,12,NULL,'0000-00-00 00:00:00',NULL),(46,6,6,NULL,'0000-00-00 00:00:00',NULL),(56,1,5,NULL,'0000-00-00 00:00:00',NULL),(56,2,5,NULL,'0000-00-00 00:00:00',NULL),(56,2,6,NULL,'2022-01-31 16:00:00',NULL),(56,4,6,NULL,'0000-00-00 00:00:00',NULL),(57,2,5,NULL,'0000-00-00 00:00:00',NULL),(57,4,5,NULL,'0000-00-00 00:00:00',NULL),(57,4,6,NULL,'0000-00-00 00:00:00',NULL),(57,5,5,NULL,'0000-00-00 00:00:00',NULL),(58,2,5,NULL,'0000-00-00 00:00:00',NULL),(58,4,5,NULL,'0000-00-00 00:00:00',NULL),(58,4,6,NULL,'0000-00-00 00:00:00',NULL),(58,5,6,NULL,'0000-00-00 00:00:00',NULL),(58,6,5,NULL,'0000-00-00 00:00:00',NULL),(60,1,5,NULL,'0000-00-00 00:00:00',NULL),(60,2,6,NULL,'0000-00-00 00:00:00',NULL),(60,3,5,NULL,'0000-00-00 00:00:00',NULL),(60,6,5,NULL,'0000-00-00 00:00:00',NULL),(60,6,6,NULL,'0000-00-00 00:00:00',NULL),(60,7,5,NULL,'0000-00-00 00:00:00',NULL),(60,7,6,NULL,'0000-00-00 00:00:00',NULL),(60,9,5,NULL,'0000-00-00 00:00:00',NULL),(60,9,6,NULL,'0000-00-00 00:00:00',NULL),(63,1,3,NULL,'0000-00-00 00:00:00',NULL),(66,1,2,NULL,'0000-00-00 00:00:00',NULL),(66,1,3,NULL,'0000-00-00 00:00:00',NULL),(66,1,4,NULL,'0000-00-00 00:00:00',NULL),(66,2,5,NULL,'0000-00-00 00:00:00',NULL),(66,2,6,NULL,'0000-00-00 00:00:00',NULL),(67,2,2,NULL,'0000-00-00 00:00:00',NULL),(67,2,3,NULL,'0000-00-00 00:00:00',NULL),(67,2,4,NULL,'0000-00-00 00:00:00',NULL),(68,1,2,NULL,'0000-00-00 00:00:00',NULL),(68,1,3,NULL,'0000-00-00 00:00:00',NULL),(68,1,4,NULL,'0000-00-00 00:00:00',NULL),(68,2,5,NULL,'0000-00-00 00:00:00',NULL),(68,2,6,NULL,'0000-00-00 00:00:00',NULL),(69,4,5,NULL,'0000-00-00 00:00:00',NULL),(69,4,6,NULL,'0000-00-00 00:00:00',NULL),(71,3,2,NULL,'0000-00-00 00:00:00',NULL),(71,3,3,NULL,'0000-00-00 00:00:00',NULL),(81,1,2,NULL,'0000-00-00 00:00:00',NULL),(81,1,3,NULL,'0000-00-00 00:00:00',NULL),(81,1,4,NULL,'0000-00-00 00:00:00',NULL),(666,666,666,'1122认证1','2019-04-02 07:47:06',NULL),(888,888,888,'888','2019-04-02 09:28:50','888');
/*!40000 ALTER TABLE `user_country_product_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission_rel`
--

DROP TABLE IF EXISTS `user_permission_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permission_rel` (
  `user_id` int(10) NOT NULL,
  `permission_id` int(10) NOT NULL,
  `is_access` int(10) NOT NULL DEFAULT '3',
  PRIMARY KEY (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission_rel`
--

LOCK TABLES `user_permission_rel` WRITE;
/*!40000 ALTER TABLE `user_permission_rel` DISABLE KEYS */;
INSERT INTO `user_permission_rel` VALUES (1,1,2),(1,2,2),(1,3,1),(2,1,2),(2,2,2),(3,2,2),(6,2,2),(40,1,1),(40,2,3),(40,3,1),(40,4,1),(41,1,1),(41,2,1),(41,3,1),(41,4,1);
/*!40000 ALTER TABLE `user_permission_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_product_rel`
--

DROP TABLE IF EXISTS `user_product_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_product_rel` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_product_rel`
--

LOCK TABLES `user_product_rel` WRITE;
/*!40000 ALTER TABLE `user_product_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_product_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bison'
--

--
-- Dumping routines for database 'bison'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-24 18:49:06
