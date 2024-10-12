-- MySQL Workbench Synchronization
-- Generated: 2024-10-12 18:08
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alina

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`customers` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `address` VARCHAR(155) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `city_id` INT(11) NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customers_cities1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `pizzeria`.`cities` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery` TINYINT(4) NOT NULL,
  `total_price` FLOAT(11) NOT NULL,
  `customer_id` INT(11) NOT NULL,
  `store_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_stores1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `pizzeria`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_stores1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizzeria`.`stores` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `price` FLOAT(11) NOT NULL,
  `product_type` ENUM("pizza", "burguer", "drink") NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`order_has_product` (
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_orders_has_products_products1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_orders_has_products_orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_products_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_category` (
  `pizza_category_id` INT(11) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pizza_category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `product_id` INT(11) NOT NULL,
  `pizza_category_id` INT(11) NOT NULL,
  PRIMARY KEY (`product_id`, `pizza_category_id`),
  INDEX `fk_products_has_pizza_category_pizza_category1_idx` (`pizza_category_id` ASC) VISIBLE,
  INDEX `fk_products_has_pizza_category_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_has_pizza_category_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_has_pizza_category_pizza_category1`
    FOREIGN KEY (`pizza_category_id`)
    REFERENCES `pizzeria`.`pizza_category` (`pizza_category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`cities` (
  `city_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `province_id` INT(11) NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_cities_provinces1_idx` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_cities_provinces1`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizzeria`.`provinces` (`province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`provinces` (
  `province_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`province_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`stores` (
  `store_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(155) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `city_id` INT(11) NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_stores_cities1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_stores_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `pizzeria`.`cities` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`employees` (
  `employee_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `job_role` ENUM("cook", "delivery person") NOT NULL,
  `store_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  INDEX `fk_employees_stores1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_stores1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizzeria`.`stores` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `pizzeria`.`deliveries` (
  `order_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `date_time` DATETIME NOT NULL,
  INDEX `fk_deliveries_employees1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_deliveries_orders1_idx` (`order_id` ASC) VISIBLE,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_deliveries_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `pizzeria`.`employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_deliveries_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
