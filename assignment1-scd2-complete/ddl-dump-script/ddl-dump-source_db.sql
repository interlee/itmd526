/*
SQLyog Community v12.2.0 (64 bit)
MySQL - 5.7.10-log : Database - source_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `source_db`;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL,
  `category` tinytext,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `city_state` */

DROP TABLE IF EXISTS `city_state`;

CREATE TABLE `city_state` (
  `city_state_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `city` varchar(64) DEFAULT '-',
  `state` varchar(64) DEFAULT '-',
  PRIMARY KEY (`city_state_id`),
  UNIQUE KEY `nkey_city_state` (`city`,`state`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `country_iso_code` varchar(3) DEFAULT NULL,
  `country_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(32) NOT NULL DEFAULT '-',
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `city_state_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_customer` (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=780 DEFAULT CHARSET=utf8;

/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `EMPLOYEENUMBER` int(11) NOT NULL DEFAULT '0',
  `LASTNAME` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `FIRSTNAME` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `EXTENSION` varchar(10) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `EMAIL` varchar(100) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `OFFICECODE` varchar(20) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `REPORTSTO` int(11) DEFAULT NULL,
  `JOBTITLE` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  PRIMARY KEY (`EMPLOYEENUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

/*Table structure for table `offices` */

DROP TABLE IF EXISTS `offices`;

CREATE TABLE `offices` (
  `OFFICECODE` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `CITY` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `PHONE` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `ADDRESSLINE1` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `ADDRESSLINE2` varchar(50) COLLATE latin1_general_cs DEFAULT NULL,
  `STATE` varchar(50) COLLATE latin1_general_cs DEFAULT NULL,
  `COUNTRY` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `POSTALCODE` varchar(10) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `TERRITORY` varchar(10) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  PRIMARY KEY (`OFFICECODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

/*Table structure for table `outdoor_categories` */

DROP TABLE IF EXISTS `outdoor_categories`;

CREATE TABLE `outdoor_categories` (
  `id_category` int(11) NOT NULL,
  `category` tinytext,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `outdoor_products` */

DROP TABLE IF EXISTS `outdoor_products`;

CREATE TABLE `outdoor_products` (
  `id_product` int(11) DEFAULT NULL,
  `desc_product` tinytext,
  `price` double DEFAULT NULL,
  `id_category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `PRODUCTCODE` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `PRODUCTNAME` varchar(70) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `PRODUCTLINE` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `PRODUCTSCALE` varchar(10) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `PRODUCTVENDOR` varchar(50) COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `PRODUCTDESCRIPTION` mediumtext COLLATE latin1_general_cs NOT NULL,
  `QUANTITYINSTOCK` smallint(6) NOT NULL DEFAULT '0',
  `BUYPRICE` decimal(17,0) NOT NULL DEFAULT '0',
  `MSRP` decimal(17,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PRODUCTCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

/*Table structure for table `revenue` */

DROP TABLE IF EXISTS `revenue`;

CREATE TABLE `revenue` (
  `date` date DEFAULT NULL,
  `country_iso_code` varchar(3) DEFAULT NULL,
  `revenue` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

/*Table structure for table `sales_raw` */

DROP TABLE IF EXISTS `sales_raw`;

CREATE TABLE `sales_raw` (
  `sales_raw_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(32) DEFAULT NULL,
  `prod_code` varchar(11) DEFAULT NULL,
  `sales_date` date DEFAULT NULL,
  `transaction_number` int(11) DEFAULT NULL,
  `transaction_line_number` int(11) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `discount_pct` int(11) DEFAULT NULL,
  `sales_qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`sales_raw_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
