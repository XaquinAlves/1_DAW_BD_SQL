-- q1. Para cada jugador muestra nombre, posición, nacionalidad_nome, nombre_equipo, fecha_nacimiento.
SELECT xog.nome , xog.posicion , nac.nome AS nacionalidade_nome , e.nome_equipo, xog.data_nacemento  
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo 
JOIN equipo e ON xog.codigo_equipo = e.codigo 
ORDER BY xog.nome, xog.posicion;

-- q2. Para cada jugador menor de 38 años muestra nombre, posición, nacionalidad_nome, nombre_equipo, fecha_nacimiento.
SELECT xog.nome , xog.posicion , nac.nome AS nacionalidade_nome , e.nome_equipo, xog.data_nacemento  
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
JOIN equipo e ON xog.codigo_equipo = e.codigo 
WHERE TIMESTAMPDIFF(YEAR,xog.data_nacemento,NOW()) < 38
ORDER BY xog.nome, xog.posicion; 

-- q3. Muestra nombre, posición, nacionalidad_nome, nombre_equipo, altura, fecha_nacimiento de todos los jugadores
-- que miden menos de 1,90 y militan en un club que es S. A. D.
SELECT xog.nome , xog.posicion , nac.nome AS nacionalidade_nome , e.nome_equipo, xog.estatura , xog.data_nacemento  
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
JOIN equipo e ON xog.codigo_equipo = e.codigo 
WHERE xog.estatura < 1.90 AND e.nome_club LIKE '%S.A.D.'
ORDER BY xog.nome, xog.posicion;

-- q4. Muestra nombre, posición, nacionalidad_nome, nombre_equipo, altura, fecha_nacimiento de los todos jugadores
-- cuyo pais de nacimiento contiene una letra e, una i o una u y que lleven al menos 2 temporadas en la liga.
SELECT xog.nome , xog.posicion , nac.nome AS nacionalidade_nome , e.nome_equipo, xog.estatura , xog.data_nacemento 
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
JOIN equipo e ON xog.codigo_equipo = e.codigo 
WHERE nac.nome REGEXP '[eiu]' AND xog.temporadas >= 2
ORDER BY xog.nome, xog.posicion;

-- q5. Muestra a los jugadores de entre 35 y 45 años que juegan en un club del que no conocemos el aforo de su campo.
-- Es obligatorio que estén militando en un equipo.
SELECT xog.*
FROM xogador xog
JOIN equipo e ON xog.codigo_equipo = e.codigo 
WHERE e.capacidade_pavillon IS NULL AND TIMESTAMPDIFF(YEAR,xog.data_nacemento,NOW()) BETWEEN 35 AND 45
ORDER BY xog.numero_licencia;

-- q6. Muestra las distintas nacionalidades de jugadores que han jugado como locales en pabellones que tienen
-- en su nombre la palabra Arena. Si la nacionalidad no se conoce el jugador debe ser ignorado.
SELECT DISTINCT nac.nome 
FROM xogador xog
JOIN equipo eq ON xog.codigo_equipo = eq.codigo 
JOIN nacionalidade nac ON nac.codigo = xog.nacionalidade 
WHERE eq.pavillon REGEXP '\\bArena\\b'
ORDER BY nac.nome;

-- q7. Muestra el nombre de diferentes equipos que han tenido al menos un jugador nacido después de 1980 y que
-- ha jugado 10 o más temporadas en la categoría.
SELECT DISTINCT eq.nome_equipo 
FROM equipo eq
JOIN xogador xog ON eq.codigo = xog.codigo_equipo 
WHERE YEAR(xog.data_nacemento) > 1980 AND xog.temporadas >= 10
ORDER BY eq.nome_equipo;

-- q8. Muestra nombre, posición, nacionalidad_nome, nombre_equipo, altura, fecha_nacimiento de todos los jugadores
-- que miden entre 1,98 y 2,06. Ordena el resultado por altura, nombre.
SELECT xog.nome , xog.posicion , nac.nome AS nacionalidade_nome , e.nome_equipo, xog.estatura , xog.data_nacemento 
FROM xogador xog
LEFT JOIN nacionalidade nac ON xog.nacionalidade = nac.codigo
JOIN equipo e ON xog.codigo_equipo = e.codigo 
WHERE xog.estatura BETWEEN 1.98 AND 2.06
ORDER BY xog.estatura , xog.nome;

-- q9. Muestra el nombre de los jugadores, nombre_club y nombre_equipo que pertenecen a un club cuyo nombre
-- de equipo contiene un patrocinador que sea una banca o una caja. Ordena el resultado por nombre_equipo,
-- nombre_jugador.
SELECT xog.nome AS nome_xogador , eq.nome_club , eq.nome_equipo 
FROM xogador xog
JOIN equipo eq ON eq.codigo = xog.codigo_equipo
WHERE eq.nome_equipo LIKE '%caja%' OR eq.nome_equipo LIKE '%banca%'
ORDER BY eq.nome_equipo , nome_xogador; 


-- q10. Muestra nombre de los jugadores, nombre_club y nombre_equipo de los jugadores mayores de 40 años que
-- militan en equipos de los que desconocemos el nombre del pabellón. Es obligatorio que estén militando en un equipo.
SELECT xog.nome AS nome_xogador , eq.nome_club , eq.nome_equipo 
FROM xogador xog
JOIN equipo eq ON eq.codigo = xog.codigo_equipo
WHERE TIMESTAMPDIFF(YEAR,xog.data_nacemento,NOW()) > 40 AND eq.pavillon IS NULL 
ORDER BY xog.nome, eq.nome_club;










