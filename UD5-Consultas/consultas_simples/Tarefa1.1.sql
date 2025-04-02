-- q1
--  Mostrar os datos de todas as tendas. Ordenadas por tda_poboación.
SELECT *
FROM tendas t
ORDER BY tda_poboacion; 

-- q2
-- Mostrar os nomes de todos os provedores. Ordenados por prv_nome.
SELECT p.prv_nome 
FROM provedores p 
ORDER BY prv_nome; 

-- q3
-- Obter a lista das poboacións nas que existen clientes. Ordenadas alfabéticamente.
SELECT DISTINCT c.clt_poboacion 
FROM clientes c 
ORDER BY c.clt_poboacion;

-- q4
-- Mostrar o código, nome e prezo de venda de todos os artigos e o prezo de venda que resultaría despois 
-- de aplicarlles un incremento do 10%. Ordenados por prezo de venda ascendente.
SELECT a.art_codigo , a.art_nome , a.art_pv , (a.art_pv * 1.10) AS precio_incrementado
FROM artigos a 
ORDER BY a.art_pv ASC;

-- q5
-- Mostrar o número de cliente, apelidos e nome de todos os clientes de Madrid. Ordenados por apelidos, nome.
SELECT c.clt_id , c.clt_apelidos , c.clt_nome 
FROM clientes c 
WHERE c.clt_poboacion = 'Madrid'
ORDER BY c.clt_apelidos , c.clt_nome;

-- q6
-- Seleccionar o código e peso dos artigos que pesen máis de 500 gramos.  Ordenados por código, peso.
SELECT a.art_codigo , a.art_peso 
FROM artigos a 
WHERE a.art_peso > 500
ORDER BY a.art_codigo , a.art_peso ;

-- q7 
-- Seleccionar todos os artigos que teñan prezo de venda superior ou igual ao dobre do prezo de compra. 
-- Ordenados por porcentaje de incremento de precio de forma descendente.
SELECT a.*, (a.art_pv / a.art_pc) * 100 AS incremento
FROM artigos a 
WHERE a.art_pv >= a.art_pc * 2
ORDER BY incremento DESC;

-- q8
-- Seleccionar apelidos, nome, poboación e desconto, de todos clientes de Asturias ou Valencia que teñan 
-- un desconto superior ao 2% ou que non teñan desconto. Ordenados por apelidos, nome.
SELECT c.clt_apelidos , c.clt_nome , c.clt_poboacion , c.clt_desconto 
FROM clientes c 
WHERE c.clt_poboacion IN ('Valencia','Asturias') AND (c.clt_desconto >= 2 OR c.clt_desconto = 0)
ORDER BY c.clt_apelidos , c.clt_nome ;

-- q9
-- Seleccionar todos os artigos de cor negra que pesen máis de 5000 gramos. Ordenados por código.
SELECT  *
FROM artigos a 
WHERE a.art_color = 'NEGRO' AND a.art_peso > 5000
ORDER BY a.art_codigo ;

-- q10
-- Obter todos os artigos que non son de cor negra ou que teñan un peso menor ou igual de 5000 gramos,
-- é dicir, obter o resultado complementario da consulta anterior. Ordenados por código.
SELECT *
FROM artigos a 
WHERE (a.art_color IS NULL OR != 'NEGRO') AND a.art_peso <= 5000
ORDER BY a.art_codigo ;

-- q11
-- Seleccionar os artigos que son de cor negra e pesan máis de 100 gramos, 
-- ou ben son de cor cyan. Ordenados por código.
SELECT *
FROM artigos a
WHERE (a.art_color  = 'NEGRO' AND a.art_peso > 100) OR a.art_color  = 'CYAN'
ORDER BY a.art_codigo 

-- q12
-- Facer unha lista dos artigos que teñan un prezo de compra entre 12 e 18 euros,
-- ambos prezos incluídos. Ordenados por prezo de compra.
SELECT *
FROM artigos a
WHERE a.art_pc BETWEEN 12 AND 18
ORDER BY a.art_pc ;

-- q13
-- Mostrar unha lista de artigos de cor negra ou de cor cyan. Ordenados por color, código.
SELECT *
FROM artigos a 
WHERE a.art_color IN ('NEGRO','CYAN') 
ORDER BY a.art_color , a.art_codigo ;

-- q14
-- Buscar un cliente do que se descoñece o apelido exacto, pero se sabe que as dúas primeiras do primeiro letras son 'RO'. 
SELECT *
FROM clientes c 
WHERE c.clt_apelidos LIKE 'RO%'

-- q15 
-- Buscar clientes que teñan o nome de 5 letras, empezando por 'B' e terminando por 'A'. Ordenados por nome.
SELECT *
FROM clientes c 
WHERE c.clt_nome REGEXP '\\bB[A-Z]{3}A\\b'
ORDER BY c.clt_nome ;

-- q16
-- Buscar todos os artigos para os que non se gravou o seu color. 
SELECT a.*
FROM artigos a 
WHERE a.art_color IS NULL;

-- q17 
--  Clasificar os artigos tendo en conta o seu peso, por orden decrecente.
SELECT a.*
FROM artigos a 
GROUP BY a.art_peso DESC ;

-- q18
-- Mostrar código de artigo, nome, prezo de compra, prezo de venda e marxe de beneficio (prezo de venda – prezo de compra) 
-- dos artigos que teñen un prezo de compra superior  a 3000 euros, ordenados pola marxe.
SELECT a.art_codigo , a.art_nome , a.art_pc , a.art_pv , (a.art_pv - a.art_pc) AS marxe_de_beneficio
FROM artigos a 
WHERE a.art_pc > 3000
ORDER BY marxe_de_beneficio;

-- q19
-- Clasificar nome, provedor, stock e peso dos artigos que teñen un peso menor ou igual de 1000 gramos, 
-- por orden crecente do provedor. Cando os provedores coincidan, deben clasificarse polo stock en orden decrecente.
SELECT a.art_nome , a.art_provedor , a.art_stock , a.art_peso 
FROM artigos a 
WHERE a.art_peso <= 1000
ORDER BY a.art_provedor ASC,a.art_stock DESC; 

-- q20 
-- Seleccionar nome e apelidos dos clientes que teñan un apelido que empece por 'F' e remate por 'Z'.
SELECT c.clt_nome , c.clt_apelidos 
FROM clientes c 
WHERE c.clt_apelidos REGEXP '\\bF[[:alpha:]]*Z\\b';
-- q21
-- Seleccionar todos os artigos que leven a palabra LED, en maiúsculas, no campo art_nome.
SELECT a.*
FROM artigos a 
WHERE a.art_nome LIKE BINARY '%LED%';
-- q22
-- Seleccionar todos os artigos que teñan un art_nome que empece por 'CABI', 
-- sen diferenciar maiúsculas de minúsculas. Ordenados por art_nome.
SELECT a.*
FROM artigos a
WHERE a.art_nome LIKE 'CABI%';
-- q23
-- Crea una consulta que compruebe si una string pasada como parámetro contiene un número entero
--  (número que puede o no empezar por + o - y que luego está formada por números).  
SELECT '-33' REGEXP '^[\+\-]{0,1}[0-9]+';
-- q24
-- Seleccionar os clientes que teñan un apelido que empece pola letra 'a' ou pola letra 'f'.
SELECT c.*
FROM clientes c 
WHERE c.clt_apelidos REGEXP '\\b[fa]';

-- q25
-- Seleccionar os clientes que teñan un apelido que non empece por 'a','b','c', ou 'd'.
SELECT c.*
FROM clientes c 
WHERE c.clt_apelidos REGEXP '\\b[^ABCD]';
-- q26
-- Seleccionar os artigos que teñan un prezo de venta que remata en .00.
SELECT a.*
FROM artigos a 
WHERE  a.art_pv LIKE '%\.00';
-- q27
-- Seleccionar os clientes que teñen un nome que teña exactamente 5 carácteres.
SELECT c.*
FROM clientes c 
WHERE c.clt_nome LIKE '_____';
-- q28
-- Buscar clientes que teñan o nome de 5 caracteres, empezando por 'B' e terminando por 'A'. Ordenados por nome.
SELECT c.*
FROM clientes c 
WHERE c.clt_nome LIKE 'B___A'
ORDER BY c.clt_nome ;








