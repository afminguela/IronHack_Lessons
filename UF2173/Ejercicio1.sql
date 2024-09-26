
CREATE DATABASE IF NOT EXISTS `XYZDB` ;
USE `XYZDB` ;

-- -----------------------------------------------------
-- Table `Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Categoria` VARCHAR(100) NOT NULL,
  `Descripoción_Categoria` TEXT(2000) NULL,
  PRIMARY KEY (`idCategorias`));



-- -----------------------------------------------------
-- Table .`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proveedores` (
  `idProveedores` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Proveedor` VARCHAR(100) NOT NULL,
  `Direccion_Proveedor` TEXT(2000) NULL,
  `Telefono_Proveedor` VARCHAR(45) NULL,
  `Persona_Contacto_proveedor` VARCHAR(50) NULL,
  `Horario_atencion` VARCHAR(20) NULL,
  `Website` VARCHAR(100) NULL,
  `Correo_Proveedor` VARCHAR(100) NULL,
  `Cargo_persona_contacto_Proveedor` VARCHAR(50) NULL,
  PRIMARY KEY (`idProveedores`));


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Productos` (
  `idProductos` INT NOT NULL AUTO_INCREMENT,
  `Nombre_productos` VARCHAR(100) NOT NULL,
  `Descripcion` TEXT(2000) NULL,
  `Precio_unitario` DECIMAL(10,2) NOT NULL,
  `Cantidad_Item` INT NOT NULL,
  `Fecha_Adquisicion` DATE NULL,
  `Fecha_Caducidad` DATE NOT NULL,
  `Fecha_Ultima_Adquisicion` DATETIME NOT NULL,
  `Categorias_idCategorias` INT NOT NULL,
  `Proveedores_idProveedores` INT NOT NULL,
  PRIMARY KEY (`idProductos`),
  INDEX `fk_Productos_Categorias1_idx` (`Categorias_idCategorias` ASC) VISIBLE,
  INDEX `fk_Productos_Proveedores1_idx` (`Proveedores_idProveedores` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Categorias1`
    FOREIGN KEY (`Categorias_idCategorias`)
    REFERENCES `Categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Proveedores1`
    FOREIGN KEY (`Proveedores_idProveedores`)
    REFERENCES `Proveedores` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` ENUM("Administrador", "Gestor", "usuario") NOT NULL,
  PRIMARY KEY (`idRol`));



-- -----------------------------------------------------
-- Table`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT,
  `Nombre_usuario` VARCHAR(50) NOT NULL,
  `Telefono_usuario` VARCHAR(45) NULL,
  `Correo_Usuario` VARCHAR(100) NOT NULL,
  `Hash_PW_Usuario` VARCHAR(300) NOT NULL,
  `Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idusuarios`),
  UNIQUE INDEX `Correo_Usuario_UNIQUE` (`Correo_Usuario` ASC) VISIBLE,
  INDEX `fk_usuarios_Rol_idx` (`Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_Rol`
    FOREIGN KEY (`Rol_idRol`)
    REFERENCES `Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table`Reportes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reportes` (
  `idReportes` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Reporte` DATE NULL,
  `usuarios_idusuario_Autor` INT NOT NULL,
  PRIMARY KEY (`idReportes`),
  INDEX `fk_Reportes_usuarios1_idx` (`usuarios_idusuario_Autor` ASC) VISIBLE,
  CONSTRAINT `fk_Reportes_usuarios1`
    FOREIGN KEY (`usuarios_idusuario_Autor`)
    REFERENCES `usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `mydb`.`Notificaciones_al_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notificaciones_al_usuario` (
  `idNotificaciones_al_usuario` INT NOT NULL auto_increment,
  `Tipo_Notificacion` ENUM("Caducidad cercana", "bajo Stock") NOT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `Productos_idProductos` INT NOT NULL,
  PRIMARY KEY (`idNotificaciones_al_usuario`),
  INDEX `fk_Notificaciones_al_usuario_usuarios1_idx` (`usuarios_idusuarios` ASC) VISIBLE,
  INDEX `fk_Notificaciones_al_usuario_Productos1_idx` (`Productos_idProductos` ASC) VISIBLE,
  CONSTRAINT `fk_Notificaciones_al_usuario_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios`)
    REFERENCES `usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notificaciones_al_usuario_Productos1`
    FOREIGN KEY (`Productos_idProductos`)
    REFERENCES `Productos` (`idProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `mydb`.`Reportes_has_Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reportes_has_Productos` (
  `Reportes_idReportes` INT NOT NULL,
  `Productos_idProductos` INT NOT NULL,
  PRIMARY KEY (`Reportes_idReportes`, `Productos_idProductos`),
  INDEX `fk_Reportes_has_Productos_Productos1_idx` (`Productos_idProductos` ASC) VISIBLE,
  INDEX `fk_Reportes_has_Productos_Reportes1_idx` (`Reportes_idReportes` ASC) VISIBLE,
  CONSTRAINT `fk_Reportes_has_Productos_Reportes1`
    FOREIGN KEY (`Reportes_idReportes`)
    REFERENCES `Reportes` (`idReportes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reportes_has_Productos_Productos1`
    FOREIGN KEY (`Productos_idProductos`)
    REFERENCES `Productos` (`idProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Reportes_has_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reportes_has_usuarios` (
  `Reportes_idReportes` INT NOT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  PRIMARY KEY (`Reportes_idReportes`, `usuarios_idusuarios`),
  INDEX `fk_Reportes_has_usuarios_usuarios1_idx` (`usuarios_idusuarios` ASC) VISIBLE,
  INDEX `fk_Reportes_has_usuarios_Reportes1_idx` (`Reportes_idReportes` ASC) VISIBLE,
  CONSTRAINT `fk_Reportes_has_usuarios_Reportes1`
    FOREIGN KEY (`Reportes_idReportes`)
    REFERENCES `Reportes` (`idReportes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reportes_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios`)
    REFERENCES `usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `Reportes_has_Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reportes_has_Proveedores` (
  `Reportes_idReportes` INT NOT NULL,
  `Proveedores_idProveedores` INT NOT NULL,
  PRIMARY KEY (`Reportes_idReportes`, `Proveedores_idProveedores`),
  INDEX `fk_Reportes_has_Proveedores_Proveedores1_idx` (`Proveedores_idProveedores` ASC) VISIBLE,
  INDEX `fk_Reportes_has_Proveedores_Reportes1_idx` (`Reportes_idReportes` ASC) VISIBLE,
  CONSTRAINT `fk_Reportes_has_Proveedores_Reportes1`
    FOREIGN KEY (`Reportes_idReportes`)
    REFERENCES `Reportes` (`idReportes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reportes_has_Proveedores_Proveedores1`
    FOREIGN KEY (`Proveedores_idProveedores`)
    REFERENCES `Proveedores` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- ------------------------------------------------------
-- Data Relleno DB 
-- ------------------------------------------------------

INSERT INTO Categorias (Nombre_Categoria, Descripoción_Categoria)
VALUES
('Lácteos', 'Productos derivados de la leche, como queso, yogurt y mantequilla'),
('Bebidas', 'Incluye refrescos, jugos, agua mineral y bebidas alcohólicas'),
('Carnes', 'Variedad de carnes frescas y procesadas, como pollo, res y cerdo'),
('Frutas y Verduras', 'Productos frescos como frutas, verduras y hortalizas'),
('Panadería', 'Productos de panadería y pastelería, como pan, bizcochos y bollería'),
('Congelados', 'Alimentos congelados como pizzas, helados, vegetales y carnes');

INSERT INTO Proveedores (Nombre_Proveedor, Direccion_Proveedor, Telefono_Proveedor, Persona_Contacto_proveedor, Horario_atencion, Website, Correo_Proveedor, Cargo_persona_contacto_Proveedor)
VALUES
('Lácteos Frescos S.A.', 'Calle de los Lácteos, 123, Madrid', '912345678', 'Marta López', '08:00 - 18:00', 'www.lacteosfrescos.com', 'contacto@lacteosfrescos.com', 'Gerente de Ventas'),
('Agua Mineral SL', 'Avenida del Agua, 45, Barcelona', '934567890', 'Juan Pérez', '09:00 - 17:00', 'www.aguamineral.com', 'ventas@aguamineral.com', 'Jefe de Distribución'),
('Carnes Selectas', 'Polígono Industrial La Carne, Sevilla', '954123456', 'Carlos Jiménez', '07:00 - 16:00', 'www.carnesselectas.com', 'carlos@carnesselectas.com', 'Encargado de Logística'),
('Frutas del Campo', 'Camino de la Huerta, 78, Valencia', '963258741', 'Ana Fernández', '06:00 - 14:00', 'www.frutasdelcampo.com', 'ana@frutasdelcampo.com', 'Jefa de Compras'),
('Panadería Artesanal', 'Calle del Trigo, 12, Bilbao', '946789012', 'Luis Martínez', '05:00 - 13:00', 'www.panaderiaartesanal.com', 'ventas@panaderiaartesanal.com', 'Gerente'),
('Congelados Premium', 'Carretera del Frío, 98, Zaragoza', '976543210', 'Isabel Gómez', '08:00 - 17:00', 'www.congeladospremium.com', 'isabel@congeladospremium.com', 'Directora de Ventas');

INSERT INTO Productos (Nombre_productos, Descripcion, Precio_unitario, Cantidad_Item, Fecha_Adquisicion, Fecha_Caducidad, Fecha_Ultima_Adquisicion, Categorias_idCategorias, Proveedores_idProveedores)
VALUES
('Leche Entera', 'Leche entera fresca, 1 litro', 1.20, 500, '2024-09-01', '2025-01-01', '2024-08-20', 1, 1),
('Agua Mineral', 'Agua mineral natural, 1.5 litros', 0.90, 800, '2024-09-05', '2025-02-10', '2024-09-01', 2, 2),
('Pechuga de Pollo', 'Pechuga de pollo fresca, 1 kg', 5.50, 200, '2024-09-03', '2024-09-20', '2024-08-30', 3, 3),
('Manzanas Fuji', 'Manzanas Fuji frescas, 1 kg', 3.00, 350, '2024-09-06', '2024-09-12', '2024-09-04', 4, 4),
('Pan Integral', 'Pan integral de trigo, 500 g', 2.30, 150, '2024-09-02', '2024-09-08', '2024-08-28', 5, 5),
('Pizza Congelada', 'Pizza congelada de pepperoni, 400 g', 4.50,250, '2024-09-08', '2025-03-01', '2024-09-05', 6, 6);

INSERT INTO Rol (Nombre_Rol)
VALUES
('Administrador'),
('Gestor'),
('usuario');

INSERT INTO usuarios (Nombre_usuario, Telefono_usuario, Correo_Usuario, Hash_PW_Usuario, Rol_idRol)
VALUES
('admin', '600123456', 'admin@xyz.com', 'hash_pw_admin', 1),
('gestor', '600654321', 'gestor@xyz.com', 'hash_pw_gestor', 2),
('usuario1', '600987654', 'usuario1@xyz.com', 'hash_pw_usuario1', 3),
('usuario2', '600345678', 'usuario2@xyz.com', 'hash_pw_usuario2', 3),
('usuario3', '600876543', 'usuario3@xyz.com', 'hash_pw_usuario3', 3),
('usuario4', '600234567', 'usuario4@xyz.com', 'hash_pw_usuario4', 3);

INSERT INTO Reportes (Fecha_Reporte, usuarios_idusuario_Autor)
VALUES
('2024-09-01', 1),
('2024-09-02', 2),
('2024-09-03', 3),
('2024-09-04', 4),
('2024-09-05', 5),
('2024-09-06', 6);

INSERT INTO Notificaciones_al_usuario (Tipo_Notificacion, usuarios_idusuarios, Productos_idProductos)
VALUES
('Caducidad cercana', 3, 1),
('bajo Stock', 4, 2),
('Caducidad cercana', 5, 3),
('bajo Stock', 6, 4),
('Caducidad cercana', 3, 5),
('bajo Stock', 4, 6);

INSERT INTO Reportes_has_Productos (Reportes_idReportes, Productos_idProductos)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO Reportes_has_usuarios (Reportes_idReportes, usuarios_idusuarios)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO Productos (Nombre_productos, Descripcion, Precio_unitario, Cantidad_Item, Fecha_Adquisicion, Fecha_Caducidad, Fecha_Ultima_Adquisicion, Categorias_idCategorias, Proveedores_idProveedores)
VALUES
('Melon piel de sapo', 'Melon entero de villaconejos', 2.40, 200, '2024-09-01', '2025-02-10', '2024-08-20', 4, 4);