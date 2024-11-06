-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema EC2405
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EC2405
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EC2405` DEFAULT CHARACTER SET utf8 ;
USE `EC2405` ;

-- -----------------------------------------------------
-- Table `EC2405`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EC2405`.`Cliente` (
  `idC` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `correo` VARCHAR(100) NULL,
  PRIMARY KEY (`idC`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EC2405`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EC2405`.`Producto` (
  `idP` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `precio` DOUBLE NULL,
  PRIMARY KEY (`idP`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EC2405`.`CPC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EC2405`.`CPC` (
  `idC` INT NOT NULL,
  `idP` INT NOT NULL,
  PRIMARY KEY (`idC`, `idP`),
  INDEX `fk_Cliente_Tiene_Producto_Producto1_idx` (`idP` ASC) VISIBLE,
  INDEX `fk_Cliente_Tiene_Producto_Cliente_idx` (`idC` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Tiene_Producto_Cliente`
    FOREIGN KEY (`idC`)
    REFERENCES `EC2405`.`Cliente` (`idC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Tiene_Producto_Producto1`
    FOREIGN KEY (`idP`)
    REFERENCES `EC2405`.`Producto` (`idP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
