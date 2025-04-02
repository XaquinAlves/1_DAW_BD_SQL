-- 1. Mostrar apellidos, nombre, dni, apellidos_padre, nombre_padre, apellidos_madre, nombre_madre de todas las personas
-- existentes en la tabla tengan o no progenitores registrados. Ordena el resultado por apellidos, nombre.
SELECT per.apellidos , per.nombre , per.dni , padre.apellidos AS apellidos_padre, padre.nombre AS nombre_padre,
	madre.apellidos AS apellidos_madre, madre.nombre AS nombre_madre
FROM persona per
LEFT JOIN persona madre ON per.madre = madre.id_persona 
LEFT JOIN persona padre ON per.padre = padre.id_persona 
ORDER BY per.apellidos, per.nombre;

-- 2. Muestra apellidos, nombre y dni de todas las personas que han sido madre ordenando el resultado por apellidos
-- y nombre.
SELECT DISTINCT madre.apellidos , madre.nombre , madre.dni 
FROM persona per
JOIN persona madre ON per.madre = madre.id_persona
ORDER BY madre.apellidos , madre.nombre ;

-- 3. Muestra apellidos, nombre y dni de todas las personas que han sido padre ordenando el resultado por apellidos
-- y nombre.
SELECT DISTINCT padre.apellidos , padre.nombre , padre.dni 
FROM persona per
JOIN persona padre ON per.padre  = padre.id_persona
ORDER BY padre.apellidos , padre.nombre ;

/* 4. Busca a todos los varones que han sido abuelo. Muestra una tupla por cada nieto que tengan con los siguientes 
campos: id_abuelo, nombre_abuelo, apellidos_abuelo, id_hije, nombre_hije, apellidos_hije, id_niete, nombre_niete,
apellidos_niete.  Sólo deben aparecer registros para los varones que han sido abuelos.
Ordenalos por apellidos y nombre de abuelo, hije, niete. Resultado: */
SELECT abuelo.id_persona AS id_abuelo, abuelo.nombre AS nombre_abuelo, abuelo.apellidos AS apellidos_abuelo,
	padre.id_persona AS id_hije, padre.nombre AS nombre_hije, padre.apellidos AS apellidos_hije,
	hijo.id_persona AS id_niete, hijo.nombre AS nombre_niete, hijo.apellidos AS apellidos_niete
FROM persona hijo
JOIN persona padre ON hijo.padre = padre.id_persona OR hijo.madre = padre.id_persona 
JOIN persona abuelo ON padre.padre = abuelo.id_persona 
ORDER BY apellidos_abuelo, nombre_abuelo, apellidos_hije, nombre_hije, apellidos_niete, nombre_niete;

/* 5. Busca a todas las mujeres que han sido bisabuela. Muestra una tupla por cada bisniete que tengan con los
siguientes campos: id_bis, nombre_bis, apellidos_bis, id_abuele, nombre_abuele, apellidos_abuele, id_hije,
nombre_hije, apellidos_hije, id_niete, nombre_niete, apellidos_niete. Sólo deben aparecer registros para las
mujeres que han sido bisabuelos. Ordenalos por apellidos y nombre de bisabuela, abuele, hije, niete.*/
SELECT bisabuela.id_persona AS id_bis, bisabuela.nombre AS nombre_bis, bisabuela.apellidos AS apellidos_bis,
	abuelo.id_persona AS id_abuele, abuelo.nombre AS nombre_abuele, abuelo.apellidos AS apellidos_abuele,
	padre.id_persona AS id_hije, padre.nombre AS nombre_hije, padre.apellidos AS apellidos_hije,
	persona.id_persona AS id_niete, persona.nombre AS nombre_niete, persona.apellidos AS apellidos_niete
FROM persona persona 
JOIN persona padre ON (persona.padre = padre.id_persona OR persona.madre = padre.id_persona )
JOIN persona abuelo ON padre.padre = abuelo.id_persona  OR padre.madre = abuelo.id_persona 
JOIN persona bisabuela ON abuelo.madre = bisabuela.id_persona 

/* 6. Para cada persona existente en la base de datos, muestra nombre_persona, apellidos_persona, nombre_madre,
apellidos_madre, nombre_padre, apellidos_padre. Ordenados por apellidos y nombre de persona. Deben aparecer
todos los usuarios de la BBDD tengan o no dados de alta a sus progenitores en la base de datos. */


