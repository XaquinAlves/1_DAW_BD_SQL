/*
 * 1. Muestra todas las nacionalidades existentes en la base de datos y
 *  el número de jugadores que pertenecen a ellas. Ordena el resultado
 *  de más a menos número de jugadores. Los países con el mismo número
 *  de jugadores serán ordenados alfabéticamente.
 */
SELECT nac.codigo ,nac.nome , COUNT(xog.numero_licencia) AS num_xogadores
FROM nacionalidade nac
LEFT JOIN xogador xog ON xog.nacionalidade = nac.codigo
GROUP BY nac.codigo
ORDER BY num_xogadores DESC, nac.nome;

/*
 * 2. Para cada nacionalidad, muestra el número de jugadores que juegan
 *  en cada posición. No es necesario mostrar los pares país-posición que
 *  no tienen jugadores. Los campos a mostrar son nacionalidad, posición,
 *  jugadores_en_posición. Ordena por esos campos en ese orden.
 */
SELECT xg.nacionalidade, xg.posicion, COUNT(xg.numero_licencia) AS numero_xogadores
FROM xogador xg
GROUP BY xg.nacionalidade, xg.posicion;

/*
 * 3. Queremos consultar qué países aportan más jugadores para cada posición.
 *  Los campos a mostrar son nacionalidade.nome, posición y num_jugadores.
 *  El resultado debe mostrar para cada posición los países ordenados de más
 *  jugadores que aportan a menos. En caso de empate se muestran los países
 *  empatados en orden alfabético. Ejemplo resultado:
 */ 
SELECT nac.nome , xg.posicion, COUNT(xg.numero_licencia) AS num_xogadores
FROM xogador xg
JOIN nacionalidade nac ON xg.nacionalidade = nac.codigo
GROUP BY xg.posicion, nac.codigo 
ORDER BY xg.posicion, num_xogadores DESC, nac.nome;

/*
 * 4. Queremos sacar un informe que muestre para cada equipo muestre el número
 *  de jugadores de cada nacionalidad. Los campos a mostrar son: equipo.nome_equipo,
 *  nacionalidade.nome, num_jugadores. El resultado vendrá ordenado por
 *  equipo.nome_equipo de la A..Z y las nacionalidades ordenadas de las que más
 *  aportan a las que menos. A igualdad de jugadores de una nacionalidad, se ordenará
 *  por nombre de la nacionalidad.
 */
SELECT eq.nome_equipo, nac.nome, COUNT(xg.numero_licencia) AS num_xogadores
FROM equipo eq 
RIGHT JOIN xogador xg ON xg.codigo_equipo = eq.codigo 
LEFT JOIN nacionalidade nac ON xg.nacionalidade = nac.codigo
GROUP BY eq.nome_equipo, nac.codigo 
ORDER BY eq.nome_equipo, num_xogadores DESC, nac.nome;

/*
 * 5. Muestra la edad media de los jugadores de cada país ordenando el resultado
 *  de menor edad media a mayor edad media. En caso de misma edad media, ordena
 *  por nombre de nacionalidad.
 */
SELECT nac.nome, AVG(TIMESTAMPDIFF(YEAR, xg.data_nacemento, NOW())) AS edad_media
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
GROUP BY nac.codigo
ORDER BY edad_media , nac.nome;

/*
 * 6. Muestra los países que aportan más jugadores altos. Un jugador será alto
 *  si su estatura es mayor que la media de altura de todos los jugadores existentes
 *  en la base de datos. Campos a mostrar: nombre_pais, num_jugadores_altos. Ordena
 *  por num_jugadores_altos de más a menos y a igualdad de jugadores por nombre_pais.
 */
SELECT nac.nome,  COUNT(xg.numero_licencia) AS num_xogadores_altos
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
WHERE xg.estatura > (SELECT AVG(xg2.estatura)
					 FROM xogador xg2)
GROUP BY nac.codigo 
ORDER BY num_xogadores_altos, nac.nome;


/*
 * 7. Muestra los países que tienen como altura media un valor mayor que la altura
 *  media de todos los jugadores. Ordena el resultado de mayor media a menor. En caso
 *  de empate muestra los países ordenados por orden alfabético.
 */
SELECT nac.nome, AVG(xg.estatura) AS estatura_media
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
GROUP BY nac.codigo 
HAVING AVG(xg.estatura) > (SELECT AVG(xg2.estatura)
					 		FROM xogador xg2) 
ORDER BY estatura_media DESC, nac.nome;

/*
 * 8. Muestra los países que aportan más jugadores menores que la media de edad de
 *  todos los jugadores existentes en la base de datos. Campos a mostrar: nombre_pais,
 *  num_jugadores_menores. Ordena por num_jugadores_menores de más a menos y a
 *  igualdad de jugadores por nombre_pais.
 */
SELECT nac.nome, COUNT(xg.numero_licencia) AS num_xogadores_menores
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
WHERE TIMESTAMPDIFF(YEAR, xg.data_nacemento, CURDATE()) < (SELECT AVG(TIMESTAMPDIFF(YEAR, xg2.data_nacemento, CURDATE())) 
														FROM xogador xg2)
GROUP BY nac.codigo
ORDER BY num_xogadores_menores DESC, nac.nome ;

/*
 * 9. Muestra los países que tienen como edad media un valor menor que la edad
 *  media de todos los jugadores. Campos a mostrar: nombre_pais, edad_media_pais,
 *  edad_media_general. Ordena por edad_media_pais y a igualdad de edad_media_pais
 *  por nombre_pais.
 */
SELECT nac.nome, AVG(TIMESTAMPDIFF(YEAR, xg.data_nacemento, NOW())) AS edad_media_pais,
	(SELECT AVG(TIMESTAMPDIFF(YEAR, xg2.data_nacemento, NOW())) FROM xogador xg2) AS edad_media_general
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
GROUP BY nac.codigo
HAVING AVG(TIMESTAMPDIFF(YEAR, xg.data_nacemento, NOW())) < (SELECT AVG(TIMESTAMPDIFF(YEAR, xg3.data_nacemento, NOW()))
															 FROM xogador xg3)
ORDER BY edad_media_pais , nac.nome;

/*
 * 10. Muestra para cada país con al menos un jugador cuantos jugadores aportan con
 *  cada número de temporadas. Campos a mostrar: nombre_pais, num_temporadas,
 *  num_jugadores. Ordena el resultado por nombre_pais, num_temporadas DESC.
 *  No deben aparecer los pares país-temporadas que no tengan jugadores.
 */
SELECT nac.nome, SUM(xg.temporadas) AS num_temporadas, COUNT(xg.numero_licencia) AS num_xogadores
FROM xogador xg
JOIN nacionalidade nac On nac.codigo = xg.nacionalidade
GROUP BY nac.codigo
ORDER BY nac.nome, num_temporadas DESC;

/*
 * 11. Muestra para cada país con al menos un jugador cuantos jugadores
 *  jovenes (jugadores menores que la media de edad de todos los jugadores existentes
 *  en la base de datos) aportan con cada número de temporadas. Campos a mostrar:
 *  nombre_pais, num_temporadas, num_jugadores. Ordena el resultado por nombre_pais,
 *  num_temporadas DESC. No deben aparecer los pares país-temporadas que no tengan
 *  jugadores.
 */
SELECT nac.nome,  SUM(xg.temporadas) AS num_temporadas, COUNT(xg.numero_licencia) AS num_xogadores
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade 
WHERE xg.data_nacemento > (SELECT AVG(xg2.data_nacemento) 
							FROM xogador xg2)
GROUP BY nac.codigo
ORDER BY nac.nome, num_temporadas DESC;

/*
 * 12. Muestra para cada país el número de jugadores que militan en cada uno de
 *  los equipos de la liga que tienen un pabellón con al menos un aforo de 6.000
 *  espectadores. Campos a mostrar: nome_equipo, nombre_país, num_jugadores.
 *  Ordena el resultado por nome_equipo, num_jugadores DESC, nome_pais.
 */
SELECT nac.nome , eq.nome_equipo, COUNT(xg.numero_licencia) AS num_xogadores 
FROM xogador xg
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
JOIN equipo eq ON xg.codigo_equipo = eq.codigo
WHERE eq.capacidade_pavillon >= 6000
GROUP BY nac.codigo, eq.codigo
ORDER BY eq.nome_equipo, num_xogadores DESC, nac.nome

/*
 * 13. Busca al jugador/jugadores más bajos menores de 40 años y muestra los
 *  siguientes datos de el/ellos: xogador.nome, nome_equipo, nacionalidade.nome,
 *  estatura, estatura_media de los jugadores menores de 40 años.
 */
SELECT xg.nome, eq.nome_equipo, nac.nome, xg.estatura, (SELECT AVG(xg2.estatura) 
														FROM xogador xg2
														WHERE TIMESTAMPDIFF(YEAR, xg2.data_nacemento, NOW()) < 40 ) AS media_estatura
FROM xogador xg
JOIN equipo eq ON eq.codigo = xg.codigo_equipo
JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
WHERE TIMESTAMPDIFF(YEAR, xg.data_nacemento, NOW()) < 40 
GROUP BY xg.estatura
HAVING xg.estatura <= ALL (SELECT xg2.estatura FROM xogador xg2)

/*
 * 14. Saca un informe en el que muestres cuantos jugadores nacieron en cada año.
 *  Campos a mostrar: anho_nacimiento, jugadores. Ordenado por anho_nacimiento.
 */
SELECT YEAR(xg.data_nacemento) as ano_nacemento, COUNT(xg.numero_licencia)
FROM xogador xg
GROUP BY YEAR(xg.data_nacemento);

/*
 * 15. Modifica el informe anterior para que además desglose por nacionalidad:
 */
SELECT YEAR(xg.data_nacemento) as ano_nacemento, nac.nome ,COUNT(xg.numero_licencia)
FROM xogador xg
LEFT JOIN nacionalidade nac ON nac.codigo = xg.nacionalidade
GROUP BY YEAR(xg.data_nacemento), nac.codigo;











