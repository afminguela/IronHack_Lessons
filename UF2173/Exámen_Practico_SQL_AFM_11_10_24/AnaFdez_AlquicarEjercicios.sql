USE Alquicar;
-- --------------------------------------------------------------------------------------------------------------------
-- CONSULTAS
-- --------------------------------------------------------------------------------------------------------------------

-- 1. Listar todos los vehículos que están actualmente disponibles para alquilar.

SELECT * 
FROM Vehículos V
WHERE V.Estado = 'Disponible';

-- 2. Listar los vehículos que han requerido mantenimiento más de una vez, mostrando el número total de mantenimientos por vehículo y la fecha del último mantenimiento.

SELECT V.Matricula, V.Marca, V.Modelo,Count(M.idMantenimiento)AS Reparaciones, Max( M.FechaMantenimiento)as Ultimo_Mantenimiento£
FROM Vehículos V
inner Join Mantenimiento M ON V.idVehiculo = M.idVehiculo
group by V.idVehiculo
Having Count(M.idVehiculo) > 1;

-- 3. Mostrar todas las reservas hechas por un cliente, incluyendo el modelo del vehículo alquilado, las fechas de inicio y fin de la reserva, y el total de reservas hechas por ese cliente.

With Reservas_Cliente as (
Select Count(*)FROM Reservas R  
inner join Clientes C ON R.idCliente = C.idCliente
WHERE C.Nombre like 'Juan%')

SELECT C.Nombre, V.Matricula, V.Tipo, V.Modelo, R.FechaReserva,  R.FechaDevolucion, (select * from Reservas_Cliente) AS total_reservas
FROM Reservas R  
inner join Clientes C ON R.idCliente = C.idCliente
inner Join Vehículos V ON R.idVehiculo = V.idVehiculo
WHERE C.Nombre like 'Juan%';



-- 4. Calcular cuántas veces ha sido alquilado cada vehículo, mostrando el modelo del vehículo, el número total de veces que ha sido reservado, y la última fecha de alquiler para cada vehículo.

SELECT V.Matricula, V.Marca,V.Modelo ,COUNT(*) AS Total_Reservas, MAX(R.FechaReserva)AS Ultima_Fecha_Alquiler
FROM Vehículos V
inner Join  Reservas R ON R.idVehiculo = V.idVehiculo
Group By V.Matricula, V.Marca, V.Modelo
Order By Total_Reservas, Ultima_Fecha_Alquiler;

-- 5. Encontrar todas las reservas activas a la fecha actual, mostrando también cuántos vehículos están actualmente en uso por tipo de vehículo.

with Alquilados as (
SELECT R.idReservas, R.idVehiculo, V.Tipo, V.Marca, V.Modelo, V.Matricula 
from Reservas R 
inner Join Vehículos V ON V.idVehiculo= R.idVehiculo 
where '2024-10-12' BETWEEN R.FechaReserva AND R.FechaDevolucion 
) 

SELECT A.idReservas AS "Numero  de Reserva",A.Tipo,A.Matricula, A.Marca, A.Modelo, COUNT(*) OVER (PARTITION BY A.Tipo) AS Vehiculos_Alquilados  
FROM Alquilados A
ORDER BY A.Tipo, A.idReservas;
    
 -- --------------------------------------------------------------------------------------------------------------------
-- TRIGGER 
 -- --------------------------------------------------------------------------------------------------------------------
-- Crea un trigger que actualice el estado de un vehículo a "mantenimiento" cuando se registre un mantenimiento para ese vehículo.

DELIMITER //  
  
CREATE TRIGGER Actualizar_Estado
AFTER INSERT ON Mantenimiento
For each row 
BEGIN

	UPDATE Vehículos 
    SET Estado = "En Mantenimiento"
    Where idVehiculo = new.idVehiculo;

END; //

DELIMITER ;
Drop TRIGGER Actualizar_Estado;

Insert into Mantenimiento (idVehiculo, Descripción, FechaMantenimiento)
values (5,"cambio de frenos", Now());
select * from Mantenimiento;

-- --------------------------------------------------------------------------------------------------------------------
-- PROCEDURE -- 
-- --------------------------------------------------------------------------------------------------------------------

-- Crea un procedimiento almacenado con control de errores (formulario), que permita registrar una nueva reserva para un usuario concreto. 
-- Antes de registrar la reserva, el procedimiento debe verificar si el vehículo está disponible, y si lo está, actualizar el estado del vehículo a "alquilado" y proceder con el registro de la reserva. 
-- Antes de registrar la reserva también se debe verificar si el usuario tiene algún otro vehículo en alquiler, si es el caso, no tiene que poder realizar la nueva reserva.

DROP PROCEDURE Nueva_reserva;


DELIMITER //
CREATE PROCEDURE Nueva_reserva(
    IN pidCliente INT,
    IN pidVehiculo INT,
    IN pFechaReserva DATETIME,
    IN pFechaDevolucion DATETIME,
    IN pPrecio DOUBLE)
    
BEGIN

			DECLARE pNombreCliente Varchar(45);
            DECLARE pAlquiler  INT default 0;
            DECLARE pDisponible INT default 0;
            DECLARE error_message VARCHAR(2000);
            DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN                            -- Rollback mejorado 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;
                
                

START TRANSACTION;
-- Guardar nombre Cliente (por UX, simplemente)

	SELECT C.Nombre INTO pNombreCliente
    From Clientes C
    WHERE C.idCliente = pidCliente;
    
-- Verificar la Disponibilidad del Vehiculo
    SELECT Count(*) INTO pDisponible 
    FROM Vehículos V
    WHERE V.idVehiculo = pidVehiculo AND V.Estado = 'Disponible';

-- Verificar que el cliente no tiene alquileres pendientes   
    SELECT Count(*) INTO pAlquiler 
    FROM Reservas R
    WHERE R.idCliente = pidCliente AND R.FechaDevolucion > NOW();

-- Los IFs 
    IF (pDisponible = 0 AND pAlquiler > 0 )THEN
        SELECT Concat('Lo Sentimos ',pNombreCliente,', El vehículo no está disponible para alquilar y además tiene un alquiler en curso') AS Mensaje;
		Rollback;
    ELSEIF (pDisponible = 0) THEN
		SELECT Concat('Lo Sentimos ',pNombreCliente,', El vehículo no está disponible para Alquiler, elija otro del catálogo') AS Mensaje;
        Rollback;
	ELSEIF (pAlquiler > 0) THEN
		SELECT Concat('Lo Sentimos ',pNombreCliente,', Debe devolver el Vehiculo alquilado a su nombre antes de alquilar otro') AS Mensaje; 
	
    ELSE
		INSERT INTO Reservas(idCliente,idVehiculo,FechaReserva,FechaDevolucion,Precio)
		VALUES (pidCliente,pidVehiculo,pFechaReserva,pFechaDevolucion,pPrecio);
        
        UPDATE Vehículos V
		SET V.Estado = "Alquilado"
		Where V.idVehiculo = pidVehiculo;
        
		COMMIT;
        SELECT Concat('¡Enhorabuena ',pNombreCliente,'!, su reserva para el dia ',DATE_FORMAT(pFechaReserva, '%Y-%m-%d'),' se ha registrado con éxito') as Mensaje;
     END IF ;
	
     
END //

DELIMITER ;

DROP PROCEDURE Nueva_reserva;
CALL Nueva_reserva (15,8,'2024-11-10', '2024-11-20',200.00) ;
select * from Reservas;
select * from Vehículos;

update Reservas -- para modificar los registros de las reservas cliente
Set idCliente = 11 
WHERE idReservas = 29;

update Reservas -- para modificar los registros de las reservas vehiculo
Set idVehiculo = 11 
WHERE idReservas = 1;

-- ahora el coche 1 debería estar libre y el cliente 15 no tiene reservas

CALL Nueva_reserva (15,1,'2024-11-10', '2024-11-20',200.00) ;