-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Ejercicio-6
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ejercicio-6
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ejercicio-6` DEFAULT CHARACTER SET utf8 ;
USE `Ejercicio-6` ;

-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Ciudad` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCiudad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Calle` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(45) NOT NULL,
  `Ciudad_idCiudad` INT NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `FechaNacimiento` DATE NOT NULL,
  `FechaAlta` DATE NOT NULL,
  `FechaBaja` DATE NULL,
  `FechaUltimaActualizacion` DATETIME NOT NULL,
  `DNI` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPersona`),
  INDEX `fk_Persona_Ciudad1_idx` (`Ciudad_idCiudad` ASC) VISIBLE,
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE,
  CONSTRAINT `fk_Persona_Ciudad1`
    FOREIGN KEY (`Ciudad_idCiudad`)
    REFERENCES `Ejercicio-6`.`Ciudad` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Agente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Agente` (
  `idAgente` INT NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idAgente`),
  INDEX `fk_Agente_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Agente_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `Ejercicio-6`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  `Agente_idAgente` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Agente1_idx` (`Agente_idAgente` ASC) VISIBLE,
  INDEX `fk_Cliente_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Agente1`
    FOREIGN KEY (`Agente_idAgente`)
    REFERENCES `Ejercicio-6`.`Agente` (`idAgente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `Ejercicio-6`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Vehiculo` (
  `idVehiculo` INT NOT NULL,
  `NumeroSerie` VARCHAR(45) NOT NULL,
  `Matricula` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `AñoFabricacion` DATE NOT NULL,
  `Tipo` ENUM('Terrestre', 'Marino', 'Aereo') NOT NULL,
  `TipoLicencia` VARCHAR(45) NOT NULL,
  `Kilometraje` VARCHAR(45) NULL,
  PRIMARY KEY (`idVehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Hogar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Hogar` (
  `idHogar` INT NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(45) NOT NULL,
  `NumeroExterior` VARCHAR(45) NOT NULL,
  `Bloque` VARCHAR(45) NULL,
  `Piso` VARCHAR(45) NULL,
  `Puerta` VARCHAR(45) NULL,
  `Escalera` VARCHAR(45) NULL,
  `ValorContenido` DECIMAL(10,2) NOT NULL,
  `ValorContinente` DECIMAL(10,2) NOT NULL,
  `Descipcion` TEXT(1000) NULL,
  `Ciudad_idCiudad` INT NOT NULL,
  PRIMARY KEY (`idHogar`),
  INDEX `fk_Hogar_Ciudad1_idx` (`Ciudad_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Hogar_Ciudad1`
    FOREIGN KEY (`Ciudad_idCiudad`)
    REFERENCES `Ejercicio-6`.`Ciudad` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Poliza`
-- -----------------------------------------------------
Drop TABLE `Ejercicio-6`.`Poliza`;
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Poliza` (
  `idPoliza` INT NOT NULL AUTO_INCREMENT,
  `TipoSeguro` ENUM('Vida', 'Automovil', 'Hogar') NOT NULL,
  `FechaInicio` DATE NOT NULL,
  `FechaCancelacion` DATE NULL,
  `FechaExpiracion` DATE NULL,
  `MontoAsegurado` DECIMAL(10,2) NOT NULL,
  `EstadoPoliza` BINARY(1) NOT NULL,
  `Agente_idAgente` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Vehiculo_idVehiculo` INT NULL,
  `Hogar_idHogar` INT NULL,
  `Prima` DECIMAL(10,2) NOT NULL,
  `Descripcion` TEXT(1000) NOT NULL,
  `Condiciones` TEXT(1000) NOT NULL,
  `FechaUltimaActualzacion` DATETIME NOT NULL,
  `Contrato (URL)` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idPoliza`),
  INDEX `fk_Poliza_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Poliza_Agente1_idx` (`Agente_idAgente` ASC) VISIBLE,
  INDEX `fk_Poliza_Vehiculo1_idx` (`Vehiculo_idVehiculo` ASC) VISIBLE,
  INDEX `fk_Poliza_Hogar1_idx` (`Hogar_idHogar` ASC) VISIBLE,
  CONSTRAINT `fk_Poliza_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Ejercicio-6`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poliza_Agente1`
    FOREIGN KEY (`Agente_idAgente`)
    REFERENCES `Ejercicio-6`.`Agente` (`idAgente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poliza_Vehiculo1`
    FOREIGN KEY (`Vehiculo_idVehiculo`)
    REFERENCES `Ejercicio-6`.`Vehiculo` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poliza_Hogar1`
    FOREIGN KEY (`Hogar_idHogar`)
    REFERENCES `Ejercicio-6`.`Hogar` (`idHogar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Reclamacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Reclamacion` (
  `idReclamacion` INT NOT NULL AUTO_INCREMENT,
  `FechaPresentacion` DATETIME NOT NULL,
  `FechaTramite` DATETIME NULL,
  `FechaFinalizacion` DATETIME NULL,
  `FechaCancelacion` DATETIME NULL,
  `MontoReclamado` DECIMAL(10,2) NOT NULL,
  `EstadoReclamacion` ENUM('Pendiente', 'En tramite', 'Finalizada', 'Cancelada') NULL,
  `DocumentacionAdjuntal` MEDIUMTEXT NULL,
  `Poliza_idPoliza` INT NOT NULL,
  PRIMARY KEY (`idReclamacion`),
  INDEX `fk_Reclamacion_Poliza1_idx` (`Poliza_idPoliza` ASC) VISIBLE,
  CONSTRAINT `fk_Reclamacion_Poliza1`
    FOREIGN KEY (`Poliza_idPoliza`)
    REFERENCES `Ejercicio-6`.`Poliza` (`idPoliza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Transaccion` (
  `idTransaccion` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Monto` DECIMAL(10,2) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Poliza_idPoliza` INT NOT NULL,
  PRIMARY KEY (`idTransaccion`),
  INDEX `fk_Transaccion_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Transaccion_Poliza1_idx` (`Poliza_idPoliza` ASC) VISIBLE,
  CONSTRAINT `fk_Transaccion_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Ejercicio-6`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaccion_Poliza1`
    FOREIGN KEY (`Poliza_idPoliza`)
    REFERENCES `Ejercicio-6`.`Poliza` (`idPoliza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Pagos` (
  `idPagos` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Transaccion_idTransaccion` INT NOT NULL,
  `IBAN` VARCHAR(45) NULL,
  PRIMARY KEY (`idPagos`),
  INDEX `fk_Pagos_Transaccion1_idx` (`Transaccion_idTransaccion` ASC) VISIBLE,
  CONSTRAINT `fk_Pagos_Transaccion1`
    FOREIGN KEY (`Transaccion_idTransaccion`)
    REFERENCES `Ejercicio-6`.`Transaccion` (`idTransaccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Recordatorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Recordatorio` (
  `idRecordatorio` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Descripcion` TEXT(1000) NULL,
  `Poliza_idPoliza` INT NOT NULL,
  PRIMARY KEY (`idRecordatorio`),
  INDEX `fk_Recordatorio_Poliza1_idx` (`Poliza_idPoliza` ASC) VISIBLE,
  CONSTRAINT `fk_Recordatorio_Poliza1`
    FOREIGN KEY (`Poliza_idPoliza`)
    REFERENCES `Ejercicio-6`.`Poliza` (`idPoliza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio-6`.`Informe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio-6`.`Informe` (
  `idInforme` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `FechaGeneracion` DATETIME NOT NULL,
  `ReclamacionesPendientes` INT NULL,
  `NumeroPolizasActivas` INT NULL,
  `TendenciasSeguro` TEXT(1000) NULL,
  `HistorialRenovaciones` TEXT(1000) NULL,
  `Agente_idAgente` INT NOT NULL,
  `Descipcion` TEXT(1000) NOT NULL,
  PRIMARY KEY (`idInforme`),
  INDEX `fk_Informe_Agente1_idx` (`Agente_idAgente` ASC) VISIBLE,
  CONSTRAINT `fk_Informe_Agente1`
    FOREIGN KEY (`Agente_idAgente`)
    REFERENCES `Ejercicio-6`.`Agente` (`idAgente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Insertando datos en la tabla Ciudad
INSERT INTO `Ejercicio-6`.`Ciudad` (Nombre, Pais)
VALUES 
('Madrid', 'España'),
('Barcelona', 'España'),
('Valencia', 'España'),
('Sevilla', 'España'),
('Bilbao', 'España'),
('Zaragoza', 'España');

-- Insertando datos en la tabla Persona
INSERT INTO `Ejercicio-6`.`Persona` (Nombre, Calle, CodigoPostal, Ciudad_idCiudad, Telefono, Email, FechaNacimiento, FechaAlta, FechaUltimaActualizacion, DNI)
VALUES
('Juan Pérez', 'Calle Mayor 12', '28013', 1, '600111222', 'juan.perez@example.com', '1980-05-15', '2022-01-10', NOW(), '12345678A'),
('Ana García', 'Avenida Diagonal 5', '08007', 2, '600222333', 'ana.garcia@example.com', '1990-03-22', '2022-02-18', NOW(), '23456789B'),
('Luis Martínez', 'Calle Colón 18', '46004', 3, '600333444', 'luis.martinez@example.com', '1985-08-08', '2022-03-05', NOW(), '34567890C'),
('María Sánchez', 'Avenida Constitución 9', '41001', 4, '600444555', 'maria.sanchez@example.com', '1992-07-11', '2022-04-12', NOW(), '45678901D'),
('Carlos Ruiz', 'Calle de la Ría 4', '48005', 5, '600555666', 'carlos.ruiz@example.com', '1983-09-14', '2022-05-20', NOW(), '56789012E'),
('Laura Fernández', 'Calle del Pilar 10', '50001', 6, '600666777', 'laura.fernandez@example.com', '1987-12-21', '2022-06-22', NOW(), '67890123F');

-- Insertando datos en la tabla Agente
INSERT INTO `Ejercicio-6`.`Agente` (Persona_idPersona)
VALUES
(1),
(2),
(3),
(4),
(5),
(6);

-- Insertando datos en la tabla Cliente
INSERT INTO `Ejercicio-6`.`Cliente` (idCliente, Persona_idPersona, Agente_idAgente)
VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 5),
(5, 5, 6),
(6, 6, 1);

-- Insertando datos en la tabla Vehiculo
INSERT INTO `Ejercicio-6`.`Vehiculo` (idVehiculo, NumeroSerie, Matricula, Modelo, Marca, AñoFabricacion, Tipo, TipoLicencia, Kilometraje)
VALUES
(1, 'S123456789', '1234ABC', 'Model X', 'Tesla', '2019-05-20', 'Terrestre', 'B', '50000'),
(2, 'S987654321', '5678DEF', 'Astra', 'Opel', '2018-03-15', 'Terrestre', 'B', '75000'),
(3, 'S112233445', '9101GHI', 'Civic', 'Honda', '2020-07-11', 'Terrestre', 'B', '30000'),
(4, 'S556677889', '3141JKL', 'Panda', 'Fiat', '2017-02-05', 'Terrestre', 'B', '90000'),
(5, 'S778899001', '5161MNO', 'Yaris', 'Toyota', '2019-12-25', 'Terrestre', 'B', '60000'),
(6, 'S223344556', '7181PQR', 'Clio', 'Renault', '2021-09-09', 'Terrestre', 'B', '20000');

-- Insertando datos en la tabla Hogar
INSERT INTO `Ejercicio-6`.`Hogar` (Calle, CodigoPostal, NumeroExterior, Bloque, Piso, Puerta, Escalera, ValorContenido, ValorContinente, Descipcion, Ciudad_idCiudad)
VALUES
('Calle Alcalá', '28001', '10', NULL, '3', 'B', NULL, 20000.00, 100000.00, 'Piso en el centro de Madrid', 1),
('Calle de Aragón', '08009', '15', NULL, '2', 'A', NULL, 15000.00, 90000.00, 'Piso moderno en Barcelona', 2),
('Avenida Blasco Ibáñez', '46010', '20', '1', '4', 'C', 'B', 18000.00, 95000.00, 'Piso amplio en Valencia', 3),
('Calle Sierpes', '41004', '25', NULL, '1', 'D', NULL, 22000.00, 120000.00, 'Casa histórica en Sevilla', 4),
('Calle de la Merced', '48003', '30', '2', '5', 'E', 'C', 25000.00, 110000.00, 'Ático en Bilbao', 5),
('Calle Alfonso I', '50003', '35', NULL, '6', 'F', NULL, 17000.00, 85000.00, 'Piso céntrico en Zaragoza', 6);

-- Insertando datos en la tabla Poliza
INSERT INTO `Ejercicio-6`.`Poliza` (TipoSeguro, FechaInicio, FechaCancelacion, FechaExpiracion, MontoAsegurado, EstadoPoliza, Agente_idAgente, Cliente_idCliente, Vehiculo_idVehiculo, Hogar_idHogar, Prima, Descripcion, Condiciones, FechaUltimaActualzacion, `Contrato (URL)`)
VALUES
('Automovil', '2022-01-01', null , '2023-01-01', 15000.00, 1, 1, 1, 1, NULL, 500.00, 'Seguro de coche para Tesla Model X', 'Cobertura total', NOW(), 'https://contrato1.com'),
('Hogar', '2022-02-01',null , '2023-02-01', 100000.00, 1, 2, 2, NULL, 1, 400.00, 'Seguro de hogar en Barcelona', 'Cobertura contra incendios y robos', NOW(), 'https://contrato2.com'),
('Automovil', '2022-03-01',null ,'2023-03-01', 12000.00, 1, 3, 3, 2, NULL, 450.00, 'Seguro de coche para Opel Astra', 'Cobertura estándar', NOW(), 'https://contrato3.com'),
('Hogar', '2022-04-01',null ,'2023-04-01', 90000.00, 1, 4, 4, NULL, 400.00, 'Seguro de hogar en Valencia', 'Cobertura completa', NOW(), 'https://contrato4.com'),
('Automovil', '2022-05-01', null,'2023-05-01', 10000.00, 1, 5, 5, 3, NULL, 300.00, 'Seguro de coche para Honda Civic', 'Cobertura parcial', NOW(), 'https://contrato5.com'),
('Hogar', '2022-06-01', null ,'2023-06-01', 95000.00, 1, 6, 6, NULL, 350.00, 'Seguro de hogar en Zaragoza', 'Cobertura contra robos', NOW(), 'https://contrato6.com');

-- Insertando datos en la tabla Reclamacion
INSERT INTO `Ejercicio-6`.`Reclamacion` (FechaPresentacion, FechaTramite, FechaFinalizacion, MontoReclamado, EstadoReclamacion, DocumentacionAdjuntal, Poliza_idPoliza)
VALUES
(NOW(), '2022-01-15', '2022-02-01', 5000.00, 'Finalizada', 'Documentación completa', 1),
(NOW(), '2022-02-10', NULL, 3000.00, 'Pendiente', 'Documentación en proceso', 2),
(NOW(), '2022-03-20', '2022-04-10', 4500.00, 'Finalizada', 'Documentación completa', 3),
(NOW(), '2022-04-25', '2022-05-15', 8000.00, 'Finalizada', 'Documentación completa', 4),
(NOW(), '2022-05-05', NULL, 2000.00, 'Pendiente', 'Documentación incompleta', 5),
(NOW(), '2022-06-10', '2022-07-01', 3500.00, 'Finalizada', 'Documentación completa', 6);

-- Insertando datos en la tabla Transaccion
INSERT INTO `Ejercicio-6`.`Transaccion` (Fecha, Monto, Cliente_idCliente, Poliza_idPoliza)
VALUES
('2022-01-05', 500.00, 1, 1),
('2022-02-10', 400.00, 2, 2),
('2022-03-15', 450.00, 3, 3),
('2022-04-20', 400.00, 4, 4),
('2022-05-25', 300.00, 5, 5),
('2022-06-30', 350.00, 6, 6);

-- Insertando datos en la tabla Pagos
INSERT INTO `Ejercicio-6`.`Pagos` (Fecha, Transaccion_idTransaccion, IBAN)
VALUES
('2022-01-06', 1, 'ES7621000813610123456789'),
('2022-02-11', 2, 'ES7621000813610123456790'),
('2022-03-16', 3, 'ES7621000813610123456791'),
('2022-04-21', 4, 'ES7621000813610123456792'),
('2022-05-26', 5, 'ES7621000813610123456793'),
('2022-07-01', 6, 'ES7621000813610123456794');

-- Insertando datos en la tabla Recordatorio
INSERT INTO `Ejercicio-6`.`Recordatorio` (Fecha, Descripcion, Poliza_idPoliza)
VALUES
(NOW(), 'Renovar seguro de coche antes del 01/01/2023', 1),
(NOW(), 'Revisar cobertura de seguro de hogar antes del 01/02/2023', 2),
(NOW(), 'Renovar seguro de coche antes del 01/03/2023', 3),
(NOW(), 'Revisar póliza de hogar antes del 01/04/2023', 4),
(NOW(), 'Renovar seguro de coche antes del 01/05/2023', 5),
(NOW(), 'Revisar condiciones de seguro de hogar antes del 01/06/2023', 6);

-- Insertando datos en la tabla Informe
INSERT INTO `Ejercicio-6`.`Informe` (Nombre, FechaGeneracion, ReclamacionesPendientes, NumeroPolizasActivas, TendenciasSeguro, HistorialRenovaciones, Agente_idAgente, Descipcion)
VALUES
('Informe Enero', NOW(), 1, 2, 'Tendencia al aumento de seguros de automóviles', 'Renovaciones correctas', 1, 'Informe sobre la actividad de seguros de enero'),
('Informe Febrero', NOW(), 2, 3, 'Tendencia al aumento de seguros de hogar', 'Revisiones pendientes', 2, 'Informe sobre la actividad de seguros de febrero'),
('Informe Marzo', NOW(), 1, 2, 'Tendencia a la baja en seguros de automóviles', 'Renovaciones correctas', 3, 'Informe sobre la actividad de seguros de marzo'),
('Informe Abril', NOW(), 3, 4, 'Aumento en reclamaciones de seguros de hogar', 'Pendientes de renovación', 4, 'Informe sobre la actividad de seguros de abril'),
('Informe Mayo', NOW(), 2, 3, 'Tendencia estable en reclamaciones de automóviles', 'Renovaciones en curso', 5, 'Informe sobre la actividad de seguros de mayo'),
('Informe Junio', NOW(), 1, 2, 'Tendencia a la baja en seguros de hogar', 'Renovaciones correctas', 6, 'Informe sobre la actividad de seguros de junio');
