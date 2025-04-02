/*
 * 1.Seleccionar da táboa artigos as cores e o prezo medio de venda dos artigos
 *  de cada cor, para as cores que teñan o prezo medio maior que 100 euros.
 */
SELECT art.art_color, AVG(art.art_pv) AS precio_medio
FROM artigos art
GROUP BY art.art_color
HAVING AVG(art.art_pv) > 100
ORDER BY art.art_color, precio_medio ;

/*
 * 2. Mostrar as tendas que fixeron máis de 2 vendas no mes de maio de 2015.
 *  Para cada tenda débese mostrar: numero de tenda, número de vendas,
 *  número de artigos diferentes vendidos e a suma de unidades vendidas nese
 *  período de tempo.
 */
SELECT tda.tda_id, COUNT(ven.ven_id) AS ventas,
	COUNT(DISTINCT dv.dev_artigo) AS artigos_diferentes, SUM(dv.dev_cantidade) AS unidades_vendidas
FROM tendas tda
JOIN vendas ven ON ven.ven_tenda = tda.tda_id
JOIN detalle_vendas dv ON ven.ven_id = dv.dev_venda
WHERE ven.ven_data  >= '2015-05-01' AND ven.ven_data < '2015-06-01'
GROUP BY tda.tda_id
HAVING ventas > 2
ORDER BY tda.tda_id;

/*
 * 3. Mostrar o identificador do cliente, data de venda, a cantidade de artigos
 *  vendidos, a suma dos importes das vendas na data e o desconto practicado
 *  nesas vendas, para os clientes aos que se vendeu máis de 1200 euros nun só día.
 */
SELECT ven.ven_cliente, CAST(ven.ven_data AS DATE) , SUM(dv.dev_cantidade) AS cantidade_artigos,
	SUM(dv.dev_cantidade * (dv.dev_prezo_unitario * (1-dv.dev_desconto/100))) AS importe_vendas, 
	SUM(dv.dev_cantidade * (dv.dev_prezo_unitario * (dv.dev_desconto/100))) AS desconto_aplicado
FROM vendas ven
JOIN detalle_vendas dv ON dv.dev_venda = ven.ven_id
GROUP BY ven.ven_cliente, ven.ven_data
HAVING importe_vendas  > 1200
ORDER BY ven.ven_cliente, ven.ven_data;


/*
 * 4. Mostrar identificador de cliente, apelidos e nome na mesma columna separados
 *  por coma, e data e hora da venda, para os clientes que só teñen unha venda.
 */
SELECT clt.clt_id, CONCAT( clt.clt_apelidos,', ',clt.clt_nome) AS nome_cliente, ven.ven_data
FROM vendas ven
JOIN clientes clt ON ven.ven_cliente  = clt.clt_id 
GROUP BY clt.clt_id
HAVING COUNT(ven.ven_id) = 1
ORDER BY clt.clt_id, nome_cliente ;
