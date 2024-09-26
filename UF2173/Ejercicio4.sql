CREATE DATABASE IF NOT EXISTS Centro_Convenciones;
Use Centro_Convenciones;

-- Tablas Unicas--
CREATE TABLE `Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `email` VARCHAR(75) NOT NULL,
  `telefono` INT NOT NULL,
  `hash_contraseña` VARCHAR(256) NOT NULL,
  `dni` VARCHAR(15) NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_baja` DATETIME NULL,
  `fecha_modificacion` DATETIME NULL,
  PRIMARY KEY (`idUsuarios`)
  );

CREATE TABLE `Salas` (
  `idSalas` INT NOT NULL AUTO_INCREMENT,
  `ubicacion` VARCHAR(50) NOT NULL,
  `capacidad_maxima` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_baja` DATETIME NULL,
  `estado` ENUM('OCUPADO', 'LIBRE') NOT NULL,
  PRIMARY KEY (`idSalas`)
  );
  
CREATE TABLE `Equipamientos` (
  `idEquipamientos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_baja` DATETIME NULL,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `num_serie` VARCHAR(45) NOT NULL,
  `tipo_equipo` VARCHAR(45) NOT NULL,
  `disponibilidad` TINYINT NOT NULL,
  `estado` ENUM('BUEN_ESTADO', 'MAL_ESTADO', 'INTERMEDIO', 'ROTO') NOT NULL,
  PRIMARY KEY (`idEquipamientos`)
  );
  
CREATE TABLE `Roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` ENUM('USUARIO', 'ADMIN') NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_baja` DATETIME NULL,
  PRIMARY KEY (`id`)
  );

CREATE TABLE `Reportes` (
  `idReportes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `pdf` VARCHAR(256) NOT NULL,
  `fecha_generacion` DATETIME NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `idUsuarios` INT NULL,
  PRIMARY KEY (`idReportes`),
  FOREIGN KEY (`idUsuarios`)    REFERENCES `Usuarios` (`idUsuarios`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
);

CREATE TABLE `Reservas` (
  `idReservas` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `fecha_cancelacion` DATETIME NULL,
  `comentario` TEXT(1000) NULL,
  `idUsuarios` INT NOT NULL,
  `Salas_id` INT NOT NULL,
  PRIMARY KEY (`idReservas`),
	FOREIGN KEY (`idUsuarios`)    REFERENCES `Usuarios` (`idUsuarios`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,
    FOREIGN KEY (`Salas_id`)    REFERENCES `Salas` (`idSalas`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
    );

CREATE TABLE `Recordatorios` (
  `idRecordatorios` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `mensaje` TEXT(1000) NOT NULL,
  `idReservas` INT NOT NULL,
  PRIMARY KEY (`idRecordatorios`),
  FOREIGN KEY (`idReservas`)    REFERENCES `Reservas` (`idReservas`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
  );



  
-- Tablas mixtas --

CREATE TABLE `Roles_has_Usuarios` (
  `Roles_id` INT NOT NULL,
  `Usuarios_idUsuarios` INT NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_baja` DATETIME NULL,
  PRIMARY KEY (`Roles_id`, `Usuarios_idUsuarios`),
  FOREIGN KEY (`Roles_id`)    REFERENCES `Roles` (`id`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,
  FOREIGN KEY (`Usuarios_idUsuarios`)   REFERENCES `Usuarios` (`idUsuarios`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
  );

CREATE TABLE `Reportes_has_Salas` (
  `idReportes` INT NOT NULL,
  `Salas_id` INT NOT NULL,
  `tasa_ocupacion` DECIMAL(5,2) NOT NULL,
  `frecuencia_uso` INT NOT NULL,
  `problemas_reportados` TEXT(5000) NULL,
  PRIMARY KEY (`idReportes`, `Salas_id`),
  FOREIGN KEY (`idReportes`)    REFERENCES `Reportes` (`idReportes`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,
  FOREIGN KEY (`Salas_id`)    REFERENCES `Salas` (`idSalas`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
    );

CREATE TABLE `Equipamientos_Salas` (
  `id_equipo_sala` INT NOT NULL,
  `idEquipamientos` INT NOT NULL,
  `Salas_id` INT NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_baja` DATETIME NULL,
  PRIMARY KEY (`id_equipo_sala`),
  FOREIGN KEY (`idEquipamientos`)    REFERENCES `Equipamientos` (`idEquipamientos`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,
  FOREIGN KEY (`Salas_id`)    REFERENCES `Salas` (`idSalas`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
  );
  
CREATE TABLE `Reservas_Equipamientos` (
  `Reservas_idReservas` INT NOT NULL,
  `Equipamientos_idEquipamientos` INT NOT NULL,
  PRIMARY KEY (`Reservas_idReservas`, `Equipamientos_idEquipamientos`),
  FOREIGN KEY (`Reservas_idReservas`)    REFERENCES `Reservas` (`idReservas`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,
  FOREIGN KEY (`Equipamientos_idEquipamientos`)    REFERENCES `Equipamientos` (`idEquipamientos`)    ON DELETE NO ACTION    ON UPDATE NO ACTION
  );


  
-- Luego rellenar y hacer scripts de querys --

INSERT INTO Usuarios (nombre, apellido1, apellido2, email, telefono, hash_contraseña, dni, fecha_alta)
VALUES
('Juan', 'Pérez', 'García', 'juan.perez@example.com', 600123456, 'hashed_password_1', '12345678A', NOW()),
('Ana', 'Martínez', 'López', 'ana.martinez@example.com', 600234567, 'hashed_password_2', '23456789B', NOW()),
('Luis', 'Gómez', 'Sánchez', 'luis.gomez@example.com', 600345678, 'hashed_password_3', '34567890C', NOW()),
('Maria', 'Fernández', 'Ruiz', 'maria.fernandez@example.com', 600456789, 'hashed_password_4', '45678901D', NOW()),
('Pedro', 'Jiménez', 'Hernández', 'pedro.jimenez@example.com', 600567890, 'hashed_password_5', '56789012E', NOW()),
('Laura', 'García', 'Alonso', 'laura.garcia@example.com', 600678901, 'hashed_password_6', '67890123F', NOW()),
('Javier', 'Moreno', 'Moya', 'javier.moreno@example.com', 600789012, 'hashed_password_7', '78901234G', NOW()),
('Carmen', 'Romero', 'Cano', 'carmen.romero@example.com', 600890123, 'hashed_password_8', '89012345H', NOW()),
('Fernando', 'Torres', 'Vera', 'fernando.torres@example.com', 600901234, 'hashed_password_9', '90123456I', NOW()),
('Isabel', 'Cruz', 'Pacheco', 'isabel.cruz@example.com', 600912345, 'hashed_password_10', '01234567J', NOW());

INSERT INTO Salas (ubicacion, capacidad_maxima, nombre, fecha_alta, estado)
VALUES
('Planta 1', 50, 'Sala A', NOW(), 'LIBRE'),
('Planta 1', 100, 'Sala B', NOW(), 'LIBRE'),
('Planta 2', 75, 'Sala C', NOW(), 'OCUPADO'),
('Planta 2', 150, 'Sala D', NOW(), 'LIBRE'),
('Planta 3', 200, 'Sala E', NOW(), 'OCUPADO'),
('Planta 3', 30, 'Sala F', NOW(), 'LIBRE'),
('Planta 4', 80, 'Sala G', NOW(), 'LIBRE'),
('Planta 4', 120, 'Sala H', NOW(), 'OCUPADO'),
('Planta 5', 60, 'Sala I', NOW(), 'LIBRE'),
('Planta 5', 90, 'Sala J', NOW(), 'LIBRE');

INSERT INTO Equipamientos (nombre, descripcion, marca, modelo, num_serie, tipo_equipo, disponibilidad, estado, fecha_alta)
VALUES
('Proyector', 'Proyector HD', 'Sony', 'VPL-HW45ES', 'SN123456', 'Proyector', 10, 'BUEN_ESTADO', NOW()),
('Micrófono', 'Micrófono inalámbrico', 'Sennheiser', 'EW 100 G4', 'SN654321', 'Audio', 15, 'BUEN_ESTADO', NOW()),
('Pantalla', 'Pantalla de proyección', 'Epson', 'ELP-PDC06', 'SN789012', 'Pantalla', 20, 'INTERMEDIO', NOW()),
('Laptop', 'Laptop para presentaciones', 'Dell', 'XPS 13', 'SN345678', 'Computadora', 8, 'BUEN_ESTADO', NOW()),
('Mesa de sonido', 'Consola de audio', 'Yamaha', 'MG10XU', 'SN901234', 'Audio', 5, 'MAL_ESTADO', NOW()),
('Cámara', 'Cámara de vídeo', 'Canon', 'VIXIA HF G50', 'SN567890', 'Video', 7, 'BUEN_ESTADO', NOW()),
('Altavoces', 'Altavoces de sala', 'JBL', 'EON615', 'SN234567', 'Audio', 12, 'INTERMEDIO', NOW()),
('Luces LED', 'Luces para eventos', 'Philips', 'Hue White', 'SN345678', 'Iluminación', 25, 'BUEN_ESTADO', NOW()),
('Grabadora', 'Grabadora de audio', 'Zoom', 'H6', 'SN678901', 'Audio', 10, 'ROTO', NOW()),
('Microscopio', 'Microscopio digital', 'Leica', 'DM750', 'SN890123', 'Instrumento', 4, 'BUEN_ESTADO', NOW());

INSERT INTO Roles (nombre, fecha_alta)
VALUES
('USUARIO', NOW()),
('ADMIN', NOW());

INSERT INTO Reportes (nombre, pdf, fecha_generacion, fecha_inicio, fecha_fin, idUsuarios)
VALUES
('Reporte Mensual', 'reporte1.pdf', NOW(), '2024-08-01', '2024-08-31', 1),
('Reporte Anual', 'reporte2.pdf', NOW(), '2023-09-01', '2024-08-31', 2),
('Reporte de Ocupación', 'reporte3.pdf', NOW(), '2024-01-01', '2024-06-30', 3),
('Reporte de Equipos', 'reporte4.pdf', NOW(), '2024-07-01', '2024-09-14', 4),
('Reporte de Reservas', 'reporte5.pdf', NOW(), '2024-01-01', '2024-09-14', 5),
('Reporte de Problemas', 'reporte6.pdf', NOW(), '2024-05-01', '2024-09-14', 6),
('Reporte de Finanzas', 'reporte7.pdf', NOW(), '2024-01-01', '2024-09-14', 7),
('Reporte de Clientes', 'reporte8.pdf', NOW(), '2024-03-01', '2024-09-14', 8),
('Reporte de Mantenimiento', 'reporte9.pdf', NOW(), '2024-06-01', '2024-09-14', 9),
('Reporte de Eventos', 'reporte10.pdf', NOW(), '2024-02-01', '2024-09-14', 10);

INSERT INTO Reservas (fecha, fecha_inicio, fecha_fin, comentario, idUsuarios, Salas_id)
VALUES
(NOW(), '2024-09-15 09:00:00', '2024-09-15 11:00:00', 'Reunión de equipo', 1, 1),
(NOW(), '2024-09-16 14:00:00', '2024-09-16 16:00:00', 'Presentación del producto', 2, 2),
(NOW(), '2024-09-17 10:00:00', '2024-09-17 12:00:00', 'Capacitación', 3, 3),
(NOW(), '2024-09-18 11:00:00', '2024-09-18 13:00:00', 'Evento de networking', 4, 4),
(NOW(), '2024-09-19 15:00:00', '2024-09-19 17:00:00', 'Seminario', 5, 5),
(NOW(), '2024-09-20 09:00:00', '2024-09-20 11:00:00', 'Taller de formación', 6, 6),
(NOW(), '2024-09-21 13:00:00', '2024-09-21 15:00:00', 'Conferencia', 7, 7),
(NOW(), '2024-09-22 08:00:00', '2024-09-22 10:00:00', 'Jornada de puertas abiertas', 8, 8),
(NOW(), '2024-09-23 12:00:00', '2024-09-23 14:00:00', 'Reunión de clientes', 9, 9),
(NOW(), '2024-09-24 16:00:00', '2024-09-24 18:00:00', 'Evento de lanzamiento', 10, 10);

INSERT INTO Recordatorios (fecha, mensaje, idReservas)
VALUES
(NOW(), 'Revisar configuración del proyector', 1),
(NOW(), 'Confirmar asistencia para la presentación', 2),
(NOW(), 'Verificar equipos de capacitación', 3),
(NOW(), 'Preparar material para el networking', 4),
(NOW(), 'Asegurarse de que el seminario esté bien organizado', 5),
(NOW(), 'Hacer pruebas de audio para el taller', 6),
(NOW(), 'Revisar lista de conferenciantes', 7),
(NOW(), 'Organizar la jornada de puertas abiertas', 8),
(NOW(), 'Confirmar detalles de la reunión de clientes', 9),
(NOW(), 'Revisar logística para el evento de lanzamiento', 10);

INSERT INTO Roles_has_Usuarios (Roles_id, Usuarios_idUsuarios, fecha_alta)
VALUES
(1, 1, NOW()),
(1, 2, NOW()),
(1, 3, NOW()),
(1, 4, NOW()),
(1, 5, NOW()),
(1, 6, NOW()),
(2, 7, NOW()),
(2, 8, NOW()),
(2, 9, NOW()),
(2, 10, NOW());

INSERT INTO Reportes_has_Salas (idReportes, Salas_id, tasa_ocupacion, frecuencia_uso, problemas_reportados)
VALUES
(1, 1, 0.75, 12, 'Sin problemas reportados'),
(1, 2, 0.60, 10, 'Problemas menores de iluminación'),
(2, 3, 0.85, 15, 'Sistema de sonido en mal estado'),
(2, 4, 0.50, 8, 'Sin problemas reportados'),
(3, 5, 0.90, 20, 'Frecuente uso de equipo audiovisual'),
(3, 6, 0.40, 5, 'Sin problemas reportados'),
(4, 7, 0.70, 14, 'Problemas menores en la climatización'),
(4, 8, 0.65, 13, 'Sin problemas reportados'),
(5, 9, 0.80, 18, 'Uso intensivo de proyectores'),
(5, 10, 0.55, 9, 'Problemas en la conexión de audio');

INSERT INTO Equipamientos_Salas (id_equipo_sala, idEquipamientos, Salas_id, fecha_alta)
VALUES
(1, 1, 1, NOW()),
(2, 2, 2, NOW()),
(3, 3, 3, NOW()),
(4, 4, 4, NOW()),
(5, 5, 5, NOW()),
(6, 6, 6, NOW()),
(7, 7, 7, NOW()),
(8, 8, 8, NOW()),
(9, 9, 9, NOW()),
(10, 10, 10, NOW());

INSERT INTO Reservas_Equipamientos (Reservas_idReservas, Equipamientos_idEquipamientos)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10);
