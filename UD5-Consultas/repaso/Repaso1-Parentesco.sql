/*
 * 1. Busca a todas las personas que tienen como último apellido Estévez. 
 * Datos a mostrar apellidos, nombre. Ordenado por apellidos, nombre.
 */
SELECT p.apellidos, p.nombre
FROM persona p
WHERE p.apellidos LIKE '%Estévez'
ORDER BY p.apellidos, p.nombre;

/*
 * 2. Busca a todas las personas que tienen primer apellido Fernández.
 *  Datos a mostrar apellidos, nombre. Ordenado por apellidos, nombre.
 */
SELECT p.apellidos, p.nombre
FROM persona p
WHERE p.apellidos LIKE 'Fernández%'
ORDER BY p.apellidos, p.nombre;
/*
 * 3. Busca a todas las personas que no han sido padre o madre que se apellidan Estévez.
 *  Datos a mostrar apellidos, nombre. Ordenado por apellidos, nombre.
 */


/*
 * 4. Busca a las personas que tienen como padre o madre una persona que se apellide 
 * Costas. Datos a mostrar apellidos, nombre. Ordenado por apellidos, nombre.
 */
SELECT p.apellidos, p.nombre
FROM persona p
JOIN persona padre ON padre.id_persona = p.padre OR padre.id_persona = p.madre
WHERE padre.apellidos  LIKE '%Costas%' -- REGEXP ('\\bCostas\\b') 
ORDER BY p.apellidos, p.nombre;

/*
 * 5. Busca a las personas que tienen como abuelo o abuela a una persona que se apellide
 *  Darriba. Datos a mostrar apellidos, nombre, apellidos_abuelao, nombre_abuelao. 
 *  Ordenado por apellidos, nombre.
 */
SELECT p.apellidos, p.nombre, abueloa.apellidos AS abueloa_apellidos, abueloa.nombre AS abueloa_nombre
FROM persona p
JOIN persona mapadre ON mapadre.id_persona = p.padre OR mapadre.id_persona = p.madre
JOIN persona abueloa ON abueloa.id_persona = mapadre.madre OR abueloa.id_persona = mapadre.padre
WHERE abueloa.apellidos LIKE '%Darriba%'
ORDER BY p.apellidos, p.nombre;

/*
 * 6. Para cada persona en la base de datos, muestra el número de hijos e hijas que tiene.
 *  Ordena por num_hijos DESC, apellidos, nombre.
 */
SELECT mapadre.apellidos, mapadre.nombre, COUNT(hijoa.id_persona) AS num_hijos
FROM persona hijoa
RIGHT JOIN persona mapadre ON mapadre.id_persona = hijoa.padre OR mapadre.id_persona = hijoa.madre
GROUP BY mapadre.id_persona
ORDER BY num_hijos DESC, mapadre.apellidos, mapadre.nombre;

/*
 * 7. Busca a las personas que tienen más hijos que la media de hijos que tienen las
 *  personas de la base de datos. Ordena por num_hijos DESC, apellidos, nombre. Campos 
 *  a mostrar: Muestra apellidos, nombre, número de hijos e hijas, media_hijos.
 */
SELECT mapadre.apellidos, mapadre.nombre, COUNT(hijoa.id_persona) AS num_hijos, 
	(SELECT AVG(num_fillos) 
	FROM (
			SELECT COUNT(hijoa2.id_persona) AS num_fillos
			FROM persona hijoa2
			RIGHT JOIN persona mapadre2 ON mapadre2.id_persona = hijoa2.padre 
										OR mapadre2.id_persona = hijoa2.madre
			GROUP BY mapadre2.id_persona
		 ) AS tabla
	) AS media_hijos
FROM persona hijoa
RIGHT JOIN persona mapadre ON mapadre.id_persona = hijoa.padre OR mapadre.id_persona = hijoa.madre
GROUP BY mapadre.id_persona
HAVING COUNT(hijoa.id_persona) > (SELECT AVG(num_fillos) 
								  FROM (
								  		SELECT COUNT(hijoa2.id_persona) AS num_fillos
										FROM persona hijoa2
										RIGHT JOIN persona mapadre2 ON mapadre2.id_persona = hijoa2.padre 
																OR mapadre2.id_persona = hijoa2.madre
										GROUP BY mapadre2.id_persona
								 	   ) AS tabla
								 )

/*
 * 8. Muestra la media de hijos que tienen la personas que tienen más hijos que la 
 *  media de hijos que tienen las personas de la base de datos. Es decir, queremos la 
 *  media de hijos que tienen las personas que tienen más hijos que la media general.
 */
SELECT (SELECT AVG(num_hijos) 
		FROM(
			SELECT COUNT(hijoa.id_persona) AS num_hijos
			FROM persona mapadre3 
			LEFT JOIN persona hijoa ON hijoa.madre = mapadre.id_persona 
									OR hijoa.padre  = mapadre.id_persona 
			WHERE mapadre3.id_persona = mapadre.id_persona
		)AS tabla) AS media_fillos
FROM persona mapadre
LEFT JOIN persona hijoa ON hijoa.madre = mapadre.id_persona 
							OR hijoa.padre  = mapadre.id_persona
GROUP BY mapadre.id_persona
HAVING COUNT(hijoa.id_persona) > (SELECT AVG(num_fillos)
									FROM(
											SELECT COUNT(hijoa2.id_persona) AS num_fillos
											FROM persona mapadre2
											LEFT JOIN persona hijoa2 ON hijoa2.madre = mapadre2.id_persona 
																	OR hijoa2.padre  = mapadre2.id_persona
											GROUP BY mapadre2.id_persona
									) AS resumen
								)

/*
 * 9. Muestra apellidos, nombres y número de nietos de las 2 personas con más nietos de la base de datos. En caso de empate aparecerá la persona con apellidos, nombre ASC.
 */
/*
 * 10. Para cada persona en la base de datos, muestra el número de hijos e hijas que tiene así como el número de nietas y nietos. Ordena por num_nietos DESC, num_hijos DESC, apellidos, nombre.
 */
/*
 * 11. Muestra apellidos, nombre y el número de descendientes totales (hijos + nietos + bisnietos) que tienen las personas de las que desconocemos sus progenitores. Ordena por apellidos, nombre.
 */
/*
 * 12. Muestra a las personas que tienen al menos dos hijos que se apellidan Darriba. Datos a mostrar id_persona, apellidos, nombre, num_hijes_darriba. Ordenado por apellidos, nombre.
 */
/*
 * 13. Muestra a las personas que tienen al menos dos hijos o hijas que se apelliden Fernández ordenadas por número de hijos_totales (se apelliden o no Fernández). Datos a mostrar id_persona, apellidos, nombre, num_hijos_totales. Ordenado por num_hijos_totales, apellidos, nombre.
 */
/*
 * 14. Muestra a las personas que tienen al menos tres hijos o hijas que se apelliden Fernández o Aguado ordenadas por número de hijos_totales (se apelliden o no Fernández o Aguado). Datos a mostrar id_persona, apellidos, nombre, num_hijos_totales. Ordenado por num_hijos_totales, apellidos, nombre.
 */
