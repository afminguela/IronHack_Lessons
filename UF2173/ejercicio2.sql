create database ESCUELA;

use ESCUELA;


	create table Materiales (
		idMateriales INT auto_increment unique primary key,
        Titulo varchar(100),
        Descripcion text(3000),
        tipo enum("Video","Audio","Documento","Url"),
        Disponibilidad bool,
        Fecha_Alta datetime,
        Obsolescencia bool
        );
        
	create table Cursos (
		idCursos INT auto_increment unique primary key,
        Nombre varchar(100),
        Descripcion text(3000),
        Fecha_inicio_curso date,
        Fecha_fin_curso date,
        Aforo int,
        Sincronicidad bool
        );
        
	
    create table Estudiante (
		idEstudiante INT auto_increment unique primary key,
        Nombre varchar(100),
        correo varchar(100),
        telefono varchar(100),
        direccion varchar(100),
        hash_PW varchar(256),
        Fecha_Alta datetime,
        Fecha_Baja datetime,
        Fecha_Modificacion datetime
        );
        
	create table Profesor (
		idprofesor INT auto_increment unique primary key,
        Nombre varchar(100),
        correo varchar(100),
        telefono varchar(100),
        direccion varchar(100),
        hash_PW varchar(256),
        Fecha_Alta_Contrato datetime,
        Fecha_Baja datetime,
        Fecha_Modificacion datetime
        );
        
	create table Horarios (
		idHorarios INT auto_increment unique primary key,
        dia_semana enum("Lunes","Martes","Miercoles","jueves","viernes"),
        Hora_inicio	time,
        Hora_final time
        );
       
    create table Roles (
		idRoles int primary key not null auto_increment,
        Estudiante boolean,
        Profesor boolean,
        Administrador boolean,
        Tutor boolean,
        Revisor_tareas boolean
        );
        
	create table Tareas (
		idTareas INT auto_increment unique primary key,
        Titulo varchar(100) not null,
        Descripcion text(3000),
        tipo enum("Lectura", "Redaccion", "Problema_Resolver", "Examen_Online", "Presentacion"),
        Fecha_Creación datetime not null,
        Fecha_muerte datetime not null,
        Fecha_Modificacion datetime not null,
        ProfesorCreador_IdProfesor int not null,
        FOREIGN KEY (ProfesorCreador_IdProfesor) REFERENCES Profesor(idProfesor) ON Update cascade on delete cascade
        );
    
    CREATE TABLE calificaciones (
		idCalificaciones INT primary key auto_increment not null, 
		Notas DECIMAL(4,2) not null,
		Profesores_idProfesores INT not null,
		Feedback TEXT(3000) not null,
		Fecha_Calificación DATETIME,
		Tipo_calificación ENUM("Tarea","Curso")
        );
	
    CREATE TABLE Cursos_has_tareas (
		Cursos_idCursos int, 
		Tareas_idTareas int,
		FOREIGN KEY (Tareas_idTareas) REFERENCES Tareas(IdTareas) on update cascade on delete cascade,
		FOREIGN KEY (Cursos_idCursos) REFERENCES Cursos(idCursos) on update cascade on delete cascade
		);

      CREATE TABLE Autores (
		IdAutores int not null auto_increment,
        Estudiante_IdEstudiante int,
        Profesor_IdProfesor Int,
        primary key (IdAutores),
        FOREIGN KEY (profesor_IdProfesor) REFERENCES Profesor(idProfesor) ON Update cascade on delete cascade,
		FOREIGN KEY (estudiante_idEstudiante) REFERENCES Estudiante(idEstudiante) ON Update cascade on delete cascade
        );
        
    CREATE TABLE Foros (
		idForos INT not null auto_increment,
        Nombre_Foro VARCHAR(200) not null,
        Descripcion_Foro TEXT(2000),
        Fecha_Creacion_Foro DATETIME not null,
        Fecha_Ultimo_comentario_Foro DATETIME(6) not null,
        Cantidad_Mensajes_foro INT,
        ID_Autor_Foro INT not null,
        primary key(idForos),
        FOREIGN KEY (ID_Autor_foro) REFERENCES Autores(idAutores)ON Update cascade on delete cascade 
        );
	
	
	CREATE TABLE Mensajes (
		idMensajes INT not null auto_increment,
		Titulo_Mensaje VARCHAR(100) not null,
		Contenido_Mensaje TEXT(3000),
		Fecha_creacion_mensaje DATETIME,
		EsReplica boolean not null,
		ID_Autor_Mensaje INT not null,
		id_Mensaje_padre INT,
		Foros_idForos INT not null,
		primary key(idMensajes, Foros_idForos), 
        FOREIGN KEY (ID_Autor_Mensaje) REFERENCES Autores(idAutores)ON Update cascade on delete cascade,
		FOREIGN KEY (id_Mensaje_padre, Foros_idForos) REFERENCES Mensajes(idMensajes, Foros_idForos) ON Update cascade on delete cascade ,
        FOREIGN KEY (Foros_idForos) REFERENCES Foros(idForos) ON Update cascade on delete cascade
        );
    
  
        
	create table Materiales_has_cursos (
		materiales_idMateriales int not null,
        Cursos_idCursos int not null,
        Fecha_Vinculacion datetime not null,
        Fecha_asignacion_a_curso datetime not null,
        Humano_Vinculador int not null,
        primary key ( materiales_idMateriales, Cursos_idCursos),
        FOREIGN KEY (Humano_Vinculador) REFERENCES Profesor(idProfesor)ON Update cascade on delete cascade,
        FOREIGN KEY (Materiales_idMateriales) REFERENCES Materiales(idMateriales) ON Update cascade on delete cascade,
        FOREIGN KEY (Cursos_idCursos) REFERENCES Cursos(idCursos) ON Update cascade on delete cascade
        );
        
    CREATE TABLE Cursos_has_profesores (
		cursos_idCursos int not	null, 
        profesor_IdProfesor int not null, 
        Fecha_alta_profesor datetime not null,
        Fecha_baja_profesor datetime not null,
        Roles_idRoles int not null,
        primary key (cursos_idCursos,profesor_IdProfesor),
        FOREIGN KEY (Cursos_idCursos) REFERENCES Cursos(idCursos) ON Update cascade on delete cascade,
        FOREIGN KEY (profesor_IdProfesor) REFERENCES Profesor(idProfesor) ON Update cascade on delete cascade,
        FOREIGN KEY (Roles_idRoles) REFERENCES Roles(idRoles) ON Update cascade on delete cascade
        );
        
	CREATE TABLE Cursos_has_Estudiantes (
		cursos_idCursos int not	null,
        estudiante_idEstudiante int not null,
        Fecha_alta_profesor datetime not null,
        Fecha_baja_profesor datetime not null,
        calificaciones_idCalificaciones int not null,
        primary key (cursos_idCursos, estudiante_idEstudiante),
        FOREIGN KEY (cursos_idCursos) REFERENCES cursos(idCursos) ON Update cascade on delete cascade,
        FOREIGN KEY (estudiante_idEstudiante) REFERENCES Estudiante(idEstudiante) ON Update cascade on delete cascade,
        FOREIGN KEY (calificaciones_idCalificaciones) REFERENCES calificaciones(idCalificaciones) ON Update cascade on delete cascade 
		);
	
	CREATE TABLE Estudiantes_has_tareas (
		Tareas_idTareas int not	null,
        estudiante_idEstudiante int not null,
        Estado enum("Entregada","pendiente","Corregida") not null,
        Fecha_Entrega datetime not null,
        calificaciones_idCalificaciones int not null,
        primary key (Tareas_idTareas, estudiante_idEstudiante, calificaciones_IdCalificaciones),
        FOREIGN KEY (Tareas_idTareas) REFERENCES Tareas(idTareas) ON Update cascade on delete cascade,
        FOREIGN KEY (estudiante_idEstudiante) REFERENCES Estudiante(idEstudiante) ON Update cascade on delete cascade,
        FOREIGN KEY (calificaciones_idCalificaciones) REFERENCES calificaciones(idCalificaciones) ON Update cascade on delete cascade 
		);
    
    CREATE TABLE Tareas_has_Profesores_Revisores (
			Tareas_idTareas INT not null,
            Profesor_revisor_idProfesor INT not null, 
            primary key (Tareas_idTareas, Profesor_revisor_idProfesor),
            FOREIGN KEY (Tareas_idTareas) REFERENCES Tareas(idTareas) ON Update cascade on delete cascade,
            FOREIGN KEY (profesor_revisor_IdProfesor) REFERENCES Profesor(idProfesor) ON Update cascade on delete cascade
            );
            
	CREATE TABLE Cursos_has_foros (
		Cursos_idCursos int not null,
        Foros_IdForos int not null,
        primary	key	(Cursos_idCursos, Foros_IdForos),
		FOREIGN KEY (Cursos_idCursos) REFERENCES Cursos(idCursos) ON Update cascade on delete cascade,
        FOREIGN KEY (Foros_IdForos) REFERENCES Foros(idForos) ON Update cascade on delete cascade
        );

  
    
        
	INSERT INTO Materiales (Titulo, Descripcion, tipo, Disponibilidad, Fecha_Alta, Obsolescencia)
VALUES 
('Guía de Introducción a Agile', 'Documento que detalla los principios y valores del método Agile, incluyendo casos prácticos y ejercicios.', 'Documento', true, '2023-01-15 10:30:00', false),
('Video Tutorial Scrum', 'Video educativo sobre los fundamentos de Scrum, roles y eventos clave dentro de un equipo Scrum.', 'Video', true, '2022-11-20 14:45:00', false),
('Podcast sobre Metodologías Lean', 'Audio que profundiza en las metodologías Lean y su aplicación en la mejora continua de procesos empresariales.', 'Audio', true, '2023-03-05 09:15:00', false),
('Documentación de Kaizen', 'Documento que cubre los fundamentos de la mejora continua Kaizen, con ejemplos aplicados a diferentes industrias.', 'Documento', true, '2021-08-30 11:20:00', true),
('Webinar sobre UX y Sostenibilidad', 'URL de un webinar que explora la intersección entre el diseño de experiencia de usuario y la sostenibilidad en el desarrollo de productos digitales.', 'Url', true, '2023-06-12 17:00:00', false),
('Guía de Buenas Prácticas en QA', 'Documento que proporciona un conjunto de buenas prácticas para la ejecución de pruebas de calidad en productos de software.', 'Documento', true, '2023-02-25 08:40:00', false),
('Video Tutorial de Pruebas Automatizadas', 'Video que enseña cómo realizar pruebas automatizadas utilizando herramientas modernas, con ejemplos prácticos.', 'Video', false, '2020-09-13 16:25:00', true),
('Curso de Introducción a Product Management', 'Audio que cubre los conceptos básicos de la gestión de productos, dirigido a nuevos gerentes de productos y emprendedores.', 'Audio', true, '2021-12-01 12:10:00', true),
('Documentación Técnica sobre APIs', 'Documento técnico detallado que explica cómo diseñar, desarrollar y documentar APIs RESTful.', 'Documento', true, '2022-10-18 14:00:00', false),
('Sitio Web sobre el Futuro de la Innovación Digital', 'URL de un sitio web dedicado a la exploración de tendencias emergentes en la tecnología digital y la innovación.', 'Url', true, '2023-04-22 19:30:00', false);
        

 INSERT INTO Cursos (Nombre, Descripcion, Fecha_inicio_curso, Fecha_fin_curso, Aforo, Sincronicidad)
VALUES
('Curso de Metodologías Ágiles', 'Curso intensivo que cubre las principales metodologías ágiles como Scrum, Kanban y Lean, con ejemplos prácticos.', '2023-10-01', '2023-12-01', 30, true),
('Introducción a UX Design', 'Curso sobre los fundamentos del diseño de experiencia de usuario, centrado en la creación de interfaces intuitivas y accesibles.', '2024-01-15', '2024-03-15', 25, false),
('Desarrollo de APIs RESTful', 'Aprende a desarrollar APIs robustas con REST, buenas prácticas de diseño y cómo asegurar la escalabilidad y mantenimiento del código.', '2023-11-05', '2024-01-05', 20, true),
('Gestión de Proyectos con Scrum', 'Curso avanzado para la implementación y gestión de proyectos utilizando el marco de trabajo Scrum en equipos ágiles.', '2023-09-01', '2023-11-01', 40, false),
('Lean y Mejora Continua', 'Un enfoque profundo sobre la filosofía Lean y cómo aplicarla para mejorar procesos de negocio en diversas industrias.', '2024-02-10', '2024-04-10', 35, true),
('Introducción a la Programación Python', 'Curso básico de Python orientado a personas sin experiencia en programación, con proyectos prácticos y tutorización.', '2023-10-20', '2023-12-20', 50, true),
('Optimización de Procesos con Kaizen', 'Curso diseñado para enseñar la implementación de la mejora continua utilizando Kaizen en empresas y startups.', '2023-11-01', '2024-01-01', 15, false),
('Diseño Sostenible en Productos Digitales', 'Curso especializado en la creación de productos digitales con un enfoque en la sostenibilidad y reducción del impacto ambiental.', '2024-01-25', '2024-03-25', 30, false),
('Automatización de Pruebas QA', 'Aprende a automatizar pruebas de software utilizando herramientas modernas, mejorando la eficiencia en el ciclo de desarrollo.', '2023-12-01', '2024-02-01', 20, true),
('Product Management: De la Idea a la Ejecución', 'Curso orientado a product managers que desean aprender a desarrollar productos desde la conceptualización hasta el lanzamiento.', '2023-10-05', '2023-12-05', 45, false);       
	
        
INSERT INTO Estudiante (Nombre, correo, telefono, direccion, hash_PW, Fecha_Alta, Fecha_Baja, Fecha_Modificacion)
VALUES
('Ana García', 'ana.garcia@email.com', '+34 600 123 456', 'Calle Falsa 123, Madrid', '5f4dcc3b5aa765d61d8327deb882cf99', '2023-01-15 10:30:00', NULL, '2023-09-01 12:00:00'),
('Carlos Martínez', 'carlos.martinez@email.com', '+34 611 987 654', 'Avenida de la Paz 45, Barcelona', 'e99a18c428cb38d5f260853678922e03', '2023-03-22 09:20:00', NULL, '2023-09-05 14:00:00'),
('Lucía Fernández', 'lucia.fernandez@email.com', '+34 622 555 987', 'Calle Luna 78, Valencia', '098f6bcd4621d373cade4e832627b4f6', '2023-05-10 15:00:00', NULL, '2023-08-20 11:15:00'),
('David Gómez', 'david.gomez@email.com', '+34 633 234 789', 'Paseo del Mar 21, Sevilla', 'd8578edf8458ce06fbc5bb76a58c5ca4', '2022-12-05 11:45:00', '2023-07-01 09:30:00', '2023-06-25 10:00:00'),
('María López', 'maria.lopez@email.com', '+34 644 987 321', 'Plaza Mayor 7, Zaragoza', '5f4dcc3b5aa765d61d8327deb882cf99', '2023-06-12 08:50:00', NULL, '2023-09-02 13:20:00'),
('Javier Ruiz', 'javier.ruiz@email.com', '+34 655 123 654', 'Calle del Sol 99, Málaga', '25f9e794323b453885f5181f1b624d0b', '2023-02-20 16:15:00', NULL, '2023-09-10 12:45:00'),
('Sara Pérez', 'sara.perez@email.com', '+34 666 234 876', 'Avenida de la Estrella 54, Bilbao', '6cb75f652a9b52798eb6cf2201057c73', '2023-07-25 10:10:00', NULL, '2023-09-12 09:50:00'),
('Juan Torres', 'juan.torres@email.com', '+34 677 345 098', 'Calle Verde 88, Alicante', '098f6bcd4621d373cade4e832627b4f6', '2023-04-15 11:30:00', '2023-08-10 17:30:00', '2023-07-30 14:00:00'),
('Paula Ramírez', 'paula.ramirez@email.com', '+34 688 456 543', 'Calle Azul 32, Granada', 'e99a18c428cb38d5f260853678922e03', '2023-08-05 13:40:00', NULL, '2023-09-14 15:10:00'),
('Roberto Sánchez', 'roberto.sanchez@email.com', '+34 699 567 321', 'Avenida del Río 67, Córdoba', '5f4dcc3b5aa765d61d8327deb882cf99', '2023-09-01 10:00:00', NULL, '2023-09-15 08:30:00');	
    
	
 INSERT INTO Profesor (Nombre, correo, telefono, direccion, hash_PW, Fecha_Alta_Contrato, Fecha_Baja, Fecha_Modificacion)
VALUES
('Pedro Alvarez', 'pedro.alvarez@email.com', '+34 600 123 789', 'Calle Principal 123, Madrid', '5f4dcc3b5aa765d61d8327deb882cf99', '2022-01-10 09:00:00', NULL, '2023-08-15 10:30:00'),
('Laura Gómez', 'laura.gomez@email.com', '+34 611 987 432', 'Avenida del Parque 45, Barcelona', 'e99a18c428cb38d5f260853678922e03', '2021-05-22 09:20:00', NULL, '2023-09-01 12:00:00'),
('Jorge Fernández', 'jorge.fernandez@email.com', '+34 622 555 654', 'Calle del Sol 78, Valencia', '098f6bcd4621d373cade4e832627b4f6', '2020-07-15 15:00:00', NULL, '2023-08-20 11:15:00'),
('Marta López', 'marta.lopez@email.com', '+34 633 234 321', 'Plaza de España 21, Sevilla', 'd8578edf8458ce06fbc5bb76a58c5ca4', '2019-11-01 11:45:00', '2023-07-01 09:30:00', '2023-06-25 10:00:00'),
('Antonio Torres', 'antonio.torres@email.com', '+34 644 987 654', 'Calle de la Luna 7, Zaragoza', '5f4dcc3b5aa765d61d8327deb882cf99', '2021-09-12 08:50:00', NULL, '2023-09-02 13:20:00'),
('Lucía Martín', 'lucia.martin@email.com', '+34 655 123 321', 'Avenida de la Paz 99, Málaga', '25f9e794323b453885f5181f1b624d0b', '2020-10-20 16:15:00', NULL, '2023-09-10 12:45:00'),
('José Pérez', 'jose.perez@email.com', '+34 666 234 543', 'Calle Estrella 54, Bilbao', '6cb75f652a9b52798eb6cf2201057c73', '2022-03-25 10:10:00', NULL, '2023-09-12 09:50:00'),
('Elena Rodríguez', 'elena.rodriguez@email.com', '+34 677 345 876', 'Calle Verde 88, Alicante', '098f6bcd4621d373cade4e832627b4f6', '2021-01-15 11:30:00', '2023-08-10 17:30:00', '2023-07-30 14:00:00'),
('Pablo Ramírez', 'pablo.ramirez@email.com', '+34 688 456 654', 'Calle Azul 32, Granada', 'e99a18c428cb38d5f260853678922e03', '2023-06-05 13:40:00', NULL, '2023-09-14 15:10:00'),
('Sofía Sánchez', 'sofia.sanchez@email.com', '+34 699 567 987', 'Avenida del Río 67, Córdoba', '5f4dcc3b5aa765d61d8327deb882cf99', '2022-12-01 10:00:00', NULL, '2023-09-15 08:30:00');   
    
INSERT INTO Horarios (dia_semana, Hora_inicio, Hora_final)
VALUES
('Lunes', '09:00:00', '11:00:00'),
('Lunes', '13:00:00', '15:00:00'),
('Martes', '10:00:00', '12:00:00'),
('Martes', '14:00:00', '16:00:00'),
('Miercoles', '09:30:00', '11:30:00'),
('Miercoles', '13:30:00', '15:30:00'),
('Jueves', '08:00:00', '10:00:00'),
('Jueves', '11:00:00', '13:00:00'),
('Viernes', '09:00:00', '11:00:00'),
('Viernes', '14:00:00', '16:00:00');    
        
INSERT INTO Roles (Estudiante, Profesor, Administrador, Tutor, Revisor_tareas) 
VALUES (1, 0, 0, 0, 0),
       (0, 1, 0, 0, 1),
       (0, 0, 1, 0, 0),
       (0, 0, 0, 1, 1);	
        
INSERT INTO Tareas (Titulo, Descripcion, tipo, Fecha_Creación, Fecha_muerte, Fecha_Modificacion, ProfesorCreador_IdProfesor)
VALUES ('Lectura Inicial', 'Leer el capítulo 1 del libro de matemáticas.', 'Lectura', '2023-01-15 10:00:00', '2023-01-30 23:59:59', '2023-01-20 15:00:00', 1),
       ('Redacción de Ensayo', 'Escribir un ensayo sobre el impacto del cambio climático.', 'Redaccion', '2023-02-01 09:00:00', '2023-02-10 23:59:59', '2023-02-05 10:30:00', 2),
       ('Examen en línea', 'Realizar el examen sobre álgebra lineal.', 'Examen_Online', '2023-03-05 08:00:00', '2023-03-07 12:00:00', '2023-03-06 09:45:00', 3);        

INSERT INTO calificaciones (Notas, Profesores_idProfesores, Feedback, Fecha_Calificación, Tipo_calificación)
VALUES (8.5, 1, 'Buen trabajo, pero necesita mejorar la ortografía.', '2023-01-20 11:00:00', 'Tarea'),
       (9.0, 2, 'Excelente ensayo.', '2023-02-12 14:30:00', 'Tarea'),
       (5.5, 3, 'Aprobado con dificultades.', '2023-03-08 16:00:00', 'Curso');	
    
INSERT INTO Autores (Estudiante_IdEstudiante, Profesor_IdProfesor)
VALUES (1, NULL),
       (NULL, 1),
       (2, NULL),
       (NULL, 2);
       
INSERT INTO Foros (Nombre_Foro, Descripcion_Foro, Fecha_Creacion_Foro, Fecha_Ultimo_comentario_Foro, Cantidad_Mensajes_foro, ID_Autor_Foro)
VALUES ('Foro de Optimización de Procesos con Kaizen', 'Discusión sobre los primeros conceptos de organización de espacion.', '2023-01-12 09:00:00', '2023-01-15 10:00:00', 10, 1),
       ('Foro de Programación', 'Debate sobre los impactos del cambio climático en el desarrollo web.', '2023-02-02 12:00:00', '2023-02-05 11:30:00', 20, 2);
       
INSERT INTO Mensajes (Titulo_Mensaje, Contenido_Mensaje, Fecha_creacion_mensaje, EsReplica, ID_Autor_Mensaje, id_Mensaje_padre, Foros_idForos)
VALUES ('Pregunta sobre el capítulo 1', 'Tengo dudas sobre la ecuación en la página 15.', '2023-01-12 10:00:00', 0, 1, NULL, 1),
       ('Respuesta a la pregunta', 'La ecuación en la página 15 se refiere a...', '2023-01-12 12:00:00', 1, 2, 1, 1),
       ('Comentario sobre la lectura', 'La lectura me pareció interesante.', '2023-02-02 13:00:00', 0, 3, NULL, 2);   
       
       INSERT INTO Materiales_has_cursos (materiales_idMateriales, Cursos_idCursos, Fecha_Vinculacion, Fecha_asignacion_a_curso, Humano_Vinculador)
VALUES (1, 1, '2023-01-02 09:00:00', '2023-01-05 10:00:00', 1),
       (2, 2, '2023-02-10 11:00:00', '2023-02-15 14:00:00', 2),
       (3, 3, '2023-03-01 12:00:00', '2023-03-05 13:00:00', 3);
       
       INSERT INTO Cursos_has_profesores (cursos_idCursos, profesor_IdProfesor, Fecha_alta_profesor, Fecha_baja_profesor, Roles_idRoles)
VALUES (1, 1, '2023-01-01 08:00:00', '2023-12-31 18:00:00', 2),
       (2, 2, '2023-02-01 08:00:00', '2023-12-31 18:00:00', 2),
       (3, 3, '2023-03-01 08:00:00', '2023-12-31 18:00:00', 2);
       
       INSERT INTO Cursos_has_Estudiantes (cursos_idCursos, estudiante_idEstudiante, Fecha_alta_profesor, Fecha_baja_profesor, calificaciones_idCalificaciones)
VALUES (1, 1, '2023-01-10 09:00:00', '2023-12-15 17:00:00', 1),
       (2, 2, '2023-02-15 09:00:00', '2023-12-15 17:00:00', 2),
       (3, 3, '2023-03-05 09:00:00', '2023-12-15 17:00:00', 3);
       
       INSERT INTO Estudiantes_has_tareas (Tareas_idTareas, estudiante_idEstudiante, Estado, Fecha_Entrega, calificaciones_idCalificaciones)
VALUES (1, 1, 'Entregada', '2023-01-25 10:30:00', 1),
       (2, 2, 'Pendiente', '2023-02-28 16:00:00', 2),
       (3, 3, 'Corregida', '2023-03-10 13:00:00', 3);
       
       INSERT INTO Tareas_has_Profesores_Revisores (Tareas_idTareas, Profesor_revisor_idProfesor)
VALUES (1, 1),
       (2, 2),
       (3, 3);
       
       INSERT INTO Cursos_has_foros (Cursos_idCursos, Foros_IdForos)
VALUES (1, 1),
       (2, 2);
       
       insert into ESCUELA.Cursos_has_tareas (Cursos_idCursos, Tareas_idTareas)
VALUES (1, 2),
	(1, 3),
	(1, 4),
	(1, 7),
	(2, 2),
	(2, 3),
	(4, 4),
	(4, 7),
	(6, 2),
	(6, 3),
	(7, 4),
	(7, 7),
	(3, 2),
	(3, 3),
	(5, 7),
	(5, 2),
	(9, 2),
	(10,3),
	(10,4),
	(10,7),
	(7, 2),
	(8, 3);