USE Centro_Convenciones;
-- 1. **Crear un *stored procedure* para registrar un nuevo usuario.**
--     - Parámetros de entrada: nombre, email, teléfono.

DROP PROCEDURE NuevoUsuario;

DELIMITER //  
   CREATE PROCEDURE NuevoUsuario (
    			IN nombre VARCHAR(45), 
    			IN email VARCHAR(45),
    			IN telefono INT
    			)
    BEGIN			
	                DECLARE EXIT HANDLER FOR SQLEXCEPTION
    				BEGIN 
    						ROLLBACK;
                            SIGNAL SQLSTATE '45000' 
							SET MESSAGE_TEXT = 'Me he vuelto al Rollback';
					END;
    
    Start transaction;
    
    INSERT INTO Usuarios(nombre, email, telefono)
    Values(nombre,email,telefono); 	
    
            SIGNAL SQLSTATE '45000' 	SET MESSAGE_TEXT = 'He hecho el insert';
    Commit;
    END //
  DELIMITER ;     
select * from usuarios;
Call NuevoUsuario('Maria', 'maria@gmail.com', 12367657);

  
-- 2. **Crear un *stored procedure* para actualizar el nombre de un usuario.**
-- Parámetro de entrada: ID de usuario y nuevo nombre.
 


DROP PROCEDURE ActualizaUsuario;
DELIMITER // 
CREATE PROCEDURE ActualizaUsuario (
			IN idUsuario INT,
			IN NuevoNombre VARCHAR(100)
			)
BEGIN			
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						ROLLBACK;
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = 'Me he vuelto al Rollback';
				END;

START TRANSACTION;


UPDATE Usuarios SET Nombre = NuevoNombre 
WHERE Usuarios.idUsuarios = idUsuario;

COMMIT;
END//
DELIMITER ;


CALL ActualizaUsuario(3,'Manolo');
set sql_safe_updates = 0;
    
-- 3. **Crear un *stored procedure* que devuelva los datos de una sala por ID.**
-- Parámetro de entrada: ID de sala.

DROP PROCEDURE Datos_sala;
DELIMITER //
CREATE PROCEDURE Datos_sala (
			IN idSalas INT)
BEGIN			
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

SELECT * FROM Sala s WHERE s.idSalas = idSalas;

/*SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = 'He pasado la instruccion';*/

COMMIT;

END//
DELIMITER ; 

CALL Datos_sala(255);


-- 4. **Crear una transacción que inserte un nuevo registro en la tabla USUARIOS con rol Administrados y otro en REservas.**

DROP PROCEDURE Nuevo_Administrador_y_reserva;
DELIMITER //
CREATE PROCEDURE Nuevo_Administrador_y_reserva ()
			
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

INSERT INTO Roles_has_Usuarios (Roles_id,Usuarios_idUsuarios,fecha_alta)
VALUES (1,3,now());

INSERT INTO Reservas (fecha_inicio,fecha_fin,comentario,idUsuarios,Salas_id)
VALUES ('2024-10-18 14:00:00', '2024-10-19 23:00:00', 'Necesitamos proyector y la devolveremos limpia, avisad al catering' , 2, 3);


COMMIT;

END//
*/

/* Un plan B
CREATE PROCEDURE Nuevo_Administrador_y_reserva ()
BEGIN
    DECLARE error_message VARCHAR(2000);
    DECLARE error_code INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN 
            GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
            ROLLBACK;	
            SET error_message = Concat('Me he vuelto al Rollback, He dado error: ', error_code);
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = error_message;
        END;

START TRANSACTION;

INSERT INTO Roles_has_Usuarios (Roles_id, Usuarios_idUsuarios, fecha_alta)
VALUES (1, 3, NOW());

-- Verificar si existe una reserva duplicada
IF EXISTS (
    SELECT * FROM Reservas 
    WHERE idUsuarios = 2 AND Salas_id = 3 
    AND fecha_inicio BETWEEN '2024-10-18' AND '2024-10-19'
) THEN
    INSERT INTO Reservas (fecha_inicio, fecha_fin, comentario, idUsuarios, Salas_id)
    VALUES ('2024-10-18 14:00:00', '2024-10-19 23:00:00', 'Necesitamos proyector y la devolveremos limpia, avisad al catering', 2, 3);
ELSE
    SET @error_message = 'Ya existe una reserva duplicada para este usuario y sala dentro del rango de fechas especificado.';
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = @error_message;
END IF;

COMMIT;

END //
*/


DELIMITER ; 

call Nuevo_Administrador_y_reserva();

-- 5. **Crear una transacción que reserve una sala.**
   -- Parámetros: ID del usuario, ID de la sala, fecha y hora.
DROP PROCEDURE Nueva_reserva;
DELIMITER //
CREATE PROCEDURE Nuevo_Administrador_y_reserva ()
			
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

INSERT INTO Reservas (fecha_inicio,fecha_fin,idUsuarios,Salas_id)
VALUES ('2024-10-18 14:00', '2024-10-19 23:00',1,4);

COMMIT;

END//
DELIMITER ; 

   
   
   
   
-- 6. **Crear un *stored procedure* para eliminar un recordatorio.**
    -- Parámetro de entrada: ID del recordatorio.
    DROP PROCEDURE Borrar_Recordatorio;
DELIMITER //
CREATE PROCEDURE Borrar_Recordatorio(
			IN idRecordatorios INT)
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

DELETE FROM Recordatorios R WHERE R.idRecordatorios = idRecordatorios;


COMMIT;

END//
DELIMITER ; 

CALL Borrar_Recordatorio(2); 
    
    
-- 7. **Crear un *stored procedure* que liste todas las salas disponibles en una fecha específica.**
    -- Parámetro de entrada: fecha.
    
   DROP PROCEDURE Lista_Salas_Disponibles_porFecha;
DELIMITER //
CREATE PROCEDURE Lista_Salas_Disponibles_porFecha (
			IN Fecha DATETIME)
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

/*Select * 
From Salas S 
Inner JOIN Reservas R ON R.Salas_id = S.idSalas
where  S.estado like 'LIBRE' and R.fecha_inicio = Fecha;
*/

SELECT DISTINCT S.*
    FROM Salas S
    LEFT JOIN Reservas R ON R.Salas_id = S.idSalas
    WHERE S.estado = 'LIBRE'
      AND (R.Salas_id IS NULL OR R.fecha_inicio != Fecha);


COMMIT;

END//
DELIMITER ; 

CALL Lista_Salas_Disponibles_porFecha('2024-09-16 14:00'); 
      
    
    
-- 8. **Crear una transacción que registre un nuevo equipo y lo asigne a una sala.**
    -- Parámetros: nombre del equipamiento, ID de sala.
   DROP PROCEDURE Añadir_Equipo_A_Sala;
DELIMITER //
CREATE PROCEDURE Añadir_Equipo_A_Sala (
			IN pIdSala int,
			OUT IdEquipamiento INT)

BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

INSERT INTO Equipamientos (nombre, descripcion, fecha_alta, fecha_baja, marca, modelo, num_serie, tipo_equipo, disponibilidad, estado)
VALUES ('Cámara', 'Cámara de vídeo', '2024-09-14 18:52:15', NULL, 'Canon', 'VIXIA HF G50', 'SN567886', 'Video', '1', 'BUEN_ESTADO');

SET IdEquipamiento = LAST_INSERT_ID();

INSERT INTO Equipamientos_Salas (idEquipamientos, Salas_id, fecha_alta, fecha_baja)
VALUES (IdEquipamiento,pIdSala,NOW(), null);


COMMIT;

END//
DELIMITER ; 

CALL Añadir_Equipo_A_Sala(2,@IdEquipamiento);  
          
    
-- 9. **Crear una transacción para registrar una nueva reserva y enviar un recordatorio.**
    -- Parámetros: ID de sala, ID de usuario, fecha, hora, tipo de recordatorio.

   DROP PROCEDURE Nueva_reserva_recordatorio;
DELIMITER //
CREATE PROCEDURE Nueva_reserva_recordatorio (
			OUT NuevaReserva INT)

BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

INSERT INTO Reservas (fecha,fecha_inicio,fecha_fin,idUsuarios,Salas_id)
VALUES(NOW(),'2024-09-14 18:00:00', '2024-09-14 20:00:00', 2, 3);

SET NuevaReserva = LAST_INSERT_ID();

INSERT INTO Recordatorios (fecha,mensaje,idReservas)
VALUES (NOW(), 'Le confirmamos que se reserva se ha confirmado', NuevaReserva); 



COMMIT;

END//
DELIMITER ; 

CALL Nueva_reserva_recordatorio(@NuevaReserva); -- Mismo error que antes en reciclaje de variables.


-- 10. **Crear un *stored procedure* que actualice el estado de un recordatorio a "enviado".**
    -- Parámetro de entrada: ID del recordatorio.

   DROP PROCEDURE ActuatizaRecordatorioEnviado;
DELIMITER //
CREATE PROCEDURE ActuatizaRecordatorioEnviado (
			IN IdRecordatorio INT)

BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

IF NOT EXISTS ( SELECT * FROM information_schema.columns WHERE table_schema = 'Centro_Convenciones' AND table_name = 'Recordatorios' AND column_name = 'Estado' ) THEN
ALTER TABLE  Recordatorios
ADD COLUMN  Estado ENUM('Pendiente','Enviado') DEFAULT 'Pendiente';
SELECT 'He creado la columna' AS Flag;
else Select 'Ya había columna' AS Flag;
END IF;



UPDATE Recordatorios R
SET R.Estado = 'Enviado'
WHERE R.idRecordatorios = IdRecordatorio;


COMMIT;

END//
DELIMITER ; 


CALL ActuatizaRecordatorioEnviado(2); 

### **Nivel Intermedio (5 ejercicios)**

-- 1. **Crear una transacción que inserte una nueva reserva, actualice la capacidad de la sala y genere un reporte. Incluye manejo de errores.**
   -- - Parámetros: ID de sala, ID de usuario, fecha, hora.
   DROP PROCEDURE Reserva_Capacidad_Reporte;
DELIMITER //
CREATE PROCEDURE Reserva_Capacidad_Reporte ()
			
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;
INSERT INTO Reservas (fecha_inicio,fecha_fin,idUsuarios,Salas_id)
VALUES('2024-09-14 18:00:00', '2024-09-14 20:00:00', 2, 3);


UPDATE Salas
SET capacidad_maxima = '500'
WHERE idSalas = '2';

INSERT INTO Reportes (nombre,pdf,fecha_generacion,fecha_inicio,fecha_fin,idUsuarios)
VALUES('Nueva Sala y capacidad','ext', NOW(), NOW(), Null, 2) ;


COMMIT;

END//
DELIMITER ; 


CALL Reserva_Capacidad_Reporte(); 
    
-- 2. **Crear un *stored procedure* que devuelva todas las reservas de un usuario dentro de un rango de fechas.**
--     - Parámetros: ID de usuario, fecha de inicio, fecha de fin

    
   DROP PROCEDURE Reservas_Usuario_porFecha;
DELIMITER //
CREATE PROCEDURE Reservas_Usuario_porFecha (
			IN IdUsuario int,
            IN Fecha_In DATETIME,
            IN Fecha_Out DATETIME )
            
            
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

Select * 
From Reservas R 
Inner Join Usuarios U ON R.idUsuarios = U.idUsuarios
WHERE R.idUsuarios = IdUsuario and R.fecha_inicio BETWEEN Fecha_In AND Fecha_Out;


COMMIT;

END//
DELIMITER ; 

CALL Reservas_Usuario_porFecha('1','2024-09-16 14:00:00','2024-09-20 14:00:00'); 
      
    


-- 3. **Crear una transacción con manejo de errores que inserte un nuevo administrador y le asigne múltiples salas. IIncluye manejo de errores.**
--    - Parámetros: nombre, email, teléfono, IDs de las salas.

  

DROP PROCEDURE NuevoAdmin_SALAS_2;
DELIMITER //

CREATE PROCEDURE NuevoAdmin_SALAS_2 (
			IN pNombre Varchar(45),
            IN pEmail Varchar(75),
            IN pTelefono int,
            IN psalas varchar(255),
            IN pRol int
            )
            
            
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
            DECLARE elemento varchar(50);
            DECLARE posicion int default 1;
            DECLARE contador int default 0;
            DECLARE pIdUsuario int ;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
						SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
						SIGNAL SQLSTATE '45000' 
						SET MESSAGE_TEXT = error_message;
				END;
                


START TRANSACTION;
IF NOT EXISTS ( SELECT * FROM information_schema.columns WHERE table_schema = 'Centro_Convenciones' AND table_name = 'Salas' AND column_name = 'Responsable' ) THEN
ALTER TABLE  Salas
ADD COLUMN  Responsable Int,
ADD CONSTRAINT fk_Salas_Usuarios
FOREIGN KEY (Responsable) REFERENCES Usuarios(idUsuarios);
SELECT 'He creado la columna' AS Flag;

else Select 'Ya había columna' AS Flag;
END if;
INSERT INTO Usuarios(nombre, apellido1, apellido2,email,telefono,hash_contraseña,dni,fecha_alta,fecha_baja,fecha_modificacion)
VAlues(pNombre, ' ', null, pEmail, pTelefono, ' ', ' ', NOW(),null,null);

SELECT 'Primer Insert hecho' as control;

SET pIdUsuario = LAST_INSERT_ID();

INSERT INTO Roles_has_Usuarios (Roles_id,Usuarios_idUsuarios,fecha_alta)
VALUES (pRol,pIdUsuario,now());
select 'segundo insert hecho' as control;

 
WHILE CHAR_LENGTH(psalas) > 0 DO
	SET elemento = SUBSTRING_INDEX(psalas, ',', 1);
    Update Salas SET Responsable = pIdUsuario WHERE idSalas = elemento;
    SET psalas = SUBSTRING(psalas, CHAR_LENGTH(elemento) + 2);
    SET contador = contador +1;
End while;
select 'he salido del while' as control;

SELECT contador;

END //
DELIMITER ;
DROP PROCEDURE NuevoAdmin_SALAS_2;
call NuevoAdmin_SALAS_2('JoseLuis', 'joseluis@mail.com', 12332321,'1,5,3',2);

select * from roles_has_usuarios;
select * from roles;
select * from salas;

-- 4. **Crear un *stored procedure* que devuelva todas las reservas de una sala y sus detalles (incluyendo el nombre del usuario).**
--    - Parámetro de entrada: ID de sala.

    
   DROP PROCEDURE Reservas_de_Sala;
DELIMITER //
CREATE PROCEDURE Reservas_de_Sala (
			IN pIdSala int
            )
            
            
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;

START TRANSACTION;

Select S.nombre As Nombre_Sala,S.ubicacion,fecha_inicio as 'fecha Inicio reserva',fecha_fin as 'fecha Inicio reserva',U.nombre as 'Reservado por', U.telefono,R.fecha as 'fecha se hizo la Reserva', comentario 
From Reservas R
right Join Usuarios U ON R.idUsuarios = U.idUsuarios
right JOin Salas S ON R.Salas_id = S.idSalas
WHERE S.idSalas = pIdSala;


COMMIT;

END//
DELIMITER ; 

CALL Reservas_de_Sala(3); 


-- 5. **Crear una transacción para insertar una nueva sala y equiparla con varios equipos, con manejo de errores. Incluye manejo de errores.**
--    - Parámetros: nombre de la sala, ubicación, lista de IDs de equipamientos.


DROP PROCEDURE NuevoSALASEquipadas;
DELIMITER //

CREATE PROCEDURE NuevoSALASEquipadas (
			IN pUbicacion VArchar (50),
            IN pcapacidad_maxima int,
            IN pnombre varchar(45),
            IN pfecha_alta datetime,
            IN pestado Enum, 
            IN pResponsable INT,
            
                        )
            
            
BEGIN		-- Chivato de rollback	
			DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
            DECLARE elemento varchar(50);
            DECLARE posicion int default 1;
            DECLARE contador int default 0;
            DECLARE pIdUsuario int ;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
						SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
						SIGNAL SQLSTATE '45000' 
						SET MESSAGE_TEXT = error_message;
				END;
                


START TRANSACTION;

INSERT INTO Salas(ubicacion,capacidad_maxima,nombre,fecha_alta,estado,Responsable)
VAlues(pUbicacion,pcapacidad_maxima,pnombre,pfecha_alta,pestado, pResponsable);

SELECT 'Primer Insert hecho' as control;

SET pIdUsuario = LAST_INSERT_ID();

INSERT INTO Equipamientos_Salas (idEquipamientos,Salas_id,fecha_alta)
VALUES ();
select 'segundo insert hecho' as control;

 
WHILE CHAR_LENGTH(psalas) > 0 DO
	SET elemento = SUBSTRING_INDEX(psalas, ',', 1);
    Update Salas SET Responsable = pIdUsuario WHERE idSalas = elemento;
    SET psalas = SUBSTRING(psalas, CHAR_LENGTH(elemento) + 2);
    SET contador = contador +1;
End while;
select 'he salido del while' as control;

SELECT contador;

END //
DELIMITER ;
DROP PROCEDURE NuevoAdmin_SALAS_2;
call NuevoAdmin_SALAS_2('JoseLuis', 'joseluis@mail.com', 12332321,'1,5,3',2);



## **Nivel Difícil (5 ejercicios)**


-- 1. **Crear una transacción que registre una nueva reserva, envíe recordatorios a todos los usuarios de la sala y genere un reporte con tasa de ocupación. Si falla tiene que hacer rollback.**
--    - Parámetros: ID de sala, lista de IDs de usuarios, fecha, hora.


-- 2. **Crear un *stored procedure* que asigne un administrador a múltiples salas y equipos en una sola transacción.**
    -- Parámetros: ID de administrador, lista de IDs de salas, lista de IDs de equipamientos.
-- 3. **Crear una transacción con manejo de errores que actualice el nombre de un usuario y su correo, y si falla, haga un rollback completo.**
    -- Parámetros: ID de usuario, nuevo nombre, nuevo correo.
-- 4. **Crear un *stored procedure* para eliminar una sala y todas sus reservas asociadas usando una transacción con manejo de errores.**
    -- Parámetro de entrada: ID de sala.
-- 5. **Crear una transacción que registre un nuevo reporte, actualice el estado de las reservas relacionadas, y si algo falla, se haga rollback.**
    -- Parámetros: tipo de reporte, ID de sala, rango de fechas.