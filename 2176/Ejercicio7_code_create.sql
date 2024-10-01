-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ejercico7
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ejercico7
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ejercico7` DEFAULT CHARACTER SET utf8 ;
USE `ejercico7` ;

-- -----------------------------------------------------
-- Table `ejercico7`.`Planeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Planeta` (
  `idPlaneta` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Galaxia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPlaneta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `FechaAlta` DATETIME NOT NULL,
  `FechaBaja` DATETIME NULL,
  `FechaModificacion` DATETIME NULL,
  `NumeroIdentificacion` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `1erApellido` VARCHAR(45) NOT NULL,
  `2ºApellido` VARCHAR(45) NOT NULL,
  `Planeta_idPlaneta` INT NOT NULL,
  `Telefono` VARCHAR(45) NULL,
  `Mail` VARCHAR(45) NULL,
  PRIMARY KEY (`idPersona`),
  INDEX `fk_Persona_Planeta_idx` (`Planeta_idPlaneta` ASC) VISIBLE,
  CONSTRAINT `fk_Persona_Planeta`
    FOREIGN KEY (`Planeta_idPlaneta`)
    REFERENCES `ejercico7`.`Planeta` (`idPlaneta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Rol` VARCHAR(45) NOT NULL,
  `LugarTrabajo` VARCHAR(45) NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_Empleado_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `ejercico7`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Categotia` VARCHAR(45) NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `ejercico7`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`NaveEspacial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`NaveEspacial` (
  `idNaveEspacial` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Tipo` ENUM('Aereo', 'Espacial', 'Terrestre') NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `CapacidadPasajeros` INT NOT NULL,
  `CapacidadCarga` DECIMAL(10,2) NOT NULL,
  `Autonomia` DECIMAL(10,2) NOT NULL,
  `VelocidadMaxima` DECIMAL(10) NOT NULL,
  `TipoCombustible` VARCHAR(45) NOT NULL,
  `FechaAlta` DATETIME NOT NULL,
  `FechaMantenimiento` DATETIME NULL,
  `FechaProximoMantenimiento` DATETIME NOT NULL,
  `FechaBaja` DATETIME NULL,
  PRIMARY KEY (`idNaveEspacial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Viaje` (
  `idViaje` INT NOT NULL AUTO_INCREMENT,
  `Origen` VARCHAR(45) NOT NULL,
  `Destino` VARCHAR(45) NOT NULL,
  `FechaSalida` DATETIME NOT NULL,
  `FechaLlegada` DATETIME NULL,
  `Duracion` DECIMAL(10,2) NOT NULL,
  `idNaveEspacial` INT NOT NULL,
  PRIMARY KEY (`idViaje`),
  INDEX `fk_Viaje_NaveEspacial1_idx` (`idNaveEspacial` ASC) VISIBLE,
  CONSTRAINT `fk_Viaje_NaveEspacial1`
    FOREIGN KEY (`idNaveEspacial`)
    REFERENCES `ejercico7`.`NaveEspacial` (`idNaveEspacial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Hotel` (
  `idHotel` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `fechaConstruccion` DATE NOT NULL,
  `idPlaneta` INT NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `CapacidadMaxima` INT NOT NULL,
  `NumeroHabitaciones` INT NOT NULL,
  `FechaBaja` DATE NULL,
  PRIMARY KEY (`idHotel`),
  INDEX `fk_Hotel_Planeta1_idx` (`idPlaneta` ASC) VISIBLE,
  CONSTRAINT `fk_Hotel_Planeta1`
    FOREIGN KEY (`idPlaneta`)
    REFERENCES `ejercico7`.`Planeta` (`idPlaneta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Habitacion` (
  `idHabitacion` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Capacidad` INT NOT NULL,
  `Servicios` VARCHAR(255) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `idHotel` INT NOT NULL,
  PRIMARY KEY (`idHabitacion`),
  INDEX `fk_Habitacion_Hotel1_idx` (`idHotel` ASC) VISIBLE,
  CONSTRAINT `fk_Habitacion_Hotel1`
    FOREIGN KEY (`idHotel`)
    REFERENCES `ejercico7`.`Hotel` (`idHotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Reserva` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `Fechareserva` DATETIME NOT NULL,
  `FechaCancelacion` DATETIME NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Persona1_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `ejercico7`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Suministro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Suministro` (
  `idSuministro` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Detalle` TEXT NOT NULL,
  `FechaPedido` DATETIME NOT NULL,
  `idHotel` INT NOT NULL,
  `idNaveEspacial` INT NOT NULL,
  `FechaSalida` DATETIME NOT NULL,
  `FechaLlegada` DATETIME NULL,
  PRIMARY KEY (`idSuministro`),
  INDEX `fk_Suministro_Hotel1_idx` (`idHotel` ASC) VISIBLE,
  INDEX `fk_Suministro_NaveEspacial1_idx` (`idNaveEspacial` ASC) VISIBLE,
  CONSTRAINT `fk_Suministro_Hotel1`
    FOREIGN KEY (`idHotel`)
    REFERENCES `ejercico7`.`Hotel` (`idHotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Suministro_NaveEspacial1`
    FOREIGN KEY (`idNaveEspacial`)
    REFERENCES `ejercico7`.`NaveEspacial` (`idNaveEspacial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Operacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Operacion` (
  `idOperacion` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(255) NOT NULL,
  `FechaInicio` DATETIME NOT NULL,
  `FechaFinal` DATETIME NULL,
  PRIMARY KEY (`idOperacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Empleado_has_Operacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Empleado_has_Operacion` (
  `idEmpleado` INT NOT NULL,
  `idOperacion` INT NOT NULL,
  `FechaAlta` DATETIME NOT NULL,
  `FechaBaja` DATETIME NULL,
  INDEX `fk_Empleado_has_Operacion_Operacion1_idx` (`idOperacion` ASC) VISIBLE,
  INDEX `fk_Empleado_has_Operacion_Empleado1_idx` (`idEmpleado` ASC) VISIBLE,
  PRIMARY KEY (`idEmpleado`, `idOperacion`),
  CONSTRAINT `fk_Empleado_has_Operacion_Empleado1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `ejercico7`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_has_Operacion_Operacion1`
    FOREIGN KEY (`idOperacion`)
    REFERENCES `ejercico7`.`Operacion` (`idOperacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`ReservaHabitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`ReservaHabitacion` (
  `idHabitacion` INT NOT NULL,
  `idReserva` INT NOT NULL,
  `FechaInicio` DATETIME NOT NULL,
  `FechaFinal` DATETIME NULL,
  PRIMARY KEY (`idHabitacion`, `idReserva`),
  INDEX `fk_Habitacion_has_ReservaHabitacion_ReservaHabitacion1_idx` (`idReserva` ASC) VISIBLE,
  INDEX `fk_Habitacion_has_ReservaHabitacion_Habitacion1_idx` (`idHabitacion` ASC) VISIBLE,
  CONSTRAINT `fk_Habitacion_has_ReservaHabitacion_Habitacion1`
    FOREIGN KEY (`idHabitacion`)
    REFERENCES `ejercico7`.`Habitacion` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habitacion_has_ReservaHabitacion_ReservaHabitacion1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `ejercico7`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`ReservaViaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`ReservaViaje` (
  `idReserva` INT NOT NULL,
  `idViaje` INT NOT NULL,
  PRIMARY KEY (`idReserva`, `idViaje`),
  INDEX `fk_Reserva_has_Viaje_Viaje1_idx` (`idViaje` ASC) VISIBLE,
  INDEX `fk_Reserva_has_Viaje_Reserva1_idx` (`idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_has_Viaje_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `ejercico7`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_has_Viaje_Viaje1`
    FOREIGN KEY (`idViaje`)
    REFERENCES `ejercico7`.`Viaje` (`idViaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`AsignacionOperacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`AsignacionOperacion` (
  `IdAsignacionOperacion` INT NOT NULL AUTO_INCREMENT,
  `FechaAsignacion` DATETIME NOT NULL,
  `idNaveEspacial` INT NULL,
  `idViaje` INT NULL,
  `Suministro` INT NULL,
  `idHotel` INT NULL,
  `idHabitacion` INT NULL,
  `Operacion_idOperacion` INT NOT NULL,
  PRIMARY KEY (`IdAsignacionOperacion`),
  INDEX `fk_AsignacionOperacion_NaveEspacial1_idx` (`idNaveEspacial` ASC) VISIBLE,
  INDEX `fk_AsignacionOperacion_Viaje1_idx` (`idViaje` ASC) VISIBLE,
  INDEX `fk_AsignacionOperacion_Suministro1_idx` (`Suministro` ASC) VISIBLE,
  INDEX `fk_AsignacionOperacion_Hotel1_idx` (`idHotel` ASC) VISIBLE,
  INDEX `fk_AsignacionOperacion_Habitacion1_idx` (`idHabitacion` ASC) VISIBLE,
  INDEX `fk_AsignacionOperacion_Operacion1_idx` (`Operacion_idOperacion` ASC) VISIBLE,
  CONSTRAINT `fk_AsignacionOperacion_NaveEspacial1`
    FOREIGN KEY (`idNaveEspacial`)
    REFERENCES `ejercico7`.`NaveEspacial` (`idNaveEspacial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AsignacionOperacion_Viaje1`
    FOREIGN KEY (`idViaje`)
    REFERENCES `ejercico7`.`Viaje` (`idViaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AsignacionOperacion_Suministro1`
    FOREIGN KEY (`Suministro`)
    REFERENCES `ejercico7`.`Suministro` (`idSuministro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AsignacionOperacion_Hotel1`
    FOREIGN KEY (`idHotel`)
    REFERENCES `ejercico7`.`Hotel` (`idHotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AsignacionOperacion_Habitacion1`
    FOREIGN KEY (`idHabitacion`)
    REFERENCES `ejercico7`.`Habitacion` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AsignacionOperacion_Operacion1`
    FOREIGN KEY (`Operacion_idOperacion`)
    REFERENCES `ejercico7`.`Operacion` (`idOperacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`DetalleViaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`DetalleViaje` (
  `idDetalleViaje` INT NOT NULL AUTO_INCREMENT,
  `FechaRegistro` DATETIME NOT NULL,
  `Telemetria` VARCHAR(45) NOT NULL,
  `Velocidad` DECIMAL(10,2) NOT NULL,
  `Consumo` DECIMAL(10,2) NOT NULL,
  `idViaje` INT NOT NULL,
  PRIMARY KEY (`idDetalleViaje`),
  INDEX `fk_DetalleViaje_Viaje1_idx` (`idViaje` ASC) VISIBLE,
  CONSTRAINT `fk_DetalleViaje_Viaje1`
    FOREIGN KEY (`idViaje`)
    REFERENCES `ejercico7`.`Viaje` (`idViaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`EstadosVitales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`EstadosVitales` (
  `idEstadosVitales` INT NOT NULL AUTO_INCREMENT,
  `Mestruacion` TINYINT NOT NULL,
  `PulsacionesHR` INT NOT NULL,
  `Oxigeno` DECIMAL(10,2) NOT NULL,
  `PresionAlta` INT NOT NULL,
  `PresionBaja` INT NOT NULL,
  `Azucar` DECIMAL(10,2) NOT NULL,
  `CO2enSangre` DECIMAL(10,2) NOT NULL,
  `Temperatura` DECIMAL(10,2) NOT NULL,
  `idViaje` INT NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idEstadosVitales`),
  INDEX `fk_EstadosVitales_Viaje1_idx` (`idViaje` ASC) VISIBLE,
  INDEX `fk_EstadosVitales_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_EstadosVitales_Viaje1`
    FOREIGN KEY (`idViaje`)
    REFERENCES `ejercico7`.`Viaje` (`idViaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadosVitales_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `ejercico7`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Inventario` (
  `idInventario` INT NOT NULL AUTO_INCREMENT,
  `Producto` VARCHAR(256) NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(1000) NOT NULL,
  `Cantidad` DECIMAL(10,2) NOT NULL,
  `FechaRecepcion` DATETIME NOT NULL,
  `idSuministro` INT NOT NULL,
  PRIMARY KEY (`idInventario`),
  INDEX `fk_Inventario_Suministro1_idx` (`idSuministro` ASC) VISIBLE,
  CONSTRAINT `fk_Inventario_Suministro1`
    FOREIGN KEY (`idSuministro`)
    REFERENCES `ejercico7`.`Suministro` (`idSuministro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`Formacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercico7`.`Formacion` (
  `idFormacion` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(1000) NOT NULL,
  `Descripcion` TEXT NOT NULL,
  `FechaAlta` DATETIME NOT NULL,
  `FechaBaja` DATETIME NULL,
  PRIMARY KEY (`idFormacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercico7`.`EmpleadoFormacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicClienteo7`.`EmpleadoFormacion` (
  `idEmpleado` INT NOT NULL,
  `idFormacion` INT NOT NULL,
  `FechaInicio` DATETIME NOT NULL,
  `FechaFin` DATETIME NULL,
  `Evaluacion` TINYINT NULL,
  PRIMARY KEY (`idEmpleado`, `idFormacion`),
  INDEX `fk_Empleado_has_Formacion_Formacion1_idx` (`idFormacion` ASC) VISIBLE,
  INDEX `fk_Empleado_has_Formacion_Empleado1_idx` (`idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_has_Formacion_Empleado1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `ejercico7`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_has_Formacion_Formacion1`
    FOREIGN KEY (`idFormacion`)
    REFERENCES `ejercico7`.`Formacion` (`idFormacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Populate Planeta table
INSERT INTO Planeta (Nombre, Galaxia) VALUES
('Tierra', 'Vía Láctea'),
('Marte', 'Vía Láctea'),
('Kepler-22b', 'Cygnus'),
('Gliese 581g', 'Libra'),
('HD 40307g', 'Pictor'),
('Próxima Centauri b', 'Alpha Centauri'),
('TRAPPIST-1e', 'Acuario'),
('LHS 1140b', 'Cetus'),
('K2-18b', 'Leo'),
('TOI 700 d', 'Dorado');

-- Populate Persona table
INSERT INTO Persona (FechaAlta, NumeroIdentificacion, Nombre, 1erApellido, 2ºApellido, Planeta_idPlaneta, Telefono, Mail) VALUES
('2024-09-26 10:00:00', 'ID001', 'Juan', 'García', 'Pérez', 1, '123456789', 'juan@email.com'),
('2024-09-26 11:00:00', 'ID002', 'María', 'López', 'Sánchez', 1, '987654321', 'maria@email.com'),
('2024-09-26 12:00:00', 'ID003', 'Zorg', 'Blorp', 'Florp', 3, '555123456', 'zorg@kepler22b.com'),
('2024-09-27 09:00:00', 'ID004', 'Laura', 'Martínez', 'Gómez', 1, '456789123', 'laura@email.com'),
('2024-09-27 10:00:00', 'ID005', 'Carlos', 'Rodríguez', 'Fernández', 2, '789123456', 'carlos@mars.com'),
('2024-09-27 11:00:00', 'ID006', 'Xyli', 'Zeta', 'Alpha', 4, '321654987', 'xyli@gliese581g.com'),
('2024-09-28 08:00:00', 'ID007', 'Ana', 'Sánchez', 'Pérez', 1, '654987321', 'ana@email.com'),
('2024-09-28 09:00:00', 'ID008', 'Pedro', 'González', 'López', 2, '147258369', 'pedro@mars.com'),
('2024-09-28 10:00:00', 'ID009', 'Qwert', 'Yuiop', 'Asdf', 5, '369258147', 'qwert@hd40307g.com'),
('2024-09-28 11:00:00', 'ID010', 'Elena', 'Fernández', 'Martínez', 1, '258369147', 'elena@email.com');

-- Populate Empleado table
INSERT INTO Empleado (Rol, LugarTrabajo, Persona_idPersona) VALUES
('Piloto', 'Nave Espacial', 1),
('Ingeniero', 'Estación Espacial', 2),
('Médico', 'Hotel Espacial', 4),
('Capitán', 'Nave Espacial', 5),
('Científico', 'Laboratorio Orbital', 7),
('Técnico de Mantenimiento', 'Estación Espacial', 8),
('Oficial de Seguridad', 'Nave Espacial', 10);

-- Populate Cliente table
INSERT INTO Cliente (Categotia, Persona_idPersona) VALUES
('VIP', 3),
('Estándar', 6),
('Premium', 9);

-- Populate NaveEspacial table
INSERT INTO NaveEspacial (Nombre, Tipo, Modelo, CapacidadPasajeros, CapacidadCarga, Autonomia, VelocidadMaxima, TipoCombustible, FechaAlta, FechaProximoMantenimiento) VALUES
('Estrella Fugaz', 'Espacial', 'XR-5000', 100, 5000.00, 10000.00, 100000, 'Antimateria', '2024-01-01 00:00:00', '2025-01-01 00:00:00'),
('Explorador Planetario', 'Terrestre', 'TP-200', 10, 1000.00, 500.00, 200, 'Solar', '2024-02-15 00:00:00', '2024-12-31 00:00:00'),
('Cometa Veloz', 'Espacial', 'CV-3000', 150, 7500.00, 15000.00, 120000, 'Fusión', '2024-03-01 00:00:00', '2025-03-01 00:00:00'),
('Orbitador Lunar', 'Espacial', 'OL-100', 5, 500.00, 1000.00, 50000, 'Iónico', '2024-04-01 00:00:00', '2025-04-01 00:00:00'),
('Transbordador Galáctico', 'Espacial', 'TG-7000', 500, 20000.00, 50000.00, 150000, 'Materia Oscura', '2024-05-01 00:00:00', '2025-05-01 00:00:00');

-- Populate Viaje table
INSERT INTO Viaje (Origen, Destino, FechaSalida, FechaLlegada, Duracion, idNaveEspacial) VALUES
('Tierra', 'Marte', '2024-10-01 08:00:00', '2024-10-03 08:00:00', 48.00, 1),
('Marte', 'Kepler-22b', '2024-11-15 10:00:00', '2024-12-15 10:00:00', 720.00, 1),
('Tierra', 'Estación Espacial Internacional', '2024-10-10 09:00:00', '2024-10-10 15:00:00', 6.00, 2),
('Tierra', 'Luna', '2024-10-20 12:00:00', '2024-10-21 00:00:00', 12.00, 4),
('Kepler-22b', 'Gliese 581g', '2025-01-01 00:00:00', '2025-02-01 00:00:00', 744.00, 3),
('Tierra', 'Marte', '2024-12-01 08:00:00', '2024-12-03 08:00:00', 48.00, 1),
('Marte', 'Tierra', '2024-12-10 10:00:00', '2024-12-12 10:00:00', 48.00, 3),
('Tierra', 'Próxima Centauri b', '2025-03-01 00:00:00', '2025-06-01 00:00:00', 2160.00, 5),
('Gliese 581g', 'TRAPPIST-1e', '2025-04-01 00:00:00', '2025-06-01 00:00:00', 1464.00, 5),
('Tierra', 'HD 40307g', '2025-07-01 00:00:00', '2025-10-01 00:00:00', 2232.00, 5);

-- Populate Hotel table
INSERT INTO Hotel (Nombre, fechaConstruccion, idPlaneta, Categoria, CapacidadMaxima, NumeroHabitaciones) VALUES
('Gran Hotel Marte', '2023-05-15', 2, '5 Estrellas', 500, 200),
('Kepler Paradise', '2024-01-01', 3, '6 Estrellas', 1000, 400),
('Tierra View', '2023-01-01', 1, '4 Estrellas', 300, 150),
('Gliese Galactic Resort', '2024-06-01', 4, '7 Estrellas', 2000, 800),
('HD 40307g Oasis', '2024-09-01', 5, '6 Estrellas', 1500, 600);

-- Populate Habitacion table
INSERT INTO Habitacion (Tipo, Capacidad, Servicios, Precio, idHotel) VALUES
('Suite', 2, 'Vista al espacio, Jacuzzi antigravedad', 5000.00, 1),
('Estándar', 4, 'Simulador de gravedad terrestre', 2000.00, 1),
('Suite Real', 2, 'Jardín bioluminiscente privado', 10000.00, 2),
('Familiar', 6, 'Sala de juegos virtual', 4000.00, 3),
('Deluxe', 2, 'Observatorio privado', 7000.00, 4),
('Penthouse', 4, 'Piscina de gravedad cero', 15000.00, 5),
('Cápsula Individual', 1, 'Experiencia de criogenia', 1000.00, 1),
('Suite Presidencial', 2, 'Teletransportador privado', 20000.00, 2),
('Eco-Habitación', 2, 'Biosfera autosostenible', 6000.00, 3),
('Suite Astronómica', 2, 'Techo transparente con vista al espacio', 8000.00, 4);

-- Populate Reserva table
INSERT INTO Reserva (Fechareserva, Precio, idPersona) VALUES
('2024-09-27 09:00:00', 7000.00, 3),
('2024-09-28 10:00:00', 5000.00, 6),
('2024-09-29 11:00:00', 15000.00, 9),
('2024-09-30 12:00:00', 4000.00, 1),
('2024-10-01 13:00:00', 10000.00, 2),
('2024-10-02 14:00:00', 6000.00, 4),
('2024-10-03 15:00:00', 8000.00, 5),
('2024-10-04 16:00:00', 20000.00, 7),
('2024-10-05 17:00:00', 1000.00, 8),
('2024-10-06 18:00:00', 7000.00, 10);



-- Example of populating Suministro table
INSERT INTO Suministro (Tipo, Detalle, FechaPedido, idHotel, idNaveEspacial, FechaSalida) VALUES
('Alimentos', 'Provisiones para 1 mes', '2024-09-25 14:00:00', 1, 2, '2024-09-28 08:00:00'),
('Combustible', 'Recarga de antimateria', '2024-09-26 10:00:00', NULL, 1, '2024-09-29 08:00:00'),
('Equipo Médico', 'Suministros médicos de emergencia', '2024-09-27 09:00:00', 2, 3, '2024-09-30 08:00:00'),
('Agua', 'Reservas de agua potable', '2024-09-28 11:00:00', 3, 4, '2024-10-01 08:00:00'),
('Repuestos', 'Piezas de repuesto para motores', '2024-09-29 13:00:00', NULL, 5, '2024-10-02 08:00:00');

-- Example of populating Operacion table
INSERT INTO Operacion (Tipo, Descripcion, FechaInicio, FechaFinal) VALUES
('Mantenimiento', 'Revisión general de la nave Estrella Fugaz', '2024-10-15 09:00:00', '2024-10-17 18:00:00'),
('Reabastecimiento', 'Carga de suministros en Kepler Paradise', '2024-10-20 10:00:00', '2024-10-21 16:00:00'),
('Rescate', 'Misión de rescate en asteroide cercano', '2024-10-25 08:00:00', '2024-10-26 20:00:00'),
('Exploración', 'Mapeo de nueva región en Marte', '2024-11-01 07:00:00', '2024-11-10 19:00:00'),
('Reparación', 'Arreglo de sistema de soporte vital en Gliese Galactic Resort', '2024-11-15 09:00:00', '2024-11-16 18:00:00');

-- Populate Empleado_has_Operacion table
INSERT INTO Empleado_has_Operacion (idEmpleado, idOperacion, FechaAlta) VALUES
(1, 1, '2024-10-15 09:00:00'),
(2, 1, '2024-10-15 09:00:00'),
(4, 2, '2024-10-20 10:00:00'),
(5, 3, '2024-10-25 08:00:00'),
(7, 4, '2024-11-01 07:00:00'),
(8, 5, '2024-11-15 09:00:00'),
(1, 3, '2024-10-25 08:00:00'),
(2, 5, '2024-11-15 09:00:00'),
(4, 4, '2024-11-01 07:00:00'),
(5, 2, '2024-10-20 10:00:00');

-- Populate ReservaHabitacion table
INSERT INTO ReservaHabitacion (idHabitacion, idReserva, FechaInicio, FechaFinal) VALUES
(1, 1, '2024-11-20 14:00:00', '2024-11-25 11:00:00'),
(3, 2, '2024-12-01 12:00:00', '2024-12-10 10:00:00'),
(5, 3, '2025-01-05 15:00:00', '2025-01-15 11:00:00'),
(2, 4, '2024-11-28 14:00:00', '2024-12-05 11:00:00'),
(4, 5, '2024-12-15 12:00:00', '2024-12-20 10:00:00'),
(6, 6, '2025-02-01 15:00:00', '2025-02-10 11:00:00'),
(7, 7, '2024-12-10 14:00:00', '2024-12-15 11:00:00'),
(8, 8, '2025-01-20 12:00:00', '2025-01-30 10:00:00'),
(9, 9, '2024-11-25 15:00:00', '2024-11-30 11:00:00'),
(10, 10, '2025-03-01 14:00:00', '2025-03-10 11:00:00');

-- Populate ReservaViaje table
INSERT INTO ReservaViaje (idReserva, idViaje) VALUES
(1, 2),
(2, 1),
(3, 5),
(4, 3),
(5, 4),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Populate AsignacionOperacion table
INSERT INTO AsignacionOperacion (FechaAsignacion, idNaveEspacial, idViaje, Suministro, idHotel, idHabitacion, Operacion_idOperacion) VALUES
('2024-10-15 09:00:00', 1, NULL, NULL, NULL, NULL, 1),
('2024-10-20 10:00:00', NULL, NULL, 1, 2, NULL, 2),
('2024-10-25 08:00:00', 3, 5, NULL, NULL, NULL, 3),
('2024-11-01 07:00:00', 2, 1, NULL, NULL, NULL, 4),
('2024-11-15 09:00:00', NULL, NULL, NULL, 4, 5, 5);

-- Populate DetalleViaje table
INSERT INTO DetalleViaje (FechaRegistro, Telemetria, Velocidad, Consumo, idViaje) VALUES
('2024-10-01 10:00:00', 'Coordenadas: X135 Y246 Z789', 50000.00, 100.50, 1),
('2024-11-15 12:00:00', 'Coordenadas: X246 Y357 Z468', 75000.00, 150.75, 2),
('2024-10-10 10:30:00', 'Coordenadas: X100 Y200 Z300', 10000.00, 50.25, 3),
('2024-10-20 13:00:00', 'Coordenadas: X50 Y100 Z150', 25000.00, 75.50, 4),
('2025-01-15 09:00:00', 'Coordenadas: X500 Y750 Z1000', 100000.00, 200.00, 5),
('2024-12-01 11:00:00', 'Coordenadas: X150 Y250 Z350', 55000.00, 110.75, 6),
('2024-12-10 14:00:00', 'Coordenadas: X175 Y275 Z375', 60000.00, 120.50, 7),
('2025-04-01 08:00:00', 'Coordenadas: X1000 Y1500 Z2000', 125000.00, 250.00, 8),
('2025-05-01 10:00:00', 'Coordenadas: X1500 Y2000 Z2500', 130000.00, 260.00, 9),
('2025-08-01 12:00:00', 'Coordenadas: X2000 Y2500 Z3000', 140000.00, 280.00, 10);

-- Populate EstadosVitales table
INSERT INTO EstadosVitales (Mestruacion, PulsacionesHR, Oxigeno, PresionAlta, PresionBaja, Azucar, CO2enSangre, Temperatura, idViaje, Persona_idPersona) VALUES
(0, 75, 98.5, 120, 80, 95.0, 40.0, 36.6, 1, 3),
(1, 80, 97.8, 130, 85, 100.0, 38.5, 36.8, 2, 6),
(0, 72, 99.0, 115, 75, 92.5, 41.5, 36.5, 3, 1),
(0, 78, 98.2, 125, 82, 97.5, 39.5, 36.7, 4, 2),
(1, 76, 98.8, 118, 78, 94.0, 40.5, 36.6, 5, 9),
(0, 74, 99.2, 122, 81, 96.0, 39.0, 36.5, 6, 4),
(1, 82, 97.5, 132, 86, 101.0, 38.0, 36.9, 7, 5),
(0, 70, 99.5, 110, 70, 91.0, 42.0, 36.4, 8, 7),
(1, 79, 98.0, 128, 84, 98.5, 39.8, 36.7, 9, 8),
(0, 77, 98.6, 124, 83, 96.5, 40.2, 36.6, 10, 10);

-- Populate Inventario table
INSERT INTO Inventario (Producto, Categoria, Descripcion, Cantidad, FechaRecepcion, idSuministro) VALUES
('Comida Deshidratada', 'Alimentos', 'Paquetes de comida espacial de larga duración', 1000.00, '2024-09-28 10:00:00', 1),
('Antimateria', 'Combustible', 'Contenedores de antimateria para propulsión', 100.00, '2024-09-29 11:00:00', 2),
('Kit Médico Espacial', 'Equipo Médico', 'Kits de primeros auxilios adaptados para el espacio', 50.00, '2024-09-30 12:00:00', 3),
('Agua Purificada', 'Bebidas', 'Contenedores de agua purificada y mineralizada', 2000.00, '2024-10-01 13:00:00', 4),
('Componentes de Motor', 'Repuestos', 'Piezas de repuesto para motores de naves espaciales', 200.00, '2024-10-02 14:00:00', 5),
('Comida Deshidratada', 'Alimentos', 'Alimentos de larga duración para viajes espaciales', 1000.00, '2024-09-25 10:00:00', 3),
('Combustible de Fusión', 'Combustible', 'Combustible de alta eficiencia para naves espaciales', 5000.00, '2024-09-26 11:00:00', 2),
('Kit Médico Espacial', 'Medicamentos', 'Kit de emergencia para situaciones médicas en el espacio', 100.00, '2024-09-27 12:00:00', 3),
('Trajes Espaciales', 'Equipamiento', 'Trajes de última generación para actividades extraveiculares', 50.00, '2024-09-28 13:00:00', 4),
('Módulos de Comunicación', 'Tecnología', 'Dispositivos de comunicación de largo alcance', 200.00, '2024-09-29 14:00:00', 5);

-- Populate Formacion table
INSERT INTO Formacion (Nombre, Tipo, Descripcion, FechaAlta) VALUES
('Pilotaje Avanzado', 'Técnica', 'Curso avanzado de pilotaje de naves espaciales', '2024-08-01 00:00:00'),
('Primeros Auxilios en el Espacio', 'Médica', 'Entrenamiento en atención médica en condiciones de microgravedad', '2024-08-15 00:00:00'),
('Mantenimiento de Sistemas de Soporte Vital', 'Técnica', 'Curso sobre mantenimiento y reparación de sistemas de soporte vital', '2024-09-01 00:00:00'),
('Protocolo Intergaláctico', 'Social', 'Formación en etiqueta y comunicación con diversas especies alienígenas', '2024-09-15 00:00:00'),
('Supervivencia Planetaria', 'Práctica', 'Técnicas de supervivencia en diversos entornos planetarios', '2024-10-01 00:00:00'),
('Supervivencia en Planetas Hostiles', 'Práctica', 'Entrenamiento para sobrevivir en ambientes planetarios extremos', '2024-08-05 13:00:00');

-- Populate EmpleadoFormacion table
INSERT INTO EmpleadoFormacion (idEmpleado, idFormacion, FechaInicio, FechaFin, Evaluacion) VALUES
(1, 1, '2024-08-15 09:00:00', '2024-09-15 18:00:00', 9),
(2, 3, '2024-09-05 09:00:00', '2024-10-05 18:00:00', 8),
(4, 2, '2024-08-20 09:00:00', '2024-09-20 18:00:00', 10),
(5, 1, '2024-08-15 09:00:00', '2024-09-15 18:00:00', 9),
(7, 5, '2024-10-10 09:00:00', '2024-11-10 18:00:00', 7),
(8, 3, '2024-09-05 09:00:00', '2024-10-05 18:00:00', 8),
(10, 4, '2024-09-20 09:00:00', '2024-10-20 18:00:00', 9),
(1, 3, '2024-09-01 09:00:00', '2024-09-15 17:00:00', 6),
(2, 2, '2024-09-05 09:00:00', '2024-09-20 17:00:00', 5),
(3, 3, '2024-09-10 09:00:00', '2024-09-25 17:00:00', 7),
(4, 4, '2024-09-15 09:00:00', '2024-09-30 17:00:00', 10),
(5, 6, '2024-09-20 09:00:00', '2024-10-05 17:00:00', 8);





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


