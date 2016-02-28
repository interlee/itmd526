/*
SQLyog Community v12.2.0 (64 bit)
MySQL - 5.7.10-log : Database - datamart_kbb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `datamart_kbb`;

/*Table structure for table `dim_customer` */

DROP TABLE IF EXISTS `dim_customer`;

CREATE TABLE `dim_customer` (
  `customer_key` bigint(20) NOT NULL DEFAULT '-1',
  `custom_id` varchar(32) NOT NULL DEFAULT '-',
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `city` varchar(64) DEFAULT '-',
  `state` varchar(64) DEFAULT '-'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `dim_customer_scd1` */

DROP TABLE IF EXISTS `dim_customer_scd1`;

CREATE TABLE `dim_customer_scd1` (
  `customer_key` bigint(20) NOT NULL DEFAULT '-1',
  `customer_id` varchar(32) NOT NULL DEFAULT '-',
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `city` varchar(64) DEFAULT '-',
  `state` varchar(64) DEFAULT '-',
  `version` bigint(20) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `dim_customer_scd2` */

DROP TABLE IF EXISTS `dim_customer_scd2`;

CREATE TABLE `dim_customer_scd2` (
  `customer_key` bigint(20) NOT NULL DEFAULT '-1',
  `customer_id` varchar(32) NOT NULL DEFAULT '-',
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `city` varchar(64) DEFAULT '-',
  `state` varchar(64) DEFAULT '-',
  `version` bigint(20) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `dim_date` */

DROP TABLE IF EXISTS `dim_date`;

CREATE TABLE `dim_date` (
  `date_key` int(11) DEFAULT NULL,
  `the_date` date DEFAULT NULL,
  `the_year` smallint(6) DEFAULT NULL,
  `the_quarter` tinyint(4) DEFAULT NULL,
  `the_month` tinyint(4) DEFAULT NULL,
  `the_week` tinyint(4) DEFAULT NULL,
  `day_of_year` smallint(6) DEFAULT NULL,
  `day_of_month` tinyint(4) DEFAULT NULL,
  `day_of_week` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `dim_product` */

DROP TABLE IF EXISTS `dim_product`;

CREATE TABLE `dim_product` (
  `PRODUCT_KEY` bigint(20) NOT NULL DEFAULT '-1',
  `PROD_CODE` varchar(11) NOT NULL DEFAULT '-',
  `PRODUCT_DESC` varchar(256) NOT NULL DEFAULT '-',
  `UNIT_PRICE` double NOT NULL DEFAULT '0',
  `CATEGORY` varchar(256) NOT NULL DEFAULT '-',
  PRIMARY KEY (`PRODUCT_KEY`),
  KEY `IX_BUS_KEY` (`PROD_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `dim_product_scd1` */

DROP TABLE IF EXISTS `dim_product_scd1`;

CREATE TABLE `dim_product_scd1` (
  `PRODUCT_KEY` bigint(20) NOT NULL DEFAULT '-1',
  `PROD_CODE` varchar(11) NOT NULL DEFAULT '-',
  `PRODUCT_DESC` varchar(256) NOT NULL DEFAULT '-',
  `UNIT_PRICE` double DEFAULT '0',
  `CATEGORY` varchar(256) NOT NULL DEFAULT '-',
  `VERSION` bigint(20) DEFAULT NULL,
  `DATE_FROM` datetime DEFAULT NULL,
  `DATE_TO` datetime DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_KEY`),
  KEY `IX_BUS_KEY` (`PROD_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `dim_product_scd2` */

DROP TABLE IF EXISTS `dim_product_scd2`;

CREATE TABLE `dim_product_scd2` (
  `product_key` bigint(20) NOT NULL DEFAULT '-1',
  `prod_code` varchar(11) NOT NULL DEFAULT '-',
  `product_desc` varchar(256) DEFAULT '-',
  `unit_price` double DEFAULT '0',
  `category` varchar(256) DEFAULT '-',
  `version` bigint(20) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `fact_sales` */

DROP TABLE IF EXISTS `fact_sales`;

CREATE TABLE `fact_sales` (
  `date_key` bigint(20) DEFAULT NULL,
  `customer_key` bigint(20) DEFAULT NULL,
  `product_key` bigint(20) DEFAULT NULL,
  `sales_raw_id` bigint(20) DEFAULT NULL,
  `transaction_number` int(11) DEFAULT NULL,
  `transaction_line_number` int(11) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `discount_pct` int(11) DEFAULT NULL,
  `sales_qty` int(11) DEFAULT NULL,
  `extended_sales_total` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
