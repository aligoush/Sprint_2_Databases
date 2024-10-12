-- MySQL Workbench Synchronization
-- Generated: 2024-10-11 20:30
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alina

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `optical_store`  DEFAULT COLLATE utf8mb4_general_ci ;

ALTER TABLE `optical_store`.`suppliers` 
DROP FOREIGN KEY `fk_suppliers_address1`;

ALTER TABLE `optical_store`.`glasses` 
DROP FOREIGN KEY `fk_glasses_suppliers1`;

ALTER TABLE `optical_store`.`sales` 
DROP FOREIGN KEY `fk_sales_customers1`,
DROP FOREIGN KEY `fk_sales_employees1`,
DROP FOREIGN KEY `fk_sales_glasses1`;

ALTER TABLE `optical_store`.`suppliers` 
COLLATE = utf8mb4_general_ci ,
CHANGE COLUMN `supplier_name` `supplier_name` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `supplier_phone_number` `supplier_phone_number` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `supplier_fax` `supplier_fax` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `supplier_nif` `supplier_nif` VARCHAR(9) NOT NULL ,
CHANGE COLUMN `address_id` `address_id` INT(11) NOT NULL ;

ALTER TABLE `optical_store`.`glasses` 
COLLATE = utf8mb4_general_ci ,
CHANGE COLUMN `glasses_brand` `glasses_brand` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `prescription_lens_left` `prescription_lens_left` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `prescription_lens_right` `prescription_lens_right` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `frame_type` `frame_type` ENUM("floating", "plastic", "metallic") NOT NULL ,
CHANGE COLUMN `frame_color` `frame_color` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `lens_color_left` `lens_color_left` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `lens_color_right` `lens_color_right` VARCHAR(45) NOT NULL ;

ALTER TABLE `optical_store`.`customers` 
COLLATE = utf8mb4_general_ci ,
CHANGE COLUMN `customer_name` `customer_name` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `customer_phone_number` `customer_phone_number` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `customer_email` `customer_email` VARCHAR(45) NOT NULL ,
DROP INDEX `fk_customers_address1` ;
;

ALTER TABLE `optical_store`.`sales` 
COLLATE = utf8mb4_general_ci ;

ALTER TABLE `optical_store`.`employees` 
COLLATE = utf8_estonian_ci ,
CHANGE COLUMN `employees_id` `employee_id` INT(11) NOT NULL AUTO_INCREMENT ,
CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `employee_phone_number` `employee_phone_number` VARCHAR(45) NOT NULL ;

ALTER TABLE `optical_store`.`address` 
COLLATE = utf8mb4_general_ci ,
CHANGE COLUMN `country` `country` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `city` `city` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `postal_code` `postal_code` VARCHAR(5) NOT NULL ,
CHANGE COLUMN `street` `street` VARCHAR(45) NOT NULL ;

ALTER TABLE `optical_store`.`suppliers` 
ADD CONSTRAINT `fk_suppliers_address1`
  FOREIGN KEY (`address_id`)
  REFERENCES `optical_store`.`address` (`address_id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `optical_store`.`glasses` 
ADD CONSTRAINT `fk_glasses_suppliers1`
  FOREIGN KEY (`supplier_id`)
  REFERENCES `optical_store`.`suppliers` (`supplier_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `optical_store`.`customers` 
DROP FOREIGN KEY `fk_customers_customers1`;

ALTER TABLE `optical_store`.`customers` ADD CONSTRAINT `fk_customers_customers1`
  FOREIGN KEY (`referred_by`)
  REFERENCES `optical_store`.`customers` (`customer_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;

ALTER TABLE `optical_store`.`sales` 
ADD CONSTRAINT `fk_sales_customers1`
  FOREIGN KEY (`customer_id`)
  REFERENCES `optical_store`.`customers` (`customer_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_sales_employees1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `optical_store`.`employees` (`employee_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_sales_glasses1`
  FOREIGN KEY (`glasses_id`)
  REFERENCES `optical_store`.`glasses` (`glasses_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
