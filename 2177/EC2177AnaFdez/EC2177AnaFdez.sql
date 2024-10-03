USE evaluacion_continua;


-- 1- Trigger: Crea un trigger que se dispare antes de insertar una nueva banda en la tabla Bandas que verifique si el país de origen ya tiene una banda de igual género musical. Si es así, cancela la inserción y lanza un error.

DROP TRIGGER Verifica_pais_y_genero;
DELIMITER //
CREATE TRIGGER Verifica_pais_y_genero
BEFORE INSERT ON Bandas 
FOR EACH ROW
BEGIN

IF 
EXISTS (SELECT 1 FROM Bandas WHERE Pais_origen = NEW.Pais_origen AND Genero_musical = Genero_musical)

THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Inserción cancelada, ya existe una banda en el pais del mismo género';
    END IF;

End;//

DELIMITER ;

-- TEST --- 
INSERT INTO Bandas (Nombre,Genero_musical,Pais_origen,Fecha_creacion) 
Values ('Muse', 'Rock', 'Reino Unido', now());

SELECT * FROM evaluacion_continua.Bandas; 


-- ------------------------------------------------------------------------------------------------------------------

-- 2- Trigger: Crea un trigger que se dispare después de actualizar la tabla Conciertos, y que automáticamente inserte la fecha y el concierto modificado en una tabla de auditoría llamada Auditoria_conciertos.

DROP TRIGGER Actualiza_auditoria;
CREATE TABLE Auditoria_conciertos (
    ID_Auditoria INT AUTO_INCREMENT NOT NULL,
    Concierto_ID_concierto INT NOT NULL,
    Fecha_modificacion DATETIME NOT NULL,
    PRIMARY KEY (ID_Auditoria),
    FOREIGN KEY (Concierto_ID_concierto)
        REFERENCES Conciertos (ID_concierto)
);

DELIMITER //
CREATE TRIGGER Actualiza_auditoria
AFTER UPDATE ON Conciertos 
FOR EACH ROW
BEGIN

INSERT INTO Auditoria_conciertos (Concierto_ID_concierto,Fecha_modificacion)
VALUES (new.ID_concierto, NOW());


  
End;//

DELIMITER ;

-- TEST --
UPDATE Conciertos 
SET 
    ID_banda = 3
WHERE
    ID_concierto = 1; -- cambiamos de los rolling a metálica el concierto de barcelona

SELECT 
    *
FROM
    evaluacion_continua.Auditoria_conciertos;


-- ------------------------------------------------------------------------------------------------------------------
-- 3- Transaction con Control de Errores: Crea una transacción que registre una nueva venta de merchandising. Debe insertar una nueva fila en la tabla Ventas_merchandising, reducir la cantidad disponible del artículo en un inventario (Crea tabla llamada Inventario_merchandising con los artículos disponibles), y si el artículo no tiene suficiente stock, debe abortar la transacción y lanzar un error. Si todo es correcto, la transacción debe completarse exitosamente.


CREATE TABLE Inventario_merchandising (
    ID_Inventario INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Articulo VARCHAR(100) NOT NULL,
    Precio INT NOT NULL,
    Talla VARCHAR(45),
    Cantidad INT NOT NULL,
    Disponible TINYINT DEFAULT 1
);
        
INSERT INTO Inventario_merchandising (Articulo, Precio, Talla, Cantidad, Disponible)
VALUES  ('Gorra', 10,null, 500, 1),
		('Camiseta Grupo', 25,'S', 250,1),
        ('Camiseta Grupo', 25,'M', 250,1),
        ('Camiseta Grupo', 25,'L', 250,1),
        ('Llavero',2,null,150,1),
        ('Camiseta Mujer Grupo', 25,'S', 250,1),
        ('Camiseta Mujer Grupo', 25,'M', 250,1),
        ('Camiseta Mujer Grupo', 25,'L', 250,1),
        ('Pack Pegatinas',3,null,150,1);

DROP PROCEDURE Nueva_Venta_Actualización_Stock;
DELIMITER // 
CREATE PROCEDURE  Nueva_Venta_Actualización_Stock(
			IN pArticulo VARCHAR(100),
            IN pCantidad INT
            )
BEGIN		-- Chivato de rollback super pro -- 
		    DECLARE pidArticulo INT;
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
 -- Cambio Nombre del articulo por su Id para hacer safe update por Index de primary key
    SET pidArticulo = (Select I.ID_Inventario from Inventario_merchandising I where I.Articulo = pArticulo);
 -- Si hay Stock...
    IF EXISTS (SELECT 1 From Inventario_merchandising I where I.Articulo = pArticulo and I.Cantidad > 0 AND I.Disponible = 1)
    THEN
-- Inserta datos en Ventas--
		INSERT INTO Ventas_merchandising (ID_concierto,Articulo,Cantidad,Ingresos)
        VALUES (2, pArticulo, pCantidad, 500);
        
-- actualiza inventario restando ventas.cantidad a inventario.cantidad
    	
        UPDATE Inventario_merchandising I SET I.Cantidad = (I.Cantidad -  pCantidad)
        WHERE I.Articulo = pArticulo ;
    -- Printa mensaje confirmacion
		SELECT 'He hecho el update' AS Mensaje;
           
		COMMIT;
    ELSE 
-- Si no lo hay Printa mensaje error
		SELECT CONCAT('no hay stock de ', pArticulo, ' suficiente') AS Mensaje;
    END IF;
 
END //

DELIMITER ;
-- TESTs --
CALL Nueva_Venta_Actualización_Stock('Gorra', 50);

SELECT * FROM Ventas_merchandising;

SELECT * FROM Inventario_merchandising;
-- Test de que no hay stock
UPDATE Inventario_merchandising SET Disponible = 0 where ID_Inventario = 1;
CALL Nueva_Venta_Actualización_Stock('Gorra', 50);

-- ------------------------------------------------------------------------------------------------------------------

-- 4- Informe con Procedure: Crea un procedimiento almacenado que genere un informe con los ingresos totales por merchandising para cada concierto, incluyendo un condicional que filtre solo los conciertos que han generado más de 5000 euros en ingresos. Utiliza un WHILE loop para recorrer los conciertos y sumar los ingresos.

DROP PROCEDURE Informe_Ingresos_Merchan;
DELIMITER //
CREATE PROCEDURE Informe_Ingresos_Merchan()
BEGIN
-- Varias Variables:
			DECLARE fin int default 0; -- > n.m: esta es para el cursor que si no está protesta.
            DECLARE pIdConcierto INT;
			DECLARE pIngresos decimal (10,2) default 0;
			DECLARE error_message VARCHAR(2000); 
            DECLARE error_code INT;
			
-- Mete un cursor... Porlo visto tiene que ir antes del Handler auqneu sea el del rollback,
DECLARE cur_conciertos CURSOR FOR 
        SELECT VM.ID_concierto, SUM(VM.Ingresos) as total_ingresos
        FROM Ventas_merchandising VM
        GROUP BY VM.ID_concierto
        HAVING total_ingresos > 5000
        ORDER BY VM.ID_concierto;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
 
 -- Super combo rollback   
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
				END;
    
-- Crear una tabla temporal para meter los resultados en algun sitio... y poder usarlos luegos ( meme de OBVIO)
CREATE TEMPORARY TABLE IF NOT EXISTS Informe_Ingresos (
        ID_concierto INT,
        Ingresos_Totales DECIMAL(10,2)
    );
    OPEN cur_conciertos;
-- THE WHILE: Por cada entrada suma los ingresos en merchan    
read_loop: LOOP
        FETCH cur_conciertos INTO pIdConcierto, pIngresos;
        IF fin THEN
            LEAVE read_loop;  -- Esto tb es importante, si no acabas como con las entradas... con 13459282364. 
        END IF;

        -- Insertar en la tabla temporal
        INSERT INTO Informe_Ingresos (ID_concierto, Ingresos_Totales)
        VALUES (pIdConcierto, pIngresos);
    END LOOP;
    CLOSE cur_conciertos;
-- Printa el Informe
    SELECT C.Ciudad, I.Ingresos_Totales
    FROM Informe_Ingresos I 
    inner join Conciertos C ON C.ID_Concierto = I.ID_Concierto 
    ORDER BY Ingresos_Totales DESC;

    -- Matar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS Informe_Ingresos;     
 END;  //     
     

DELIMITER ;

DROP PROCEDURE Informe_Ingresos_Merchan;
-- TESTS 
 CALL Informe_Ingresos_Merchan();

-- ------------------------------------------------------------------------------------------------------------------
-- 5- Procedure con Transaction y Control de Errores: Crea un procedimiento almacenado que inserte una nueva entrada en la tabla Entradas. El procedimiento debe comenzar con una transacción y utilizar un WHILE loop para verificar si el asistente ya tiene entradas para otros conciertos de la misma banda en fechas diferentes. Si existe alguna entrada duplicada, debe abortar la transacción y lanzar un error.

DROP PROCEDURE Entradas_Duplicadas;
DELIMITER //
CREATE PROCEDURE Entradas_Duplicadas(
			IN pidConcierto INT,
			IN pidAsistente INT
			)
BEGIN 
			DECLARE pCompra TinyINT DEFAULT false;
            DECLARE pidBanda INT;
            DECLARE pFecha datetime;
            
            DECLARE error_message VARCHAR(2000);
			DECLARE error_code INT;
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
				BEGIN 
						
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
                   
                 END;
-- 
START TRANSACTION;
-- Seleccionar y guardar banda y fecha (no me ha dejado hacerlo en una sola... \_(¨)_/ )
		
			SELECT  ID_banda INTO pidBanda 
            FROM Conciertos AS C 
            WHERE C.ID_concierto = pidConcierto;
            SELECT Fecha INTO pFecha 
            FROM Conciertos AS C
            WHERE C.ID_concierto = pidConcierto;
	
-- El WHILE DICHOSO cuenta duplicados, si hay duplicados frena 
WHILE NOT pCompra DO
	IF EXISTS(
        SELECT 1 
        FROM Entradas E 
        WHERE E.ID_asistente = pidAsistente AND E.ID_concierto = pidConcierto )
	THEN
        SELECT 'Ya Tiene una entrada, no puede comprar'as Mensaje; -- Flag 1
        SET pCompra = true;
	ELSEIF EXISTS(
            SELECT 1 
            FROM Entradas E 
            INNER JOIN Conciertos C ON C.ID_concierto = E.ID_concierto
            WHERE E.ID_asistente = pidAsistente AND C.ID_banda = pidBanda  AND C.Fecha = pFecha AND E.ID_concierto <> pidConcierto)
	THEN	
        SET pCompra = true;
        
        SELECT 'Ya Tiene una entrada para la misma banda y fecha, no puede comprar'as Mensaje;
    ELSE
        INSERT INTO Entradas(ID_asistente,ID_concierto,Precio,Fecha_creacion)
        VALUES ( pidAsistente, pidConcierto, 75, NOW());
        
        SELECT 'Enhorabuena, Ha comprador una entrada' AS Mensaje; -- Flag 2
        
        SET pCompra = true;
    END IF;
     
END WHILE ;
    
  COMMIT;
  END;

//

DELIMITER ;

-- Tests -- 
CALL Entradas_Duplicadas(2,7);
SELECT * FROM Entradas;

-- ------------------------------------------------------------------------------------------------------------------

-- 6- Procedure con Control de Errores y Loop: Crea un procedimiento almacenado que inserte una nueva venta de merchandising en la tabla Ventas_merchandising. Si el concierto asociado no existe, el procedimiento debe lanzar un error y no realizar la inserción. Utiliza un WHILE loop para verificar si el artículo ya ha sido vendido previamente en ese concierto, y si es así, aumenta la cantidad en lugar de insertar una nueva fila.

DROP PROCEDURE NUEVA_VENTA_MERCHAN;
DELIMITER //
CREATE PROCEDURE NUEVA_VENTA_MERCHAN (
IN pConcierto INT,
IN pArticulo VARCHAR (100),
IN pCantidadVendida INT,
IN pIngresos INT

)
BEGIN
-- VARIAS VARIABLES
				
				DECLARE pVenta BOOLEAN DEFAULT false; -- testigo para el while
                DECLARE pCantidad_actual INT;     -- la cantidad que ya hay en la tabla
				DECLARE pArticuloVendido INT; -- cuantos articulos se han vendido, para el if2
                DECLARE pIngresos_actual INT;
				DECLARE error_message VARCHAR(2000);
				DECLARE error_code INT;
				DECLARE EXIT HANDLER FOR SQLEXCEPTION -- El super Rollback
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
                        
				END;
START TRANSACTION;
-- Comprueba que existe el concierto
   IF EXISTS ( Select 1 from Conciertos C WHERE C.ID_concierto = pConcierto) -- IF 1
    THEN
        WHILE NOT pVenta DO
        -- Chequea que si existe el articulo y me guarda los valores de cuantos articulos, la cantidad y los ingresos en variables
        SELECT COUNT(*)
        INTO pArticuloVendido
        FROM Ventas_merchandising VM
        WHERE VM.ID_concierto = pConcierto AND VM.Articulo = pArticulo;
        
        SELECT Cantidad
        INTO pCantidad_actual
        FROM Ventas_merchandising VM
        WHERE VM.ID_concierto = pConcierto AND VM.Articulo = pArticulo;
        
		SELECT Ingresos
        INTO pIngresos_actual
        FROM Ventas_merchandising VM
        WHERE VM.ID_concierto = pConcierto AND VM.Articulo = pArticulo;
       
       -- Si existe la venta actualiza valor cantidad
        IF pArticuloVendido > 0 THEN  -- IF2
            -- Actualizar la venta existente
            UPDATE Ventas_merchandising VM
            SET Cantidad = pCantidad_actual + pCantidadVendida,
				Ingresos = pIngresos + pIngresos_actual
            WHERE VM.ID_concierto = pConcierto AND VM.Articulo = pArticulo;
            
            SET pVenta = TRUE;
        ELSE    -- Insertar la fila con la venta nueva y los valores de los IN
        INSERT INTO Ventas_merchandising (ID_concierto,Articulo,Cantidad, Ingresos)
        VALUES(pConcierto,pArticulo,pCantidadVendida,pIngresos);
        END IF;
        SELECT Concat('Has registrado correctamente la venta de ', pArticulo,' con la cantidad de ',pCantidadVendida) as Mensaje;
        END WHILE;
   -- SI no se cumple lo anterior , lanza error
   ELSE
		SELECT 'El concierto no existe'as Mensaje;
    END IF;    -- FIN IF1
        
                    
 COMMIT;       
    
END //
DELIMITER ;        

DROP PROCEDURE NUEVA_VENTA_MERCHAN;

CALL NUEVA_VENTA_MERCHAN (4,'Gorra',50,500);        
SELECT * FROM Ventas_merchandising;        
-- ------------------------------------------------------------------------------------------------------------------
-- 7- Formulario con Procedure y Loop: Crea un procedimiento almacenado que reciba como entrada el nombre de una banda, el género musical, el país de origen, y verifique si ya existe una banda en ese país con el mismo género. Si no existe, inserta la nueva banda. Utiliza un WHILE loop para verificar que los nombres de las bandas similares no coinciden con la nueva banda antes de hacer la inserción. AND Es la única prueba
DROP TRIGGER Verifica_pais_y_genero;
DROP PROCEDURE NUEVA_BANDA_SIN_REPETIR;
DELIMITER //
CREATE PROCEDURE NUEVA_BANDA_SIN_REPETIR (
		IN pNombreBanda VARCHAR (100),
        IN pGenero varchar(50),
        IN pPais Varchar(50))
        
BEGIN

-- VArias Variables
				DECLARE pidBanda INT;
				DECLARE banda_existe BOOLEAN DEFAULT FALSE;
				DECLARE nombre_similar VARCHAR(100);
				DECLARE PalWhile BOOLEAN DEFAULT FALSE;
				DECLARE error_message VARCHAR(2000);
				DECLARE error_code INT;
        		-- Cursor para comparar los nombres uno a uno		
        DECLARE curBanda CURSOR FOR 
        SELECT Nombre 
        FROM Bandas B
        WHERE B.Pais_origen = pPais AND B.Genero_musical = pGenero;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET PalWhile = TRUE;
        
                /*DECLARE EXIT HANDLER FOR SQLEXCEPTION -- El super Rollback
				BEGIN 
						GET DIAGNOSTICS CONDITION 1 error_code = MYSQL_ERRNO;
						ROLLBACK;	
                        SET error_message = Concat('Me he vuelto al Rollback, He dado error:  ', error_code);
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = error_message;
                        
				END;*/

		

START TRANSACTION;
        
        
-- Modifica valores en texto a ID--
SET pidBanda = (Select B.ID_Banda from Bandas B where B.Nombre = pNombreBanda);        
        -- Verifica si existe una banda de igual género en el pais --  
IF not Exists (Select Count(ID_Banda) from Bandas B WHERE B.ID_banda = pidBanda or (B.Pais_origen = pPais AND B.Genero_musical = pGenero)) -- IF1
	THEN      -- Si existe comprobamos el nombre si suena parecido tb
		 OPEN curBanda;
        read_loop: WHILE NOT PalWhile DO  
            FETCH curBanda INTO nombre_similar;
            IF NOT PalWhile THEN   -- revisa que los nombres no suenen parecido
                IF SOUNDEX(nombre_similar) = SOUNDEX(pNombreBanda)  -- Pues resulta que existe una función que compara foneticamente los nombres
                THEN
                    SET banda_existe = TRUE;   -- si suenan parecidos la toma como que existe la banda y la manda al IF3
                    LEAVE read_loop;
                END IF;
            END IF;
        END WHILE;
        CLOSE curBanda;

        IF banda_existe    -- si definitivamente existe Error no insert  -- IF3
        THEN
            SELECT CONCAT('¡Lo siento Prenda!, ya existe una banda similar (', nombre_similar, ') en ', pPais, ' con el género ', pGenero) AS Mensaje;
       
	    ELSE  -- Si no existe, Inserta la banda nueva
			INSERT INTO Bandas (Nombre,Genero_musical,Pais_origen,Fecha_creacion)
			VALUES (pNombreBanda,pGenero,pPais, now());
		    SELECT Concat(pNombreBanda, ' ha sido registrada, Bienvenido al Tour') as Mensaje;  -- mensaje de confirmación
		END IF;
	ELSE                   -- Si no Existe, la crea en el registro,  ale pa dentro del tour
      INSERT INTO Bandas (Nombre,Genero_musical,Pais_origen,Fecha_creacion)
	  VALUES (pNombreBanda,pGenero,pPais, now());
	  SELECT Concat(pNombreBanda, ' ha sido registrada, Bienvenido al Tour') as Mensaje;  -- mensaje de confirmación
END IF;
Commit;
END //
DELIMITER ;

DROP PROCEDURE NUEVA_BANDA_SIN_REPETIR;
CALL  NUEVA_BANDA_SIN_REPETIR ('rolin estons','Rock','Reino Unido');

Select * from Bandas;


-- ------------------------------------------------------------------------------------------------------------------

-- 8- Function con Loop: Crea una función que, dado el ID de un concierto, devuelva el total de ingresos por ventas de merchandising para ese concierto. Utiliza un WHILE loop para sumar cada una de las ventas de merchandising asociadas al concierto. La función debe realizar cálculos matemáticos para sumar los ingresos y retornar el valor, manejando los posibles casos en los que no haya ventas.

DROP FUNCTION Ingresos_Concierto;
DELIMITER //
CREATE FUNCTION Ingresos_Concierto (pIdConcierto INT) RETURNS VARCHAR (100)
READS SQL DATA
BEGIN
-- Varias Variables
DECLARE Total_Ventas DECIMAL (10,2) DEFAULT 0;
DECLARE Ingresos_actuales DECIMAL (10,2);
DECLARE freno BOOLEAN DEFAULT FALSE;
DECLARE devolucion varchar(100);

--  Cursor para recorrer Ventas_Merchan
DECLARE curIngresos CURSOR FOR
	SELECT Ingresos
    FROM Ventas_merchandising VM
    WHERE VM.ID_concierto = pIdConcierto;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET freno = TRUE;

	OPEN curIngresos;
WHILE NOT freno DO
	FETCH curIngresos INTO Ingresos_actuales;
    IF NOT freno 
    THEN
		set Total_Ventas = Total_Ventas + Ingresos_Actuales;
	END IF;
    END WHILE;
    CLOSE curIngresos;
	
    IF Total_Ventas > 0 THEN
		set devolucion =  CONCAT('Total ingresos: ', Total_Ventas);
        RETURN  devolucion;
    
    ELSE
        RETURN 'No hay ventas registradas para este concierto';

    END IF;

END //

DELIMITER ;
Select Ingresos_Concierto(23) as Ingresos ;
Select * from Asistentes;
select 1+1 as suma;

-- ------------------------------------------------------------------------------------------------------------------

-- 9- Formulario con Procedure y Loop: Crea un procedimiento almacenado que permita la creación de una nueva entrada en la tabla Entradas, comprobando que la edad del asistente sea mayor de 18 años. Si el asistente es menor de 18 años, lanza un error. Utiliza un WHILE loop para recorrer la lista de asistentes menores de edad que intenten registrarse, y si se encuentran, se deben rechazar todas las entradas.

DROP PROCEDURE Crear_Entrada_Adultos;
DELIMITER //

CREATE PROCEDURE Crear_Entrada_Adultos(
    IN p_id_concierto INT,
    IN p_id_asistente INT,
    IN p_precio DECIMAL(10,2)
)
BEGIN
    DECLARE pedad INT;
    DECLARE menores_encontrados BOOLEAN DEFAULT FALSE;
    DECLARE asistente_actual INT;
    DECLARE freno BOOLEAN DEFAULT FALSE;
    
    DECLARE curAsistentes CURSOR FOR 
        SELECT ID_asistente 
        FROM Asistentes 
        WHERE Edad < 18;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET freno = TRUE;

    -- Verificar la edad del asistente
    SELECT Edad INTO pedad 
    FROM Asistentes 
    WHERE ID_asistente = p_id_asistente;

    IF pedad < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El asistente es menor de 18 años.';
    ELSE
        -- Verificar si hay menores intentando registrarse
        OPEN curAsistentes;
        
        check_menores: WHILE NOT freno DO
            FETCH curAsistentes INTO asistente_actual;
            IF NOT freno THEN
                SET menores_encontrados = TRUE;
                END IF;
        END WHILE;
        
        CLOSE curAsistentes;

        IF menores_encontrados THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Se encontraron menores de edad intentando Colarse. Todas las entradas han sido rechazadas.';
            
        ELSE
            -- Insertar la nueva entrada
            INSERT INTO Entradas (ID_concierto, ID_asistente, Precio, Fecha_creacion)
            VALUES (p_id_concierto, p_id_asistente, p_precio, NOW());
            
            SELECT 'Bien!!, Entrada comprada Difruta del concierto' AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;
DROP PROCEDURE Crear_Entrada_Adultos;
CALL Crear_Entrada_Adultos (21, 2, 75);
-- He insertado una señora jejeje de 17 y otra de 14 jejeje

select * from Asistentes;

-- ------------------------------------------------------------------------------------------------------------------

-- 10- Informe con Procedure y Loop: Crea un procedimiento que genere un informe detallado de todos los conciertos de una banda específica, incluyendo la cantidad de asistentes y el total de ingresos generados por merchandising y entradas. Utiliza un WHILE loop para recorrer cada concierto de la banda, sumar los ingresos, y verificar que haya asistentes para cada concierto. Si un concierto no tiene asistentes o ventas, genera un mensaje de advertencia.

DROP PROCEDURE Informe_Conciertos_Banda;
DELIMITER //
CREATE PROCEDURE Informe_Conciertos_Banda(
	IN pNombre_banda VARCHAR(100))
BEGIN
-- Varias Variables
    DECLARE freno INT DEFAULT FALSE;
    DECLARE pID_concierto INT;
    DECLARE pFecha DATE;
    DECLARE pCiudad VARCHAR(100);
    DECLARE pEscenario VARCHAR(100);
    DECLARE pAsistentes INT;
    DECLARE pIngresos_merch DECIMAL(10,2);
    DECLARE pIngresos_entradas DECIMAL(10,2);
    DECLARE pTotal_ingresos DECIMAL(10,2);
    DECLARE pMensaje VARCHAR(1000);
    DECLARE pID_banda INT;

    -- Cursor para recorrer los conciertos de la banda
    DECLARE cur_conciertos CURSOR FOR 
        SELECT C.ID_concierto, C.Fecha, C.Ciudad, C.Escenario
        FROM Conciertos C
        JOIN Bandas B ON C.ID_banda = B.ID_banda
        WHERE B.Nombre = pNombre_banda
        ORDER BY C.Fecha;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET freno = TRUE;

    -- Obtener el ID de la banda desde el nombre
    SELECT ID_banda INTO pID_banda 
    FROM Bandas B
    WHERE B.Nombre = pNombre_banda;

    IF pID_banda IS NULL THEN
        SELECT 'La banda especificada no existe' AS Mensaje;
    ELSE
        -- Crear tabla temporal para almacenar resultados
        CREATE TEMPORARY TABLE IF NOT EXISTS Informe_Temporal (
            ID_concierto INT,
            Fecha DATE,
            Ciudad VARCHAR(100),
            Escenario VARCHAR(100),
            Asistentes INT,
            Ingresos_Merchandising DECIMAL(10,2),
            Ingresos_Entradas DECIMAL(10,2),
            Total_Ingresos DECIMAL(10,2),
            Mensaje VARCHAR(1000)
        );

        OPEN cur_conciertos;

      WHILE NOT freno DO
            FETCH cur_conciertos INTO pID_concierto, PFecha, pCiudad, pEscenario;
            IF NOT freno THEN
                -- Contar asistentes
                SELECT COUNT(DISTINCT E.ID_asistente) INTO pAsistentes
                FROM Entradas E
                WHERE E.ID_concierto = pID_concierto;

                -- Calcular ingresos por merchandising
                SELECT IFNULL(SUM(VM.Ingresos), 0) INTO pIngresos_merch
                FROM Ventas_merchandising VM
                WHERE VM.ID_concierto = pID_concierto;

                -- Calcular ingresos por entradas
                SELECT IFNULL(SUM(E.Precio), 0) INTO pIngresos_entradas
                FROM Entradas E
                WHERE E.ID_concierto = pID_concierto;

                SET pTotal_ingresos = pIngresos_merch + pIngresos_entradas;

                -- Chivatos de Errores
                IF (pTotal_ingresos = 0) AND (pAsistentes = 0) THEN
					SET pMensaje = 'Este concierto fue un desastre';
                ELSEIF pTotal_ingresos = 0 THEN
                    SET pMensaje = 'En este concierto no se Vendió nada';
                ELSEIF pAsistentes = 0 THEN
                    SET pMensaje = 'A este concierto no vino nadie.';
                ELSE 
                    SET pMensaje = 'En este hicimos duros';
                END IF;

                -- Insertar en la tabla temporal
                INSERT INTO Informe_Temporal VALUES (
                    pID_concierto, pFecha, pCiudad, pEscenario, pAsistentes, 
                    pIngresos_merch, pIngresos_entradas, pTotal_ingresos, pMensaje
                );
            END IF;
        END WHILE;

        CLOSE cur_conciertos;

        -- Mostrar resultados
        SELECT * FROM Informe_Temporal;

        -- Limpiar
        DROP TEMPORARY TABLE IF EXISTS Informe_Temporal;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE Informe_Conciertos_Banda;
CALL Informe_Conciertos_Banda('The Rolling Stones');