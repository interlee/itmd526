USE datamart_kbb;

DROP TABLE IF EXISTS dim_customer_scd1;
CREATE TABLE `dim_customer_scd1` (
  `customer_key` BIGINT(20) NOT NULL DEFAULT '-1',
  `custom_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `first_name` VARCHAR(32) DEFAULT NULL,
  `last_name` VARCHAR(32) DEFAULT NULL,
  `date_of_birth` CHAR(10) DEFAULT NULL,
  `city` VARCHAR(64) DEFAULT '-',
  `state` VARCHAR(64) DEFAULT '-',
  `version` BIGINT(20) DEFAULT NULL, -- special column used by PDI
  `date_from` DATETIME,              -- special column used by PDI
  `date_to` DATETIME                 -- special column used by PDI  
) ENGINE=MYISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS dim_customer;
CREATE TABLE `dim_customer` (
  `customer_key` BIGINT(20) NOT NULL DEFAULT '-1',
  `custom_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `first_name` VARCHAR(32) DEFAULT NULL,
  `last_name` VARCHAR(32) DEFAULT NULL,
  `date_of_birth` CHAR(10) DEFAULT NULL,
  `city` VARCHAR(64) DEFAULT '-',
  `state` VARCHAR(64) DEFAULT '-',
  `version` BIGINT(20) DEFAULT NULL, -- special column used by PDI
  `date_from` DATETIME,              -- special column used by PDI
  `date_to` DATETIME                 -- special column used by PDI
) ENGINE=MYISAM DEFAULT CHARSET=utf8