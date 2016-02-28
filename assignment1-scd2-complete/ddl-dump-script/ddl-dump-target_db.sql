/*
SQLyog Community v12.2.0 (64 bit)
MySQL - 5.7.10-log : Database - target_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `target_db`;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_key` bigint(20) NOT NULL DEFAULT '-1',
  `category` varchar(256) NOT NULL DEFAULT '-',
  PRIMARY KEY (`category_key`),
  UNIQUE KEY `idx_category_pk` (`category_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `product_key` bigint(20) NOT NULL DEFAULT '-1',
  `product_desc` varchar(256) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `category_key` bigint(20) DEFAULT NULL,
  KEY `idx_product_lookup` (`product_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `product_v2` */

DROP TABLE IF EXISTS `product_v2`;

CREATE TABLE `product_v2` (
  `product_key` bigint(20) NOT NULL DEFAULT '-1',
  `prod_code` int(11) DEFAULT NULL,
  `prod_desc` varchar(256) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `category_key` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `idx_product_v2_lookup` (`prod_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sales_random` */

DROP TABLE IF EXISTS `sales_random`;

CREATE TABLE `sales_random` (
  `customer_key` int(11) DEFAULT NULL,
  `product_key` int(11) DEFAULT NULL,
  `discountPct` int(11) DEFAULT NULL,
  `nrProducts` int(11) DEFAULT NULL,
  `minCustKey` int(11) DEFAULT NULL,
  `minProdKey` int(11) DEFAULT NULL,
  `maxCustKey` int(11) DEFAULT NULL,
  `maxProdKey` int(11) DEFAULT NULL,
  `salesDate` datetime DEFAULT NULL,
  `transactionLineNr` bigint(20) DEFAULT NULL,
  `transactionNr` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `stg_customer` */

DROP TABLE IF EXISTS `stg_customer`;

CREATE TABLE `stg_customer` (
  `customer_id` tinytext,
  `first_name` tinytext,
  `last_name` tinytext,
  `date_of_birth` datetime DEFAULT NULL,
  `city` tinytext,
  `state` tinytext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `stg_prod_catalog` */

DROP TABLE IF EXISTS `stg_prod_catalog`;

CREATE TABLE `stg_prod_catalog` (
  `prod_code` varchar(11) DEFAULT NULL,
  `prod_desc` varchar(256) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `category` varchar(256) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `test_tbl` */

DROP TABLE IF EXISTS `test_tbl`;

CREATE TABLE `test_tbl` (
  `desc_product` tinytext,
  `price` double DEFAULT NULL,
  `category` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `time` */

DROP TABLE IF EXISTS `time`;

CREATE TABLE `time` (
  `the_date` tinytext,
  `the_day` tinytext,
  `the_month` tinytext,
  `the_year` int(11) DEFAULT NULL,
  `day_of_month` int(11) DEFAULT NULL,
  `week_of_year` int(11) DEFAULT NULL,
  `month_of_year` int(11) DEFAULT NULL,
  `quarter` tinytext,
  `fiscal_period` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
