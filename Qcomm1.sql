-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema quick_commerce_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema quick_commerce_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quick_commerce_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema qcomm_enterprise
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema qcomm_enterprise
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `qcomm_enterprise` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema quick_commerce_12
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema quick_commerce_12
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quick_commerce_12` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `quick_commerce_db` ;

-- -----------------------------------------------------
-- Table `quick_commerce_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`customers` (
  `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone_number` CHAR(15) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_at` TIMESTAMP NULL DEFAULT NULL,
  `loyalty_points` INT UNSIGNED NOT NULL DEFAULT '0',
  `marketing_opt_in` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`customer_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`customer_addresses` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  `address_line_1` VARCHAR(255) NOT NULL,
  `address_line_2` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(50) NOT NULL,
  `pincode` CHAR(10) NOT NULL,
  `latitude` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitude` DECIMAL(11,8) NULL DEFAULT NULL,
  `is_default` TINYINT(1) NOT NULL DEFAULT '0',
  `address_type` ENUM('HOME', 'WORK', 'OTHER') NOT NULL DEFAULT 'HOME',
  PRIMARY KEY (`address_id`),
  INDEX `fk_customer_addresses_customers_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_addresses_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `quick_commerce_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`dark_stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`dark_stores` (
  `store_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `pincode` CHAR(10) NOT NULL,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  `operating_status` ENUM('OPEN', 'CLOSED', 'BUSY') NOT NULL DEFAULT 'OPEN',
  `manager_name` VARCHAR(100) NULL DEFAULT NULL,
  `max_delivery_range_km` INT UNSIGNED NOT NULL DEFAULT '3',
  `max_orders_per_hour` INT UNSIGNED NOT NULL DEFAULT '60',
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`delivery_partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`delivery_partners` (
  `partner_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone_number` CHAR(15) NOT NULL,
  `vehicle_type` ENUM('BICYCLE', 'MOTORBIKE', 'ELECTRIC') NOT NULL,
  `is_available` TINYINT(1) NOT NULL DEFAULT '1',
  `current_latitude` DECIMAL(10,8) NULL DEFAULT NULL,
  `current_longitude` DECIMAL(11,8) NULL DEFAULT NULL,
  `rating` DECIMAL(2,1) NOT NULL DEFAULT '5.0',
  `bank_account_number` VARCHAR(30) NULL DEFAULT NULL,
  `last_activity_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`partner_id`),
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `bank_account_number` (`bank_account_number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`orders` (
  `order_id` CHAR(20) NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `store_id` INT UNSIGNED NOT NULL,
  `partner_id` INT UNSIGNED NULL DEFAULT NULL,
  `order_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_address_id` INT UNSIGNED NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `status` ENUM('PLACED', 'PREPARING', 'READY', 'PICKED_UP', 'DELIVERED', 'CANCELLED') NOT NULL DEFAULT 'PLACED',
  `delivery_fee` DECIMAL(5,2) NOT NULL DEFAULT '0.00',
  `tip_amount` DECIMAL(5,2) NOT NULL DEFAULT '0.00',
  `discount_amount` DECIMAL(5,2) NOT NULL DEFAULT '0.00',
  `delivery_slot_minutes` INT UNSIGNED NOT NULL DEFAULT '15',
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_stores_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_orders_partners_idx` (`partner_id` ASC) VISIBLE,
  INDEX `fk_orders_addresses_idx` (`delivery_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_addresses`
    FOREIGN KEY (`delivery_address_id`)
    REFERENCES `quick_commerce_db`.`customer_addresses` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `quick_commerce_db`.`customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_partners`
    FOREIGN KEY (`partner_id`)
    REFERENCES `quick_commerce_db`.`delivery_partners` (`partner_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_stores`
    FOREIGN KEY (`store_id`)
    REFERENCES `quick_commerce_db`.`dark_stores` (`store_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`product_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`product_categories` (
  `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(100) NOT NULL,
  `parent_category_id` INT UNSIGNED NULL DEFAULT NULL,
  `icon_url` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_name` (`category_name` ASC) VISIBLE,
  INDEX `fk_product_categories_parent_idx` (`parent_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_categories_parent`
    FOREIGN KEY (`parent_category_id`)
    REFERENCES `quick_commerce_db`.`product_categories` (`category_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`products` (
  `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  `unit_of_measure` VARCHAR(20) NOT NULL,
  `brand` VARCHAR(100) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT '1',
  `sku` CHAR(20) NULL DEFAULT NULL,
  `weight_grams` INT UNSIGNED NULL DEFAULT NULL,
  `shelf_life_days` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `sku` (`sku` ASC) VISIBLE,
  INDEX `fk_products_categories_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_categories`
    FOREIGN KEY (`category_id`)
    REFERENCES `quick_commerce_db`.`product_categories` (`category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`order_items` (
  `order_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` CHAR(20) NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` DECIMAL(5,2) NOT NULL,
  `unit_price_at_time_of_order` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `is_replacement` TINYINT(1) NOT NULL DEFAULT '0',
  `original_product_id` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `fk_order_items_orders_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_items_products_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_order_items_original_product_idx` (`original_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `quick_commerce_db`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_original_product`
    FOREIGN KEY (`original_product_id`)
    REFERENCES `quick_commerce_db`.`products` (`product_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `quick_commerce_db`.`products` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`payments` (
  `payment_id` CHAR(30) NOT NULL,
  `order_id` CHAR(20) NOT NULL,
  `payment_method` ENUM('CARD', 'UPI', 'COD', 'WALLET') NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `transaction_status` ENUM('PENDING', 'SUCCESS', 'FAILED') NOT NULL,
  `transaction_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `currency` CHAR(3) NOT NULL DEFAULT 'INR',
  `gateway_transaction_id` CHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `fk_payments_orders_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `quick_commerce_db`.`orders` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_db`.`store_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_db`.`store_inventory` (
  `store_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `stock_quantity` INT UNSIGNED NOT NULL DEFAULT '0',
  `price` DECIMAL(10,2) NOT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reorder_point` INT UNSIGNED NOT NULL DEFAULT '5',
  `sale_price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`, `product_id`),
  INDEX `fk_inventory_products_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `quick_commerce_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_stores`
    FOREIGN KEY (`store_id`)
    REFERENCES `quick_commerce_db`.`dark_stores` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `qcomm_enterprise` ;

-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`cities` (
  `city_id` CHAR(10) NOT NULL,
  `city_name` VARCHAR(100) NULL DEFAULT NULL,
  `state_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE INDEX `city_id` (`city_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`delivery_partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`delivery_partners` (
  `rider_id` CHAR(10) NOT NULL,
  `full_name` VARCHAR(100) NULL DEFAULT NULL,
  `phone_number` VARCHAR(15) NULL DEFAULT NULL,
  `dl_number` VARCHAR(50) NULL DEFAULT NULL,
  `vehicle_type` ENUM('Bike', 'EV_Scooter', 'Cycle') NULL DEFAULT NULL,
  PRIMARY KEY (`rider_id`),
  UNIQUE INDEX `rider_id` (`rider_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`order_items` (
  `order_item_id` CHAR(10) NOT NULL,
  `variant_id` CHAR(10) NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `price_at_time_of_order` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  UNIQUE INDEX `order_item_id` (`order_item_id` ASC) VISIBLE,
  UNIQUE INDEX `variant_id_UNIQUE` (`variant_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`inventory_batches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`inventory_batches` (
  `batch_id` CHAR(10) NOT NULL,
  `quantity_available` INT NULL DEFAULT NULL,
  `manufacturing_date` DATE NULL DEFAULT NULL,
  `expiry_date` DATE NOT NULL,
  `batch_number` VARCHAR(50) NULL DEFAULT NULL,
  `aisle_number` VARCHAR(10) NULL DEFAULT NULL,
  `rack_number` VARCHAR(10) NULL DEFAULT NULL,
  `order_items_order_item_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`batch_id`),
  UNIQUE INDEX `batch_id` (`batch_id` ASC) VISIBLE,
  INDEX `fk_inventory_batches_order_items1_idx` (`order_items_order_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_batches_order_items1`
    FOREIGN KEY (`order_items_order_item_id`)
    REFERENCES `qcomm_enterprise`.`order_items` (`order_item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`orders` (
  `order_id` CHAR(10) NOT NULL,
  `total_mrp` DECIMAL(10,2) NULL DEFAULT NULL,
  `delivery_fee` DECIMAL(10,2) NULL DEFAULT NULL,
  `final_amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `payment_method` ENUM('UPI', 'CreditCard', 'COD', 'Wallet') NULL DEFAULT NULL,
  `order_status` ENUM('Placed', 'Accepted', 'Packing', 'Ready', 'Out_For_Delivery', 'Delivered', 'Cancelled') NULL DEFAULT 'Placed',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `order_items_order_item_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`order_id`, `order_items_order_item_id`),
  UNIQUE INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `fk_orders_order_items1_idx` (`order_items_order_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_order_items1`
    FOREIGN KEY (`order_items_order_item_id`)
    REFERENCES `qcomm_enterprise`.`order_items` (`order_item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`products` (
  `product_id` CHAR(10) NOT NULL,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id` (`product_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`purchase_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`purchase_orders` (
  `po_id` CHAR(10) NOT NULL,
  `status` ENUM('Created', 'Received', 'Cancelled') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`po_id`),
  UNIQUE INDEX `po_id` (`po_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`suppliers` (
  `supplier_id` CHAR(10) NOT NULL,
  `name` VARCHAR(150) NULL DEFAULT NULL,
  `contact_info` VARCHAR(150) NULL DEFAULT NULL,
  `gstin` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `supplier_id` (`supplier_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`users` (
  `user_id` CHAR(10) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `full_name` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`user_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`user_addresses` (
  `address_id` CHAR(10) NOT NULL,
  `address` TEXT NULL DEFAULT NULL,
  `pincode` VARCHAR(10) NULL DEFAULT NULL,
  `users_user_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`address_id`, `users_user_id`),
  UNIQUE INDEX `address_id` (`address_id` ASC) VISIBLE,
  INDEX `fk_user_addresses_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_addresses_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `qcomm_enterprise`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`user_wallets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`user_wallets` (
  `wallet_id` CHAR(10) NOT NULL,
  `balance` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `currency` VARCHAR(5) NULL DEFAULT 'INR',
  PRIMARY KEY (`wallet_id`),
  UNIQUE INDEX `wallet_id` (`wallet_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `qcomm_enterprise`.`wallet_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qcomm_enterprise`.`wallet_transactions` (
  `transaction_id` CHAR(10) NOT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id` (`transaction_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `quick_commerce_12` ;

-- -----------------------------------------------------
-- Table `quick_commerce_12`.`delivery_partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`delivery_partners` (
  `partner_id` CHAR(10) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `vehicle_type` ENUM('BICYCLE', 'MOTORBIKE', 'ELECTRIC') NOT NULL,
  PRIMARY KEY (`partner_id`),
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `partner_id_UNIQUE` (`partner_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`Warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`Warehouse` (
  `store_id` CHAR(10) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `pincode` VARCHAR(10) NOT NULL,
  `operating_status` ENUM('OPEN', 'CLOSED', 'BUSY') NULL DEFAULT 'OPEN',
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`orders` (
  `order_id` CHAR(20) NOT NULL,
  `customer_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `partner_id` INT NOT NULL,
  `delivery_address_id` INT NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `status` ENUM('PLACED', 'PREPARING', 'DELIVERED', 'CANCELLED') NULL DEFAULT 'PLACED',
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_customer` (`customer_id` ASC) VISIBLE,
  INDEX `fk_order_store` (`store_id` ASC) VISIBLE,
  INDEX `fk_order_partner` (`partner_id` ASC) VISIBLE,
  INDEX `fk_order_address` (`delivery_address_id` ASC) VISIBLE,
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC) VISIBLE,
  UNIQUE INDEX `partner_id_UNIQUE` (`partner_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_address`
    FOREIGN KEY (`delivery_address_id`)
    REFERENCES `quick_commerce_12`.`customer_addresses` (`address_id`),
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `quick_commerce_12`.`customers` (`customer_id`),
  CONSTRAINT `fk_order_partner`
    FOREIGN KEY (`partner_id`)
    REFERENCES `quick_commerce_12`.`delivery_partners` (`partner_id`),
  CONSTRAINT `fk_order_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `quick_commerce_12`.`Warehouse` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`payments` (
  `payment_id` CHAR(25) NOT NULL,
  `order_id` CHAR(20) NOT NULL,
  `payment_method` ENUM('CARD', 'UPI', 'COD', 'WALLET') NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `transaction_status` ENUM('SUCCESS', 'FAILED', 'PENDING') NOT NULL,
  `transaction_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `wallet_id` CHAR(10) NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_order` (`order_id` ASC) VISIBLE,
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) VISIBLE,
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  UNIQUE INDEX `wallet_id_UNIQUE` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `quick_commerce_12`.`orders` (`order_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`Customer_wallets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`Customer_wallets` (
  `wallet_id` CHAR(10) NOT NULL,
  `customer_id` CHAR(10) NOT NULL,
  `balance` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `currency` CHAR(3) NULL DEFAULT 'INR',
  `payments_payment_id` CHAR(25) NOT NULL,
  PRIMARY KEY (`wallet_id`),
  INDEX `fk_Customer_wallets_payments1_idx` (`payments_payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_wallets_payments1`
    FOREIGN KEY (`payments_payment_id`)
    REFERENCES `quick_commerce_12`.`payments` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`customers` (
  `customer_id` CHAR(10) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Customer_wallets_wallet_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE,
  INDEX `fk_customers_Customer_wallets1_idx` (`Customer_wallets_wallet_id` ASC) VISIBLE,
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_Customer_wallets1`
    FOREIGN KEY (`Customer_wallets_wallet_id`)
    REFERENCES `quick_commerce_12`.`Customer_wallets` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`customer_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`customer_addresses` (
  `address_id` CHAR(10) NOT NULL,
  `customer_id` CHAR(10) NOT NULL,
  `address_line_1` VARCHAR(255) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `pincode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_customer` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `quick_commerce_12`.`customers` (`customer_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`product_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`product_categories` (
  `category_id` CHAR(10) NOT NULL,
  `category_name` VARCHAR(100) NOT NULL,
  `parent_category_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`category_id`, `parent_category_id`),
  UNIQUE INDEX `category_name` (`category_name` ASC) VISIBLE,
  INDEX `fk_category_parent` (`parent_category_id` ASC) VISIBLE,
  UNIQUE INDEX `category_id_UNIQUE` (`category_id` ASC) VISIBLE,
  UNIQUE INDEX `parent_category_id_UNIQUE` (`parent_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_parent`
    FOREIGN KEY (`parent_category_id`)
    REFERENCES `quick_commerce_12`.`product_categories` (`category_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`products` (
  `product_id` CHAR(10) NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `category_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_category` (`category_id` ASC) VISIBLE,
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  UNIQUE INDEX `category_id_UNIQUE` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `quick_commerce_12`.`product_categories` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`order_items` (
  `order_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` CHAR(20) NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` DECIMAL(5,2) NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`, `order_id`),
  INDEX `fk_item_order` (`order_id` ASC) VISIBLE,
  INDEX `fk_item_product` (`product_id` ASC) VISIBLE,
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `quick_commerce_12`.`orders` (`order_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_item_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `quick_commerce_12`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quick_commerce_12`.`store_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quick_commerce_12`.`store_inventory` (
  `store_id` CHAR(10) NOT NULL,
  `product_id` CHAR(10) NOT NULL,
  `stock_quantity` INT UNSIGNED NULL DEFAULT '0',
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`store_id`, `product_id`),
  INDEX `fk_inventory_product` (`product_id` ASC) VISIBLE,
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC) VISIBLE,
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `quick_commerce_12`.`products` (`product_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_inventory_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `quick_commerce_12`.`Warehouse` (`store_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
