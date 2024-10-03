Use Ejercicio1;

-- Preguntas con PARTITION BY

-- 1. ¿Cómo obtener el precio promedio de los productos por categoría y la diferencia de precio de cada producto con respecto al promedio de su categoría?
SELECT p.nombre,
       p.precio,
       c.nombre,
       AVG(p.precio) OVER (PARTITION BY c.nombre) AS precio_promedio_categoria,
       p.precio - AVG(p.precio) OVER (PARTITION BY c.nombre) AS diferencia_con_promedio
FROM Ejercicio1.productos p
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria;


-- 2. ¿Cómo mostrar el precio más alto de un producto dentro de cada categoría y la posición de cada producto en esa categoría basado en el precio?

select * from (SELECT p.nombre as nombre_producto,
       p.precio,
       c.nombre as categoria,
       MAX(p.precio) OVER (PARTITION BY c.nombre) AS precio_max_categoria,
	   ROW_NUMBER() OVER (PARTITION BY c.nombre ORDER BY p.precio DESC) AS posicion_precio
FROM Ejercicio1.productos p
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria) as t1 where t1.posicion_precio = 1;


-- 3. ¿Cómo calcular el valor acumulado del inventario por categoría, ordenado por el nombre del producto dentro de cada categoría?
SELECT p.nombre,
       c.nombre AS categoria,
       p.precio * p.en_stock AS valor_inventario_producto,
       SUM(p.precio * p.en_stock) OVER (PARTITION BY c.nombre ORDER BY p.nombre asc) AS valor_acumulado_categoria
FROM Ejercicio1.productos p
JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria order by categoria asc;

-- Ejemplo if con if anidado 
select nombre, en_stock, if(en_stock > 100, 'mucho stock', if(en_stock > 10, 'muy poco', 'mínimo')) as cantidad_stock from productos;

-- Ejemplo case when then else end (es como una especie de if)
select nombre, 
		en_stock,
        case
			when en_stock > 100 THEN 'MUCHO STOCK'
            when en_stock > 10 then 'muy poco'
            else 'mínimo'
		end as cantidad_stock,
        fecha_caducidad
from productos;


-- Preguntas con WITH (CTE)

-- 1. ¿Cómo calcular el valor total de inventario por proveedor y luego listar solo aquellos proveedores cuyo inventario supera el valor promedio de todos los proveedores?
WITH valor_por_proveedor AS (
    SELECT pr.id_proveedor, pr.nombre,
           SUM(p.precio * p.en_stock) AS valor_total
    FROM Ejercicio1.proveedores pr
    JOIN Ejercicio1.proveedores_productos pp ON pr.id_proveedor = pp.proveedores_id_proveedor
    JOIN Ejercicio1.productos p ON pp.numero_lote = p.numero_lote
    GROUP BY pr.id_proveedor
), promedio_valor AS (
    SELECT AVG(valor_total) AS valor_promedio FROM valor_por_proveedor
)
SELECT vpp.nombre, vpp.valor_total
FROM valor_por_proveedor vpp
JOIN promedio_valor pv ON vpp.valor_total > pv.valor_promedio;





-- 2. ¿Cómo listar todos los productos cuyo stock está por debajo de la media de stock de los productos en su categoría?
WITH stock_promedio_categoria AS (
    SELECT c.id_categoria, AVG(p.en_stock) AS promedio_stock
    FROM Ejercicio1.productos p
    JOIN Ejercicio1.categorias c ON p.id_categoria = c.id_categoria
    GROUP BY c.id_categoria
)
SELECT p.nombre, p.en_stock, spc.promedio_stock
FROM Ejercicio1.productos p
JOIN stock_promedio_categoria spc ON p.id_categoria = spc.id_categoria
WHERE p.en_stock < spc.promedio_stock;





-- 3. ¿Cómo listar los proveedores que suministran productos cuyo valor total en inventario es mayor que el promedio de valor total del inventario de todos los proveedores?
WITH valor_por_proveedor AS (
			SELECT 
			pr.id_proveedor,
			pr.nombre,
			SUM(p.precio * p.en_stock) AS valor_total
		FROM
			Ejercicio1.proveedores pr
				JOIN
			Ejercicio1.proveedores_productos pp ON pr.id_proveedor = pp.proveedores_id_proveedor
				JOIN
			Ejercicio1.productos p ON pp.numero_lote = p.numero_lote
		GROUP BY pr.id_proveedor
), 
promedio_valor_inventario AS (
		SELECT 
			AVG(valor_total) AS promedio_valor
		FROM
			valor_por_proveedor
)
SELECT 
    vpp.nombre, vpp.valor_total
FROM
    valor_por_proveedor vpp
        JOIN
    promedio_valor_inventario pvi ON vpp.valor_total > pvi.promedio_valor;



-- Ejemplo exists y not exists (miran que devuelva almenos una fila (exists) o ninguna fila (not exists)

select c.nombre as nombre_categoria
from categorias c
where exists(select 1 from productos p where c.id_categoria = p.id_categoria);


select p.nombre as nombre_producto
from productos p
where not exists( select 1 from categorias c where p.id_categoria = c.id_categoria);