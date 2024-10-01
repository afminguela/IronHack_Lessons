USE ejecico7;

/*SELECT trigger_name, action_timing, event_manipulation, event_object_table, action_statement
FROM information_schema.triggers
WHERE trigger_schema = 'ejercico7';

-- ALTER TABLE Persona;
-- UPDATE persona 
-- SET 
    -- Nombre = 'Juan'
-- WHERE
    -- idPersona = 1;

-- Insert into Persona (Nombre,1erApellido,2ºApellido,Planeta_idPlaneta,Telefono,Mail)
-- Values ('Maricarmen', 'pérez', 'gómez', 1, 123245332, 'maricarmen@gmail.com');
*/
ALTER TABLE ejercico7.Inventario;

DESCRIBE ejercico7.Inventario;

SELECT  * FROM  Inventario;

UPDATE Inventario SET Producto = 'Cocacola' WHERE idInventario= 4;

Drop TRigger Check_hay_hueco2;

DELETE FROM Inventario WHERE idInventario = 4;

INSERT INTO Inventario (`Producto`, `Categoria`, `Descripcion`, `Cantidad`, `FechaRecepcion`, `idSuministro`, CapacidadMax) 
VALUES ('Alpargatas', 'Equipamiento', 'para tener los pies calentitos', '999999.00', '2024-09-29 14:00:00', '5', '500');

INSERT INTO Inventario (`Producto`, `Categoria`, `Descripcion`, `Cantidad`, `FechaRecepcion`, `idSuministro`, CapacidadMax) 
VALUES ('Bambas ', 'Equipamiento', 'para tener los pies calentitos', '999999.00', '2024-09-29 14:00:00', '5', '500');

SHOW TABLES LIKE 'Inventario';

SHOW INDEX FROM ejercico7.Inventario;
SHOW FULL COLUMNS FROM ejercico7.Inventario;

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO Empleado (Rol,LugarTrabajo,Persona_idPersona)
VALUES ('enfermera', 'HospitalEspacial', 3);


DELETE FROM Planetas WHERE idPlaneta = 1;