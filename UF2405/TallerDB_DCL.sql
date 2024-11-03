-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Taller
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Taller
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Taller` DEFAULT CHARACTER SET utf8 ;
USE `Taller` ;

-- -----------------------------------------------------
-- Table `Taller`.`Taller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Taller`.`Taller` (
  `id_Taller` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NULL,
  PRIMARY KEY (`id_Taller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Taller`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Taller`.`Persona` (
  `id_Persona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Persona`));


-- -----------------------------------------------------
-- Table `Taller`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Taller`.`Cliente` (
  `id_Cliente` INT NOT NULL,
  `id_Persona` INT NOT NULL,
  PRIMARY KEY (`id_Cliente`),
  INDEX `fk_Cliente_Persona1_idx` (`id_Persona` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Persona1`
    FOREIGN KEY (`id_Persona`)
    REFERENCES `Taller`.`Persona` (`id_Persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Taller`.`Vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Taller`.`Vehiculo` (
  `id_Vehiculo`int not null Auto_increment,
  `matricula` varchar(10) NOT NULL ,
  `modelo` VARCHAR(100) NULL,
  `marca` VARCHAR(100) NULL,
  `propietario` INT NULL,
  PRIMARY KEY (`id_Vehiculo`),
  INDEX `Propietario_idx` (`propietario` ASC) VISIBLE,
  CONSTRAINT `Propietario`
    FOREIGN KEY (`propietario`)
    REFERENCES `Taller`.`Cliente` (`id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Taller`.`Reparacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Taller`.`Reparacion` (
  `id_Reparacion` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(2000) NULL,
  `coste`double null,
  `vehiculo` INT NULL,
  PRIMARY KEY (`id_Reparacion`),
  INDEX `vehiculo_idx` (`vehiculo` ASC) VISIBLE,
  CONSTRAINT `vehiculo`
    FOREIGN KEY (`vehiculo`)
    REFERENCES `Taller`.`Vehiculo` (`id_Vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
