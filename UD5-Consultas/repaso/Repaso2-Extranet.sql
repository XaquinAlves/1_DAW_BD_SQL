/**
 * 1.Muestra a todos los usuarios que tienen como tema de aplicación el tema por
 *  defecto (default). Datos a mostrar nombre, nombre_grupo, nombre_centro.
 */
SELECT usr.nombre, grp.grupo, cnt.center_name
FROM usuarios usr
JOIN grupos grp ON usr.id_grupo = grp.id_grupo
JOIN centers cnt ON usr.id_center = cnt.id_center
WHERE usr.theme = 'default'
ORDER BY usr.nombre, grp.grupo;

/** 
 * 2.Muestra a los usuarios pertencientes al grupo de coordinadores
 * (Organisation coordinator) que se han logueado por última vez en el sistema en
 * Octubre de 2019. Datos a mostrar last_date, nombre, nombre_centro.
 */ 
SELECT usr.last_date, usr.nombre, cnt.center_name
FROM usuarios usr
JOIN grupos grp ON usr.id_grupo = grp.id_grupo
JOIN centers cnt ON usr.id_center = cnt.id_center
WHERE grp.grupo = 'Organisation coordinator' AND usr.last_date >= '2019-10-01' 
	AND usr.last_date < '2019-11-01' 
ORDER BY usr.last_date, usr.nombre;

/**
 * 3.Se tienen que procesar los pagos del mes de noviembre de 2019 para el proyecto
 *  Caring Rivers. Muestra los documentos que no tengan borrado lógico del tipo
 *  Signed Timesheet que han sido enviados durante el mes de octubre de 2019 y que
 *  pertenecen al proyecto 'Caring Rivers'. Datos a mostrar: doc_name, path,
 *  fecha_subida, nombre_usuario, centro_usuario. Ordenados por fecha de subida.
 */
SELECT doc.doc_name, doc.`path`, doc.upload_date, usr.nombre,  usr.id_center
FROM documents doc 
JOIN projects prj ON prj.id_project = doc.id_project 
JOIN usuarios usr ON doc.id_user = usr.id_usuario 
WHERE doc.deleted = 0 AND doc.upload_date >= '2019-10-01' 
	AND doc.upload_date < '2019-11-01' AND prj.project_name = 'Caring Rivers'
ORDER BY doc.upload_date;
	
/**
 * 4.Desde el centro Agentia Metropolitana Pentru se quejan de que no se han realizado
 * los pagos correspondientes al mes de octubre 19. Busca las Signed Timesheet no 
 * borradas subidas durante octubre del 19 que pertenezcan a usuarios de dicho centro. 
 * Datos a mostrar: doc_name, path, fecha_subida, nombre_usuario, centro_usuario.
 *  Ordenados por fecha de subida.
 */
SELECT doc.doc_name, doc.`path`, doc.upload_date, usr.nombre, cnt.center_name
FROM documents doc
JOIN usuarios usr ON usr.id_usuario = doc.id_user
JOIN centers cnt ON cnt.id_center = usr.id_center
WHERE cnt.center_name = 'Agentia Metropolitana Pentru' AND doc.upload_date >= '2019-10-01' 
	AND doc.upload_date < '2019-11-01' AND doc.deleted = 0
ORDER BY doc.upload_date;

/**
 * 5.Muestra por pantalla todos los registros de horas imputadas al proyecto Caring
 * Rivers entre Diciembre de 2018 y Marzo de 2019 por usuario del centro Ecoloxistas
 * de Galiza (id_center = 12) o por la Universidade de Coimbra (id_center = 14).
 */ 
SELECT usr.nombre, usr.id_center, SUM(rhours.hours) AS horas_totales_usuario
FROM projects prj 
JOIN rel_user_project_input_hours rhours ON rhours.id_project = prj.id_project
JOIN usuarios usr ON rhours.id_user = usr.id_usuario 
WHERE prj.project_name = 'Caring Rivers' AND (usr.id_center = 12 OR usr.id_center = 14)
GROUP BY usr.id_usuario;

/**
 * 6.Muestra los proyectos existentes en la base de datos ordenados por proyectos de
 *  más duración a menos y project_name. Campos a mostrar:  project_name,
 *  administrador_proyecto_nombre, adminsitrador_email, start_date, end_date,
 *  duracion_dias. Muestra sólo los primeros 5 proyectos.
 */
SELECT prj.project_name, usr.nombre AS administrador_proyecto_nombre, usr.email AS adminsitrador_email,
	prj.start_date, prj.end_date, TIMESTAMPDIFF(DAY, prj.start_date, prj.end_date) AS duracion_dias
FROM projects prj
LEFT JOIN usuarios usr ON usr.id_usuario = prj.project_administrator
ORDER BY duracion_dias 
LIMIT 5;

/**
 * 7.Muestra todos los usuarios que sean administradores de al menos un proyecto. 
 * Campos a mostrar: usuario.nombre, usuario.email, num_proyectos_administrados. 
 * Ordena por num_proyectos_administrados más a menos, usuario.nombre.
 */
SELECT usr.nombre, usr.email, COUNT(prj.id_project) AS num_proyectos_administrados
FROM usuarios usr
JOIN projects prj ON usr.id_usuario = prj.project_administrator
GROUP BY usr.id_usuario
ORDER BY num_proyectos_administrados, usr.nombre;

/**
 * 8.Para cada proyecto, muestra el número de usuarios asignados a dicho proyecto y el 
 * total de horas máximas que se podrá imputar a dicho proyecto diariamente. Campos a 
 * mostrar project_name, num_usuarios_asignados, num_horas. Ordena por 
 * num_usuarios_asignados DESC, num_horas DESC, project_name.
 */
SELECT prj.project_name , COUNT(usr.id_usuario) AS num_usuarios_asignados, 
	SUM(rpu.max_hours_day) AS num_horas
FROM projects prj
JOIN rel_project_user rpu ON rpu.id_project = prj.id_project
JOIN usuarios usr ON rpu.id_user = usr.id_usuario
GROUP BY prj.id_project
ORDER BY num_usuarios_asignados DESC, num_horas DESC, prj.project_name;

/**
 * 9.Muestra todos los outputs principales de proyectos (no tienen output_parent asignado). 
 * Datos a mostrar: Output_name, project_name. Ordena por project_name, output_name.
 */
SELECT po.output_name, prj.project_name
FROM project_outputs po 
JOIN projects prj ON po.id_project = prj.id_project
WHERE po.id_parent_output IS NULL
ORDER BY po.output_name, prj.project_name;

/**
 * 10.Para cada proyecto, muestra el número de outputs asignados al mismo sean o no 
 * principales.
 */
SELECT prj.project_name, COUNT(po.id_output) AS num_outputs
FROM project_outputs po 
JOIN projects prj ON po.id_project = prj.id_project
GROUP BY prj.id_project;

/**
 * 11.Muestra todos los outputs NO principales. Datos a mostrar: Output_name, 
 * parent_output_name, project_name. Ordena por project_name, parent_output_name, 
 * output_name.
 */
SELECT po.output_name, prj.project_name, parent.output_name AS parent_output_name
FROM project_outputs po 
JOIN projects prj ON po.id_project = prj.id_project
JOIN project_outputs parent ON po.id_parent_output = parent.id_output
WHERE po.id_parent_output IS NOT NULL
ORDER BY po.output_name, prj.project_name;

/**
 * 12.Muestra los 5 proyectos con más outputs totales. Campos a mostrar: project_name, 
 * duracion_dias, num_outputs. Ordena por num_outputs DESC, duracion_dias, project_name.
 */
SELECT prj.project_name, TIMESTAMPDIFF(DAY, prj.start_date, prj.end_date) AS duracion_dias,
	COUNT(po.id_output) AS num_outputs
FROM project_outputs po 
JOIN projects prj ON po.id_project = prj.id_project
GROUP BY prj.id_project
ORDER BY num_outputs DESC, duracion_dias , prj.project_name
LIMIT 5;

/**
 * 13.Para cada proyecto, muestra los centros asignados al mismo. Ordena por project_name, 
 * num_centros.
 */
SELECT prj.project_name, COUNT(cnt.id_center) AS num_centros
FROM projects prj
JOIN rel_project_center rpc ON prj.id_project = rpc.id_project
JOIN centers cnt ON cnt.id_center = rpc.id_center
GROUP BY prj.id_project
ORDER BY prj.project_name, num_centros;

/**
 * 14.Muestra un listado que contenga para cada proyecto, nombre_centro, nombre_rol, 
 * horas_maximas_permitidas, coste_hora, importe_maximo (horas_maximas x coste_hora). 
 * Usa la tabla rel_project_user_role_cost para realizar este cálculo. Ordena por 
 * project_name, center_name, name_role_en.
 */
SELECT prj.project_name, cnt.center_name, rol.name_role_en, rpurc.max_allowed_hours,
	rpurc.hour_cost, rpurc.max_allowed_hours*rpurc.hour_cost AS importe_maximo
FROM projects prj
JOIN rel_project_user_role_cost rpurc ON rpurc.id_project = prj.id_project
JOIN centers cnt ON rpurc.id_center = cnt.id_center 
JOIN aux_role_user rol ON rpurc.id_role = rol.id_role
ORDER BY prj.project_name, cnt.center_name, rol.name_role_en;

/**
 * 15.Muestra un listado que contenga para cada proyecto el coste_maximo. Para ello 
 * tendremos en cuenta para cada proyecto, los centros asignados y para cada centro los 
 * roles que pueden trabajar, horas máximas que puede invertir cada rol y coste de hora 
 * del rol. Ordena por coste_maximo de mayor a menor y project_name. Campos a mostrar: 
 * project_name, coste_maximo.
 */
SELECT prj.project_name, SUM(rpurc.max_allowed_hours*rpurc.hour_cost) AS coste_maximo
FROM projects prj
JOIN rel_project_user_role_cost rpurc ON rpurc.id_project = prj.id_project
JOIN centers cnt ON rpurc.id_center = cnt.id_center 
JOIN aux_role_user rol ON rpurc.id_role = rol.id_role
GROUP BY prj.id_project
ORDER BY prj.id_project, coste_maximo;

/**
 * 16.Calcula las horas estimadas que llevará cada proyecto. Para calcular las horas 
 * estimadas, cogeremos para cada proyecto todos sus project_output, revisaremos las horas 
 * presupuestadas de cada centro rol para cada output y las sumaremos. La suma total de 
 * horas será las horas estimadas del proyecto. Campos a mostrar: project_name, 
 * horas_estimadas. Ordenar por horas estimadas de más a menos y project_name. Si alguna 
 * tupla de rel_output_center_budgeted tiene un null en la columna budgeted_hours lo 
 * tomaremos como un 0. Deben aparecer todos los proyectos en el listado.
 */
SELECT prj.project_name, SUM(IFNULL(roch.budgeted_hours,0)) AS horas_estimadas
FROM projects prj
LEFT JOIN project_outputs outp ON outp.id_project = prj.id_project 
LEFT JOIN rel_output_center_budgeted_hours roch ON roch.id_output = outp.id_output
GROUP BY prj.id_project
ORDER BY horas_estimadas DESC, prj.project_name;

/**
 * 17.Muestra el nombre de proyecto y el número total de horas imputadas 
 * (rel_user_project_input_hours) para los proyectos que tienen imputadas más de horas 
 * que la media. Ordena el resultado por project_name.
 */
SELECT  prj.project_name, SUM(ruph.hours) horas_imputadas
FROM projects prj
JOIN rel_user_project_input_hours ruph ON ruph.id_project = prj.id_project
GROUP BY prj.id_project
HAVING SUM(ruph.hours) > (SELECT AVG(total_horas) 
							FROM (
								   SELECT prj2.project_name, SUM(IFNULL(ruph2.hours,0)) AS total_horas
								   FROM projects prj2
								   LEFT JOIN rel_user_project_input_hours ruph2 ON prj2.id_project = ruph2.id_project
								   GROUP BY prj2.id_project
								 ) AS tabla
						 )
ORDER BY prj.project_name;

/**
 * 18.Muestra para cada project_output el número total de horas imputadas 
 * (rel_user_project_input_hours). Sólo deben aparecer los project_output con más del 
 * doble de horas imputadas que la media horas imputadas en todos projects_outputs 
 * existentes en la bbdd. Ordena por horas_imputadas de más a menos.
 */
SELECT pout.output_name, SUM(IFNULL(rupih.hours,0)) AS horas_imputadas
FROM project_outputs pout
LEFT JOIN rel_output_tasks rot ON rot.id_output = pout.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rot.id_task = rupih.id_task
GROUP BY pout.id_output
HAVING (horas_imputadas/2) > (SELECT AVG(pout_hours)
							  FROM (
								  	SELECT SUM(IFNULL(rupih2.hours,0)) AS pout_hours
								  	FROM project_outputs pout2
								  	LEFT JOIN rel_output_tasks rot2 ON rot2.id_output = pout2.id_output
								 	LEFT JOIN rel_user_project_input_hours rupih2 ON rot2.id_task = rupih2.id_task
								 	GROUP BY pout2.id_output
								   ) AS tabla
						  	 )
ORDER BY horas_imputadas DESC;

/**
 * 19.Para cada project_output muestra el número de horas imputadas 
 * (rel_user_project_input_hours) en total por cada usuario que ha trabajado en el dicho 
 * output. Campos a mostrar: project_name, parent_project_output.output_name, 
 * project_output.output_name, usuarios.nombre as nombre_usuario, total_horas. Ordena 
 * por project_name, parent_project_output.output_name, project_output.output_name, 
 * nombre_usuario.
 */
SELECT prj.project_name, parent.output_name AS output_parent, pout.output_name,
	usr.nombre AS nombre_usuario, SUM(rupih.hours) AS total_horas
FROM project_outputs pout
LEFT JOIN rel_output_tasks rot ON rot.id_output = pout.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rot.id_task = rupih.id_task
JOIN usuarios usr ON rupih.id_user = usr.id_usuario
LEFT JOIN projects prj ON pout.id_project = prj.id_project
LEFT JOIN project_outputs parent ON parent.id_output = pout.id_parent_output
GROUP BY pout.id_output, usr.id_usuario
ORDER BY prj.project_name, output_parent, pout.output_name, nombre_usuario;

/**
 * 20.Para cada project_output muestra el número de horas imputadas 
 * (rel_user_project_input_hours) en total por cada usuario que ha trabajado en el dicho 
 * output y el coste total de dichas horas. Campos a mostrar: project_name, 
 * parent_project_output.output_name, project_output.output_name, usuarios.nombre as 
 * nombre_usuario, total_horas, coste_total. Ordena por project_name, 
 * parent_project_output.output_name, project_output.output_name, nombre_usuario. El coste 
 * de las horas podemos sacarlo multiplicando el número de horas y el hour_cost asociado 
 * a id_role, id_center (tabla rel_project_user_role_cost).
 */
SELECT prj.project_name, parent.output_name AS output_parent, pout.output_name,
	usr.nombre AS nombre_usuario, SUM(rupih.hours) AS total_horas, 
	SUM(rupih.hours) * rpurc.hour_cost AS coste_total
FROM project_outputs pout
LEFT JOIN project_outputs parent ON parent.id_output = pout.id_parent_output
LEFT JOIN projects prj ON pout.id_project = prj.id_project
LEFT JOIN rel_output_tasks rot ON rot.id_output = pout.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rot.id_task = rupih.id_task
JOIN usuarios usr ON rupih.id_user = usr.id_usuario
JOIN rel_project_user_role_cost rpurc ON rpurc.id_role = usr.id_role AND rpurc.id_center = usr.id_center 
GROUP BY pout.id_output, usr.id_usuario
ORDER BY prj.project_name, output_parent, pout.output_name, nombre_usuario;

/**
 * 21.Muestra para cada project_output el coste_total_imputado. Descarta los 
 * projects_outputs cuyo coste sea menor 70% del coste medio. Campos a mostrar: 
 * project_name, parent_output_name, output_name, coste_total, 70% del coste medio. 
 * Ordena por coste_total_imputado de menos a más.
 */
SELECT p.project_name, parent.output_name AS parent_name, po.output_name,
 SUM(rupih.hours) * rpurc.hour_cost AS coste_total, 
 (SELECT AVG(coste_total) * 0.7 
 	FROM(
 		SELECT SUM(rupih2.hours) * rpurc2.hour_cost AS coste_total
		FROM project_outputs po2
		LEFT JOIN projects p2 ON p2.id_project = po2.id_project
		LEFT JOIN rel_output_tasks rot2 ON po2.id_output = rot2.id_output
		LEFT JOIN rel_user_project_input_hours rupih2 ON rupih2.id_task = rot2.id_task
		JOIN usuarios usr2 ON rupih2.id_user = usr2.id_usuario
		JOIN rel_project_user_role_cost rpurc2 ON rpurc2.id_role = usr2.id_role AND rpurc2.id_center = usr2.id_center
		GROUP BY po2.id_output
 	) AS tabla
 ) AS coste_70_medio
FROM project_outputs po
LEFT JOIN project_outputs parent ON parent.id_output = po.id_parent_output
LEFT JOIN projects p ON p.id_project = po.id_project
LEFT JOIN rel_output_tasks rot ON po.id_output = rot.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rupih.id_task = rot.id_task
JOIN usuarios usr ON rupih.id_user = usr.id_usuario
JOIN rel_project_user_role_cost rpurc ON rpurc.id_role = usr.id_role AND rpurc.id_center = usr.id_center
GROUP BY po.id_output
HAVING coste_total < coste_70_medio 
ORDER BY coste_total;

/**
 * 22.Saca un informe para el usuario con id_user = 21 en el que muestres el total de horas 
 * inputadas a cada output y el coste que han tenido dichos trabajos. Campos a mostrar 
 * project_name, parent_output_name, output_name, horas_total, coste_total.
 */
SELECT pro.project_name, parent.output_name AS parent_name, po.output_name,
	SUM(rupih.hours) AS horas_total, SUM(rupih.hours) * rpurc.hour_cost AS coste_total
FROM project_outputs po 
LEFT JOIN project_outputs parent ON parent.id_output = po.id_parent_output
LEFT JOIN projects pro ON pro.id_project = po.id_project
LEFT JOIN rel_output_tasks rot ON po.id_output = rot.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rupih.id_task = rot.id_task
JOIN usuarios usr ON rupih.id_user = usr.id_usuario
JOIN rel_project_user_role_cost rpurc ON rpurc.id_role = usr.id_role AND rpurc.id_center = usr.id_center
WHERE usr.id_usuario = 21
GROUP BY po.id_output, usr.id_usuario
ORDER BY pro.project_name, parent_name ;

/**
 * 23.Saca un informe para el usuario con id_user = 21 en el que muestres el total de horas 
 * inputadas a cada proyecto y el coste que han tenido dichos trabajos. Campos a mostrar 
 * project_name, horas_total, coste_total.
 */
SELECT pro.project_name, SUM(rupih.hours) AS horas_total, 
	SUM(rupih.hours) * rpurc.hour_cost AS coste_total
FROM projects pro 
LEFT JOIN project_outputs po ON po.id_project = pro.id_project -- vale JOIN normal
LEFT JOIN rel_output_tasks rot ON rot.id_output = po.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rupih.id_task = rot.id_task
JOIN usuarios usr ON rupih.id_user = usr.id_usuario
JOIN rel_project_user_role_cost rpurc ON rpurc.id_role = usr.id_role AND rpurc.id_center = usr.id_center
WHERE usr.id_usuario = 21
GROUP BY pro.id_project;

/**
 * 24.Saca un informe para el usuario con id_user = 21 en el que muestres las horas totales 
 * y el coste total que han tenido dichas horas. Campos a mostrar horas_total, coste_total.
 */
SELECT SUM(rupih.hours) AS horas_total, SUM(rupih.hours) * rpurc.hour_cost AS coste_total
FROM usuarios usr
JOIN rel_project_user_role_cost rpurc ON rpurc.id_role = usr.id_role AND rpurc.id_center = usr.id_center
JOIN rel_user_project_input_hours rupih ON rupih.id_user = usr.id_usuario 
RIGHT JOIN rel_output_tasks rot ON rot.id_task = rupih.id_task
RIGHT JOIN project_outputs po ON po.id_output = rot.id_output
WHERE usr.id_usuario = 21
GROUP BY usr.id_usuario;

/**
 * 25.Saca un informe en el que muestres para el usuario con id_user = 39 el total de horas 
 * inputadas a cada output y el coste que han tenido dichos trabajos para los trabajos 
 * realizados en los meses de febrero y marzo de 2019. Campos a mostrar project_name, 
 * parent_output_name, output_name, horas_total, coste_total.
 */
SELECT
FROM project_outputs po
JOIN projects pro ON pro.id_project = po.id_project 
LEFT JOIN project_outputs parent ON parent.id_output = po.id_parent_output 
LEFT JOIN rel_output_tasks rot ON rot.id_output = po.id_output
LEFT JOIN rel_user_project_input_hours rupih ON rupih.id_task = rot.id_task
JOIN usuarios usr ON rupih.id_user = usr.id_usuario
JOIN rel_project_user_role_cost rpurc ON rpurc.id_role = usr.id_role AND rpurc.id_center = usr.id_center
WHERE 
/**
 * 26.El cliente nos ha solicitado sacar un informe mensual con el número de horas totales 
 * imputadas en el sistema cada mes. Sacar un listado con los campos mes, total_horas 
 * ordenado de más antiguo a más reciente. Resultado esperado:
 */
















