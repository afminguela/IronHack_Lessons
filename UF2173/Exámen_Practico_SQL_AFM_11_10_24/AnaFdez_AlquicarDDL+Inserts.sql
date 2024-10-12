-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Alquicar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Alquicar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Alquicar` DEFAULT CHARACTER SET utf8 ;
USE `Alquicar` ;

-- -----------------------------------------------------
-- Table `Alquicar`.`Vehículos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Alquicar`.`Vehículos` (
  `idVehiculo` INT NOT NULL AUTO_INCREMENT,
  `Matricula` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Tipo` ENUM("Patinete", "bicicleta", "Coche") NOT NULL,
  `Estado` ENUM("Disponible", "Alquilado", "En Mantenimiento") NOT NULL,
  PRIMARY KEY (`idVehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Alquicar`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Alquicar`.`Clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Alquicar`.`Reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Alquicar`.`Reservas` (
  `idReservas` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `idVehiculo` INT NOT NULL,
  `FechaReserva` DATETIME NOT NULL,
  `FechaDevolucion` DATETIME NULL,
  `Precio` DOUBLE NOT NULL,
  PRIMARY KEY (`idReservas`),
  INDEX `idCliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `idVehiculo_idx` (`idVehiculo` ASC) VISIBLE,
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Alquicar`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idVehiculo`
    FOREIGN KEY (`idVehiculo`)
    REFERENCES `Alquicar`.`Vehículos` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Alquicar`.`Mantenimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Alquicar`.`Mantenimiento` (
  `idMantenimiento` INT NOT NULL AUTO_INCREMENT,
  `idVehiculo` INT NOT NULL,
  `Descripción` VARCHAR(2000) NULL,
  `FechaMantenimiento` DATETIME NOT NULL,
  PRIMARY KEY (`idMantenimiento`),
    FOREIGN KEY (`idVehiculo`)
    REFERENCES `Alquicar`.`Vehículos` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Inserts--

INSERT INTO `Alquicar`.`Vehículos` (Matricula, Marca, Modelo, Tipo, Estado) VALUES
('ABC123', 'Tesla', 'Model 3', 'Coche', 'Disponible'),
('DEF456', 'Nissan', 'Leaf', 'Coche', 'Alquilado'),
('GHI789', 'BMW', 'i3', 'Coche', 'Disponible'),
('JKL012', 'Kawasaki', 'Z Electric', 'Patinete', 'En Mantenimiento'),
('MNO345', 'Giant', 'E+1', 'bicicleta', 'Disponible'),
('PQR678', 'Audi', 'e-tron', 'Coche', 'Alquilado'),
('STU901', 'Raleigh', 'Motus', 'bicicleta', 'Disponible'),
('VWX234', 'Segway', 'Ninebot S', 'Patinete', 'Alquilado'),
('YZA567', 'Ford', 'Mustang Mach-E', 'Coche', 'En Mantenimiento'),
('BCD890', 'Trek', 'Verve+', 'bicicleta', 'Disponible'),
('EFG123', 'Porsche', 'Taycan', 'Coche', 'Alquilado'),
('HIJ456', 'Xiaomi', 'M365 Pro', 'Patinete', 'Disponible'),
('KLM789', 'Volvo', 'XC40 Recharge', 'Coche', 'En Mantenimiento'),
('NOP012', 'Cannondale', 'Adventure Neo 4', 'bicicleta', 'Disponible'),
('QRS345', 'Smart', 'EQ Fortwo', 'Coche', 'Alquilado');


INSERT INTO `Alquicar`.`Clientes` (Nombre, Telefono, Direccion) VALUES
('Juan Pérez', '+34123456789', 'Calle Falsa 123, Madrid'),
('María Gómez', '+34198765432', 'Avenida Siempre Viva 742, Barcelona'),
('Luis Martínez', '+34123456700', 'Paseo del Prado 45, Sevilla'),
('Ana López', '+34123456701', 'Calle Mayor 10, Valencia'),
('Carlos Sánchez', '+34123456702', 'Gran Vía 25, Bilbao'),
('Laura Fernández', '+34123456703','Calle del Sol 15, Málaga'),
('Javier Torres','+34123456704','Avenida de la Libertad 30, Zaragoza'),
('Sofía Ruiz','+34123456705','Calle del Río 5, Alicante'),
('Pedro Jiménez','+34123456706','Plaza Mayor 12, Granada'),
('Clara Martín','+34123456707','Calle del Mar 8, Murcia'),
('Diego Romero','+34123456708','Avenida del Norte 20, Córdoba'),
('Lucía Morales','+34123456709','Calle de la Paz 18, Toledo'),
('Fernando Díaz','+34123456710','Avenida de los Reyes 50, Palma de Mallorca'),
('Isabel Castro','+34123456711','Calle del Campo 22, Valladolid'),
('Samuel Ortega','+34123456712','Avenida de la Ciencia 17, Salamanca');

INSERT INTO `Alquicar`.`Mantenimiento` (idVehiculo, Descripción, FechaMantenimiento) VALUES
(1, 'Cambio de batería y revisión general.', '2024-09-01 10:00:00'),
(2, 'Reemplazo de frenos y revisión eléctrica.', '2024-09-05 11:30:00'),
(3, 'Inspección anual y cambio de aceite.', '2024-09-15 09:00:00'),
(4, 'Reparación de rueda y revisión.', '2024-09-20 14:00:00'),
(5, 'Revisión general y limpieza.', '2024-09-25 08:30:00'),
(6, 'Cambio de neumáticos y revisión.', '2024-10-01 10:00:00'),
(7, 'Revisión del sistema eléctrico.', '2024-10-05 11:30:00'),
(8, 'Cambio de batería y limpieza.', '2024-10-10 09:00:00'),
(9, 'Inspección general y cambio de frenos.', '2024-10-15 14:00:00'),
(10, 'Reparación de cuadro y revisión.', '2024-10-20 08:30:00'),
(11, 'Cambio de luces y revisión general.', '2024-10-25 10:00:00'),
(12, "Revisión del sistema de frenos.", '2024-11-01 11:30:00'),
(13, "Cambio de aceite y revisión general.", '2024-11-05 09:00:00'),
(14, "Inspección anual.", '2024-11-10 14:00:00'),
(1, "Reparación del motor eléctrico.", '2024-11-15 08:30:00'),
(3, "Cambio de batería.", '2024-11-20 10:00:00'),
(7, "Revisión del sistema eléctrico.", '2024-11-25 11:30:00'),
(1, "Cambio de frenos.", '2024-12-01 09:00:00'),
(2, "Inspección del cuadro.", '2024-12-05 14:00:00'),
(15, "Revisión general.", '2024-12-10 08:30:00');

INSERT INTO `Alquicar`.`Reservas` (idCliente, idVehiculo, FechaReserva, FechaDevolucion, Precio) VALUES
(1, 1, '2024-09-01 12:00:00', '2024-09-04 12:00:00', 100.00),
(1, 2, '2024-09-05 12:30:00', '2024-09-08 12:30:00', 80.00),
(2, 3, '2024-09-10 13:00:00', '2024-09-12 13:30:00', 120.00),
(3, 4, '2024-09-15 14:00:00', '2024-09-17 14:30:00', 30.00),
(4, 5, '2024-09-20 15:30:00', '2024-09-23 15:30:00', 50.00),
(5, 6, '2024-09-25 16:45:00', '2024-09-28 16:45:00', 150.00),
(6, 7, '2024-10-01 17:15:00', '2024-10-03 17:15:00', 90.00),
(7, 8, '2024-10-05 18:30:00', '2024-10-07 18:30:00', 40.00),
(8, 9, '2024-10-10 19:45:00', '2024-10-12 19:45:00', 200.00),
(9,10,'2024-10-15 20:15:00','2024-10-17 20:15:00',60.00),
(1, 3, '2025-01-15 12:00:00', '2025-01-18 12:00:00', 120.00),
(2, 5, '2025-01-20 13:30:00', '2025-01-23 13:30:00', 50.00),
(3, 7, '2025-01-25 14:00:00', '2025-01-27 14:30:00', 90.00),
(4, 8, '2025-02-01 15:30:00', '2025-02-04 15:30:00', 40.00),
(5, 9, '2025-02-05 16:45:00', '2025-02-08 16:45:00', 200.00),
(6, 10, '2025-02-10 17:15:00', '2025-02-12 17:15:00', 60.00),
(15, 11, '2025-02-15 18:30:00', '2025-02-18 18:30:00', 70.00),
(13, 12, '2025-02-20 19:45:00', '2025-02-23 19:45:00', 80.00),
(14, 13, '2025-03-01 20:15:00', '2025-03-04 20:15:00', 90.00),
(10,14,'2025-03-05 21:30:00','2025-03-08 21:30:00',100.00),
(11,15,'2025-03-10 22:45:00','2025-03-12 22:45:00',110.00),
(1,2,'2025-03-15 12:30:00','2025-03-18 12:30:00',85.00),
(12,4,'2025-03-20 13:45:00','2025-03-23 13:45:00',95.00),
(3,6,'2025-03-25 14:30:00','2025-03-28 14:30:00',75.00),
(14,8,'2025-04-01 15:50:00','2025-04-04 15:50:00',65.00),
(5,10,'2025-04-05 16:20:00','2025-04-08 16:20:00',55.00);
