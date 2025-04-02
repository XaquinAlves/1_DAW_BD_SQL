-- q1
SELECT art.art_codigo, art.art_nome, art.art_peso, art.art_color
FROM artigos art
WHERE art.art_peso >= 2000 AND art.art_peso <= 3000
	AND art.art_color != 'Negro'
ORDER BY art.art_peso DESC, art.art_color
LIMIT 10;

-- q2
SELECT clt.clt_id, clt.clt_apelidos, clt.clt_nome, COUNT(ven.ven_id) AS num_compras
FROM clientes clt
LEFT JOIN vendas ven ON ven.ven_cliente = clt.clt_id
WHERE clt.clt_nome like 'J%'
GROUP BY clt.clt_id
ORDER BY num_compras DESC, clt.clt_apelidos, clt.clt_nome;

-- q3
SELECT art.art_codigo, art.art_nome, art.art_peso, art.art_pc, art.art_pv,
	(art.art_pv - art.art_pc) AS diferencia, prv.prv_nome
FROM artigos art
JOIN provedores prv ON art.art_provedor  = prv.prv_id
WHERE art.art_nome LIKE 'SAI%' and prv.prv_nome LIKE '%NET%'
ORDER BY diferencia DESC;

-- q4
SELECT prv.prv_id, prv.prv_nome, COUNT(dv.dev_venda) AS unidades_vendidas
FROM provedores prv
LEFT JOIN artigos art ON art.art_provedor = prv.prv_id
LEFT JOIN detalle_vendas dv ON dv.dev_artigo = art.art_codigo
GROUP BY prv.prv_id
ORDER BY unidades_vendidas DESC, prv.prv_nome;

-- q5
SELECT art.art_codigo, art.art_nome, art.art_peso
FROM provedores prv
JOIN artigos art ON art.art_provedor = prv.prv_id
JOIN detalle_vendas dv ON art.art_codigo = dv.dev_artigo
JOIN vendas ven ON dv.dev_venda = ven.ven_id
JOIN tendas tda ON ven.ven_tenda = tda.tda_id
WHERE prv.prv_nome = 'APC - NETWORK' AND tda.tda_poboacion LIKE 'Coruña%'
ORDER BY art.art_nome;

-- q7
SELECT emp.emp_id, emp.emp_dni, 
	CONCAT(emp.emp_apelidos,', ',emp.emp_nome) AS nome_completo
FROM empregados emp
LEFT JOIN vendas ven ON ven.ven_empregado = emp.emp_id
GROUP BY emp.emp_id
HAVING COUNT(ven.ven_id) = 0;

-- q8
SELECT prv.prv_id, prv.prv_nome, COUNT(DISTINCT art.art_codigo) AS tipo_articulos, 
	SUM(art.art_stock) AS stock_proveedor
FROM provedores prv
JOIN artigos art ON art.art_provedor = prv.prv_id
WHERE (art.art_nome LIKE 'PC%' OR art.art_nome LIKE 'portátil%')
GROUP BY prv.prv_id
HAVING SUM(art.art_stock) >= 50
ORDER By prv.prv_nome;

-- q9
SELECT clt.clt_id, clt.clt_apelidos, clt.clt_nome
FROM clientes clt
JOIN vendas ven ON ven.ven_cliente = clt.clt_id
WHERE ven.ven_data >=  (SELECT cltRef.clt_ultima_venda
						FROM clientes cltRef
						WHERE cltRef.clt_id = 59
						)
ORDER BY clt.clt_id;

-- q10
SELECT prv.prv_id, prv.prv_nome, COUNT(DISTINCT art.art_codigo) AS tipo_articulos, 
	SUM(art.art_stock) AS stock_articulos, ROUND(AVG(art.art_pc),2) AS precio_medio,
	ROUND((SELECT AVG(art2.art_pc) FROM artigos art2),2) AS precio_medio_general
FROM provedores prv
JOIN artigos art ON art.art_provedor = prv.prv_id
WHERE (art.art_nome LIKE 'PC%' OR art.art_nome LIKE 'portátil%')
GROUP BY prv.prv_id
HAVING AVG(art.art_pc) > (SELECT AVG(art3.art_pc) FROM artigos art3)
ORDER BY prv.prv_nome;


