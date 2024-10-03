USE Torneo;

-- 1 Mostrar todas las carreras en las que participó un piloto específico, incluyendo el drone que utilizó y su posición final. (Usar JOIN entre pilotos, carreras y resultados).

Select p.Nombre, c.Pista, c.Ciudad, c.Fecha, r.Posicion, d.Marca, d.Modelo
FROM Resultados r
inner join  Pilotos p ON r.id_Piloto = p.id_Piloto
inner join Carreras c ON r.id_Carrera = c.id_Carrera
inner Join DRONES d ON r.id_Dron = d.id_DRON
WHERE p.Nombre like 'Luis%';


-- 2 Mostrar todas las carreras en las que un drone con velocidad máxima mayor a 200 km/h participó. (Usar WHERE con una condición sobre la velocidad del drone).

SELECT c.Fecha,c.Pista,c. Ciudad,d.Marca,d.Modelo, d.`Velocidad _Max`,r.Posicion
FROM Resultados r
Inner Join DRONES d ON d.id_DRON = r.id_Dron
inner Join Carreras c ON r.id_Carrera = c.id_Carrera
WHERE d.`Velocidad _Max` > 200;


-- 3 Calcular el tiempo promedio de carrera por cada piloto, utilizando una subconsulta o WITH. Mostrar solo los pilotos que hayan participado en al menos 3 carreras.

SELECT p.Nombre, AVG(r.Tiempo) as Tiempo_promedio, count(DISTINCT r.id_Carrera) as Carreras_participadas
From Pilotos p
inner join (SELECT  id_Piloto, id_Carrera, Tiempo
              FROM Resultados
              WHERE Tiempo IS NOT NULL) r ON p.id_Piloto = r.id_Piloto
GROUP BY p.Nombre
HAVING 
    COUNT(DISTINCT r.id_Carrera) >= 3
ORDER BY 
    Tiempo_Promedio ASC;
-- 4 Mostrar el mejor tiempo (más rápido) de cada drone en todas las carreras en las que ha participado, utilizando PARTITION BY para agrupar por drone.
WITH RankedTimes AS (
    SELECT d.id_DRON, d.Marca, d.Modelo,  r.id_Carrera, r.tiempo,
        ROW_NUMBER() OVER (PARTITION BY d.id_DRON ORDER BY r.tiempo ASC) AS tiempo_rank
    FROM  DRONES d
    INNER JOIN Resultados r ON d.id_DRON = r.id_Dron
    WHERE r.tiempo IS NOT NULL
)
SELECT 
    id_DRON,
    Marca,
    Modelo,
    id_Carrera AS Carrera_Mejor_Tiempo,
    tiempo AS Mejor_Tiempo
FROM 
    RankedTimes -- el with
WHERE 
    tiempo_rank = 1
ORDER BY 
    tiempo ASC;
-- 5 Mostrar el nombre de los pilotos y el número de carreras que han ganado (posición 1). Si no han ganado ninguna carrera, mostrar "Ninguna". Utilizar IFNULL para manejar los casos sin victorias y LOWER para mostrar los nombres de los pilotos en minúsculas.

SELECT 
    LOWER(p.Nombre) AS Nombre_Piloto,
    IFNULL(victorias.Carreras_Ganadas, 'Ninguna') AS Carreras_Ganadas
FROM 
    Pilotos p
LEFT JOIN (
    SELECT 
        id_Piloto,
        COUNT(*) AS Carreras_Ganadas
    FROM 
        Resultados
    WHERE 
        Posicion = 1
    GROUP BY 
        id_Piloto
) victorias ON p.id_Piloto = victorias.id_Piloto
ORDER BY 
    CASE 
        WHEN victorias.Carreras_Ganadas IS NULL THEN 0 
        ELSE victorias.Carreras_Ganadas 
    END DESC,
    p.Nombre;
-- Trigger:
-- 1 Crea un trigger que se active cuando se inserte un nuevo resultado de una carrera, actualizando automáticamente el rendimiento del drone (velocidad promedio y tiempo total en carrera) en la tabla de drones.

ALTER TABLE DRONES
ADD COLUMN velocidad_promedio DECIMAL(10,2) DEFAULT 0,
ADD COLUMN tiempo_total_carrera TIME DEFAULT '00:00:00';

DELIMITER //

CREATE TRIGGER actualizar_rendimiento_dron
AFTER INSERT ON Resultados
FOR EACH ROW
BEGIN
    DECLARE total_tiempo TIME;
    DECLARE total_carreras INT;
    DECLARE velocidad_avg DECIMAL(10,2);
    
    -- Calcular el tiempo total en carreras para el dron
    SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(tiempo))) INTO total_tiempo
    FROM Resultados
    WHERE id_Dron = NEW.id_Dron AND tiempo IS NOT NULL;
    
    -- Contar el número total de carreras para el dron
    SELECT COUNT(*) INTO total_carreras
    FROM Resultados
    WHERE id_Dron = NEW.id_Dron AND tiempo IS NOT NULL;
    
    -- Calcular la velocidad promedio
    -- Asumimos que todas las carreras tienen la misma distancia, por ejemplo, 1000 metros
    SET velocidad_avg = (1000 * total_carreras) / (TIME_TO_SEC(total_tiempo) / 3600);
    
    -- Actualizar la tabla DRONES
    UPDATE DRONES
    SET 
        velocidad_promedio = velocidad_avg,
        tiempo_total_carrera = total_tiempo
    WHERE id_DRON = NEW.id_Dron;
END //

DELIMITER ;




-- Procedimiento (Formulario):
-- 1 Crea un procedimiento almacenado que permita registrar una nueva carrera y el resultado de un drone en esa carrera. El procedimiento debe:
-- - Registrar la carrera: Incluir la fecha y la pista de la competencia.
-- - Insertar el resultado del drone: Incluir el drone, piloto, posición final, tiempo de carrera, y cualquier problema técnico.
-- - Verificar la existencia: Comprobar si el drone y el piloto están registrados en el sistema antes de insertar el resultado.
-- - Actualizar estadísticas: Si el drone queda en primer lugar, actualizar el número de victorias del piloto y el rendimiento del drone.
-- *Se debe crear un campo en la tabla de piloto para almacenar el número de victorias.
ALTER TABLE Pilotos
ADD COLUMN numero_victorias INT DEFAULT 0;

ALTER TABLE Carreras
MODIFY COLUMN Fecha DATETIME NOT NULL,
MODIFY COLUMN Pista VARCHAR(100) NOT NULL;

DELIMITER //

CREATE PROCEDURE registrar_carrera_y_resultado(
    IN p_fecha DATETIME,
    IN p_pista VARCHAR(100),
    IN p_ciudad VARCHAR(100),
    IN p_id_dron INT,
    IN p_id_piloto INT,
    IN p_posicion INT,
    IN p_tiempo TIME,
    IN p_problema_tecnico VARCHAR(200)
)
BEGIN
    DECLARE v_id_carrera INT;
    DECLARE v_drone_existe INT;
    DECLARE v_piloto_existe INT;
    
    -- Iniciar transacción
    START TRANSACTION;
    
    -- Verificar existencia del drone y piloto
    SELECT COUNT(*) INTO v_drone_existe FROM DRONES WHERE id_DRON = p_id_dron;
    SELECT COUNT(*) INTO v_piloto_existe FROM Pilotos WHERE id_Piloto = p_id_piloto;
    
    IF v_drone_existe = 0 OR v_piloto_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El drone o el piloto no existen en el sistema.';
        ROLLBACK;
    ELSE
        -- Registrar la carrera
        INSERT INTO Carreras (Fecha, Pista, Ciudad)
        VALUES (p_fecha, p_pista, p_ciudad);
        
        SET v_id_carrera = LAST_INSERT_ID();
        
        -- Insertar el resultado
        INSERT INTO Resultados (id_Dron, id_Carrera, id_Piloto, Posicion, tiempo, Problema_tecnico)
        VALUES (p_id_dron, v_id_carrera, p_id_piloto, p_posicion, p_tiempo, p_problema_tecnico);
        
        -- Si el drone queda en primer lugar
        IF p_posicion = 1 THEN
            -- Actualizar número de victorias del piloto
            UPDATE Pilotos
            SET numero_victorias = numero_victorias + 1
            WHERE id_Piloto = p_id_piloto;
            
            -- Actualizar rendimiento del drone
            UPDATE DRONES
            SET 
                velocidad_promedio = (
                    SELECT AVG(1000 / TIME_TO_SEC(tiempo) * 3600)
                    FROM Resultados
                    WHERE id_Dron = p_id_dron AND Posicion = 1
                ),
                tiempo_total_carrera = (
                    SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(tiempo)))
                    FROM Resultados
                    WHERE id_Dron = p_id_dron
                )
            WHERE id_DRON = p_id_dron;
        END IF;
        
        COMMIT;
        
        SELECT 'Carrera y resultado registrados con éxito.' AS Mensaje;
    END IF;
END //

DELIMITER ;

CALL registrar_carrera_y_resultado(
    '2023-11-15 14:00:00',  -- Fecha
    'Circuito Urbano',      -- Pista
    'Madrid',               -- Ciudad
    1,                      -- ID del drone
    1,                      -- ID del piloto
    1,                      -- Posición (1 para primer lugar)
    '00:02:15',             -- Tiempo
    NULL                    -- Problema técnico (NULL si no hubo problemas)
);
