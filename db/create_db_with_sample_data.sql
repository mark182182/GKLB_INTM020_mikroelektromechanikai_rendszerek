-- MySQL Script generated by MySQL Workbench
-- Mon Oct 30 23:18:37 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

START TRANSACTION;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema belepteto
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `belepteto` ;

-- -----------------------------------------------------
-- Schema belepteto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `belepteto` DEFAULT CHARACTER SET utf8 ;
USE `belepteto` ;

-- -----------------------------------------------------
-- Table `belepteto`.`felhasznalok`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `belepteto`.`felhasznalok` ;

CREATE TABLE IF NOT EXISTS `belepteto`.`felhasznalok` (
  `fhId` INT NOT NULL AUTO_INCREMENT,
  `fhNev` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`fhId`),
  UNIQUE INDEX `fhId_UNIQUE` (`fhId` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `belepteto`.`rfid`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `belepteto`.`rfid` ;

CREATE TABLE IF NOT EXISTS `belepteto`.`rfid` (
  `rId` INT NOT NULL AUTO_INCREMENT,
  `rErtek` CHAR(12) NOT NULL,
  PRIMARY KEY (`rId`),
  UNIQUE INDEX `rId_UNIQUE` (`rId` ASC) VISIBLE,
  UNIQUE INDEX `rErtek_UNIQUE` (`rErtek` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `belepteto`.`felhasznaloAzonosito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `belepteto`.`felhasznaloAzonosito` ;

CREATE TABLE IF NOT EXISTS `belepteto`.`felhasznaloAzonosito` (
  `fhAzonId` INT NOT NULL AUTO_INCREMENT,
  `fhId` INT NOT NULL,
  `rId` INT NOT NULL,
  `letiltva` BIT NOT NULL DEFAULT 0,
  INDEX `fk_felhasznaloAzonosito_felhasznalo1_idx` (`fhId` ASC) VISIBLE,
  UNIQUE INDEX `rfid_rId_UNIQUE` (`rId` ASC) VISIBLE,
  PRIMARY KEY (`fhAzonId`),
  UNIQUE INDEX `fhAzonId_UNIQUE` (`fhAzonId` ASC) VISIBLE,
  CONSTRAINT `fk_felhasznaloAzonosito_felhasznalo1`
    FOREIGN KEY (`fhId`)
    REFERENCES `belepteto`.`felhasznalok` (`fhId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_felhasznaloAzonosito_rfid1`
    FOREIGN KEY (`rId`)
    REFERENCES `belepteto`.`rfid` (`rId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `belepteto`.`belepes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `belepteto`.`belepes` ;

CREATE TABLE IF NOT EXISTS `belepteto`.`belepes` (
  `fhAzonId` INT NOT NULL,
  `belepIdo` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  INDEX `fk_belepes_felhasznaloAzonosito1_idx` (`fhAzonId` ASC) VISIBLE,
  CONSTRAINT `fk_belepes_felhasznaloAzonosito1`
    FOREIGN KEY (`fhAzonId`)
    REFERENCES `belepteto`.`felhasznaloAzonosito` (`fhAzonId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Insert example data
-- -----------------------------------------------------

INSERT INTO `belepteto`.`felhasznalok` VALUES (NULL, 'Gipsz Jakab');
INSERT INTO `belepteto`.`felhasznalok` VALUES (NULL, 'Nagy Paszkál');
INSERT INTO `belepteto`.`felhasznalok` VALUES (NULL, 'Kiss Béla');

INSERT INTO `belepteto`.`rfid` VALUES (NULL, '3100821010');
INSERT INTO `belepteto`.`rfid` VALUES (NULL, '1913502801');

INSERT INTO `belepteto`.`felhasznaloAzonosito` VALUES (NULL, 1,1,0);
INSERT INTO `belepteto`.`felhasznaloAzonosito` VALUES (NULL, 2,2,1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

commit;