USE ejercico7;

Create Trigger Trigger_name
BEFORE|AFTER  INSERT|UPDATE|DELETE
ON Tabla
FOR EACH ROW
BEGIN 
	-- Intrucciones sql 
END;

/*Enunciado 1: Cada vez que se modifique un registro en la tabla estudiantes, 
se debe actualizar automáticamente el campo Fecha_Modificacion_Plataforma 
con la fecha y hora actual para llevar un control preciso de los cambios realizados.*/


DELIMITER //
CREATE TRIGGER before_update_estudiantes
BEFORE UPDATE ON estudiantes
FOR EACH ROW
BEGIN
  SET NEW.Fecha_Modificacion_Plataforma = NOW();
END;
//
DELIMITER ;

/* Este trigger actualiza automáticamente la columna Fecha_Modificacion_Plataforma 
de la tabla estudiantes cuando se modifica cualquier dato de un estudiante.
Este trigger se ejecuta antes de cada actualización en la tabla estudiantes 
y asegura que el campo Fecha_Modificacion_Plataforma se actualice con la fecha 
y hora actual automáticamente.*/






/*Enunciado 2: No se permitirá eliminar a un estudiante de la base de datos 
si tiene tareas pendientes en la tabla estudiantes_has_tareas. 
Antes de proceder con la eliminación, el sistema debe verificar 
si existen tareas con el estado 'Pendiente' y, en caso afirmativo, 
bloquear la eliminación y mostrar un mensaje de error.*/

DELIMITER //
CREATE TRIGGER before_delete_estudiante
BEFORE DELETE ON estudiantes
FOR EACH ROW
BEGIN
  DECLARE tareas_pendientes INT; -- delcara una variable, 
  
  SELECT COUNT(*)
  INTO tareas_pendientes. -- aqui guardas el resultado de esta query.
  FROM estudiantes_has_tareas.    
  WHERE Estudiantes_idEstudiantes = OLD.idEstudiantes
    AND Estado_Tarea = 'Pendiente';
  
  IF tareas_pendientes > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se puede eliminar el estudiante porque tiene tareas pendientes.';
  END IF;
END;
//
DELIMITER ;


/*Este trigger impide la eliminación de un estudiante si tiene tareas pendientes.
 Este trigger verifica si un estudiante tiene tareas pendientes antes de ser eliminado. 
 Si se encuentran tareas pendientes, se lanza un error y la operación de eliminación se cancela.*/







/* Enunciado 3: Cada vez que se inserte un nuevo profesor en la tabla profesores, 
se deberá actualizar la tabla roles asignando el idProfesores del profesor recién 
creado en la columna id_profesor de la fila correspondiente al rol con idroles = 1, 
para que el profesor recién creado se asocie automáticamente con el rol de revisor.*/


DELIMITER //
CREATE TRIGGER nuevo_profesor_revisor
AFTER INSERT ON profesores
FOR EACH ROW
BEGIN
  UPDATE roles
    SET roles.id_profesor = new.idProfesores 
    where roles.idroles = 1;
END;
 //
 DELIMITER ;

/*Este trigger asigna el rol de "Revisor_Tareas" automáticamente al crear un nuevo profesor.
Este trigger se ejecuta después de insertar un nuevo profesor, y 
automáticamente asigna el rol de "Revisor_Tareas" en la tabla roles.*/

/*Cada vez que se actualice un registro en la tabla proveedores, 
se deberá registrar automáticamente la fecha de modificación en la columna fecha_modificacion. 
Además, si alguno de los campos críticos como nombre, email, telefono o direccion es modificado, 
se debe registrar cuál de estos campos fue cambiado en la columna campo_modificado, 
de manera que se pueda identificar fácilmente qué información fue actualizada.*/


DELIMITER $$
create trigger trigger_proveedores
before UPDATE ON proveedores
FOR EACH ROW
BEGIN
	SET NEW.fecha_modificacion = now();
	
    IF old.nombre<>new.nombre then 
		set new.campo_modificado = 'nombre';
	elseif old.email<>new.email then
		set new.campo_modificado = 'email';
	elseif old.telefono<>new.telefono then
		set new.campo_modificado = 'telefono';
	elseif old.direccion<>new.direccion then
		set new.campo_modificado = 'direccion';
	END IF;
END $$

DELIMITER ;