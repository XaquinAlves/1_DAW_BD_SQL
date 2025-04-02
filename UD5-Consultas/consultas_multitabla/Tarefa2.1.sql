-- q1.
-- Seleccionar os artigos de cor negra e mostrar o seu número, nome e peso, así como o nome do provedor.
SELECT  ar.art_codigo , ar.art_nome , ar.art_peso , prv.prv_nome 
FROM artigos AS ar 
JOIN provedores AS prv ON (ar.art_provedor = prv.prv_id )
WHERE ar.art_color = 'Negro'
ORDER BY ar.art_codigo, ar.art_nome;

-- q2.
-- Seleccionar para todos os clientes os apelidos, nome e o nome da provincia na que residen. Os dous primeiros
-- díxitos do código postal (clt_cp) corresponden ao código da provincia na que reside o cliente.
-- Ordenar o resultado polo nome da provincia, e dentro da provincia, polos apelidos e nome, alfabeticamente.
SELECT cli.clt_apelidos , cli.clt_nome , pro.pro_nome 
FROM clientes cli
JOIN provincias pro ON LEFT(cli.clt_cp,2) = pro.pro_id
ORDER BY pro.pro_nome, cli.clt_apelidos, cli.clt_nome;

-- q3.
-- Mostrar para cada venda: nome e apelidos do cliente, día, mes, e ano da venda (cada un nunha columna).
SELECT cli.clt_nome , cli.clt_apelidos , DAY(ven.ven_data) AS dia_venda, MONTH(ven.ven_data) AS mes_venda, YEAR(ven.ven_data) AS ano_venda 
FROM vendas ven
JOIN clientes cli ON ven.ven_cliente = cli.clt_id 
ORDER BY cli.clt_nome, cli.clt_apelidos;

-- q4.
-- Mostrar unha lista que conteña: número de vendas, número de artigos vendidos, suma de unidades vendidas e
-- a media dos prezos unitarios dos artigos vendidos.
SELECT COUNT(DISTINCT ven.ven_id) AS num_vendas, COUNT(*) AS artigos_vendidos,
	SUM(dvn.dev_cantidade) AS unidades_vendidas, AVG(dvn.dev_prezo_unitario ) as media_prezos
FROM vendas ven
JOIN detalle_vendas dvn ON dvn.dev_venda = ven.ven_id;  

-- q5. Seleccionar para cada artigo o seu número, nome, peso e o nome que corresponde ao peso (peso_nome),
-- tendo en conta a información contida na táboa pesos, que da un nome aos pesos en función do intervalo ao que pertence.
-- Ordenar o resultado polo peso do artigo, de maior a menor.
SELECT art.art_codigo , art.art_nome , art.art_peso , pes.peso_nome 
FROM artigos art
JOIN pesos pes ON art.art_peso BETWEEN pes.peso_min AND pes.peso_max
ORDER BY art.art_peso DESC;

-- q6. Mostrar para cada venta: nome e apelidos do cliente, a data da venta con formato dd/mm/aa e os días
-- transcorridos dende que se fixo a venta. Ordenar o resultado polo número de días transcorridos dende a venta.
SELECT cli.clt_nome , cli.clt_apelidos , DATE_FORMAT(ven.ven_data,'%d/%m/%y') AS data_venda, TIMESTAMPDIFF(DAY, ven.ven_data, NOW()) AS dias_transcorridos
FROM vendas ven
JOIN clientes cli ON ven.ven_cliente = cli.clt_id
ORDER BY dias_transcorridos ;

-- q7.
-- Seleccionar os nomes das provincias nas que temos clientes.
SELECT DISTINCT pro.pro_nome 
FROM clientes cli
JOIN provincias pro ON LEFT(cli.clt_cp,2) = pro.pro_id 
ORDER BY pro.pro_nome;

-- q8.
/*  Seleccionar para cada venda:
	Datos da venda: identificador e data da venda.
 	Datos do cliente: nome do cliente (nome e apelidos separados por coma).
 	Datos do empregado: nome do empregado (nome e apelidos separados por coma).
	Mostrar os datos ordenados polos apelidos e nome do cliente. */
SELECT ven.ven_id , ven.ven_data ,CONCAT(cli.clt_nome,', ', cli.clt_apelidos) AS cliente_nome, CONCAT(emp.emp_nome,', ',emp.emp_apelidos) AS empregado_nome 
FROM vendas ven
JOIN clientes cli ON (ven.ven_cliente = cli.clt_id )
JOIN empregados emp ON (ven.ven_empregado  = emp.emp_id )
ORDER BY cli.clt_apelidos, cli.clt_nome;

-- q9. Seleccionar información sobre os artigos vendidos. Para cada liña de detalle interesa:
-- Datos do cliente: apelidos e nome separados por coma, nunha única columna.
-- Datos do artigo: nome, cantidade,  prezo unitario, desconto e o importe final para o cliente
-- (resultado de multiplicar a cantidade polo prezo unitario e aplicar o desconto que corresponde).
-- Mostrar os resultados ordenados polo nome do artigo.
SELECT CONCAT(clt.clt_nome,', ',clt.clt_apelidos) AS nome_cliente, art.art_nome , dv.dev_cantidade , dv.dev_prezo_unitario,
	dv.dev_desconto, ROUND((dv.dev_cantidade * dv.dev_prezo_unitario) * (1 - (dv.dev_desconto / 100)),2) AS coste_total 
FROM detalle_vendas dv
JOIN vendas ven ON (dv.dev_venda = ven.ven_id )
JOIN clientes clt ON (ven.ven_cliente = clt.clt_id )
JOIN artigos art ON dv.dev_artigo = art.art_codigo
ORDER BY art.art_nome;




