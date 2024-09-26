SELECT * 
FROM XYZDB.`productos`
JOIN XYZDB.Categorias on Productos.Categorias_idCategorias = Categorias.idCategorias
-- WHERE `Categorias_idCategorias` = 4 ;
where Categorias.Nombre_Categoria = 'Lacteos';



SELECT *
From XYZDB.Productos po
JOIN XYZDB.Categorias ca on po.Categorias_idCategorias = ca.idCategorias,


