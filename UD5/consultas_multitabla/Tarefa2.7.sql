/* 0. Muestra id, dni, apellidos, nombre, dirección, población, cp, nombre_pais, fecha alta y fecha de nacimiento
de los empleados que no viven en las poblaciones León, Málaga ni Asturias. Si se desconoce la población del
empleado, éste no se muestra. Ordena el resultado por apellidos, nombre. */
SELECT e.emp_id , e.emp_dni , e.emp_apelidos , e.emp_nome , e.emp_enderezo , e.emp_poboacion , e.emp_cp , 
p.pai_nome AS nome_pais, e.emp_alta , e.emp_dataNac 
FROM empregados e 
LEFT JOIN paises p ON e.emp_pais = p.pai_id 
WHERE e.emp_poboacion NOT IN ('León','Málaga','Asturias')
ORDER BY e.emp_id, e.emp_dni;

/* 1. Muestra para cada cliente, muestra id, cif, apellidos, nombre, dirección, población, nombre_pais,
pais_isonum que no pertenezca a las poblaciones 'Sevilla', 'Segovia' ni 'Sabadell'. Ordenados por nombre_pais,
apellidos y nombre. Si se desconoce la población, se debe mostrar al cliente. */
SELECT  cli.clt_id , cli.clt_cif , cli.clt_apelidos , cli.clt_nome , cli.clt_enderezo , cli.clt_poboacion ,
p.pai_nome AS nome_pais, p.pai_isonum 
FROM clientes cli
LEFT JOIN paises p ON cli.clt_pais = p.pai_id 
WHERE cli.clt_poboacion NOT IN ('Sevilla','Segovia','Sabadell') OR cli.clt_poboacion IS NULL
ORDER BY p.pai_nome , cli.clt_apelidos , cli.clt_nome;

/* 2. Muestra de los empleados que tienen más de 35 años sus apellidos, nombre, nacionalidad (nombre_pais al que
pertenece), fecha de nacimiento y edad. Ordena el resultado por edad, apellidos, nombre. */
SELECT e.emp_apelidos , e.emp_nome , p.pai_nome AS nacionalidade, e.emp_dataNac,
TIMESTAMPDIFF(YEAR, e.emp_dataNac, now()) AS idade
FROM empregados e 
LEFT JOIN paises p ON p.pai_id = e.emp_pais 
WHERE TIMESTAMPDIFF(YEAR, e.emp_dataNac, now()) > 35
ORDER BY idade, e.emp_apelidos , e.emp_nome ;

/* 3. Vamos a generar un informe para realizar pedidos a nuestro proveedores. Muestra de los artículo con stock
bajo (stock < 20) su nombre, peso, precio_compra, precio_venta, stock, nombre de proveedor y unidades a
pedir unidades_pedir (si precio compra es menor que 100 pediremos las unidades que nos falten para tener 100
de stock, en caso de tener un precio mayor o igual que 100 pediremos las unidades necesarias para tener
un stock de 50). */
SELECT art.art_nome , art.art_peso , art.art_pc , art.art_pv , art.art_stock , pr.prv_nome ,
IF(art.art_pc <100 , 100- art.art_stock , 50 - art.art_stock) AS unidades_pedir 
FROM artigos art
LEFT JOIN provedores pr ON pr.prv_id = art.art_provedor 
WHERE art.art_stock < 20
ORDER BY art.art_nome , art.art_peso;

/* 4. Muestra apellidos, nombre, fecha_nacimiento y edad de todos los empleados gerentes de una tienda.
Muestra también la población de la tienda de la que son gerentes (poboacion_tenda). Ordena el resultado por
edad, apellidos y nombre. */
SELECT emp.emp_apelidos , emp.emp_nome , emp.emp_dataNac , TIMESTAMPDIFF(YEAR, emp.emp_dataNac, now()) AS idade ,
tn.tda_poboacion 
FROM empregados emp
JOIN tendas tn ON tn.tda_xerente = emp.emp_id 
ORDER BY idade , emp.emp_apelidos , emp.emp_nome;

/* 5. Saca un informe de líneas de venta. Muestra nombre del artículo, nombre proveedor de artículo,
* cantidad_vendida, precio unidad, descuento y coste_total de los registros de la tabla detalles_ventas cuyo
* coste_total sea mayor o igual que 100 euros. Deben aparecer todas las tuplas, tengamos o no registrado el
* artículo o el proveedor en la base de datos. */
SELECT art.art_nome , prv.prv_nome , dven.dev_cantidade , art.art_pv , dven.dev_desconto ,
(dven.dev_cantidade * art.art_pv) * (1 - dven.dev_desconto/100) AS coste_total
FROM vendas ven
LEFT JOIN detalle_vendas dven ON ven.ven_id = dven.dev_venda 
LEFT JOIN artigos art ON dven.dev_artigo = art.art_codigo 
LEFT JOIN provedores prv ON prv.prv_id = art.art_provedor 
WHERE ((dven.dev_cantidade * art.art_pv) * (1 - dven.dev_desconto/100)) >= 100
ORDER BY art.art_nome, prv.prv_nome ;

/* 6. Para cada venta muestra: fecha de venta, población de la tienda de venta (venta_tienda), apellidos,
nombre y nacionalidad del empleado que hace la venta asi como apellidos, nombre y pais de la persona que
realiza la compra. Ordena las ventas por fecha de venta, venta_tienda y apellidos, nombre del vendedor. */
SELECT ven.ven_data , tda.tda_poboacion , emp.emp_apelidos , emp.emp_nome , paiE.pai_nome AS nacionalidade ,
 clt.clt_apelidos, clt.clt_nome , paiC.pai_nome  AS pais_cliente
FROM vendas ven
LEFT JOIN tendas tda ON tda.tda_id = ven.ven_tenda
LEFT JOIN empregados emp ON emp.emp_id = ven.ven_empregado 
LEFT JOIN clientes clt ON clt.clt_id = ven.ven_cliente 
LEFT JOIN paises paiE ON paiE.pai_id = emp.emp_pais 
LEFT JOIN paises paiC ON paiC.pai_id = clt.clt_pais 
ORDER BY ven.ven_data , ven.ven_tenda , emp.emp_apelidos , emp.emp_nome;

/*
 * 7. Muestra la fecha de venta, apellidos, nombre y nacionalidad del vendedor y cliente para todas las 
 * ventas que se han realizado en las que la nacionalidad del vendedor y del cliente NO coinciden.
 */
SELECT ven.ven_data ,  emp.emp_apelidos , emp.emp_nome , paiE.pai_nome AS nacionalidade ,
 clt.clt_apelidos, clt.clt_nome , paiC.pai_nome  AS pais_cliente
FROM vendas ven
JOIN empregados emp ON emp.emp_id = ven.ven_empregado 
JOIN clientes clt ON clt.clt_id = ven.ven_cliente 
JOIN paises paiE ON paiE.pai_id = emp.emp_pais 
JOIN paises paiC ON paiC.pai_id = clt.clt_pais 
WHERE paiE.pai_id != paiC.pai_id 
ORDER BY ven.ven_data, emp.emp_apelidos;

/* 
 * 8. Para cada línea de venta (detalle_vendas) cuyo coste total sea mayor o igual que 1.000 euros y
 *  cuya venta se haya registrado en mayo de 2015 mostrar: nombre_tienda, nombre_artículo, unidades_vendidas,
 *  precio_unitario, descuento, nombre_completo del comprador (nombre + ' ' + apellidos), nacionalidad del
 *  comprador, nombre_completo del vendedor (nombre + ' ' + apellidos). Ordena los resultados por
 *  nombre_tienda, nombre_completo_vendedor, nombre_completo_comprador.
 */
SELECT tda.tda_poboacion , art.art_nome , dven.dev_cantidade , art.art_pv AS precio_unitario , dven.dev_desconto ,
CONCAT(clt.clt_nome, ' ', clt.clt_apelidos) AS nome_comprador, pai.pai_nome AS nacionalidade_comprador ,
CONCAT(emp.emp_nome, ' ', emp.emp_apelidos) AS nome_vendedor
FROM detalle_vendas dven
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN tendas tda ON tda.tda_id = ven.ven_tenda 
JOIN clientes clt ON ven.ven_cliente = clt.clt_id
JOIN paises pai ON clt.clt_pais = pai.pai_id 
JOIN empregados emp ON ven.ven_empregado = emp.emp_id 
WHERE ((dven.dev_cantidade * art.art_pv) * (1 - dven.dev_desconto/100)) >= 1000 AND
	YEAR(ven.ven_data) = 2015  AND MONTH(ven.ven_data) = 5
ORDER BY tda.tda_poboacion, nome_vendedor , nome_comprador ;

/*
 * 9. Muestra el nombre de todos los proveedores de los que hemos realizado al menos una venta de algún artículo
 *  suyo. Ordena el resultado por nombre proveedor.
 */
SELECT DISTINCT prv.prv_nome 
FROM detalle_vendas dven 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
JOIN provedores prv ON art.art_provedor = prv.prv_id
ORDER BY prv.prv_nome;

-- 10. Muestra apellidos, nombre y dni de todos los empleados que NO han realizado ninguna venta.
SELECT  emp.emp_apelidos , emp.emp_nome , emp.emp_dni 
FROM empregados emp
LEFT JOIN vendas ven ON ven.ven_empregado = emp.emp_id 
WHERE ven.ven_id IS NULL
ORDER BY emp.emp_apelidos, emp.emp_nome ;

/* 
 * 11. Muestra el nombre_artículo, stock y nombre proveedor de todos los artículos que han sido vendidos al
 *  menos una vez.
 */
SELECT DISTINCT art.art_nome , art.art_stock ,prv.prv_nome 
FROM detalle_vendas dven 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
JOIN provedores prv ON art.art_provedor = prv.prv_id
ORDER BY art.art_nome, art.art_stock;

-- 12. Muestra apellidos, nombre, población de todos los clientes que NO han realizado una compra.
SELECT clt.clt_apelidos , clt.clt_nome , clt.clt_poboacion 
FROM clientes clt
LEFT JOIN vendas ven ON ven.ven_cliente = clt.clt_id 
WHERE ven.ven_id IS NULL 
ORDER BY clt.clt_apelidos , clt.clt_nome;

/* 
 * 13. Muestra el nombre de todos los artículos que se han vendido en una tienda secundaria 
 * (tiendas cuyo nombre contiene los caracteres '- 2').
 */
SELECT DISTINCT art.art_nome 
FROM detalle_vendas dven
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN tendas tda ON ven.ven_tenda = tda.tda_id 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
WHERE tda.tda_poboacion LIKE '%- 2%'
ORDER BY art.art_nome;

/*
 *  14. Muestra el nombre completo de todos los clientes que han realizado al menos una compra en una tienda
 *  en la que el gerente es menor de 40 años.
 */
SELECT DISTINCT CONCAT(clt.clt_nome, ' ', clt.clt_apelidos) AS nome_completo_cliente
FROM vendas ven
JOIN tendas tda ON ven.ven_tenda = tda.tda_id 
JOIN empregados xer ON tda.tda_xerente = xer.emp_id 
JOIN clientes clt ON ven.ven_cliente = clt.clt_id 
WHERE TIMESTAMPDIFF(YEAR, xer.emp_dataNac, now()) < 40
ORDER BY nome_completo_cliente ;

/* 
 * 15. Muestra el nombre de los artículos y el proveedor de todos los artículos que han sido comprados por
 *  un cliente de la provincia de Pontevedra (cp empieza por 36) en mes junio de 2015.
 */
SELECT art.art_nome , prv.prv_nome 
FROM detalle_vendas dven
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN clientes clt ON ven.ven_cliente = clt.clt_id 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
JOIN provedores prv ON art.art_provedor = prv.prv_id 
WHERE clt.clt_cp LIKE '36%' AND YEAR(ven.ven_data) = 2015 AND MONTH(ven.ven_data) = 6 
ORDER BY art.art_nome, prv.prv_nome;

/* 
 * 16. Muestra el nombre de las tiendas que han conseguido vender al menos un portatil entre el día 15/05/2015
 *  y el 15/06/2015 ambos inclusive.
 */
SELECT DISTINCT tda.tda_poboacion 
FROM detalle_vendas dven  
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
JOIN tendas tda ON ven.ven_tenda = tda.tda_id 
WHERE art.art_nome LIKE '%portatil%' AND ven.ven_data >= '2015-05-15' AND ven.ven_data < '2015-06-16' 
ORDER BY tda.tda_poboacion;

/* 
 * 17. Muestra el nombre completo de los clientes que han comprado al menos un artículo que pese más de 3 Kg (3000 gr).
 *  Muestra también el nombre y el peso del artículo y la fecha de dicha compra. Ordena por peso, fecha de compra,
 *  nombre completo cliente.
 */
SELECT CONCAT(clt.clt_nome,' ',clt.clt_apelidos) AS nome_cliente, art.art_nome , art.art_peso , ven.ven_data 
FROM detalle_vendas dven
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN clientes clt ON ven.ven_cliente = clt.clt_id 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
WHERE art.art_peso > 3000
ORDER BY art.art_peso, ven.ven_data, nome_cliente ;

/* 
 * 18. Busca las líneas de venta cuyo margen de beneficio haya sido superior a 50 euros.
 *  Beneficio = coste total - (art_pc * unidades). Muestra artículo, art_pc, detalles_venda.prezo_unitario,
 *  dev_cantidade, dev_desconto, coste total, (art_pc*unidades) AS coste_stock, beneficio. Ordena las tuplas
 *  por beneficio.
*/
SELECT art.art_nome , art.art_pc , dven.dev_prezo_unitario , dven.dev_cantidade , dven.dev_desconto,
(dven.dev_cantidade * dven.dev_prezo_unitario) * (1-dven.dev_desconto/100) AS coste_total, 
art.art_pc * dven.dev_cantidade AS coste_stock,
((dven.dev_cantidade * dven.dev_prezo_unitario) * (1-dven.dev_desconto/100)) - (art.art_pc * dven.dev_cantidade) AS beneficio
FROM detalle_vendas dven
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
WHERE ((dven.dev_cantidade * dven.dev_prezo_unitario) * (1-dven.dev_desconto/100)) - (art.art_pc * dven.dev_cantidade) > 50
ORDER BY beneficio ;

/*
 *  19. Busca las ventas cuyo comprador y empleado sean de la misma población. Muestra: fecha_venta,
 *  nombre_completo_empleado, nombre_completo_comprador, poblacion_empleado y poblacion_comprador.
 */
SELECT ven.ven_data , CONCAT(emp.emp_nome, ' ', emp.emp_apelidos) AS nome_completo_empleado, emp.emp_poboacion ,
	CONCAT(clt.clt_nome, ' ', clt.clt_apelidos) AS nome_completo_comprador, clt.clt_poboacion 
FROM vendas ven
JOIN empregados emp ON ven.ven_empregado = emp.emp_id 
JOIN clientes clt ON ven.ven_cliente = clt.clt_id 
WHERE emp.emp_poboacion = clt.clt_poboacion 
ORDER BY ven.ven_data;

/* 
 * 20. Muestra las dev_venda, fecha y la tienda en la que se realizaron todas las
 * ventas que contenían al menos un producto que tenía como color el cyan. 
 */
SELECT dven.*, ven.ven_data , tda.tda_poboacion 
FROM detalle_vendas dven
JOIN vendas ven ON dven.dev_venda = ven.ven_id 
JOIN artigos art ON dven.dev_artigo = art.art_codigo 
JOIN tendas tda ON ven.ven_tenda = tda.tda_id 
WHERE art.art_color = 'Cyan'
ORDER BY dven.dev_venda, dven.dev_numero;














 