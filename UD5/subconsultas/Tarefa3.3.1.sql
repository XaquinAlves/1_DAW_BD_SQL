/*
 *1. Obter a lista de provedores que subministran como mínimo un artigo de cor negra.
 */
SELECT pro.*
FROM provedores pro
WHERE pro.prv_id IN (SELECT art.art_provedor 
					FROM artigos art
					WHERE art.art_color = 'negro')
ORDER BY pro.prv_id;

/*
 *3. Mostrar identificador e nome dos clientes que fixeron algunha compra despois
 * do día en que o cliente número 6 fixo a súa última compra.  
 */
SELECT clt.clt_id , clt.clt_nome 
FROM clientes clt
WHERE clt.clt_id IN (SELECT v.ven_cliente 
					 FROM vendas v  
					 WHERE v.ven_data > (SELECT clt2.clt_ultima_venda 
					 					 FROM clientes clt2
					 					 WHERE clt.clt_id = 6) 
					 )
ORDER BY clt.clt_id, clt.clt_nome;

/*
 * 4. Mostrar os nomes dos xerentes das tendas nas que se fixo algunha venta. 
 */
SELECT xer.emp_nome 
FROM empregados xer
WHERE xer.emp_id IN (SELECT tda.tda_xerente 
					 FROM tendas tda 
					 WHERE tda.tda_id IN (SELECT ven.ven_tenda 
					 					  FROM vendas ven )
					 )
ORDER BY xer.emp_nome;

/*
 * 5. Importe total das vendas que se fixeron ao cliente LEANDRO FERREIRO BENITEZ.
 */
SELECT dv.dev_cantidade * dv.dev_prezo_unitario * (1-dv.dev_desconto/100) AS importe_total
FROM detalle_vendas dv 
WHERE dv.dev_venda IN (SELECT ven.ven_id 
					   FROM vendas ven
					   WHERE ven.ven_cliente = (SELECT clt.clt_id
					   							FROM clientes clt
					   							WHERE CONCAT(clt.clt_nome,' ',clt.clt_apelidos) = 'LEANDRO FERREIRO BENITEZ' 
					   							)
					   )
ORDER BY importe_total;

/*
 * 6. Seleccionar o id, apelidos e nome dos empregados que aínda non fixeron
 *  ningunha venda. 
 */
SELECT emp.emp_id , emp.emp_apelidos , emp.emp_nome 
FROM empregados emp
WHERE emp.emp_id NOT IN (SELECT ven.ven_empregado 
					 	 FROM vendas ven )
ORDER BY emp.emp_id , emp.emp_apelidos;