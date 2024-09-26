Create database TIENDA;

use Tienda;

Create table productos (
   id_productos INT not null auto_increment, 
   nombre_Productos VARCHAR(100) not null, 
   marca_Productos VARCHAR(100) not null,
   precio_Productos DECIMAL(10,2) not null,
   descripcion_Productos TEXT(3000),
   Stock_original INT not null,
   Stock_disponible INT not null,
   Fecha_caducidad DATE,
   Fecha_recepcion DATE not null, 
   Codigo_barras VARCHAR(45),
   PRIMARY KEY (id_productos)
   
   );
   
CREATE TABLE categorias (
	id_categorias INT not null auto_increment,
	Nombre_categorias VARCHAR(150) not null,
    Descripcion TEXT(1000) not null, 
    Fecha_creacion DATE not null,
    Fecha_baja DATE,
    Fecha_modificacion DATE,
    Subcategoria boolean, 
    Id_categoria_padre INT,
    Primary Key (id_categorias),
    Foreign key (Id_categoria_padre) REFERENCES categorias(id_categorias)
    );
    
CREATE TABLE Ranking_clientes (
    id_ranking_clientes int auto_increment not null, 
    ranking ENUM('iniciante', 'intermedio', 'avanzado'),
    primary key(id_ranking_clientes)
    );

Create TABLE Roles (
	id_roles INT not null auto_increment, 
    Nombre_rol ENUM('administrador', 'cliente', 'tecnico') not null, 
    Descripcion LONGTEXT,
    primary key (Id_roles)
    );
   
CREATE TABLE Usuarios (
	id_usuarios INT not null auto_increment,
	DNI VARCHAR(12),
	Nombre VARCHAR(150) not null,
	Apellido1 VARCHAR(150) not null,
	Apellido2 VARCHAR(150) not null,
	Telefono VARCHAR(20),
	id_ranking_clientes INT,
	Email VARCHAR(150) not null,
	Hash_password VARCHAR(256) not null,
	Roles_Id_roles INT not null,
	Primary Key (id_usuarios),
    Foreign key (Roles_Id_roles) REFERENCES Roles(id_roles),
    Foreign key (id_ranking_clientes) REFERENCES Ranking_clientes(id_ranking_clientes)
    
    );

CREATE TABLE Direcciones (
	id_direcciones INT not null auto_increment,
	Tipo_direccion ENUM('principal', 'secundaria', 'otras', 'trabajo'),
	Calle VARCHAR(150) not null,
	Numero VARCHAR(45) not null,
	Puerta VARCHAR(45),
	Piso VARCHAR(45),
	Escalera VARCHAR(45), 
    Codigo_postal VARCHAR(45) not null,
    Ciudad VARCHAR(45) not null,
	Provincia VARCHAR(45) not null,
	Pais VARCHAR(45) not null,
    Telefono_referencia VARCHAR(45), 
    Comentarios TEXT(3000) ,
    id_usuarios INT,
    primary Key (id_direcciones),
    Foreign key (id_usuarios) ReFERENCES usuarios(id_usuarios)
    );
   
       
CREATE TABLE Promociones (
	id_promociones INT not null auto_increment,
	Nombre_promociones VARCHAR(150) not null,
	Descripción TEXT(3000) not null,
	Descuentos DECIMAL(10,2) not null,
	fecha_inicio DATETIME,
	fecha_fin DATETIME,
	Estado TINYINT not null,
    tipo ENUM('asociacion', 'fijo', 'porcentaje', 'fidelizacion', 'cantidad'),
	primary key (id_promociones) 
);

CREATE TABLE Carrito (
	Id_carrito INT not null auto_increment,
	Fecha_creacion DATETIME not null, 
    Fecha_finalización DATETIME,
    Fecha_modificacion DATETIME,
    Total_items INT,
	Total_carrito DECIMAL(10,2),
    Id_cliente INT,
    primary key (id_Carrito),
    Foreign key (id_Cliente) ReFERENCES usuarios(id_usuarios)

);

CREATE TABLE Pedidos (
	id_pedidos INT not null auto_increment, 
	Descripcion LONGTEXT not null,
	Estado_pedido ENUM('creado', 'en proceso', 'cancelado', 'detenido', 'enviado', 'entregado') not null,
	Fecha_creacion TIMESTAMP not null,
	Fecha_en_proceso DATETIME ,
	Fecha_cancelado DATETIME,
	Fecha_detenido DATETIME,
	Fecha_enviado DATETIME,
	Fecha_entrega DATETIME,
	Total DECIMAL(6,2) not null,
	id_usuarios INT not null,
	id_carrito INT not null,
	id_direccion INT not null,
    primary key (id_pedidos),
    Foreign key (id_usuarios) ReFERENCES usuarios(id_usuarios),
    Foreign key (id_carrito) ReFERENCES carrito(id_carrito),
    Foreign key (id_direccion) ReFERENCES direcciones(id_direcciones)



);

CREATE TABLE Metodos_de_pago (
	id_metodos_de_pago INT not null auto_increment,
    Tipo_de_pago ENUM('transferencia', 'tarjeto de credito', 'paypal', 'klarna', 'google pay', 'apple pay') not null,
    Fecha_añadido DATETIME not null,
    Fecha_eliminado DATETIME,
    primary key (id_metodos_de_pago)
    );
	
CREATE TABLE Tarjetas (
	id_tarjeta INT not null auto_increment,
	Num_tarjeta INT,
	Fecha_mes INT,
	Fecha_año INT,
	Hash_seguridad VARCHAR(256),
    id_usuarios INT not null,
	primary key (id_tarjeta),
    Foreign key (id_usuarios) ReFERENCES usuarios(id_usuarios)
    );
    
CREATE TABLE Reportes (
	id_reportes INT not null auto_increment,
    Nombre_reporte VARCHAR(50) not null,
    Descripcion LONGTEXT not null,
	Fecha DATETIME not null,
	URL_reporte VARCHAR(100),
    id_usuario INT not null,
	primary key (id_reportes),
    Foreign key (id_usuario) ReFERENCES usuarios(id_usuarios)
    );

-- Tablas intermedias --

CREATE TABLE Carrito_has_productos (
	id_carrito INT not null,
	id_productos INT not null,
	Fecha_creacion DATETIME not null,
    Cantidad_producto DECIMAL(10,3) not null,
    Precio_total DECIMAL(10,2) not null,
    id_promociones INT,
    primary key (id_carrito , id_productos ),
    Foreign Key (id_carrito) REFERENCEs carrito(id_carrito),
    Foreign Key (id_productos) REFERENCEs productos(id_productos),
    Foreign Key (id_promociones) REFERENCEs promociones(id_promociones)
    );
    

CREATE TABLE Productos_has_Categorias (
	id_productos INT not null,
	id_categorias INT not null,
    primary key (id_categorias , id_productos ),
    Foreign Key (id_categorias) REFERENCEs categorias(id_categorias),
    Foreign Key (id_productos) REFERENCEs productos(id_productos)
);
CREATE TABLE Productos_has_Promociones (
	id_promociones_productos INT not null auto_increment,
    id_productos INT not null,
    id_promociones INT not null,
    Fecha_inicio DATETIME not null,
    Fecha_fin DATETIME,
    primary key ( id_promociones_productos),
    Foreign Key (id_promociones) REFERENCEs promociones(id_promociones),
	Foreign Key (id_productos) REFERENCEs productos(id_productos)
    );
CREATE TABLE Promociones_has_Rank_clientes (
	id_promocion_usuario INT not null auto_increment,
    id_promociones INT not null, 
    id_ranking_clientes INT  not null,
    Fecha_inicio DATETIME not null,
	Fecha_fin DATETIME,
	primary key (id_promocion_usuario),
    Foreign Key (id_promociones) REFERENCEs promociones(id_promociones),
	Foreign Key (id_ranking_clientes) REFERENCEs Ranking_clientes(id_ranking_clientes)
    );


CREATE TABLE Usuarios_has_Metodos_de_pago (
	id_metodos_de_pago INT not null,
	id_pedidos INT not null,
	id_usuarios INT not null,
	id_tarjeta INT,
	primary key (id_metodos_de_pago, id_pedidos, id_usuarios),
    Foreign Key (id_pedidos) REFERENCEs pedidos(id_pedidos),
	Foreign Key (id_usuarios) REFERENCEs usuarios(id_usuarios),
    Foreign Key (id_tarjeta) REFERENCEs tarjetas(id_tarjeta),
    Foreign Key (id_metodos_de_pago) REFERENCEs metodos_de_pago(id_metodos_de_pago)
);