use ejercicio_2;
SET SQL_SAFE_UPDATES = 0;
set FOREIGN_KEY_CHECKS = 0;

-- 1. Transacción para matricular a un estudiante en un curso con manejo básico de errores.
DELIMITER //
CREATE PROCEDURE matricular_estudiante()
BEGIN
    -- Manejador para errores SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Si ocurre un error, hacer ROLLBACK
        ROLLBACK;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha hecho Rollback de la transacción';
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Insertar la matrícula del estudiante en el curso
    INSERT INTO Cursos_has_Estudiantes (Cursos_idCursos, Estudiantes_idEstudiantes, fecha_Matriculacion, fecha_Baja, Calificaciones_idCalificaciones)
    VALUES (1, 1, NOW(), NULL, 1);

    -- Actualizar el aforo del curso
    UPDATE Cursos SET Aforo_Curso = Aforo_Curso - 1 WHERE idCursos = 1;

    -- Confirmar la transacción
    COMMIT;
END //
DELIMITER ;


CALL matricular_estudiante();



-- Ejemplo 2: Actualizar información de un profesor y su curso con manejo de errores.
DELIMITER //
CREATE PROCEDURE actualizar_profesor_y_curso(
    IN profesor_id INT, 
    IN nuevo_nombre VARCHAR(100), 
    IN nuevo_curso INT)
BEGIN
    -- Manejador para errores SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Si ocurre un error, hacer ROLLBACK
        ROLLBACK;
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Actualizar el nombre del profesor
    UPDATE Profesores
    SET Nombre_Profesor = nuevo_nombre
    WHERE idProfesores = profesor_id;

    -- Asignar el nuevo curso al profesor
    UPDATE Cursos_has_Profesores
    SET Cursos_idCursos = nuevo_curso
    WHERE Profesores_idProfesores = profesor_id;

    -- Confirmar la transacción
    COMMIT;
END //
DELIMITER ;

CALL actualizar_profesor_y_curso(1, 'Paquito', 3);

select * from Cursos_has_Profesores;
drop procedure registrar_curso_y_material;
-- 3.Registrar un nuevo curso y asignar materiales con manejo de errores.
DELIMITER //
CREATE PROCEDURE registrar_curso_y_material(
    IN curso_nombre VARCHAR(100),
    IN descripcion TEXT,
    IN fecha_inicio DATE,
    IN fecha_fin DATE,
    IN material_titulo VARCHAR(100),
    IN material_tipo ENUM('Video', 'audio', 'Documento', 'URL', 'Otros')
)
BEGIN
    -- Manejador para errores SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Si ocurre un error, hacer ROLLBACK
        ROLLBACK;
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Insertar un nuevo curso
    INSERT INTO Cursos (Nombre_Cursos, Descripcion_curso, Fecha_inicio_Curso, fecha_fin_Curso)
    VALUES (curso_nombre, descripcion, fecha_inicio, fecha_fin);

    -- Insertar un nuevo material asociado al curso
    INSERT INTO Materiales (Titulo_Materiales, Tipo_Materiales)
    VALUES (material_titulo, material_tipo);

    -- Confirmar la transacción
    COMMIT;
END //
DELIMITER ;


CALL registrar_curso_y_material(
    'Curso de Bases de Datos',        -- Nombre del curso
    'Curso completo sobre bases de datos relacionales',  -- Descripción del curso
    '2024-10-01',                     -- Fecha de inicio del curso
    '2024-12-15',                     -- Fecha de fin del curso
    'Manual de MySQL',                -- Título del material
    'Documento'                       -- Tipo del material (puede ser 'Video', 'audio', 'Documento', 'URL', 'Otros')
);

select * from cursos;