-- q1.
-- Mostrar apelidos e nome dos clientes nunha mesma columna separados por unha coma,
-- e o número de letras que ten o nome.
SELECT  CONCAT(c.clt_apelidos,', ',c.clt_nome) AS nome_cliente, LENGTH(c.clt_nome) AS lonxitude_nome
FROM clientes c
ORDER BY nome_cliente, lonxitude_nome;

-- q2.
-- Mostrar  nomes e apelidos dos clientes en minúscula.
SELECT LOWER(c.clt_nome), LOWER(c.clt_apelidos)
FROM clientes c 
ORDER BY c.clt_nome , c.clt_apelidos;

-- q3.
-- Mostrar a idade dunha persoa nacida o 22/03/1981 no momento actual. Suponse que a data do sistema é a correcta.
SELECT TIMESTAMPDIFF(YEAR,'1981-03-22',CURDATE()) AS idade;

-- q4.
-- Mostrar tódalas vendas do mes anterior ao mes actual en dous supostos:
--    • Na táboa gárdanse datos das vendas dun ano.
SELECT v.*
FROM vendas v 
WHERE MONTH(v.ven_data) = MONTH(SUBDATE(CURRENT_DATE(), INTERVAL 1 MONTH))
ORDER BY v.ven_id;

--    • Na táboa gárdanse datos das vendas de varios anos.
SELECT v.*
FROM vendas v 
WHERE MONTH(v.ven_data) = MONTH(SUBDATE(CURRENT_DATE(), INTERVAL 1 MONTH)) AND YEAR(v.ven_data) = YEAR(SUBDATE(CURRENT_DATE(), INTERVAL 1 MONTH))
ORDER BY v.ven_id;

-- q5.
-- Mostrar  número, nome e prezo de venda (redondeado, sen decimais) dos artigos de cor negra.
SELECT a.art_codigo , a.art_nome , ROUND(a.art_pv,0) AS precio_venta 
FROM artigos a 
WHERE a.art_color = 'NEGRO'
ORDER BY a.art_codigo, a.art_nome;

-- q6.
-- Calcular a media dos pesos de todos os artigos.
SELECT AVG(a.art_peso) AS media_pesos
FROM artigos a
ORDER BY media_pesos;

-- q7.
-- Calcular a media do peso, o marxe máximo ( máxima diferenza entre o prezo de venda e o prezo de compra)
-- e a diferenza que se dá entre o maior prezo de venda e o menor prezo de compra. Estes cálculos terán que facerse
-- para aqueles artigos que teñan descrito a cor cun valor distinto do NULL.
SELECT AVG(a.art_peso) AS media_pesos, MAX(a.art_pv - a.art_pc) AS marxe_maximo, MAX(a.art_pv) - MIN(a.art_pc) AS diferencia
FROM artigos a
WHERE a.art_color IS NOT NULL
ORDER BY media_pesos , marxe_maximo ;

-- q8.
-- Contar o número de cores distintos que existen na táboa de artigos.
SELECT COUNT(DISTINCT a.art_color) AS numero_cores
FROM artigos a
ORDER BY numero_cores ; 
-- Toma null como un cor valido
SELECT COUNT(DISTINCT IFNULL(a.art_color,'Color_null')) AS numero_cores
FROM artigos a
ORDER BY numero_cores ; 

-- q9.
-- Mostrar nome e cor dos artigos. Se a cor é descoñecida, débese mostrar o texto ‘DESCOÑECIDO’.
SELECT  a.art_nome , IFNULL(a.art_color,'DESCOÑECIDO') AS cor
FROM artigos a
ORDER BY a.art_nome , cor ; 



