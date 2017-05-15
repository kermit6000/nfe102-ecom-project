-- MySQL Script generated by MySQL Workbench
-- Sun Mar 19 15:04:10 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ecom
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecom` ;

-- -----------------------------------------------------
-- Schema ecom
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecom` DEFAULT CHARACTER SET utf8 ;
USE `ecom` ;

-- -----------------------------------------------------
-- Table `ecom`.`product_shelf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`product_shelf` ;

CREATE TABLE IF NOT EXISTS `ecom`.`product_shelf` (
  `id` INT NOT NULL,
  `label` VARCHAR(100) NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`product` ;

CREATE TABLE IF NOT EXISTS `ecom`.`product` (
  `id` INT NOT NULL,
  `label` VARCHAR(255) NULL,
  `date_creation` DATETIME NULL,
  `date_modification` DATETIME NULL,
  `start_publication_date` DATETIME NULL,
  `end_publication_date` DATETIME NULL,
  `sku` VARCHAR(100) NULL,
  `weight` DECIMAL NULL,
  `status` INT NULL,
  `product_shelf_id` INT NOT NULL,
  `description` LONGTEXT NULL,
  PRIMARY KEY (`id`, `product_shelf_id`),
  INDEX `fk_product_product_shelf1_idx` (`product_shelf_id` ASC),
  CONSTRAINT `fk_product_product_shelf1`
    FOREIGN KEY (`product_shelf_id`)
    REFERENCES `ecom`.`product_shelf` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`product_stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`product_stock` ;

CREATE TABLE IF NOT EXISTS `ecom`.`product_stock` (
  `id` INT NOT NULL,
  `value` INT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_id`),
  INDEX `fk_product_stock_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_product_stock_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecom`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`currency` ;

CREATE TABLE IF NOT EXISTS `ecom`.`currency` (
  `id` INT NOT NULL,
  `label` VARCHAR(100) NULL,
  `code` VARCHAR(5) NULL CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`product_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`product_price` ;

CREATE TABLE IF NOT EXISTS `ecom`.`product_price` (
  `id` INT NOT NULL,
  `price_ht` DECIMAL NULL,
  `price_ttc` DECIMAL NULL,
  `tax` DECIMAL NULL,
  `currency_id` INT NOT NULL,
  `status` INT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `currency_id`, `product_id`),
  INDEX `fk_product_price_currency1_idx` (`currency_id` ASC),
  INDEX `fk_product_price_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_product_price_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `ecom`.`currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_price_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecom`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`media` ;

CREATE TABLE IF NOT EXISTS `ecom`.`media` (
  `id` INT NOT NULL,
  `label` VARCHAR(100) NULL,
  `url` VARCHAR(255) NULL,
  `product_id` INT NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`, `product_id`),
  INDEX `fk_media_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_media_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecom`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`payment_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`payment_method` ;

CREATE TABLE IF NOT EXISTS `ecom`.`payment_method` (
  `id` INT NOT NULL,
  `label` VARCHAR(100) NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`payment` ;

CREATE TABLE IF NOT EXISTS `ecom`.`payment` (
  `id` INT NOT NULL,
  `status` INT NULL,
  `amount` DECIMAL NULL,
  `payment_method_id` INT NOT NULL,
  PRIMARY KEY (`id`, `payment_method_id`),
  INDEX `fk_payment_payment_method1_idx` (`payment_method_id` ASC),
  CONSTRAINT `fk_payment_payment_method1`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `ecom`.`payment_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`shipment_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`shipment_method` ;

CREATE TABLE IF NOT EXISTS `ecom`.`shipment_method` (
  `id` INT NOT NULL,
  `label` VARCHAR(100) NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`shipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`shipment` ;

CREATE TABLE IF NOT EXISTS `ecom`.`shipment` (
  `id` INT NOT NULL,
  `status` INT NULL,
  `amount_ht` DECIMAL NULL,
  `amount_ttc` DECIMAL NULL,
  `shipment_method_id` INT NOT NULL,
  PRIMARY KEY (`id`, `shipment_method_id`),
  INDEX `fk_shipment_shipment_method1_idx` (`shipment_method_id` ASC),
  CONSTRAINT `fk_shipment_shipment_method1`
    FOREIGN KEY (`shipment_method_id`)
    REFERENCES `ecom`.`shipment_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`shipment_weight_grid`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`shipment_weight_grid` ;

CREATE TABLE IF NOT EXISTS `ecom`.`shipment_weight_grid` (
  `id` INT NOT NULL,
  `max_weight` DECIMAL NULL,
  `price_ht` DECIMAL NULL,
  `pricettc` DECIMAL NULL,
  `shipment_method_id` INT NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`, `shipment_method_id`),
  INDEX `fk_shipment_weight_grid_shipment_method1_idx` (`shipment_method_id` ASC),
  CONSTRAINT `fk_shipment_weight_grid_shipment_method1`
    FOREIGN KEY (`shipment_method_id`)
    REFERENCES `ecom`.`shipment_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`user` ;

CREATE TABLE IF NOT EXISTS `ecom`.`user` (
  `id` INT NOT NULL,
  `email` VARCHAR(255) NULL, -- Modified Email
  `password` VARCHAR(80) NULL,
  `salt` VARCHAR(20) NULL,
  `role` VARCHAR(50) NULL, -- Modified roles
  `creation_date` DATETIME NULL,
  `modification_date` DATETIME NULL,
  `status` INT NULL,
  `lastname` VARCHAR(100) NULL,
  `firstname` VARCHAR(100) NULL,
  `cartserialized` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`user_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`user_address` ;

CREATE TABLE IF NOT EXISTS `ecom`.`user_address` (
  `id` INT NOT NULL,
  `creation_date` DATETIME NULL,
  `modification_date` DATETIME NULL,
  `label` VARCHAR(100) NULL,
  `firstname` VARCHAR(100) NULL,
  `lastname` VARCHAR(100) NULL,
  `email` VARCHAR(255) NULL,
  `company` VARCHAR(100) NULL,
  `addressline1` VARCHAR(100) NULL,
  `addressline2` VARCHAR(100) NULL,
  `addressline3` VARCHAR(100) NULL,
  `zipcode` VARCHAR(20) NULL,
  `city` VARCHAR(100) NULL,
  `country` VARCHAR(100) NULL,
  `phone` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_user_address_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_address_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecom`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`order` ;

CREATE TABLE IF NOT EXISTS `ecom`.`order` (
  `id` INT NOT NULL,
  `creation_date` DATETIME NULL,
  `modification_date` DATETIME NULL,
  `ordernumber` VARCHAR(45) NULL,
  `order_status` INT NULL,
  `total_amount_with_tax` DECIMAL NULL,
  `total_amount_without_tax` DECIMAL NULL,
  `currency_code` VARCHAR(10) NULL,
  `shipping_fee_with_tax` DECIMAL NULL,
  `shipping_fee_without_tax` DECIMAL NULL,
  `billing_address_id` INT NULL,
  `shipping_address_id` INT NULL,
  `user_id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  `shipment_id` INT NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`id`, `user_id`, `payment_id`, `shipment_id`),
  INDEX `fk_order_user1_idx` (`user_id` ASC),
  INDEX `fk_order_payment1_idx` (`payment_id` ASC),
  INDEX `fk_order_shipment1_idx` (`shipment_id` ASC),
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecom`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `ecom`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_shipment1`
    FOREIGN KEY (`shipment_id`)
    REFERENCES `ecom`.`shipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecom`.`order_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecom`.`order_line` ;

CREATE TABLE IF NOT EXISTS `ecom`.`order_line` (
  `id` INT NOT NULL,
  `qty` INT NULL,
  `unit_price` DECIMAL NULL,
  `total_amount` DECIMAL NULL,
  `order_id` INT NOT NULL,
  `status` INT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `order_id`, `product_id`),
  INDEX `fk_order_line_order1_idx` (`order_id` ASC),
  INDEX `fk_order_line_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_order_line_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecom`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_line_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecom`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ecom`.`currency`
-- -----------------------------------------------------
START TRANSACTION;
USE `ecom`;
INSERT INTO `ecom`.`currency` (`id`, `label`, `code`, `status`) VALUES (1, 'Euro', '€', 2);
INSERT INTO `ecom`.`currency` (`id`, `label`, `code`, `status`) VALUES (2, 'Dollar', '$', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ecom`.`payment_method`
-- -----------------------------------------------------
START TRANSACTION;
USE `ecom`;
INSERT INTO `ecom`.`payment_method` (`id`, `label`, `status`) VALUES (1, 'CB/VISA/MASTERCARD', 2);
INSERT INTO `ecom`.`payment_method` (`id`, `label`, `status`) VALUES (2, 'Paypal', 2);
INSERT INTO `ecom`.`payment_method` (`id`, `label`, `status`) VALUES (3, 'Cash on delivery', 2);

COMMIT;

