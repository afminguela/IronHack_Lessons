USE `Ejercicio-6` ;
 
 -- Ejercicios de formularios e informes con loops y whiles:
-- Nivel Fácil (1-5):
-- 1. Crear procedimiento que liste clientes de una ciudad con un WHILE: Crea un procedimiento almacenado que reciba el nombre de una ciudad como parámetro y use un WHILE para recorrer la lista de clientes que viven en esa ciudad, mostrando cada cliente uno por uno.
-- Uso de: WHILE, SELECT.

DROP PROCEDURE Lista_Clientes_Ciudad;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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


SELECT p.Nombre AS Nombre, C.Nombre as Ciudad
    FROM Persona P
    LEFT JOIN Ciudad C ON P.Ciudad_idCiudad = C.idCiudad
    WHERE  C.Nombre = pNombre;
      
COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            CALL Lista_Clientes_Ciudad('Zaragoza');     
  

-- 2 Registrar un nuevo hogar y verificar en bucle: Crea un procedimiento almacenado que permita insertar un nuevo registro en la tabla Hogar, pero antes de insertar debe recorrer los registros existentes de Hogar con un LOOP para verificar si el código postal ya existe.
-- Uso de: LOOP, IF, INSERT.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Nuevo_Hogar (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            




-- 3 Recorrer y actualizar fechas de baja de varias personas: Crea un procedimiento almacenado que use un WHILE para recorrer todas las personas en la tabla Persona y actualice la FechaBaja de cada una si no tienen una asignada.
-- Uso de: WHILE, UPDATE.
DROP PROCEDURE ActualizarFechasBaja;
DELIMITER //

CREATE PROCEDURE ActualizarFechasBaja()
BEGIN

	-- Variables para controlar el bucle
    -- DECLARE pfin INT DEFAULT 0;
    DECLARE pid INT; 
    
		-- Chivato de rollback	
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
   -- Bloque Cursor
   -- Cursor para recorrer las personas que no tienen FechaBaja asignada
		DECLARE pfin INT DEFAULT 0;
        DECLARE cursor_personas CURSOR FOR  SELECT idPersona FROM Persona p WHERE p.FechaBaja IS NULL;

    -- Variable que controla el final del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET pfin = 1;

    -- Abrir el cursor
    OPEN cursor_personas;
-- Bloque While
    -- Bucle WHILE que recorre los resultados
    WHILE
        -- Obtener el idPersona de la persona actual
        FETCH cursor_personas INTO pid;

        -- Si no se ha llegado al final, actualizar FechaBaja
        IF NOT pfin THEN
            -- Actualizar la FechaBaja con la fecha actual
            UPDATE Persona
            SET FechaBaja = CURDATE()
            WHERE idPersona = pid;
        END IF;
        
    UNTIL pfin END WHILE;

    -- Cerrar el cursor
    CLOSE cursor_personas;
END //

DELIMITER ;

			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

-- 4.Informe con WHILE para contar reclamaciones pendientes por agente: Crea un procedimiento almacenado que genere un informe con el número de reclamaciones pendientes de cada agente, utilizando un WHILE para recorrer la lista de agentes y calcular las reclamaciones asociadas.
-- Uso de: WHILE, SELECT, COUNT.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

-- 5.Verificar y recorrer matrículas duplicadas: Crea un procedimiento almacenado que use un LOOP para recorrer la tabla Vehiculo y verificar si una matrícula ya existe antes de permitir la inserción de un nuevo vehículo.
-- Uso de: LOOP, IF, EXISTS.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

-- Nivel Intermedio (6-10):
-- 6. Actualizar la última fecha de actualización de pólizas en bucle: Crea un procedimiento almacenado que use un WHILE para recorrer todas las pólizas y actualice su FechaUltimaActualizacion si no están canceladas, verificando cada póliza con IF.
-- Uso de: WHILE, IF, UPDATE.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

-- 7. Procesar pagos en bucle con transacciones: Crea un procedimiento almacenado que recorra todas las transacciones pendientes de un cliente usando un LOOP, registre un pago en la tabla Pagos, y utilice transacciones MySQL para garantizar la consistencia.
-- Uso de: LOOP, START TRANSACTION, COMMIT, ROLLBACK.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

-- 8. Recorrer y listar vehículos según tipo de licencia con LOOP: Crea un procedimiento almacenado que reciba el tipo de licencia como parámetro y use un LOOP para recorrer todos los vehículos, mostrando solo aquellos que requieren la licencia dada.
-- Uso de: LOOP, SELECT.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

-- 9.Actualizar el estado de reclamaciones en bucle: Crea un procedimiento almacenado que use un WHILE para recorrer todas las reclamaciones de una póliza específica y actualice su estado usando CASE y IF.
-- Uso de: WHILE, CASE, UPDATE.

DROP PROCEDURE Nuevo_Hogar;
DELIMITER //
CREATE PROCEDURE Lista_Clientes_Ciudad (
			IN pNombre  varchar(45)
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





COMMIT;

END//
DELIMITER ; 

CALL Lista_Clientes_Ciudad('Madrid');             
            

Historial de pagos con un bucle y formateo de fechas: Crea un procedimiento que recorra el historial de pagos de un cliente usando un WHILE para formatear cada fecha de pago en un formato amigable.
Uso de: WHILE, CONCAT, DATE_FORMAT.
Nivel Difícil (11-15):
Calcular prima total asegurada por agente en bucle: Crea un procedimiento almacenado que use un WHILE para recorrer los agentes, calcular el total de primas aseguradas para cada uno, y generar un informe que muestre los resultados.
Uso de: WHILE, IF, SUM.
Generar informe de vehículos por año de fabricación en WHILE: Crea un procedimiento que reciba un rango de años y use un WHILE para generar un informe detallado de los vehículos fabricados en ese periodo, incluyendo un promedio de kilometraje por marca.
Uso de: WHILE, IF, AVG, CASE.
Reasignar clientes a nuevos agentes en LOOP: Crea un procedimiento almacenado que use un LOOP para recorrer todos los clientes de un agente y reasignarlos a otro agente, verificando la disponibilidad de agentes usando IF.
Uso de: LOOP, UPDATE, IF.
Verificar y actualizar el estado de pólizas en WHILE: Crea un procedimiento que use un WHILE para recorrer todas las pólizas, verificar su estado y actualizarlo basado en las reclamaciones asociadas, usando un CASE para definir el nuevo estado.
Uso de: WHILE, CASE, UPDATE.
Calcular montos de transacciones y marcar como pagadas en bucle: Crea un procedimiento que use un WHILE para recorrer todas las transacciones de un cliente, calcular el total pendiente y marcar las transacciones como pagadas cuando el saldo sea suficiente, utilizando transacciones MySQL.
Uso de: WHILE, IF, UPDATE, START TRANSACTION, ROLLBACK.
Ejercicios de funciones con más loops y whiles:
Funciones Nivel Fácil (1-2):
Función para verificar si un DNI ya existe con WHILE: Crea una función que reciba un DNI y use un WHILE para recorrer los registros en la tabla Persona y verificar si el DNI ya existe, devolviendo TRUE si lo encuentra.
Uso de: WHILE, EXISTS.
Función para calcular la edad con un bucle: Crea una función que reciba la fecha de nacimiento de una persona y use un LOOP para calcular la edad en años, devolviendo el resultado.
Uso de: LOOP, DATEDIFF, FLOOR.
Funciones Nivel Intermedio (3-4):
Función para calcular el monto total asegurado de una póliza en un WHILE: Crea una función que reciba el idPoliza y use un WHILE para calcular el monto total asegurado de esa póliza, sumando los montos de las reclamaciones asociadas.
Uso de: WHILE, SUM.
Función para calcular el tiempo activo de una póliza en LOOP: Crea una función que reciba el idPoliza y use un LOOP para calcular cuántos días ha estado activa la póliza, desde su FechaInicio hasta la fecha actual o la FechaCancelacion.
Uso de: LOOP, DATEDIFF, IF.
Función Nivel Difícil (5):
Función para verificar la validez de la fecha de expiración en WHILE: Crea una función que use un WHILE para recorrer todas las pólizas y verificar si están activas, expiradas o canceladas, devolviendo un estado como "Activa", "Expirada", o "Cancelada" según corresponda.
Uso de: WHILE, CASE, IF, DATE.
