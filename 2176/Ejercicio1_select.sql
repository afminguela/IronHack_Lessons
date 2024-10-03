-- 1. ¿Cómo obtener todos los productos registrados en la base de datos?
SELECT 
    *
FROM
    Ejercicio1.productos

-- 2. ¿Cómo mostrar el nombre y precio unitario de todos los productos?
SELECT t1.nombre as nombre_producto, t1.precio as costo FROM Ejercicio1.productos t1;

-- 3. ¿Cómo obtener el nombre y la cantidad en stock de un producto en particular, filtrando por su nombre?
SELECT t1.nombre, t1.en_stock FROM Ejercicio1.productos t1 WHERE t1.nombre in ('APRODUCTO B','PRODUCTO A', 'PRODUCTO C') ;
SELECT nombre, en_stock FROM Ejercicio1.productos WHERE nombre = 'APRODUCTO B' OR nombre = 'PRODUCTO A' AND NOT nombre = 'PRODUCTO C';


-- 4. ¿Cómo listar todos los productos que están actualmente en stock (cantidad > 0)?
SELECT * FROM Ejercicio1.productos WHERE en_stock > 0;
SELECT * FROM Ejercicio1.productos WHERE (en_stock between 20 and 100) and en_stock <> 47;

-- 5. ¿Cómo mostrar los productos que pertenecen a una categoría específica?
SELECT p.nombre, p.precio, c.nombre AS categoria 
FROM Ejercicio1.productos p 
INNER JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria 
WHERE c.nombre = 'Juguetes';

-- 6. ¿Cómo obtener los productos con un precio mayor a 100 euros?
SELECT * FROM Ejercicio1.productos WHERE precio > 100;
SELECT COUNT(1), id_categoria, precio FROM Ejercicio1.productos WHERE precio >= 100 group by id_categoria, precio order by id_categoria desc, precio asc;

-- 7. ¿Cómo contar cuántos productos hay en cada categoría?
SELECT c.nombre AS categoria, COUNT(p.id_producto) AS total_productos 
FROM Ejercicio1.productos p 
RIGHT JOIN Ejercicio1.categorias c 
ON p.id_categoria = c.id_categoria 
GROUP BY c.nombre
ORDER BY 2 desc;


-- FULL OUTER JOIN --
SELECT c.nombre AS categoria, COUNT(p.id_producto) AS total_productos 
FROM 
Ejercicio1.productos p LEFT JOIN Ejercicio1.categorias c 
ON p.id_categoria = c.id_categoria 
GROUP BY c.nombre
UNION 
SELECT c.nombre AS categoria, COUNT(p.id_producto) AS total_productos 
FROM 
Ejercicio1.productos p RIGHT JOIN Ejercicio1.categorias c 
ON p.id_categoria = c.id_categoria 
GROUP BY c.nombre
order by 2 asc;


-- 8. ¿Cómo obtener el producto más caro de la base de datos?
SELECT * FROM Ejercicio1.productos ORDER BY precio desc LIMIT 1;  -- Forma 1 (Saca solo un registro con precio más alto)

SELECT * FROM Ejercicio1.productos WHERE precio = (select max(precio) FROM Ejercicio1.productos);   -- Mejor opción: Forma 2 (Saca todos los registros con el precio máximo)
 
 
-- 9. ¿Cómo listar los productos cuyo nombre comienza con la letra "A"?
SELECT * FROM Ejercicio1.productos WHERE upper(nombre) like '%R%' OR upper(nombre) like '%O%';


-- 10. ¿Cómo mostrar los productos con una fecha de caducidad en los próximos 30 días?
SELECT * FROM Ejercicio1.productos 
WHERE fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 YEAR); -- CURDATE() es para mysql solo

SELECT * FROM Ejercicio1.productos  WHERE Fecha_Caducidad between current_date and current_date + interval '30'  day; -- Current_date es para sql en general

select * FROM Ejercicio1.productos 
WHERE extract(year from fecha_caducidad)= 2024 
	AND extract(month from fecha_caducidad)= 10 
	and extract(day from fecha_caducidad)= 15; -- Para extraer registros con año, mes i/o día concretos.


-- 11. ¿Cómo mostrar todos los proveedores que suministran un producto específico?
SELECT pr.nombre AS proveedor, p.nombre AS producto
FROM Ejercicio1.proveedores pr
INNER JOIN Ejercicio1.proveedores_productos pp ON pr.id_proveedor = pp.proveedores_id_proveedor
INNER JOIN Ejercicio1.productos p ON pp.numero_lote = p.numero_lote
WHERE p.nombre in ('PRODUCTO A', 'APRODUCTO B');

-- 12. ¿Cómo obtener los productos que están por debajo de un umbral de cantidad específica (por ejemplo, 5 unidades)?
SELECT * FROM Ejercicio1.productos WHERE en_stock < 5;

-- 13. ¿Cómo listar todos los productos cuyo precio esté entre 50 y 150 euros?
SELECT * FROM Ejercicio1.productos WHERE precio BETWEEN 50 AND 150;

-- 14. ¿Cómo obtener el valor total del inventario (sumar el valor de todos los productos en stock)?
SELECT SUM(precio * en_stock) AS valor_total_inventario FROM Ejercicio1.productos;

SELECT SUM(precio * en_stock) AS valor_por_producto, nombre AS valor_total_inventario FROM Ejercicio1.productos group by nombre;

select max(valor_por_producto), nombre from (
SELECT SUM(precio * en_stock) AS valor_por_producto, nombre FROM Ejercicio1.productos group by nombre) 
as producto_maximo group by nombre order by 1 desc limit 1;



-- 15. ¿Cómo obtener los productos cuyo precio ha sido actualizado recientemente (últimos 7 días)?
SELECT * FROM Ejercicio1.productos WHERE fecha_recibidad BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE();

SELECT * FROM Ejercicio1.productos  WHERE fecha_recibidad >= (current_date - interval 7 day); -- Current_date es para sql en general

SELECT * FROM Ejercicio1.productos WHERE fecha_recibidad >= DATE_SUB(CURDATE(), INTERVAL 7 DAY); -- Lo mismo que la anterior pero con notación mysql




-- 16. ¿Cómo obtener todos los productos de un proveedor específico, ordenados por precio de mayor a menor?
SELECT p.* 
FROM Ejercicio1.productos p 
INNER JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote 
INNER JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor 
WHERE pr.nombre = 'Proveedor A' 
ORDER BY p.precio DESC;

SELECT p.nombre, pp.numero_lote, pr.id_proveedor, pr.nombre, p.en_stock, p.precio
FROM Ejercicio1.productos p 
INNER JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote 
INNER JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor 
WHERE pr.nombre = 'Proveedor A' 
ORDER BY p.precio DESC;



-- 17. ¿Cómo mostrar los productos que no están en stock actualmente (cantidad = 0)?
SELECT * FROM Ejercicio1.productos WHERE en_stock = 0 or en_stock is null;

-- 18. ¿Cómo obtener un reporte con los productos que están cerca de su fecha de caducidad (por ejemplo, en los próximos 10 días) y su cantidad en stock?
SELECT * FROM Ejercicio1.productos 
WHERE fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 DAY);

SELECT * FROM Ejercicio1.productos  WHERE Fecha_Caducidad between current_date and current_date + interval '10'  day;

SELECT * FROM Ejercicio1.productos  WHERE Fecha_Caducidad >= current_date and Fecha_Caducidad <= current_date + interval 10 day;

SELECT nombre, en_stock, fecha_caducidad, DATEDIFF(fecha_caducidad, CURDATE()) AS DiasHastaCaducidad
FROM productos
WHERE DATEDIFF(fecha_caducidad, CURDATE()) BETWEEN 0 AND 10;

select concat('hola',nombre,'adios','coche',id_producto) from productos;

select concat('Producto ', nombre, ' Faltan ', DATEDIFF(fecha_caducidad, CURDATE()), ' dias para caducar') as frase 
from productos where DATEDIFF(fecha_caducidad, CURDATE()) > 0;


-- 19. ¿Cómo obtener el promedio del precio unitario de todos los productos de una categoría específica?
SELECT AVG(precio) AS promedio_precio , c.nombre
FROM Ejercicio1.productos p 
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria 
WHERE c.nombre = 'Juguetes';  -- Esta opción es la mas lenta porque el filtrado de nombre se hace después de calcular el producto cartesiano de todos los campos en la join.

SELECT AVG(precio) AS promedio_precio FROM Ejercicio1.productos p 
where p.id_categoria = (SELECT id_categoria FROM Ejercicio1.categorias WHERE nombre = 'Juguetes'); -- Esta opción es equivalente a la siguiente pero con menos información.

SELECT AVG(precio) AS promedio_precio , c.nombre
FROM Ejercicio1.productos p 
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria and c.nombre = 'Juguetes'; -- De las tres opciones esta sería la que me puede dar más información y más rápida de calculo.

select AVG(precio) AS promedio_precio, id_categoria FROM Ejercicio1.productos p group by id_categoria; -- Sin join, no da el nombre de la categoría solamente el id (no es la mejor opción).


-- 20. ¿Cómo listar los productos más recientes (adquiridos en los últimos 30 días)?
SELECT * FROM Ejercicio1.productos 
WHERE fecha_recibidad BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE();

SELECT * FROM Ejercicio1.productos 
WHERE fecha_recibidad >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT p.*, DATEDIFF(CURDATE(),p.fecha_recibidad) FROM Ejercicio1.productos p
WHERE fecha_recibidad >= current_date - interval 30 day;

SELECT p.*, DATEDIFF(CURDATE(),p.fecha_recibidad) AS DiasDesdeRecepcion
FROM productos p
WHERE DATEDIFF(CURDATE(),p.fecha_recibidad) BETWEEN 0 AND 30;

-- 21. ¿Cómo mostrar todos los productos, junto con la categoría y el proveedor?
SELECT p.nombre, p.precio, c.nombre AS categoria, pr.nombre AS proveedor 
FROM Ejercicio1.productos p
INNER JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria
INNER JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
INNER JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor order by pr.nombre asc, c.nombre asc;

-- 22. ¿Cómo obtener la cantidad total de productos disponibles por categoría, ordenados de mayor a menor cantidad?
SELECT c.nombre AS categoria, SUM(p.en_stock) AS total_en_stock 
FROM Ejercicio1.productos p 
right JOIN Ejercicio1.categorias c  ON p.id_categoria = c.id_categoria
GROUP BY c.nombre 
ORDER BY total_en_stock DESC;


SELECT c.nombre AS categoria, en_stock
FROM Ejercicio1.productos p 
right JOIN Ejercicio1.categorias c  ON p.id_categoria = c.id_categoria
where en_stock is null;


SELECT *
FROM Ejercicio1.productos p 
inner JOIN Ejercicio1.categorias c  ON p.id_categoria = c.id_categoria
where p.id_categoria is null;


-- EL IFNULL substituye un valor nulo por uno dado en este caso 0
SELECT categoria FROM (
SELECT c.nombre AS categoria, IFNULL(SUM(p.en_stock),0) AS total_en_stock 
FROM Ejercicio1.productos p 
right JOIN Ejercicio1.categorias c  ON p.id_categoria = c.id_categoria
GROUP BY c.nombre ) as t1 
where total_en_stock = 0 and categoria = 'Bebidas'
ORDER BY total_en_stock DESC;

-- Ejemplo querys anidadas en From y en Where
select * from (
select c.nombre as categoria from categorias c) as t1
where categoria in(select ca.nombre as categoria from categorias ca);


-- Como un full join
SELECT c.nombre AS categoria  
FROM 
Ejercicio1.productos p LEFT JOIN Ejercicio1.categorias c 
ON p.id_categoria = c.id_categoria 
UNION 
SELECT p.nombre AS nombre 
FROM 
Ejercicio1.productos p RIGHT JOIN Ejercicio1.categorias c 
ON p.id_categoria = c.id_categoria 
order by 1 asc;



-- 23. ¿Cómo generar un informe que muestre los productos con la menor cantidad en stock y el proveedor de cada uno?
SELECT p.nombre AS producto, p.en_stock, pr.nombre AS proveedor
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor
ORDER BY p.en_stock ASC limit 3;


SELECT p.nombre AS producto, p.en_stock, pr.nombre AS proveedor
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor
ORDER BY p.en_stock ASC limit 1;

SELECT p.nombre AS producto, avg(p.en_stock) as stock, pr.nombre AS proveedor
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor
group by p.nombre, pr.nombre
ORDER BY stock ;


-- Stock de proveedores que estan por debajo de la media del stock del inventario.
select sum(p.en_stock) as stock_proveedor, pr.nombre AS proveedor
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor  where en_stock < (
SELECT avg(p.en_stock) as stock
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor) group by pr.nombre order by proveedor desc;


-- Devolver todos los proveedores que tienen el stock perteneciente a los tres valores mínimos de stock. Sean uno, dos, tres o x proveedores por cada valor de stock dado.
select p.en_stock as stock_proveedor, pr.nombre AS proveedor
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor  where en_stock in(select stock from (SELECT distinct(p.en_stock) as stock
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor order by 1 asc limit 3) as sub )  order by proveedor desc;


select * from productos;
SELECT distinct(p.en_stock) as stock
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor order by 1 asc limit 3;


-- 24. ¿Cómo obtener el valor total del inventario por proveedor?
SELECT pr.nombre AS proveedor, sum(p.precio * p.en_stock) AS valor_total 
FROM Ejercicio1.productos p
JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor
GROUP BY pr.nombre order by 2 asc;


-- 25. ¿Cómo listar todos los usuarios que han generado reportes en un rango de fechas específico, mostrando el ID del reporte y la fecha de generación?
SELECT u.nombre AS usuario, r.id_reporte, DATE_FORMAT(r.fecha_hora, '%d-%m-%Y')
FROM Ejercicio1.reportes r
JOIN Ejercicio1.usuarios u ON r.id_usuario = u.id_usuario
WHERE r.fecha_hora BETWEEN '2023-01-01' AND '2023-12-31';



-- 26. ¿Cómo obtener el promedio de días que transcurren entre la fecha de adquisición y la fecha de caducidad de los productos en cada categoría?
SELECT c.nombre AS categoria, avg(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad)) AS promedio_dias
FROM Ejercicio1.productos p
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria
where p.fecha_caducidad is not null
GROUP BY c.nombre;

SELECT c.nombre AS categoria, 
	avg(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad)) AS promedio_dias, 
	FLOOR(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad)/365) AS año,
    MOD(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad),365) AS dias
FROM Ejercicio1.productos p
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria
where p.fecha_caducidad is not null
GROUP BY c.nombre, FLOOR(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad)/365),MOD(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad),365) ;

SELECT c.nombre AS categoria, 
	FLOOR(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad)/365) AS año,
    MOD(DATEDIFF(p.fecha_caducidad, p.fecha_recibidad),365) AS dias
FROM Ejercicio1.productos p
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria
where p.fecha_caducidad is not null ;


    
    
select datediff(fc,fr) from (
select date_format(p.fecha_caducidad, '%d-%m-%Y') as fc, date_format(p.fecha_recibidad, '%d-%m-%Y') as fr from productos p) as t1;


-- 27. ¿Cómo obtener una lista de productos que están cerca de su fecha de caducidad y que tienen el stock más bajo dentro de su categoría?

select p.nombre as nombre_producto, p.en_stock as stock, c.nombre as categoria_producto, p.fecha_caducidad
FROM Ejercicio1.productos p
INNER JOIN  Ejercicio1.categorias c ON p.id_categoria = c.id_categoria
WHERE p.fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY) 
and p.en_stock = (
SELECT min(p2.en_stock) FROM Ejercicio1.productos p2
where p2.id_categoria = c.id_categoria) order by 2 asc;




-- 28. ¿Cómo identificar el top 3 de proveedores que suministran productos cuyo valor total en inventario es mayor al promedio de todos los proveedores?

SELECT 
    t1.proveedor,
    t1.valor_total
FROM
    (SELECT 
        pr.nombre AS proveedor,
            SUM(p.precio * p.en_stock) AS valor_total
    FROM
        Ejercicio1.productos p
    JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
    JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor
    GROUP BY pr.nombre) AS t1
WHERE
    valor_total > (SELECT 
            AVG(valor_total)
        FROM
            (SELECT 
                pr.nombre AS proveedor,
                    SUM(p.precio * p.en_stock) AS valor_total
            FROM
                Ejercicio1.productos p
            JOIN Ejercicio1.proveedores_productos pp ON p.numero_lote = pp.numero_lote
            JOIN Ejercicio1.proveedores pr ON pp.proveedores_id_proveedor = pr.id_proveedor
            GROUP BY pr.nombre) AS t1)
ORDER BY valor_total DESC;


-- 29. ¿Cómo calcular el valor proyectado del inventario en los próximos 6 meses considerando productos que caducarán en ese período y excluyéndolos del valor total?
SELECT SUM(precio * en_stock) AS valor_proyectado
FROM Ejercicio1.productos
WHERE fecha_caducidad IS NULL OR fecha_caducidad > DATE_ADD(CURDATE(), INTERVAL 6 MONTH);


-- 30. ¿Cómo obtener los productos cuyo stock ha permanecido sin cambios durante los últimos 90 días, ordenados por el tiempo que llevan sin ser actualizados?
SELECT * 
FROM Ejercicio1.productos 
WHERE fecha_recibidad <= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
ORDER BY fecha_recibidad ASC;
