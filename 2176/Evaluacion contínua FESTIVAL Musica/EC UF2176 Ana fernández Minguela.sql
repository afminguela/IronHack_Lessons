-- Evaluacion contínua UF2176 -- Ana Fernandez Minguela 25/09/2024
USE evaluacion_continua;
-- 1. Listado de todas las bandas "Muestra el nombre y país de origen de todas las bandas."

SELECT Nombre as banda, Pais_origen as Origen FROM Bandas;

-- 2. Asistentes menores de 30 años "Encuentra todos los asistentes menores de 30 años."

SELECT * FROM Asistentes WHERE Edad <= 30 ;

-- 3. Bandas que han tocado en Madrid "Muestra el nombre de las bandas que han tocado en Madrid."

SELECT Nombre as Banda, Conciertos.Ciudad as Ciudad, Conciertos.Fecha as Fecha
FROM Bandas  
Inner Join Conciertos ON Bandas.ID_banda = Conciertos.ID_banda
Where Ciudad = 'Madrid';

-- 4. Conciertos en una fecha específica "¿Qué conciertos se realizaron el 5 de mayo de 2024?"

SELECT nombre as Banda, Conciertos.Fecha as Fecha, Conciertos.Ciudad as Ciudad
FROM Bandas  
Inner Join Conciertos ON Bandas.ID_banda = Conciertos.ID_banda
WHERE Conciertos.Fecha = '2024-05-05';

-- 5. Cantidad de entradas vendidas para el concierto en Barcelona"¿Cuántas entradas se han vendido para el concierto en Barcelona?"

SELECT 
    COUNT(entradas.ID_entrada) AS 'Número entradas vendidas',
    Conciertos.Ciudad AS Ciudad
FROM
    Entradas
        INNER JOIN
    Conciertos ON Conciertos.ID_concierto = Entradas.ID_concierto
        
WHERE
    Conciertos.Ciudad = 'Barcelona';
;

-- 6. Precio promedio de entradas por concierto "¿Cuál fue el precio promedio de las entradas vendidas en el concierto de Tokio?"


SELECT 
    AVG(entradas.Precio) AS 'Precio promedio',
    Conciertos.Ciudad AS Ciudad
FROM
    Entradas
        INNER JOIN
    Conciertos ON Conciertos.ID_concierto = Entradas.ID_concierto
        
WHERE
    Conciertos.Ciudad = 'Tokio';

-- 7. Número de asistentes por país de origen "Muestra el número de asistentes de cada país."

SELECT Pais_origen as Pais, count(1) as 'Cantidad de Asistentes' FROM Asistentes Group by Pais_origen;

-- 8. Bandas de género 'Rock' que tocaron en Londres "¿Qué bandas de género 'Rock' tocaron en Londres?"

SELECT Nombre as Banda, Genero_musical as Género 
FRom Bandas
inner join Conciertos On Conciertos.ID_banda = Bandas.ID_banda
WHERE Conciertos.Ciudad = 'Londres' and Genero_musical = 'Rock'  ;

-- 9. Patrocinadores de conciertos en Bogotá "¿Qué patrocinadores apoyaron el concierto en Bogotá?"

SELECT Ciudad, Nombre, Tipo_patrocinio as 'Colaboración' FRom Patrocinadores WHERE Ciudad = 'Bogotá' ;

-- 10. Conciertos con ingresos por ventas de merchandising mayores a 7000 euros "¿Qué conciertos generaron más de 7000 euros en ventas de merchandising?"

Select Bandas.Nombre as Banda , Conciertos.Ciudad, Ingresos
From Ventas_merchandising
inner join Conciertos On Conciertos.ID_concierto = Ventas_merchandising.ID_concierto
inner join Bandas On Conciertos.ID_banda = Bandas.ID_banda
where Ingresos >= 7000;

-- 11. Asistentes que compraron entradas para más de un concierto "Muestra los asistentes que compraron entradas para más de un concierto."

SELECT Asistentes.Nombre, Count(Entradas.ID_entrada) as Conciertos
From Asistentes
inner join Entradas ON Asistentes.ID_asistente = Entradas.ID_asistente
Group by (Asistentes.Nombre)
Having count(Entradas.ID_entrada) > 1;

-- 12. Conciertos donde no hubo ventas de merchandising "¿En qué conciertos no se registraron ventas de merchandising?"

Select Bandas.Nombre as Banda, Conciertos.Ciudad as 'Conciertos Sin Ventas', Ventas_merchandising.Ingresos as Ingresos
From Conciertos
Left join Ventas_merchandising ON Ventas_merchandising.ID_concierto = Conciertos.ID_concierto
inner join Bandas On Conciertos.ID_banda = Bandas.ID_banda
Where Ventas_merchandising.Ingresos IS NULL;

-- 13. Ciudades donde tocaron más de tres bandas "Muestra las ciudades donde tocaron más de tres bandas."

Select Conciertos.Ciudad as Ciudad , Count(Conciertos.Ciudad)
From Conciertos
GRoup by Ciudad 
Having Count(Conciertos.Ciudad) >3;

-- 14. Bandas que no tocaron en París utilizando EXISTS "Encuentra las bandas que no tocaron en París."

SELECT 
    Nombre AS Banda
FROM
    Bandas
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            Conciertos
        WHERE
            Conciertos.ID_banda = Bandas.ID_banda
                AND Conciertos.Ciudad LIKE 'Paris');

-- 15. Precio máximo y mínimo de entradas por ciudad utilizando MIN y MAX "¿Cuál fue el precio más alto y más bajo de las entradas vendidas en cada ciudad?"

SELECT Conciertos.Ciudad Ciudad, min(Entradas.Precio) 'Precio Minimo', Max(Entradas.Precio) 'Precio Máximo'
From Entradas
Inner Join Conciertos ON Conciertos.ID_concierto = Entradas.ID_concierto
Inner join Bandas ON Conciertos.ID_banda = Bandas.ID_banda
Group by Conciertos.Ciudad;

-- 16. Patrocinadores que solo patrocinaron en una ciudad "Muestra los patrocinadores que solo dieron apoyo en una única ciudad."

SELECT Nombre, Count(Ciudad) as 'Veces patrocinador'
FROM Patrocinadores 
Group by Nombre
Having count(ciudad) = 1;

-- 17. Listado de ingresos totales por concierto (entradas y merchandising) utilizando WITH "Muestra los ingresos totales por ventas de entradas y merchandising para cada concierto utilizando WITH."
WITH IngresosEntradas AS (
    SELECT ID_concierto, SUM(Precio) as Total_Entradas
    FROM Entradas
    GROUP BY ID_concierto
),
IngresosMerchandising AS (
    SELECT ID_concierto, SUM(Ingresos) AS Total_Merchandising
    FROM Ventas_merchandising
    GROUP BY ID_concierto
 )
SELECT   
    Ciudad,
    Fecha,
    IFNULL((IngresosEntradas.Total_Entradas + IngresosMerchandising.Total_Merchandising),0) AS Ingresos_Totales
FROM Conciertos 
LEFT JOIN  IngresosEntradas ON Conciertos.ID_concierto = IngresosEntradas.ID_concierto
LEFT JOIN  IngresosMerchandising ON Conciertos.ID_concierto = IngresosMerchandising.ID_concierto;



-- 18. Primer concierto de cada banda utilizando PARTITION BY "Muestra el primer concierto realizado por cada banda utilizando PARTITION BY."

SELECT Bandas.Nombre,Conciertos.Ciudad, MIN(Conciertos.fecha) OVER (partition by Conciertos.ID_Banda) As Primera_Fecha
FROM Bandas
Inner Join Conciertos ON Bandas.ID_banda = Conciertos.ID_banda;

-- 19. Asistentes que compraron entradas con precio mayor al promedio de todas las entradas "Encuentra los asistentes que compraron entradas cuyo precio fue mayor al precio promedio de todas las entradas vendidas."

SELECT Asistentes.Nombre as Nombre, Entradas.Precio as 'Precio pagado'
FROM Asistentes
Inner Join Entradas ON Entradas.ID_Entrada = Asistentes.ID_asistente
WHERE Entradas.precio > (Select AVG(precio) from Entradas);

-- 20. Ventas de merchandising por artículo, agrupadas por concierto "Muestra las ventas de merchandising (cantidad e ingresos) por artículo, agrupadas por concierto."
-- he añadido una fila mas a algunos valores para que muestre el orden, que si no no sale.
Select Bandas.Nombre as Banda, Conciertos.Ciudad, Articulo , 
sum(Ingresos) as Total_Ingresos,SUM(Cantidad) as Total_Cantidad_Vendidos  
FROM Ventas_merchandising
Inner Join Conciertos ON Ventas_merchandising.ID_concierto = Conciertos.ID_concierto
Inner join Bandas ON Conciertos.ID_banda = Bandas.ID_banda
GROUP BY Conciertos.ID_concierto, Articulo
Order by Conciertos.ID_concierto, Articulo;
