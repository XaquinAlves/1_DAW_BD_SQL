/*
 * 1. Seleccionar da táboa artigos as cores e o prezo medio de venda dos artigos
 *  de cada cor (con dous decimais). 
 */
SELECT art.art_color, ROUND(AVG(art.art_pv),2) AS precio_medio
FROM artigos art
GROUP BY art.art_color
ORDER BY art.art_color;

/* 
 * 2. Seleccionar da táboa artigos as cores e o prezo medio de venda dos artigos
 *  de cada cor (con dous decimais), excluíndo aos artigos que teñan un prezo de
 *  compra superior a 50 euros.
 */
SELECT art.art_color, ROUND(AVG(art.art_pv),2)
FROM artigos art
WHERE art.art_pc <= 50
GROUP BY art.art_color
ORDER BY art.art_color;

/*
 * 3. Mostrar as cidades nas que existen clientes e o número de clientes que hai
 *  en cada unha de elas. Clasificar a saída en orden decrecente polo número de clientes.
 */
SELECT clt.clt_poboacion, COUNT(clt.clt_id) AS numero_clientes
FROM clientes clt
GROUP BY clt.clt_poboacion
ORDER BY numero_clientes DESC;

/*
 * 4. Mostrar código, nome, suma dos importes das vendas sen aplicar o desconto,
 *  suma dos importes das vendas despois de aplicar o desconto, e desconto efectuado,
 *  para os artigos vendidos entre 1-1-2015 e 25-5-2015.
 */
SELECT  art.art_codigo, art.art_nome, SUM(dv.dev_prezo_unitario * dv.dev_cantidade) AS importe_sen_desconto,
	SUM(dv.dev_prezo_unitario * dv.dev_cantidade * (1-dv.dev_desconto/100)) AS importe_con_desconto,
	(SUM(dv.dev_prezo_unitario * dv.dev_cantidade) - SUM(dv.dev_prezo_unitario * dv.dev_cantidade * (1-dv.dev_desconto/100))) AS desconto_efectuado
FROM vendas ven
JOIN detalle_vendas dv ON dv.dev_venda = ven.ven_id 
JOIN artigos art ON dv.dev_artigo = art.art_codigo
WHERE ven.ven_data >= '2015-01-01' AND ven.ven_data < '2015-05-25'
GROUP BY art.art_codigo
ORDER BY art.art_codigo , art.art_nome;

/*
 * 5. Mostrar as estatísticas de vendas do ano 2015 por tenda. A información
 *  a mostrar é: identificador da tenda, número de vendas, número de artigos diferentes
 *  vendidos,suma de unidades vendidas e a media dos prezos unitarios dos artigos vendidos.
 */
SELECT ven.ven_tenda , COUNT(ven.ven_id) AS numero_vendas, COUNT(DISTINCT dv.dev_artigo) AS artigos_vendidos, 
	SUM(dv.dev_cantidade) AS unidades_vendidas , AVG(dv.dev_prezo_unitario) AS media_precio
FROM vendas ven
JOIN detalle_vendas dv ON dv.dev_venda = ven.ven_id
WHERE YEAR(ven.ven_data) = '2015' 
GROUP BY ven.ven_tenda
ORDER BY ven.ven_tenda, numero_vendas;







