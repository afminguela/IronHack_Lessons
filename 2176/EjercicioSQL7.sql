USE ejercico7;

-- 1. Actualización automática de la fecha de modificación en Persona; Cada vez que se modifique un registro en la tabla Persona, se debe actualizar automáticamente el campo FechaModificacion con la fecha y hora actual.

DELIMITER //

CREATE TRIGGER Fecha_modificacion
BEFORE UPDATE ON Persona 
FOR EACH ROW
BEGIN
	set NEW.FechaModificacion = now();
END;
//

DELIMITER ;

-- 2. Evitar la inserción de una persona sin número de identificación;No se permitirá insertar una nueva persona si el campo NumeroIdentificacion está vacío o es nulo.

DELIMITER //
CREATE TRIGGER Antes_insert_persona_noDniNoParty
BEFORE insert ON Persona
FOR EACH ROW
BEGIN
  
  
  IF new.NumeroIdentificacion is null OR new.NumeroIdentificacion = '' 
  THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: Falta Numero de Identificación de la persona.';
  END IF;
END;
//
DELIMITER ;



-- 3. Control de inventario al recibir suministros; Cuando se inserte un nuevo registro de inventario, se debe asegurar que la cantidad recibida no excede la capacidad de almacenamiento del suministro.

ALTER TABLE Inventario ADD COLUMN CapacidadMax INT ;

DELIMITER //
Create Trigger Check_hay_hueco2
BEFORE INSERT ON Inventario
FOR EACH ROW
BEGIN

	IF new.Cantidad > new.CapacidadMax 
    THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No entra ni empujando, quieres meter mas cantidad de la capacidad de la nave';
  END IF;
  END;
  //
DELIMITER;

-- 4. Asignación automática de la fecha de alta en Empleado; Cuando se cree un nuevo registro en Empleado, se asignará automáticamente la fecha y hora actual en el campo FechaAlta.
delimiter //
ALTER TABLE ejercico7.Empleado ADD COLUMN FechaAlta DATETIME DEFAULT NULL;
//
Delimiter;


DELIMITER //

CREATE TRIGGER ALta_Automatica
BEFORE INSERT ON Empleado
FOR EACH ROW 
BEGIN
	SET New.FechaAlta = NOW();
END;
//


-- 5. Bloquear eliminación de un planeta si hay personas asociadas; No se permitirá eliminar un registro de la tabla Planeta si existen personas asignadas a ese planeta.
DELIMITER //

CREATE TRIGGER bloquearEliminacionPlaneta
BEFORE DELETE ON Planeta
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Personas 
        WHERE new.Planeta_idPlaneta = OLD.idPlaneta
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el planeta porque tiene personas asociadas';
    END IF;
END;

//
DELIMITER ;


-- 6. Control de capacidad de pasajeros en NaveEspacial Si se intenta asignar un número de pasajeros superior a la capacidad de la nave en un viaje, se debe lanzar un error y bloquear la operación.

-- 7. Cálculo automático de la duración del viaje. Al insertar un nuevo registro en Viaje, se debe calcular y asignar automáticamente la duración del viaje en función de la diferencia entre FechaSalida y FechaLlegada.
-- 8. Actualización automática de la fecha de próximo mantenimiento en NaveEspacial Cada vez que se registre un nuevo mantenimiento en una nave espacial, se debe calcular y actualizar automáticamente la fecha del próximo mantenimiento.
-- 9. Control de fecha de baja en Hotel;No se permitirá insertar una fecha de baja en un hotel si esa fecha es anterior a la fecha de construcción.
-- 10. Notificación al modificar el precio de una habitación; Cuando se actualice el precio de una habitación, se debe registrar la modificación en una tabla de auditoría para seguimiento de cambios.
-- 11. Validación de fechas de reserva en Reserva;Se debe asegurar que la fecha de cancelación de una reserva nunca sea anterior a la fecha de creación de la misma.
-- 12. Control de asignación múltiple de operaciones a un mismo empleado; No se permitirá asignar un empleado a la misma operación más de una vez.
-- 13. Control de duplicación de telemetría en DetalleViaje; No se permitirá insertar un registro de telemetría en DetalleViaje si ya existe otro registro con los mismos valores para la velocidad y el consumo en el mismo viaje.
-- 14. Autorización de actualización del estado vital; Solo se permitirá la modificación de los datos de EstadosVitales si el registro de viaje asociado sigue activo (sin fecha de finalización).
-- 15. Reasignación automática de habitaciones en caso de baja de hotel Cuando se registre la baja de un hotel, todas las habitaciones asociadas deben ser automáticamente marcadas como inactivas.
-- 16. Reasignación de naves espaciales al cambiar su capacidad de carga; Si se modifica la capacidad de carga de una nave espacial, se debe verificar si hay suministros programados que excedan la nueva capacidad. Si los hay, estos deben ser reasignados a otras naves.
-- 17. Prevención de baja de un empleado si tiene operaciones activas; No se permitirá dar de baja a un empleado si está actualmente asignado a alguna operación que no haya finalizado.
-- 18. Validación de evaluación en EmpleadoFormacion Cuando se registre una evaluación para un empleado en una formación, el valor de evaluación debe estar dentro de un rango de 0 a 100.
-- 19. Asignación automática de fechas de finalización de viaje; Cuando se complete un viaje (con fecha de llegada registrada), se debe actualizar automáticamente la fecha de finalización de todas las operaciones asociadas a ese viaje.
-- 20. Control de disponibilidad de hotel en Habitacion; No se permitirá registrar una nueva reserva de habitación si la capacidad máxima del hotel ya ha sido alcanzada.