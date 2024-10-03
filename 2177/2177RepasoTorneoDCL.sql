-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Torneo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Torneo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Torneo` DEFAULT CHARACTER SET utf8 ;
USE `Torneo` ;

-- -----------------------------------------------------
-- Table `Torneo`.`DRONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`DRONES` (
  `id_DRON` INT NOT NULL,
  `Marca` VARCHAR(100) NOT NULL,
  `Modelo` VARCHAR(100) NULL,
  `Velocidad _Max` INT NOT NULL,
  `Minutos_vuelo` TIME NOT NULL,
  PRIMARY KEY (`id_DRON`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Pilotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Pilotos` (
  `id_Piloto` INT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `Edad` INT NULL,
  `Nivel` ENUM("Principiante", "Intermedio", "Avanzado") NOT NULL,
  PRIMARY KEY (`id_Piloto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Carreras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Carreras` (
  `id_Carrera` INT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `Pista` VARCHAR(100) NULL,
  `Ciudad` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_Carrera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Resultados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Resultados` (
  `id_Resultado` INT NOT NULL,
  `id_Dron` INT NOT NULL,
  `id_Carrera` INT NOT NULL,
  `id_Piloto` INT NOT NULL,
  `Posicion` INT NOT NULL,
  `Problema_tecnico` VARCHAR(200) NULL,
  PRIMARY KEY (`id_Resultado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`R_Drones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`R_Drones` (
  `DRONES_id_DRON` INT NOT NULL,
  `Resultados_id_Resultado` INT NOT NULL,
  PRIMARY KEY (`DRONES_id_DRON`, `Resultados_id_Resultado`),
  INDEX `fk_DRONES_Tiene_Resultados_Resultados1_idx` (`Resultados_id_Resultado` ASC) VISIBLE,
  INDEX `fk_DRONES_Tiene_Resultados_DRONES_idx` (`DRONES_id_DRON` ASC) VISIBLE,
  CONSTRAINT `fk_DRONES_Tiene_Resultados_DRONES`
    FOREIGN KEY (`DRONES_id_DRON`)
    REFERENCES `Torneo`.`DRONES` (`id_DRON`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DRONES_Tiene_Resultados_Resultados1`
    FOREIGN KEY (`Resultados_id_Resultado`)
    REFERENCES `Torneo`.`Resultados` (`id_Resultado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`R_Pilotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`R_Pilotos` (
  `Resultados_id_Resultado` INT NOT NULL,
  `Pilotos_id_Piloto` INT NOT NULL,
  PRIMARY KEY (`Resultados_id_Resultado`, `Pilotos_id_Piloto`),
  INDEX `fk_Resultados_Tiene_Pilotos_Pilotos1_idx` (`Pilotos_id_Piloto` ASC) VISIBLE,
  INDEX `fk_Resultados_Tiene_Pilotos_Resultados1_idx` (`Resultados_id_Resultado` ASC) VISIBLE,
  CONSTRAINT `fk_Resultados_Tiene_Pilotos_Resultados1`
    FOREIGN KEY (`Resultados_id_Resultado`)
    REFERENCES `Torneo`.`Resultados` (`id_Resultado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resultados_Tiene_Pilotos_Pilotos1`
    FOREIGN KEY (`Pilotos_id_Piloto`)
    REFERENCES `Torneo`.`Pilotos` (`id_Piloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`R_Carreras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`R_Carreras` (
  `Resultados_id_Resultado` INT NOT NULL,
  `Carreras_id_Carrera` INT NOT NULL,
  PRIMARY KEY (`Resultados_id_Resultado`, `Carreras_id_Carrera`),
  INDEX `fk_Resultados_Tiene_Carreras_Carreras1_idx` (`Carreras_id_Carrera` ASC) VISIBLE,
  INDEX `fk_Resultados_Tiene_Carreras_Resultados1_idx` (`Resultados_id_Resultado` ASC) VISIBLE,
  CONSTRAINT `fk_Resultados_Tiene_Carreras_Resultados1`
    FOREIGN KEY (`Resultados_id_Resultado`)
    REFERENCES `Torneo`.`Resultados` (`id_Resultado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resultados_Tiene_Carreras_Carreras1`
    FOREIGN KEY (`Carreras_id_Carrera`)
    REFERENCES `Torneo`.`Carreras` (`id_Carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Pilotos _en_carreras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Pilotos _en_carreras` (
  `Carreras_id_Carrera` INT NOT NULL,
  `Pilotos_id_Piloto` INT NOT NULL,
  PRIMARY KEY (`Carreras_id_Carrera`, `Pilotos_id_Piloto`),
  INDEX `fk_Carreras_Tiene_Pilotos_Pilotos1_idx` (`Pilotos_id_Piloto` ASC) VISIBLE,
  INDEX `fk_Carreras_Tiene_Pilotos_Carreras1_idx` (`Carreras_id_Carrera` ASC) VISIBLE,
  CONSTRAINT `fk_Carreras_Tiene_Pilotos_Carreras1`
    FOREIGN KEY (`Carreras_id_Carrera`)
    REFERENCES `Torneo`.`Carreras` (`id_Carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carreras_Tiene_Pilotos_Pilotos1`
    FOREIGN KEY (`Pilotos_id_Piloto`)
    REFERENCES `Torneo`.`Pilotos` (`id_Piloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Carreras_Tiene_DRONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Carreras_Tiene_DRONES` (
  `Carreras_id_Carrera` INT NOT NULL,
  `DRONES_id_DRON` INT NOT NULL,
  PRIMARY KEY (`Carreras_id_Carrera`, `DRONES_id_DRON`),
  INDEX `fk_Carreras_Tiene_DRONES_DRONES1_idx` (`DRONES_id_DRON` ASC) VISIBLE,
  INDEX `fk_Carreras_Tiene_DRONES_Carreras1_idx` (`Carreras_id_Carrera` ASC) VISIBLE,
  CONSTRAINT `fk_Carreras_Tiene_DRONES_Carreras1`
    FOREIGN KEY (`Carreras_id_Carrera`)
    REFERENCES `Torneo`.`Carreras` (`id_Carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carreras_Tiene_DRONES_DRONES1`
    FOREIGN KEY (`DRONES_id_DRON`)
    REFERENCES `Torneo`.`DRONES` (`id_DRON`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Pilotos_Tiene_DRONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Pilotos_Tiene_DRONES` (
  `Pilotos_id_Piloto` INT NOT NULL,
  `DRONES_id_DRON` INT NOT NULL,
  PRIMARY KEY (`Pilotos_id_Piloto`, `DRONES_id_DRON`),
  INDEX `fk_Pilotos_Tiene_DRONES_DRONES1_idx` (`DRONES_id_DRON` ASC) VISIBLE,
  INDEX `fk_Pilotos_Tiene_DRONES_Pilotos1_idx` (`Pilotos_id_Piloto` ASC) VISIBLE,
  CONSTRAINT `fk_Pilotos_Tiene_DRONES_Pilotos1`
    FOREIGN KEY (`Pilotos_id_Piloto`)
    REFERENCES `Torneo`.`Pilotos` (`id_Piloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pilotos_Tiene_DRONES_DRONES1`
    FOREIGN KEY (`DRONES_id_DRON`)
    REFERENCES `Torneo`.`DRONES` (`id_DRON`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insertar datos en la tabla DRONES
INSERT INTO DRONES (id_DRON, Marca, Modelo, `Velocidad _Max`, Minutos_vuelo) VALUES
(1, 'DJI', 'Mavic Air 2', 201, '00:34:00'),
(2, 'Autel', 'EVO II', 220, '00:40:00'),
(3, 'Parrot', 'Anafi', 110, '00:25:00'),
(4, 'Skydio', '2', 150, '00:23:00'),
(5, 'PowerVision', 'PowerEgg X', 150, '00:30:00'),
(6, 'DJI', 'Mavic Air 2', 205, '00:34:00'),
(7, 'Autel', 'EVO II', 220, '00:40:00'),
(8, 'Parrot', 'Anafi', 110, '00:25:00');

-- Insertar datos en la tabla Pilotos
INSERT INTO Pilotos (id_Piloto, Nombre, Edad, Nivel) VALUES
(1, 'Juan Pérez', 28, 'Avanzado'),
(2, 'María García', 32, 'Intermedio'),
(3, 'Carlos Rodríguez', 25, 'Principiante'),
(4, 'Ana Martínez', 30, 'Avanzado'),
(5, 'Luis Sánchez', 35, 'Intermedio');

-- Insertar datos en la tabla Carreras
INSERT INTO Carreras (id_Carrera, Fecha, Pista, Ciudad) VALUES
(1, '2023-06-15 14:00:00', 'Circuito Urbano', 'Madrid'),
(2, '2023-07-01 16:30:00', 'Parque Natural', 'Barcelona'),
(3, '2023-07-20 15:00:00', 'Estadio Olímpico', 'Sevilla'),
(4, '2023-08-05 17:00:00', 'Playa', 'Valencia'),
(5, '2023-08-25 13:30:00', 'Montaña', 'Bilbao');

-- Insertar datos en la tabla Resultados
INSERT INTO Resultados (id_Resultado, id_Dron, id_Carrera, id_Piloto, Posicion, Problema_tecnico) VALUES
(1, 1, 1, 1, 1, NULL),
(2, 2, 1, 2, 2, NULL),
(3, 3, 1, 3, 3, 'Pérdida de señal'),
(4, 4, 2, 4, 1, NULL),
(5, 5, 2, 5, 2, 'Batería baja');

-- Insertar datos en la tabla R_Drones
INSERT INTO R_Drones (DRONES_id_DRON, Resultados_id_Resultado) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insertar datos en la tabla R_Pilotos
INSERT INTO R_Pilotos (Resultados_id_Resultado, Pilotos_id_Piloto) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insertar datos en la tabla R_Carreras
INSERT INTO R_Carreras (Resultados_id_Resultado, Carreras_id_Carrera) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2);

-- Insertar datos en la tabla Pilotos_en_carreras
INSERT INTO `Pilotos _en_carreras` (Carreras_id_Carrera, Pilotos_id_Piloto) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

-- Insertar datos en la tabla Carreras_Tiene_DRONES
INSERT INTO Carreras_Tiene_DRONES (Carreras_id_Carrera, DRONES_id_DRON) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

-- Insertar datos en la tabla Pilotos_Tiene_DRONES
INSERT INTO Pilotos_Tiene_DRONES (Pilotos_id_Piloto, DRONES_id_DRON) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

