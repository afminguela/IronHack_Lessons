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
  `Descripcion` TEXT(1000) NULL,
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

CREATE TABLE IF NOT EXISTS   `Ejercicio-6`.`Poliza` (
  `idPoliza` INT NOT NULL AUTO_INCREMENT,
  `TipoSeguro` ENUM('Vida', 'Automovil', 'Hogar') NOT NULL,
  `FechaInicio` DATE NOT NULL,
  `FechaCancelacion` DATE NULL,
  `FechaExpiracion` DATE NULL,
  `MontoAsegurado` DECIMAL(10,2) NOT NULL,
  `EstadoPoliza` TINYINT(1) NOT NULL DEFAULT 1,
  `Agente_idAgente` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Vehiculo_idVehiculo` INT NULL,
  `Hogar_idHogar` INT NULL,
  `Prima` DECIMAL(10,2) NOT NULL,
  `Descripcion` TEXT(1000) NOT NULL,
  `Condiciones` TEXT(1000) NOT NULL,
  `FechaUltimaActualizacion` DATETIME NOT NULL,
  `ContratoURL` VARCHAR(150) NOT NULL,
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
  `DocumentacionAdjunta` MEDIUMTEXT NULL,
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

INSERT INTO Ciudad (Nombre, Pais) 
VALUES
('Madrid', 'España'),
('Barcelona', 'España'),
('Valencia', 'España'),
('Sevilla', 'España'),
('Zaragoza', 'España'),
('Málaga', 'España'),
('Murcia', 'España'),
('Palma', 'España'),
('Las Palmas', 'España'),
('Bilbao', 'España'),
('Alicante', 'España'),
('Córdoba', 'España'),
('Valladolid', 'España'),
('Vigo', 'España'),
('Gijón', 'España'),
('L''Hospitalet', 'España'),
('Vitoria', 'España'),
('La Coruña', 'España'),
('Granada', 'España'),
('Elche', 'España');

INSERT INTO Persona (Nombre, Calle, CodigoPostal, Ciudad_idCiudad, Telefono, Email, FechaNacimiento, FechaAlta, FechaBaja, FechaUltimaActualizacion, DNI) VALUES
('Juan Pérez', 'Calle Mayor 1', '28001', 1, '600111222', 'juan@email.com', '1980-01-15', '2020-01-01', NULL, '2023-01-01 10:00:00', '12345678A'),
('María López', 'Avenida Diagonal 100', '08001', 2, '600222333', 'maria@email.com', '1985-05-20', '2020-02-01', NULL, '2023-01-02 11:00:00', '23456789B'),
('Pedro Martínez', 'Calle Colón 50', '46001', 3, '600333444', 'pedro@email.com', '1990-10-10', '2020-03-01', NULL, '2023-01-03 12:00:00', '34567890C'),
('Ana Rodríguez', 'Avenida de la Constitución 25', '41001', 4, '600444555', 'ana@email.com', '1982-12-05', '2020-04-01', NULL, '2023-01-04 13:00:00', '45678901D'),
('Carlos Sánchez', 'Paseo Independencia 75', '50001', 5, '600555666', 'carlos@email.com', '1988-07-30', '2020-05-01', NULL, '2023-01-05 14:00:00', '56789012E'),
('Laura Fernández', 'Calle Larios 10', '29001', 6, '600666777', 'laura@email.com', '1995-03-25', '2020-06-01', NULL, '2023-01-06 15:00:00', '67890123F'),
('Miguel González', 'Gran Vía 1', '30001', 7, '600777888', 'miguel@email.com', '1983-09-18', '2020-07-01', NULL, '2023-01-07 16:00:00', '78901234G'),
('Elena Díaz', 'Paseo del Borne 5', '07001', 8, '600888999', 'elena@email.com', '1992-11-22', '2020-08-01', NULL, '2023-01-08 17:00:00', '89012345H'),
('David Ruiz', 'Calle Triana 20', '35001', 9, '600999000', 'david@email.com', '1987-06-14', '2020-09-01', NULL, '2023-01-09 18:00:00', '90123456I'),
('Sara Gómez', 'Gran Vía 30', '48001', 10, '601000111', 'sara@email.com', '1993-02-28', '2020-10-01', NULL, '2023-01-10 19:00:00', '01234567J'),
('Javier Muñoz', 'Rambla Méndez Núñez 15', '03001', 11, '601111222', 'javier@email.com', '1981-08-09', '2020-11-01', NULL, '2023-01-11 20:00:00', '12345678K'),
('Carmen Navarro', 'Calle Cruz Conde 12', '14001', 12, '601222333', 'carmen@email.com', '1989-04-17', '2020-12-01', NULL, '2023-01-12 21:00:00', '23456789L'),
('Antonio Moreno', 'Calle Santiago 8', '47001', 13, '601333444', 'antonio@email.com', '1994-01-07', '2021-01-01', NULL, '2023-01-13 22:00:00', '34567890M'),
('Isabel Castro', 'Calle Príncipe 40', '36201', 14, '601444555', 'isabel@email.com', '1986-12-12', '2021-02-01', NULL, '2023-01-14 23:00:00', '45678901N'),
('Francisco Ortega', 'Calle Corrida 25', '33201', 15, '601555666', 'francisco@email.com', '1991-07-03', '2021-03-01', NULL, '2023-01-15 00:00:00', '56789012O'),
('Lucía Delgado', 'Rambla Just Oliveras 50', '08901', 16, '601666777', 'lucia@email.com', '1984-05-29', '2021-04-01', NULL, '2023-01-16 01:00:00', '67890123P'),
('Roberto Herrera', 'Calle Florida 3', '01001', 17, '601777888', 'roberto@email.com', '1996-10-21', '2021-05-01', NULL, '2023-01-17 02:00:00', '78901234Q'),
('Marta Vargas', 'Calle Real 60', '15001', 18, '601888999', 'marta@email.com', '1985-03-11', '2021-06-01', NULL, '2023-01-18 03:00:00', '89012345R'),
('Alejandro Ramos', 'Gran Vía de Colón 20', '18001', 19, '601999000', 'alejandro@email.com', '1990-09-08', '2021-07-01', NULL, '2023-01-19 04:00:00', '90123456S'),
('Beatriz Torres', 'Calle Jorge Juan 15', '03201', 20, '602000111', 'beatriz@email.com', '1993-11-16', '2021-08-01', NULL, '2023-01-20 05:00:00', '01234567T');

INSERT INTO Agente (Persona_idPersona) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

INSERT INTO Cliente (idCliente, Persona_idPersona, Agente_idAgente) VALUES
(1, 1, 2), (2, 2, 3), (3, 3, 4), (4, 4, 5), (5, 5, 6),
(6, 6, 7), (7, 7, 8), (8, 8, 9), (9, 9, 10), (10, 10, 11),
(11, 11, 12), (12, 12, 13), (13, 13, 14), (14, 14, 15), (15, 15, 16),
(16, 16, 17), (17, 17, 18), (18, 18, 19), (19, 19, 20), (20, 20, 1);

INSERT INTO Informe (Nombre, FechaGeneracion, ReclamacionesPendientes, NumeroPolizasActivas, TendenciasSeguro, HistorialRenovaciones, Agente_idAgente, Descipcion) VALUES
('Informe Anual 2022', '2023-01-01 10:00:00', 5, 100, 'Aumento en seguros de hogar', 'Alta tasa de renovación', 1, 'Informe detallado del año 2022'),
('Informe Trimestral Q1', '2023-04-01 11:00:00', 3, 80, 'Estabilidad en seguros de vida', 'Renovaciones estables', 2, 'Informe del primer trimestre'),
('Informe Mensual Enero', '2023-02-01 12:00:00', 2, 90, 'Ligero descenso en seguros de auto', 'Algunas cancelaciones', 3, 'Resumen del mes de enero'),
('Informe Semestral H1', '2023-07-01 13:00:00', 4, 110, 'Crecimiento en todos los tipos de seguro', 'Aumento de renovaciones', 4, 'Balance del primer semestre'),
('Informe Anual 2021', '2022-01-01 14:00:00', 6, 95, 'Recuperación post-pandemia', 'Renovaciones en aumento', 5, 'Resumen del año 2021'),
('Informe Trimestral Q2', '2023-07-01 15:00:00', 1, 85, 'Aumento en seguros de salud', 'Renovaciones estables', 6, 'Informe del segundo trimestre'),
('Informe Mensual Febrero', '2023-03-01 16:00:00', 3, 88, 'Estabilidad general', 'Ligero aumento en renovaciones', 7, 'Resumen del mes de febrero'),
('Informe Anual 2020', '2021-01-01 17:00:00', 8, 70, 'Impacto de la pandemia', 'Descenso en renovaciones', 8, 'Balance del año de la pandemia'),
('Informe Trimestral Q3', '2023-10-01 18:00:00', 2, 92, 'Recuperación en seguros de viaje', 'Aumento de nuevas pólizas', 9, 'Informe del tercer trimestre'),
('Informe Mensual Marzo', '2023-04-01 19:00:00', 4, 95, 'Crecimiento en seguros de hogar', 'Renovaciones estables', 10, 'Resumen del mes de marzo'),
('Informe Semestral H2', '2024-01-01 20:00:00', 5, 105, 'Fuerte crecimiento en auto y hogar', 'Alto índice de renovaciones', 11, 'Balance del segundo semestre'),
('Informe Anual 2023', '2024-01-15 21:00:00', 3, 120, 'Año récord en ventas', 'Máximo histórico de renovaciones', 12, 'Resumen del exitoso año 2023'),
('Informe Trimestral Q4', '2024-01-01 22:00:00', 2, 110, 'Fuerte cierre de año', 'Renovaciones por encima del objetivo', 13, 'Informe del cuarto trimestre'),
('Informe Mensual Abril', '2023-05-01 23:00:00', 3, 98, 'Ligero aumento en todos los segmentos', 'Renovaciones estables', 14, 'Resumen del mes de abril'),
('Informe Especial COVID', '2022-06-01 00:00:00', 10, 60, 'Impacto negativo en viajes y eventos', 'Cancelaciones superiores a lo normal', 15, 'Análisis del impacto de la pandemia'),
('Informe Trimestral Q1 2024', '2024-04-01 01:00:00', 1, 125, 'Inicio de año excepcional', 'Renovaciones récord', 16, 'Primer informe trimestral del 2024'),
('Informe Mensual Mayo', '2023-06-01 02:00:00', 4, 100, 'Crecimiento en seguros de vida', 'Ligero aumento en renovaciones', 17, 'Resumen del mes de mayo'),
('Informe Anual 2019', '2020-01-01 03:00:00', 7, 85, 'Último año pre-pandemia', 'Renovaciones normales', 18, 'Análisis del último año antes de COVID'),
('Informe Semestral H1 2024', '2024-07-01 04:00:00', 2, 130, 'Crecimiento sostenido en todos los ramos', 'Excelente tasa de renovación', 19, 'Balance del primer semestre de 2024'),
('Informe Mensual Junio', '2023-07-01 05:00:00', 3, 102, 'Buen desempeño en seguros de auto', 'Renovaciones por encima del promedio', 20, 'Resumen del mes de junio');

INSERT INTO Hogar (Calle, CodigoPostal, NumeroExterior, Bloque, Piso, Puerta, Escalera, ValorContenido, ValorContinente, Descripcion, Ciudad_idCiudad) VALUES
('Calle Mayor', '28001', '10', 'A', '1', '1', NULL, 50000.00, 150000.00, 'Piso céntrico', 1),
('Avenida Diagonal', '08001', '100', NULL, '5', '2', 'B', 75000.00, 200000.00, 'Apartamento de lujo', 2),
('Calle Colón', '46001', '25', 'B', '3', '3', NULL, 40000.00, 120000.00, 'Piso familiar', 3),
('Avenida de la Constitución', '41001', '15', NULL, '2', '1', 'A', 60000.00, 180000.00, 'Casa adosada', 4),
('Paseo Independencia', '50001', '50', 'C', '4', '2', NULL, 55000.00, 160000.00, 'Piso con terraza', 5),
('Calle Larios', '29001', '30', NULL, '6', '1', 'C', 70000.00, 190000.00, 'Ático con vistas', 6),
('Gran Vía', '30001', '5', 'D', '2', '4', NULL, 45000.00, 130000.00, 'Piso reformado', 7),
('Paseo del Borne', '07001', '20', NULL, '1', '2', 'A', 80000.00, 220000.00, 'Casa histórica', 8),
('Calle Triana', '35001', '40', 'E', '3', '1', NULL, 65000.00, 170000.00, 'Piso luminoso', 9),
('Gran Vía', '48001', '60', NULL, '4', '3', 'B', 55000.00, 150000.00, 'Apartamento moderno', 10),
('Rambla Méndez Núñez', '03001', '35', 'F', '5', '2', NULL, 50000.00, 140000.00, 'Piso con balcón', 11),
('Calle Cruz Conde', '14001', '12', NULL, '2', '1', 'D', 60000.00, 160000.00, 'Casa con patio', 12),
('Calle Santiago', '47001', '8', 'G', '1', '4', NULL, 40000.00, 110000.00, 'Estudio céntrico', 13),
('Calle Príncipe', '36201', '40', NULL, '3', '2', 'E', 70000.00, 180000.00, 'Piso con garaje', 14),
('Calle Corrida', '33201', '25', 'H', '4', '1', NULL, 55000.00, 150000.00, 'Apartamento renovado', 15),
('Rambla Just Oliveras', '08901', '50', NULL, '6', '3', 'F', 75000.00, 200000.00, 'Ático dúplex', 16),
('Calle Florida', '01001', '3', 'I', '2', '2', NULL, 45000.00, 130000.00, 'Piso económico', 17),
('Calle Real', '15001', '60', NULL, '5', '1', 'G', 80000.00, 210000.00, 'Casa señorial', 18),
('Gran Vía de Colón', '18001', '20', 'J', '3', '4', NULL, 60000.00, 170000.00, 'Piso con trastero', 19),
('Calle Jorge Juan', '03201', '15', NULL, '1', '3', 'H', 50000.00, 140000.00, 'Apartamento cerca de la playa', 20);

INSERT INTO Vehiculo (idVehiculo, NumeroSerie, Matricula, Modelo, Marca, AñoFabricacion, Tipo, TipoLicencia, Kilometraje) VALUES
(1, 'WBA1234567890', '1234ABC', 'Serie 3', 'BMW', '2020-01-01', 'Terrestre', 'B', '50000'),
(2, 'VWV9876543210', '5678DEF', 'Golf', 'Volkswagen', '2019-06-15', 'Terrestre', 'B', '75000'),
(3, 'TYT1122334455', '9012GHI', 'Corolla', 'Toyota', '2021-03-10', 'Terrestre', 'B', '30000'),
(4, 'FRD5566778899', '3456JKL', 'Focus', 'Ford', '2018-11-20', 'Terrestre', 'B', '100000'),
(5, 'AUD1357924680', '7890MNO', 'A4', 'Audi', '2022-01-05', 'Terrestre', 'B', '15000'),
(6, 'MRC2468013579', '1234PQR', 'Clase C', 'Mercedes-Benz', '2020-09-30', 'Terrestre', 'B', '60000'),
(7, 'PGT9876543210', '5678STU', '308', 'Peugeot', '2019-04-22', 'Terrestre', 'B', '80000'),
(8, 'RNL1234567890', '9012VWX', 'Clio', 'Renault', '2021-07-14', 'Terrestre', 'B', '40000'),
(9, 'STY9876543210', '3456YZA', 'Ibiza', 'SEAT', '2018-02-28', 'Terrestre', 'B', '110000'),
(10, 'OPL1234567890', '7890BCD', 'Astra', 'Opel', '2022-05-17', 'Terrestre', 'B', '20000'),
(11, 'HND9876543210', '1234EFG', 'Civic', 'Honda', '2020-12-01', 'Terrestre', 'B', '55000'),
(12, 'MSB1234567890', '5678HIJ', 'Colt', 'Mitsubishi', '2019-08-09', 'Terrestre', 'B', '85000'),
(13, 'MZD9876543210', '9012KLM', 'CX-5', 'Mazda', '2021-10-31', 'Terrestre', 'B', '35000'),
(14, 'VLV1234567890', '3456NOP', 'V40', 'Volvo', '2018-05-25', 'Terrestre', 'B', '95000'),
(15, 'KIA9876543210', '7890QRS', 'Sportage', 'Kia', '2022-03-19', 'Terrestre', 'B', '25000'),
(16, 'HYU1234567890', '1234TUV', 'Tucson', 'Hyundai', '2020-07-07', 'Terrestre', 'B', '65000'),
(17, 'SKD9876543210', '5678WXY', 'Octavia', 'Skoda', '2019-01-13', 'Terrestre', 'B', '90000'),
(18, 'FIT1234567890', '9012ZAB', '500', 'Fiat', '2021-04-04', 'Terrestre', 'B', '45000'),
(19, 'CIT9876543210', '3456CDE', 'C3', 'Citroën', '2018-09-16', 'Terrestre', 'B', '105000'),
(20, 'NIS1234567890', '7890FGH', 'Qashqai', 'Nissan', '2022-02-22', 'Terrestre', 'B', '10000');

INSERT INTO Poliza (TipoSeguro, FechaInicio, FechaExpiracion, FechaCancelacion, MontoAsegurado, EstadoPoliza, Agente_idAgente, Cliente_idCliente, Vehiculo_idVehiculo, Hogar_idHogar, Prima, Descripcion, Condiciones, FechaUltimaActualizacion, ContratoURL) VALUES
('Automovil', '2023-01-01', '2024-01-01', NULL, 20000.00, 1, 1, 1, 1, NULL, 500.00, 'Seguro a todo riesgo', 'Cobertura completa', '2023-01-01 10:00:00', 'http://ejemplo.com/contrato1'),
('Hogar', '2023-02-01', '2024-02-01', NULL, 150000.00, 1, 2, 2, NULL, 1, 300.00, 'Seguro de hogar básico', 'Cobertura contra incendios y robos', '2023-02-01 11:00:00', 'http://ejemplo.com/contrato2'),
('Vida', '2023-03-01', '2033-03-01', NULL, 100000.00, 1, 3, 3, NULL, NULL, 200.00, 'Seguro de vida a 10 años', 'Cobertura por fallecimiento', '2023-03-01 12:00:00', 'http://ejemplo.com/contrato3'),
('Automovil', '2023-04-01', '2024-04-01', NULL, 25000.00, 1, 4, 4, 2, NULL, 600.00, 'Seguro a terceros ampliado', 'Cobertura de responsabilidad civil', '2023-04-01 13:00:00', 'http://ejemplo.com/contrato4'),
('Hogar', '2023-05-01', '2024-05-01', NULL, 200000.00, 1, 5, 5, NULL, 2, 400.00, 'Seguro de hogar premium', 'Cobertura total incluyendo contenido', '2023-05-01 14:00:00', 'http://ejemplo.com/contrato5'),
('Vida', '2023-06-01', '2043-06-01', NULL, 150000.00, 1, 6, 6, NULL, NULL, 250.00, 'Seguro de vida a 20 años', 'Cobertura por fallecimiento e invalidez', '2023-06-01 15:00:00', 'http://ejemplo.com/contrato6'),
('Automovil', '2023-07-01', '2024-07-01', NULL, 30000.00, 1, 7, 7, 3, NULL, 700.00, 'Seguro a todo riesgo con franquicia', 'Cobertura completa con franquicia de 300€', '2023-07-01 16:00:00', 'http://ejemplo.com/contrato7'),
('Hogar', '2023-08-01', '2024-08-01', NULL, 180000.00, 1, 8, 8, NULL, 3, 350.00, 'Seguro de hogar estándar', 'Cobertura contra daños y responsabilidad civil', '2023-08-01 17:00:00', 'http://ejemplo.com/contrato8'),
('Vida', '2023-09-01', '2038-09-01', NULL, 120000.00, 1, 9, 9, NULL, NULL, 220.00, 'Seguro de vida a 15 años', 'Cobertura por fallecimiento y enfermedad grave', '2023-09-01 18:00:00', 'http://ejemplo.com/contrato9'),
('Automovil', '2023-10-01', '2024-10-01', NULL, 22000.00, 1, 10, 10, 4, NULL, 550.00, 'Seguro a terceros', 'Cobertura básica obligatoria', '2023-10-01 19:00:00', 'http://ejemplo.com/contrato10'),
('Hogar', '2023-11-01', '2024-11-01', NULL, 220000.00, 1, 11, 11, NULL, 4, 450.00, 'Seguro de hogar con cobertura de joyas', 'Incluye cobertura especial para joyas y objetos de valor', '2023-11-01 20:00:00', 'http://ejemplo.com/contrato11'),
('Vida', '2023-12-01', '2048-12-01', NULL, 200000.00, 1, 12, 12, NULL, NULL, 300.00, 'Seguro de vida a 25 años', 'Cobertura por fallecimiento, invalidez y enfermedades graves', '2023-12-01 21:00:00', 'http://ejemplo.com/contrato12'),
('Automovil', '2024-01-01', '2025-01-01', NULL, 35000.00, 1, 13, 13, 5, NULL, 800.00, 'Seguro a todo riesgo premium', 'Cobertura completa sin franquicia', '2024-01-01 22:00:00', 'http://ejemplo.com/contrato13'),
('Hogar', '2024-02-01', '2025-02-01', NULL, 190000.00, 1, 14, 14, NULL, 5, 380.00, 'Seguro de hogar con cobertura de mascotas', 'Incluye cobertura para daños causados por mascotas', '2024-02-01 23:00:00', 'http://ejemplo.com/contrato14'),
('Vida', '2024-03-01', '2054-03-01', NULL, 250000.00, 1, 15, 15, NULL, NULL, 350.00, 'Seguro de vida a 30 años', 'Cobertura completa con opción de rescate', '2024-03-01 00:00:00', 'http://ejemplo.com/contrato15'),
('Automovil', '2024-04-01', '2025-04-01', NULL, 28000.00, 1, 16, 16, 6, NULL, 650.00, 'Seguro a terceros ampliado con asistencia', 'Incluye asistencia en carretera 24/7', '2024-04-01 01:00:00', 'http://ejemplo.com/contrato16'),
('Hogar', '2024-05-01', '2025-05-01', NULL, 230000.00, 1, 17, 17, NULL, 6, 470.00, 'Seguro de hogar con cobertura tecnológica', 'Protección especial para dispositivos electrónicos', '2024-05-01 02:00:00', 'http://ejemplo.com/contrato17'),
('Vida', '2024-06-01', '2044-06-01', NULL, 180000.00, 1, 18, 18, NULL, NULL, 280.00, 'Seguro de vida a 20 años con devolución', 'Devolución de primas si no hay siniestro', '2024-06-01 03:00:00', 'http://ejemplo.com/contrato18'),
('Automovil', '2024-07-01', '2025-07-01', NULL, 32000.00, 1, 19, 19, 7, NULL, 750.00, 'Seguro a todo riesgo para conductores noveles', 'Cobertura especial para conductores con menos de 2 años de carnet', '2024-07-01 04:00:00', 'http://ejemplo.com/contrato19'),
('Hogar', '2024-08-01', '2025-08-01', NULL, 210000.00, 1, 20, 20, NULL, 7, 420.00, 'Seguro de hogar con cobertura de energías renovables', 'Incluye protección para instalaciones solares y eólicas', '2024-08-01 05:00:00', 'http://ejemplo.com/contrato20');

INSERT INTO Reclamacion (FechaPresentacion, FechaTramite, FechaFinalizacion, FechaCancelacion, MontoReclamado, Estadoreclamacion, DocumentacionAdjunta, Poliza_idPoliza) VALUES
('2023-03-15 10:00:00', '2023-03-16 09:00:00', '2023-03-20 15:00:00', NULL, 1500.00, 'Finalizada', 'Fotos del accidente, informe policial', 1),
('2023-04-20 11:30:00', '2023-04-21 10:00:00', NULL, NULL, 3000.00, 'En tramite', 'Presupuesto de reparación', 2),
('2023-05-10 09:15:00', '2023-05-11 14:00:00', '2023-05-15 16:30:00', NULL, 500.00, 'Finalizada', 'Factura de reparación', 3),
('2023-06-05 16:45:00', NULL, NULL, '2023-06-06 10:00:00', 2000.00, 'Cancelada', 'Solicitud de cancelación del cliente', 4),
('2023-07-12 13:20:00', '2023-07-13 09:30:00', NULL, NULL, 5000.00, 'En tramite', 'Informe médico, facturas hospitalarias', 5),
('2023-08-18 10:10:00', '2023-08-19 11:00:00', '2023-08-25 14:45:00', NULL, 1200.00, 'Finalizada', 'Fotos de los daños, presupuesto', 6),
('2023-09-22 15:30:00', '2023-09-23 10:15:00', NULL, NULL, 4000.00, 'En tramite', 'Informe pericial', 7),
('2023-10-30 09:45:00', '2023-10-31 14:30:00', '2023-11-05 16:00:00', NULL, 800.00, 'Finalizada', 'Factura de reemplazo', 8),
('2023-11-14 11:55:00', NULL, NULL, '2023-11-15 09:30:00', 3500.00, 'Cancelada', 'Correo de desistimiento', 9),
('2023-12-20 14:20:00', '2023-12-21 10:00:00', NULL, NULL, 6000.00, 'En tramite', 'Informe de bomberos, fotos', 10),
('2024-01-05 10:30:00', '2024-01-06 09:15:00', '2024-01-10 15:30:00', NULL, 2500.00, 'Finalizada', 'Presupuesto y factura de reparación', 11),
('2024-02-18 13:45:00', '2024-02-19 11:00:00', NULL, NULL, 4500.00, 'En tramite', 'Informe médico, radiografías', 12),
('2024-03-25 09:20:00', '2024-03-26 14:00:00', '2024-03-30 16:15:00', NULL, 1800.00, 'Finalizada', 'Factura de reemplazo de electrodoméstico', 13),
('2024-04-10 16:10:00', NULL, NULL, '2024-04-11 10:30:00', 3200.00, 'Cancelada', 'Notificación de resolución amistosa', 14),
('2024-05-22 11:40:00', '2024-05-23 09:45:00', NULL, NULL, 5500.00, 'En tramite', 'Informe pericial, presupuestos', 15),
('2024-06-30 14:55:00', '2024-07-01 10:30:00', '2024-07-05 15:00:00', NULL, 900.00, 'Finalizada', 'Factura de reparación de cristales', 16),
('2024-07-15 10:15:00', '2024-07-16 11:30:00', NULL, NULL, 4200.00, 'En tramite', 'Informe policial, fotos del robo', 17),
('2024-08-20 13:30:00', '2024-08-21 09:00:00', '2024-08-25 14:30:00', NULL, 1600.00, 'Finalizada', 'Presupuesto y factura de fontanería', 18),
('2024-09-05 15:40:00', NULL, NULL, '2024-09-06 10:15:00', 3800.00, 'Cancelada', 'Correo de retiro de la reclamación', 19),
('2024-10-12 09:50:00', '2024-10-13 11:00:00', NULL, NULL, 5800.00, 'En tramite', 'Informe médico, facturas de tratamiento', 20);

INSERT INTO Transaccion (Fecha, Monto, Cliente_idCliente, Poliza_idPoliza) VALUES
('2023-01-15', 500.00, 1, 1),
('2023-02-20', 300.00, 2, 2),
('2023-03-10', 200.00, 3, 3),
('2023-04-05', 600.00, 4, 4),
('2023-05-12', 400.00, 5, 5),
('2023-06-18', 250.00, 6, 6),
('2023-07-22', 700.00, 7, 7),
('2023-08-30', 350.00, 8, 8),
('2023-09-14', 220.00, 9, 9),
('2023-10-25', 550.00, 10, 10),
('2023-11-08', 450.00, 11, 11),
('2023-12-19', 300.00, 12, 12),
('2024-01-03', 800.00, 13, 13),
('2024-02-11', 380.00, 14, 14),
('2024-03-21', 350.00, 15, 15),
('2024-04-07', 650.00, 16, 16),
('2024-05-16', 470.00, 17, 17),
('2024-06-28', 280.00, 18, 18),
('2024-07-09', 750.00, 19, 19),
('2024-08-14', 420.00, 20, 20);

INSERT INTO Pagos (Fecha, Transaccion_idTransaccion, IBAN) VALUES
('2023-01-15', 1, 'ES9121000418450200051332'),
('2023-02-20', 2, 'ES7100610370660001234567'),
('2023-03-10', 3, 'ES1000492352082414205416'),
('2023-04-05', 4, 'ES1720852066623456789011'),
('2023-05-12', 5, 'ES0231906355174100071892'),
('2023-06-18', 6, 'ES9420805801101234567891'),
('2023-07-22', 7, 'ES7100302053091234567895'),
('2023-08-30', 8, 'ES1000492352082414205416'),
('2023-09-14', 9, 'ES9121000418450200051332'),
('2023-10-25', 10, 'ES7100610370660001234567'),
('2023-11-08', 11, 'ES1720852066623456789011'),
('2023-12-19', 12, 'ES0231906355174100071892'),
('2024-01-03', 13, 'ES9420805801101234567891'),
('2024-02-11', 14, 'ES7100302053091234567895'),
('2024-03-21', 15, 'ES1000492352082414205416'),
('2024-04-07', 16, 'ES9121000418450200051332'),
('2024-05-16', 17, 'ES7100610370660001234567'),
('2024-06-28', 18, 'ES1720852066623456789011'),
('2024-07-09', 19, 'ES0231906355174100071892'),
('2024-08-14', 20, 'ES9420805801101234567891');

INSERT INTO Recordatorio (Fecha, Descripcion, Poliza_idPoliza) VALUES
('2023-12-01 09:00:00', 'Recordatorio de renovación de póliza', 1),
('2024-01-15 10:30:00', 'Actualización de datos del asegurado', 2),
('2024-02-28 11:45:00', 'Revisión anual de cobertura', 3),
('2024-03-10 14:00:00', 'Recordatorio de pago de prima', 4),
('2024-04-22 16:30:00', 'Actualización de valor asegurado', 5),
('2024-05-05 09:15:00', 'Recordatorio de vencimiento de póliza', 6),
('2024-06-18 11:00:00', 'Revisión de condiciones de la póliza', 7),
('2024-07-30 13:45:00', 'Recordatorio de inspección de riesgos', 8),
('2024-08-12 15:30:00', 'Actualización de beneficiarios', 9),
('2024-09-25 10:00:00', 'Recordatorio de renovación de póliza', 10),
('2024-10-08 12:15:00', 'Revisión de descuentos aplicables', 11),
('2024-11-20 14:30:00', 'Actualización de información de contacto', 12),
('2024-12-03 16:00:00', 'Recordatorio de pago de prima', 13),
('2025-01-15 09:30:00', 'Revisión anual de cobertura', 14),
('2025-02-28 11:15:00', 'Actualización de valor asegurado', 15),
('2025-03-10 13:00:00', 'Recordatorio de vencimiento de póliza', 16),
('2025-04-22 15:45:00', 'Revisión de condiciones de la póliza', 17),
('2025-05-05 10:30:00', 'Recordatorio de inspección de riesgos', 18),
('2025-06-18 12:45:00', 'Actualización de beneficiarios', 19),
('2025-07-30 14:15:00', 'Recordatorio de renovación de póliza', 20);