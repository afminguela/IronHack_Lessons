use ESCUELA;



-- 1 ¿Cómo obtener todos los cursos registrados en la base de datos?
SELECT 
    *
FROM
    Cursos

-- 2 ¿Cómo listar todos los estudiantes inscritos en un curso específico, filtrando por el nombre del curso?
SELECT 
    e.Nombre AS Nombre, c.nombre AS curso
FROM
    Estudiante e
        INNER JOIN
    Cursos_has_estudiantes ce ON e.idEstudiante = estudiante_idEstudiante
        INNER JOIN
    Cursos c ON c.idCursos = ce.cursos_idCursos
WHERE
    c.Nombre = 'Introducción a UX Design'3 ¿Cómo mostrar todas las tareas asignadas por un profesor específico, utilizando su nombre?
Select t.Titulo as Nombre_tarea, p.nombre as Profesor
from Tareas t
inner join Tareas_has_Profesores_Revisores tp on t.idTareas = Tareas_idTareas
inner join Profesor p ON p.idprofesor = tp.Profesor_revisor_idProfesor
where p.Nombre like '%Pedro%';

-- 4 ¿Cómo contar cuántos estudiantes están inscritos en cada curso?
select c.nombre as Curso, COUNT(ce.estudiante_idEstudiante) as Alumnos_matriculados
from Cursos_has_Estudiantes ce
inner join Cursos c ON ce.cursos_idCursos = c.idCursos
group by  c.nombre;


-- 5 ¿Cómo listar los estudiantes que han entregado una tarea específica?
select t.Titulo as tarea, e.nombre AS estudiante, ET.estado
from Estudiante e
inner join Estudiantes_has_tareas ET on ET.estudiante_idEstudiante  = idEstudiante
inner Join Tareas t on t.idTareas = ET.Tareas_idTareas
where t.Titulo like '%Redacción%';


-- 6 ¿Cómo obtener los cursos que están en progreso (entre la fecha de inicio y fin actuales)?

SELECT c.nombre as Curso, c.Fecha_inicio_curso as 'Fecha comienzo' , c.Fecha_fin_curso as 'Fecha Fin'
from Cursos c
where Fecha_inicio_curso < current_date and current_date < Fecha_fin_curso  ;
  

-- 7 ¿Cómo mostrar todas las calificaciones de un estudiante específico, filtrando por su nombre?

Select e.Nombre as Nombre, ca.Notas as Notas, ca.Tipo_calificación AS Tipo
from Estudiante e
inner join Estudiantes_has_tareas ET on ET.estudiante_idEstudiante  = idEstudiante
inner Join Tareas t on t.idTareas = ET.Tareas_idTareas
inner join calificaciones ca on ca.idCalificaciones = ET.calificaciones_idCalificaciones
inner join cursos_has_estudiantes ce ON ca.idCalificaciones = ce.calificaciones_idCalificaciones
where e.Nombre like '%Carlos%';

-- 8 ¿Cómo listar los distintos materiales de estudio disponibles en todos los cursos, utilizando DISTINCT para evitar duplicados?

SELECT  * From Materiales m order by m.tipo, m.Disponibilidad;

-- 9 ¿Cómo obtener la tarea con la fecha de entrega más cercana para un curso específico?


SELECT 
    c.nombre AS Curso,
    t.titulo AS tarea,
    t.Fecha_muerte AS 'Fecha de entrega'
FROM
    cursos c
        INNER JOIN
    Cursos_has_tareas ct ON ct.Cursos_idCursos = c.idCursos
        INNER JOIN
    Tareas t ON ct.Tareas_idTareas = t.idTareas
WHERE
    c.nombre LIKE '%UX%'
order BY Fecha_muerte limit 1
;
    
-- 10 ¿Cómo listar los mensajes de un foro específico, ordenados por fecha de publicación?

SELECT 
    m.Titulo_Mensaje AS Mensaje,
    m.Contenido_Mensaje As Contenido,
    f.Nombre_Foro AS foro,
    m.Fecha_creacion_mensaje AS 'Fecha de publicacion'
FROM
    Foros f
        inner JOIN
Mensajes m ON m.Foros_idForos = f.idForos
        
WHERE
    f.Nombre_Foro LIKE 'Foro de Programación'
order BY m.Fecha_creacion_mensaje ;

-- Consultas con PARTITION:

-- 11 ¿Cómo obtener la calificación más alta por cada curso utilizando particiones?

SELECT 
	c.Nombre as curso ,
    e.Nombre as Estudiante, 
    ca.Notas as calificaciones, 
	RANK() OVER (partition BY c.idCursos order by ca.Notas desc) AS Ranking_calificaciones
FROM 
	Cursos_has_Estudiantes ce
inner join 
	Estudiante e ON ce.estudiante_idEstudiante = e.idEstudiante
inner join 
	Cursos c ON c.idCursos = ce.cursos_idCursos
inner join 
	calificaciones ca on ca.idCalificaciones = ce.calificaciones_idCalificaciones;

-- 12 ¿Cómo obtener la calificación promedio por curso para cada estudiante utilizando PARTITION BY?

SELECT 
	e.Nombre as Estudiante, 
    c.Nombre as curso ,
	AVG(Notas) OVER (partition BY ce.estudiante_idEstudiante, ce.cursos_IdCursos) AS calificaciones_promedio
FROM 
	Cursos_has_Estudiantes ce
inner join 
	Estudiante e ON ce.estudiante_idEstudiante = e.idEstudiante
inner join 
	Cursos c ON c.idCursos = ce.cursos_idCursos
inner join 
	calificaciones ca on ca.idCalificaciones = ce.calificaciones_idCalificaciones;

-- 13 ¿Cómo listar los estudiantes con la mejor nota en cada tarea, utilizando particiones para dividir por tarea?
SELECT 
	e.Nombre as Estudiante, 
    t.Titulo as Tarea,
	MAX(Notas) OVER (partition BY et.Tareas_idTareas) AS Mejor_Nota
FROM 
	Estudiantes_has_tareas et
inner join 
	Estudiante e ON et.estudiante_idEstudiante = e.idEstudiante
inner join 
	Tareas t ON  t.idTareas = et.Tareas_idTareas
inner join 
	calificaciones ca on ca.idCalificaciones = et.calificaciones_idCalificaciones;

-- 14 ¿Cómo obtener la primera y última calificación que cada estudiante ha recibido en un curso, utilizando particiones para ordenar por fecha?

SELECT 
	e.Nombre as Estudiante, 
    t.Titulo as Tarea,
	MAX(Notas) OVER (partition BY et.Tareas_idTareas) AS Mejor_Nota
FROM 
	Estudiantes_has_tareas et
inner join 
	Estudiante e ON et.estudiante_idEstudiante = e.idEstudiante
inner join 
	Tareas t ON  t.idTareas = et.Tareas_idTareas
inner join 
	calificaciones ca on ca.idCalificaciones = et.calificaciones_idCalificaciones;
-- 15 ¿Cómo listar los cursos que han alcanzado su capacidad máxima de estudiantes, utilizando particiones para contar las inscripciones por curso?



-- Consultas con WITH (CTE - Common Table Expressions):

-- 16 ¿Cómo obtener un listado de cursos que ya han finalizado, utilizando una CTE para filtrar por la fecha de fin?

-- 17 ¿Cómo mostrar la calificación promedio de los estudiantes en cada curso, utilizando una CTE para calcular el promedio?

-- 18 ¿Cómo listar las tareas que aún están pendientes de revisión, utilizando una CTE para identificar las tareas por estado de revisión?

-- 19 ¿Cómo mostrar los profesores que tienen más de 5 cursos asignados, utilizando una CTE para contar los cursos por profesor?

-- 20 ¿Cómo obtener el número total de materiales por curso, utilizando una CTE para contar los materiales asociados a cada curso?


-- Consultas con IF (Control condicional):

-- 21 ¿Cómo mostrar la calificación de cada estudiante, indicando con una columna adicional si ha aprobado o no la tarea (nota >= 5)?

-- 22 ¿Cómo listar los cursos, indicando en una columna si están llenos o no (cantidad de estudiantes inscritos = cantidad máxima de estudiantes)

-- 23 ¿Cómo mostrar las tareas con su estado de revisión, y en una columna adicional "Revisión Finalizada" si la tarea ha sido revisada (estado = 'revisada' o 'aprobada')?

-- 24 ¿Cómo obtener la lista de estudiantes, indicando si su nota más reciente en una tarea fue aprobatoria o no (utilizando IF)?

-- 25 ¿Cómo listar los cursos que tienen estudiantes inscritos, mostrando una columna adicional que indique si tienen más de 20 estudiantes?


-- Consultas avanzadas (otras funcionalidades avanzadas):

-- 26 ¿Cómo calcular la posición (ranking) de cada estudiante dentro de un curso, basándose en la suma de sus calificaciones en las tareas?

-- 27 ¿Cómo mostrar el top 3 de profesores que han asignado más tareas en el último mes?

-- 28 ¿Cómo obtener los estudiantes que nunca han recibido una calificación menor a 7 en ninguna tarea?

-- 28 ¿Cómo listar los cursos que no han tenido ninguna nueva inscripción en los últimos 30 días?

-- 30 ¿Cómo mostrar los estudiantes que han participado en más del 50% de las discusiones en los foros, ordenados por su nivel de participación?