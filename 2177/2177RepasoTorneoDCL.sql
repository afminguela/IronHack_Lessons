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
  `id_DRON` INT NOT NULL AUTO_INCREMENT,
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
  `id_Piloto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Edad` INT NULL,
  `Nivel` ENUM("Principiante", "Intermedio", "Avanzado") NOT NULL,
  PRIMARY KEY (`id_Piloto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Carreras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Carreras` (
  `id_Carrera` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Pista` VARCHAR(100) NULL,
  `Ciudad` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_Carrera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Torneo`.`Resultados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Torneo`.`Resultados` (
  `id_Resultado` INT NOT NULL AUTO_INCREMENT,
  `id_Dron` INT NOT NULL,
  `id_Carrera` INT NOT NULL,
  `id_Piloto` INT NOT NULL,
  `Posicion` INT NOT NULL,
  `Problema_tecnico` VARCHAR(200) NULL,
  `Tiempo`TIME(6) NOT NULL,
  PRIMARY KEY (`id_Resultado`))
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
INSERT INTO Resultados (id_Resultado, id_Dron, id_Carrera, id_Piloto, Posicion, Problema_tecnico, tiempo) VALUES
-- Carrera 1
(1, 1, 1, 1, 1, NULL, '00:02:15.345'),
(2, 2, 1, 2, 2, NULL, '00:02:17.892'),
(3, 3, 1, 3, 3, 'Pérdida de señal', '00:02:25.671'),
(6, 4, 1, 4, 4, NULL, '00:02:28.123'),
(7, 5, 1, 5, 5, 'Interferencia de señal', '00:02:35.789'),

-- Carrera 2
(4, 4, 2, 4, 1, NULL, '00:02:10.234'),
(5, 5, 2, 5, 2, 'Batería baja', '00:02:12.567'),
(8, 1, 2, 1, 3, NULL, '00:02:14.890'),
(9, 2, 2, 2, 4, 'Fallo en el control remoto', '00:02:20.123'),
(10, 3, 2, 3, 5, NULL, '00:02:22.456'),

-- Carrera 3
(11, 2, 3, 1, 1, NULL, '00:02:08.765'),
(12, 3, 3, 2, 2, NULL, '00:02:10.987'),
(13, 4, 3, 3, 3, 'Colisión con obstáculo', '00:02:18.543'),
(14, 5, 3, 4, 4, NULL, '00:02:20.876'),
(15, 1, 3, 5, 5, 'Problema de estabilización', '00:02:25.432'),

-- Carrera 4
(16, 3, 4, 1, 1, NULL, '00:02:05.678'),
(17, 4, 4, 2, 2, NULL, '00:02:07.890'),
(18, 5, 4, 3, 3, NULL, '00:02:09.123'),
(19, 1, 4, 4, 4, 'Fallo en el motor', '00:02:15.456'),
(20, 2, 4, 5, 5, NULL, '00:02:18.789'),

-- Carrera 5
(21, 5, 5, 1, 1, NULL, '00:02:03.234'),
(22, 1, 5, 2, 2, 'Problema con la cámara', '00:02:06.567'),
(23, 2, 5, 3, 3, NULL, '00:02:08.890'),
(24, 3, 5, 4, 4, NULL, '00:02:11.123'),
(25, 4, 5, 5, 5, 'Pérdida de GPS', '00:02:16.456')



