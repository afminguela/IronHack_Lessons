CREATE DATABASE if not exists AYUNTAMIENTO;
USE AYUNTAMIENTO;

-- Tablas Unicas--

CREATE TABLE IF NOT EXISTS `ciudadanos` (
  `ID_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido_uno` VARCHAR(45) NULL,
  `apellido_dos` VARCHAR(45) NULL,
  `correo_electronico` VARCHAR(100) NOT NULL,
  `documentos` TEXT NULL DEFAULT NULL,
  `calle` VARCHAR(45) NULL,
  `numero` INT NULL,
  `cp_postal` INT NOT NULL,
  `cuidad` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL DEFAULT 'España',
  `provincia` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(15) NULL,
  `puerta` VARCHAR(45) NULL,
  `escalera` VARCHAR(45) NULL,
  `bloque` VARCHAR(45) NULL,
  `dni` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_usuario`)
  );
  
  CREATE TABLE IF NOT EXISTS `departamentos` (
  `ID_departamento` INT NOT NULL AUTO_INCREMENT,
  `nombre_departamento` VARCHAR(100) NOT NULL,
  `fecha_alta_departamento` DATE NOT NULL,
  `fecha_baja_departmento` DATE NULL,
  PRIMARY KEY (`ID_departamento`)
  );

CREATE TABLE IF NOT EXISTS `empleados` (
  `ID_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `correo_electronico` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `fecha_baja` DATE NULL,
  PRIMARY KEY (`ID_empleado`)
  );
 
CREATE TABLE IF NOT EXISTS `permisos` (
  `ID_permiso` INT NOT NULL AUTO_INCREMENT,
  `tipo_permiso` VARCHAR(100) NOT NULL,
  `fecha_alta` DATETIME NULL,
  `fecha_baja` DATETIME NULL,
  PRIMARY KEY (`ID_permiso`)
  );
 
 
CREATE TABLE IF NOT EXISTS `solicitudes` (
  `ID_solicitud` INT NOT NULL AUTO_INCREMENT unique,
  `ID_usuario` INT NOT NULL,
  `ID_permiso` INT NOT NULL,
  `fecha_solicitud` DATE NOT NULL,
  `estado_solicitud` ENUM('Pendiente', 'Aprobada', 'Rechazada') NOT NULL,
  `documentacion_adicional` TEXT NULL DEFAULT NULL,
  `empleados_ID_empleado` INT NOT NULL,
  `fecha_aprobacion` DATETIME NULL,
  `fecha_cancelacion` DATETIME NULL,
  PRIMARY KEY (`ID_solicitud`, `empleados_ID_empleado`),
  FOREIGN KEY (`ID_usuario`)    REFERENCES `ciudadanos` (`ID_usuario`)    ON DELETE CASCADE    ON UPDATE CASCADE,
  FOREIGN KEY (`ID_permiso`)    REFERENCES `permisos` (`ID_permiso`)    ON DELETE CASCADE    ON UPDATE CASCADE,
  FOREIGN KEY (`empleados_ID_empleado`)    REFERENCES `empleados` (`ID_empleado`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
    );


CREATE TABLE IF NOT EXISTS `reportes` (
  `ID_reporte` INT NOT NULL AUTO_INCREMENT,
  `tipo_reporte` ENUM('Solicitudes Procesadas', 'Tiempo Promedio de Aprobación', 'Recaudación por Tasas') NOT NULL,
  `fecha_generacion` DATE NOT NULL,
  `detalle` TEXT NULL DEFAULT NULL,
  `empleados_ID_empleado` INT NOT NULL,
  PRIMARY KEY (`ID_reporte`, `empleados_ID_empleado`),
  FOREIGN KEY (`empleados_ID_empleado`)    REFERENCES `empleados` (`ID_empleado`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
    );
    
CREATE TABLE IF NOT EXISTS `pagos` (
  `ID_pago` INT NOT NULL AUTO_INCREMENT,
  `ID_solicitud` INT NOT NULL,
  `monto_pagado` DECIMAL(10,2) NOT NULL,
  `fecha_pago` DATE NOT NULL,
  PRIMARY KEY (`ID_pago`, `ID_solicitud`),
  FOREIGN KEY (`ID_solicitud`)  REFERENCES `solicitudes`(`ID_solicitud`) ON DELETE CASCADE ON UPDATE CASCADE
 );
 
 
CREATE TABLE IF NOT EXISTS `citas` (
  `ID_cita` INT NOT NULL AUTO_INCREMENT,
  `ID_usuario` INT NOT NULL,
  `ID_departamento` INT NOT NULL,
  `fecha_cita` DATE NOT NULL,
  `hora_cita` TIME NOT NULL,
  `motivo` VARCHAR(255) NOT NULL,
  `ID_solicitud` INT NOT NULL,
  `fecha_cancelacion_cita` DATETIME NULL,
  PRIMARY KEY (`ID_cita`),
  FOREIGN KEY (`ID_usuario`)    REFERENCES `ciudadanos` (`ID_usuario`)    ON DELETE CASCADE    ON UPDATE CASCADE,
  FOREIGN KEY (`ID_departamento`)    REFERENCES `departamentos`(`ID_departamento`)    ON DELETE CASCADE    ON UPDATE CASCADE,
  FOREIGN KEY (`ID_solicitud`) REFERENCES `solicitudes`(`ID_solicitud`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
);
    
CREATE TABLE IF NOT EXISTS `departamentos_has_empleados` (
  `id_departamento_empleado` INT NOT NULL AUTO_INCREMENT,
  `departamentos_ID_departamento` INT NOT NULL,
  `empleados_ID_empleado` INT NOT NULL,
  `fecha_alta` TIMESTAMP NOT NULL,
  `fecha_baja` TIMESTAMP NULL,
  PRIMARY KEY (`id_departamento_empleado`),
  FOREIGN KEY (`departamentos_ID_departamento`)    REFERENCES `departamentos` (`ID_departamento`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,
  FOREIGN KEY (`empleados_ID_empleado`)    REFERENCES `empleados` (`ID_empleado`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
);


-- DATOS -- 

INSERT INTO ciudadanos (nombre, apellido_uno, apellido_dos, correo_electronico, documentos, calle, numero, cp_postal, cuidad, provincia, dni)
VALUES
('Ana', 'Gómez', 'Vázquez', 'ana.gomez@example.com', 'DNI12345678', 'Calle Mayor', 12, 28001, 'Madrid', 'Madrid', '12345678A'),
('Luis', 'Pérez', 'Martínez', 'luis.perez@example.com', 'DNI87654321', 'Avenida de la Constitución', 45, 29001, 'Málaga', 'Málaga', '87654321B'),
('Carlos', 'Hernández', 'Sánchez', 'carlos.hernandez@example.com', 'DNI12345679', 'Calle del Mar', 7, 08001, 'Barcelona', 'Barcelona', '12345679C'),
('Laura', 'García', 'Fernández', 'laura.garcia@example.com', 'DNI98765432', 'Calle de la Luna', 22, 46001, 'Valencia', 'Valencia', '98765432D'),
('Pedro', 'Ramírez', 'Jiménez', 'pedro.ramirez@example.com', 'DNI11223344', 'Calle del Sol', 9, 41001, 'Sevilla', 'Sevilla', '11223344E'),
('Marta', 'Martín', 'Morales', 'marta.martin@example.com', 'DNI44332211', 'Calle de los Cedros', 18, 02001, 'Albacete', 'Albacete', '44332211F');

INSERT INTO departamentos (nombre_departamento, fecha_alta_departamento)
VALUES
('Recursos Humanos', '2023-01-15'),
('Finanzas', '2023-02-01'),
('Marketing', '2023-03-10'),
('Tecnología', '2023-04-21'),
('Legal', '2023-05-18'),
('Ventas', '2023-06-30');

INSERT INTO empleados (nombre, correo_electronico, telefono, dni, fecha_nacimiento, fecha_alta)
VALUES
('Ana Ruiz', 'ana.ruiz@example.com', '600123456', '12345678A', '1985-07-12', '2023-01-15'),
('Javier López', 'javier.lopez@example.com', '600987654', '87654321B', '1990-11-22', '2023-02-01'),
('María Fernández', 'maria.fernandez@example.com', '600567890', '12345679C', '1988-03-05', '2023-03-10'),
('Carlos Sánchez', 'carlos.sanchez@example.com', '600654321', '98765432D', '1992-06-14', '2023-04-21'),
('Lucía Gómez', 'lucia.gomez@example.com', '600432109', '11223344E', '1987-09-30', '2023-05-18'),
('Pedro Martínez', 'pedro.martinez@example.com', '600321098', '44332211F', '1983-12-25', '2023-06-30');


INSERT INTO permisos (tipo_permiso, fecha_alta)
VALUES
('Vacaciones', NOW()),
('Permiso de Obras', NOW()),
('Permiso de Evento', NOW()),
('Permisos de Ocupacion de Via pública', NOW()),
('Permiso sin sueldo', NOW()),
('Permiso por estudios', NOW());

INSERT INTO solicitudes (ID_usuario, ID_permiso, fecha_solicitud, estado_solicitud, empleados_ID_empleado)
VALUES
(1, 1, '2024-09-01', 'Pendiente', 1),
(2, 2, '2024-09-02', 'Aprobada', 2),
(3, 3, '2024-09-03', 'Rechazada', 3),
(4, 4, '2024-09-04', 'Pendiente', 4),
(5, 5, '2024-09-05', 'Aprobada', 5),
(6, 6, '2024-09-06', 'Rechazada', 6);

INSERT INTO reportes (tipo_reporte, fecha_generacion, empleados_ID_empleado)
VALUES
('Solicitudes Procesadas', '2024-09-01', 1),
('Tiempo Promedio de Aprobación', '2024-09-02', 2),
('Recaudación por Tasas', '2024-09-03', 3),
('Solicitudes Procesadas', '2024-09-04', 4),
('Tiempo Promedio de Aprobación', '2024-09-05', 5),
('Recaudación por Tasas', '2024-09-06', 6);

INSERT INTO pagos (ID_solicitud, monto_pagado, fecha_pago)
VALUES
(1, 150.00, '2024-09-07'),
(2, 200.00, '2024-09-08'),
(3, 100.00, '2024-09-09'),
(4, 250.00, '2024-09-10'),
(5, 300.00, '2024-09-11'),
(6, 120.00, '2024-09-12');

INSERT INTO citas (ID_usuario, ID_departamento, fecha_cita, hora_cita, motivo, ID_solicitud)
VALUES
(1, 1, '2024-09-15', '10:00:00', 'Consulta sobre permisos', 1),
(2, 2, '2024-09-16', '11:00:00', 'Revisión de documento', 2),
(3, 3, '2024-09-17', '09:00:00', 'Solicitud de información', 3),
(4, 4, '2024-09-18', '14:00:00', 'Entrevista', 4),
(5, 5, '2024-09-19', '15:00:00', 'Asesoramiento legal', 5),
(6, 6, '2024-09-20', '13:00:00', 'Consulta administrativa', 6);

INSERT INTO departamentos_has_empleados (departamentos_ID_departamento, empleados_ID_empleado, fecha_alta)
VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW()),
(4, 4, NOW()),
(5, 5, NOW()),
(6, 6, NOW());


