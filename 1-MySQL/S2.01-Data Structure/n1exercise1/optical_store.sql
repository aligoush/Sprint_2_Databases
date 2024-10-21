-- MySQL Workbench Synchronization
-- Generated: 2024-10-21 17:44
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alien

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `optical_store` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `optical_store`.`address` (
  `address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `city` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `postal_code` VARCHAR(5) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `street` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `street_number` INT(11) NOT NULL,
  `floor` INT(11) NOT NULL,
  `door` INT(11) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`customers` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `customer_phone_number` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `customer_email` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `registration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `referred_by` INT(11) NULL DEFAULT NULL,
  `address_id` INT(11) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_email_UNIQUE` (`customer_email` ASC) VISIBLE,
  UNIQUE INDEX `customer_phone_number_UNIQUE` (`customer_phone_number` ASC) VISIBLE,
  UNIQUE INDEX `referred_by_UNIQUE` (`referred_by` ASC) VISIBLE,
  INDEX `fk_customers_customers1_idx` (`referred_by` ASC) VISIBLE,
  INDEX `fk_customers_address1` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `optical_store`.`address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customers_customers1`
    FOREIGN KEY (`referred_by`)
    REFERENCES `optical_store`.`customers` (`customer_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`employees` (
  `employees_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `employee_phone_number` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  PRIMARY KEY (`employees_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`glasses` (
  `glasses_id` INT(11) NOT NULL AUTO_INCREMENT,
  `prescription_lens_left` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `prescription_lens_right` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `frame_type` ENUM('floating', 'plastic', 'metallic') COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `frame_color` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `lens_color_left` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `lens_color_right` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `brand_id` INT(11) NOT NULL,
  `supplier_id` INT(11) NOT NULL,
  PRIMARY KEY (`glasses_id`),
  INDEX `fk_glasses_suppliers1_idx1` (`supplier_id` ASC) VISIBLE,
  INDEX `fk_glasses_brands1_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `optical_store`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_glasses_brands1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `optical_store`.`brands` (`brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`sales` (
  `sale_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `glasses_id` INT(11) NOT NULL,
  `sale_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`),
  INDEX `fk_sales_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_sales_employees1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_sales_glasses1_idx` (`glasses_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`suppliers` (
  `supplier_id` INT(11) NOT NULL,
  `supplier_name` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `supplier_phone_number` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `supplier_fax` VARCHAR(45) COLLATE 'utf8mb3_estonian_ci' NULL DEFAULT NULL,
  `supplier_nif` VARCHAR(9) COLLATE 'utf8mb3_estonian_ci' NOT NULL,
  `address_id` INT(11) NOT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `supplier_nif_UNIQUE` (`supplier_nif` ASC) VISIBLE,
  UNIQUE INDEX `supplier_phone_number_UNIQUE` (`supplier_phone_number` ASC) VISIBLE,
  INDEX `fk_suppliers_address1_idx1` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_suppliers_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `optical_store`.`address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`employees` (
  `employee_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`sales` (
  `sale_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(11) NOT NULL,
  `glasses_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `sale_date` DATETIME NOT NULL,
  PRIMARY KEY (`sale_id`),
  INDEX `fk_customers_has_glasses_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  INDEX `fk_customers_has_glasses_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_sales_employees1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_has_glasses_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `optical_store`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customers_has_glasses_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `optical_store`.`glasses` (`glasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `optical_store`.`employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optical_store`.`brands` (
  `brand_id` INT(11) NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(100) NOT NULL,
  `supplier_id` INT(11) NOT NULL,
  PRIMARY KEY (`brand_id`),
  INDEX `fk_brands_suppliers1_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_brands_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `optical_store`.`suppliers` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
