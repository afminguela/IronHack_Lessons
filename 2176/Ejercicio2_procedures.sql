use ejercicio_2;
SET SQL_SAFE_UPDATES = 0;

-- 1. Procedure para generar un informe de los materiales disponibles

DELIMITER //

CREATE PROCEDURE obtener_materiales_disponibles()
BEGIN
    -- Selecciona todos los materiales que están disponibles
    SELECT * FROM Materiales WHERE Disponibilidad_Materiales = 1;
END //

DELIMITER ;

CALL obtener_materiales_disponibles();



-- 2. Procedure para poner a 0 el aforo de cursos pasados
DELIMITER //

CREATE PROCEDURE cerrar_cursos_pasados()
BEGIN
    -- Actualizar el aforo a 0 para los cursos que ya finalizaron
    UPDATE Cursos 
    SET Aforo_Curso = 0 
    WHERE fecha_fin_Curso < CURDATE();
END //

DELIMITER ;

CALL cerrar_cursos_pasados();


-- 3.Procedure con múltiples parámetros de entrada y salida
DELIMITER //

CREATE PROCEDURE agregar_profesor(
    IN nombre_profesor VARCHAR(100),
    IN correo_profesor VARCHAR(100),
    IN telefono_profesor VARCHAR(100),
    OUT nuevo_id INT,
    OUT estado_contrato VARCHAR(50)
)
BEGIN
    -- Insertar un nuevo profesor en la base de datos
    INSERT INTO Profesores (Nombre_Profesor, Correo_Profesor, Telefono_Profesor, Direccion_Profesor, HASH_PW_Profesor, Fecha_Contrato, Fecha_baja, Fecha_Modificacion)
    VALUES (nombre_profesor, correo_profesor, telefono_profesor, Direccion_Profesor, HASH_PW_PROFESOR, NOW(), '9999-12-31', NOW());

    -- Obtener el último ID insertado
    SET nuevo_id = LAST_INSERT_ID();

    -- Establecer el estado del contrato
    SET estado_contrato = 'Contrato Activo';
END //

DELIMITER ;
CALL agregar_profesor('Maria', 'maria@mail.com', 'HOLA123456389', @nuevo_id, @estado_contrato);
SELECT @nuevo_id, @estado_contrato;



-- 4.Cambiar la disponibilidad de los materiales que esten en un curso
DELIMITER //
CREATE PROCEDURE cambiar_disponibilidad_todos_materiales(IN nombre_curso VARCHAR(100))
BEGIN
    -- Actualizar el aforo a 0 para los cursos que ya finalizaron
    UPDATE Materiales m
    INNER JOIN materiales_has_cursos c on m.idMateriales = c.Materiales_idMateriales
    INNER JOIN cursos on cursos.idCursos = c.cursos_idCursos
    SET m.disponibilidad_materiales = 0 
    WHERE cursos.nombre_cursos = nombre_curso;
END //

DELIMITER ;

CALL cambiar_disponibilidad_todos_materiales('Curso de Metodologías Ágiles');

