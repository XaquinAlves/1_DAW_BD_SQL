/*
 * 1. Mostrar a lista de artigos cun prezo de venta maior có prezo de venta 
 * do artigo máis barato de cor negra utilizando unha consulta de existencia.
 */
SELECT art1.*
FROM artigos art1 
WHERE EXISTS (SELECT  art2.*
			  FROM artigos art2
			  WHERE art2.art_color = 'NEGRO' 
			  AND art2.art_pv < art1.art_pv
			)
ORDER BY art1.art_codigo;
/*
 * 2. Mostrar o nome dos artigos de cor negra que teñan algunha venda de 
 * máis de 5 unidades. Obter o mesmo resultado nos dous casos seguintes:
 */
-- sen utilizar join.
SELECT art.art_nome
FROM artigos art
WHERE art.art_color = 'NEGRO' AND EXISTS (SELECT dv.dev_artigo 
										  FROM detalle_vendas dv 
										  WHERE  dv.dev_cantidade > 5 
										  AND dv.dev_artigo = art.art_codigo
										)
ORDER BY art.art_nome;

-- utilizando join.
SELECT DISTINCT art.art_nome
FROM artigos art
JOIN detalle_vendas dv ON art.art_codigo = dv.dev_artigo
WHERE art.art_color = 'NEGRO' AND dv.dev_cantidade > 5
ORDER BY art.art_nome;

/*
 * 3. Mostrar nome e apelidos dos clientes que non fixeron ningunha compra.
 */
SELECT clt.clt_nome, clt.clt_apelidos
FROM clientes clt
WHERE NOT EXISTS (SELECT v.ven_cliente
				  FROM vendas v 
				  WHERE v.ven_cliente = clt.clt_id
				)
ORDER BY clt.clt_nome, clt.clt_apelidos; 
