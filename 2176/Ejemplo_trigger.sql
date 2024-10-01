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