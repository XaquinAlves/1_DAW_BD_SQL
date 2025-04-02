-- q1
SELECT xog.posicion , eq.nome_equipo, xog.nome, nac.nome AS nacionalidade_nome,
	xog.data_nacemento
FROM xogador xog
LEFT JOIN equipo eq ON xog.codigo_equipo = eq.codigo
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
WHERE (xog.posicion = 'A' OR xog.posicion = 'F') AND (YEAR(xog.data_nacemento ) = 1988
	OR YEAR(xog.data_nacemento ) = 2000)
ORDER BY xog.posicion, eq.nome_equipo, xog.nome;

-- q2
SELECT xog.numero_licencia, xog.posicion, eq.nome_equipo, xog.nome, nac.nome AS nacionalidade_nome,
 xog.estatura, TIMESTAMPDIFF(YEAR, xog.data_nacemento, NOW()) AS idade
FROM xogador xog
LEFT JOIN equipo eq ON xog.codigo_equipo = eq.codigo
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
WHERE (TIMESTAMPDIFF(YEAR, xog.data_nacemento, NOW()) >= 35 
	AND TIMESTAMPDIFF(YEAR, xog.data_nacemento, NOW()) <= 45) 
	AND (xog.estatura >= 1.95 AND xog.estatura <= 2.02)
ORDER BY idade , xog.estatura, xog.nome;

-- q3
SELECT nac.nome, MAX(xog.estatura) altura_maxima, COUNT(xog.numero_licencia) AS num_xogadores
FROM nacionalidade nac
JOIN xogador xog ON xog.nacionalidade = nac.codigo
GROUP BY nac.codigo
ORDER BY altura_maxima DESC, nac.nome;

-- q4
SELECT DISTINCT nac.nome
FROM nacionalidade nac
JOIN xogador xog ON xog.nacionalidade = nac.codigo
LEFT JOIN equipo eq ON xog.codigo_equipo = eq.codigo
WHERE eq.pavillon REGEXP '\\bPalacio\\b';

-- q5
SELECT nac.nome, MAX(xog.estatura) altura_maxima, COUNT(xog.numero_licencia) AS num_xogadores
FROM nacionalidade nac
JOIN xogador xog ON xog.nacionalidade = nac.codigo
WHERE xog.estatura >= 2
GROUP BY nac.codigo
ORDER BY altura_maxima DESC, nac.nome;

-- q6
SELECT xog.posicion , eq.nome_equipo, xog.nome, nac.nome AS nacionalidade_nome,
	xog.data_nacemento, xog.temporadas, eq.capacidade_pavillon
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
LEFT JOIN equipo eq ON xog.codigo_equipo = eq.codigo
WHERE  xog.ficha = 'EUR' AND xog.temporadas <= 3 AND eq.capacidade_pavillon >= 6000
ORDER BY xog.temporadas, eq.capacidade_pavillon, xog.nome;

-- q7
SELECT nac.nome, COUNT(xog.numero_licencia) AS num_xogadores
FROM nacionalidade nac
JOIN xogador xog ON xog.nacionalidade = nac.codigo
WHERE xog.estatura >= 2
GROUP BY nac.codigo
ORDER BY num_xogadores DESC, nac.nome;

-- q8
SELECT xog.nome, xog.estatura, xog.posicion, nac.nome AS nacionalidad, eq.nome_club, eq.nome_equipo
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
JOIN equipo eq ON xog.codigo_equipo = eq.codigo
WHERE xog.posicion = 'F' AND (xog.estatura > 1.90 AND xog.estatura < 2.10)
	AND (eq.nome_equipo LIKE '%caja%' OR eq.nome_equipo LIKE '%estu%')
ORDER BY eq.nome_equipo, xog.nome;

-- q10
SELECT nac.nome AS nome_pais,
	AVG(TIMESTAMPDIFF(YEAR, xog.data_nacemento, NOW())) AS idade_madia_bases_pais,
	(SELECT AVG(TIMESTAMPDIFF(YEAR, xog3.data_nacemento, NOW()))
	 FROM xogador xog3) AS idade_media_xeral
FROM nacionalidade nac
JOIN xogador xog ON xog.nacionalidade = nac.codigo
WHERE xog.posicion = 'B'
GROUP BY nac.codigo
HAVING AVG(TIMESTAMPDIFF(YEAR, xog.data_nacemento, NOW())) < (SELECT AVG(TIMESTAMPDIFF(YEAR, xog2.data_nacemento, NOW()))
																FROM xogador xog2
															)
ORDER BY idade_madia_bases_pais, nome_pais ;





