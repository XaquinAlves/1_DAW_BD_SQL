/* 
 * q1. Para todos os clientes con identificador inferior ou igual a 10, seleccionar os datos das vendas que se lle 
 * fixeron. Hai que mostrar para cada venda, o identificador do cliente, apelidos, nome e data de venda. 
 * Se a algún deses clientes non se lle fixo ningunha venda, deberá aparecer na lista co seu identificador, nome,
 *  apelidos, e o texto 'SEN COMPRAS' na columna da data da venda.
*/
SELECT clt.clt_id , clt.clt_apelidos , clt.clt_nome , IFNULL(ven.ven_data,'SEN COMPRAS') AS data_venta
FROM clientes clt
LEFT JOIN vendas ven ON ven.ven_cliente = clt.clt_id 
WHERE clt.clt_id <= 10
ORDER BY clt.clt_id, clt.clt_apelidos;

-- q2. Seleccionar os nomes das provincias nas que non temos ningún cliente.
SELECT provin.pro_nome 
FROM provincias provin
LEFT JOIN clientes clt ON LEFT(clt.clt_cp,2) = provin.pro_id 
WHERE clt.clt_id IS NULL
ORDER BY provin.pro_nome;

/* 
 * q3. Seleccionar o código (emp_id), apelidos e nome de todos os empregados. Engadir unha columna na lista de 
 * selección, co alias Vendas, na que se mostre o literal 'Si'  se o empregado fixo algunha venda, ou o literal 
 * 'Non' no caso de que aínda non fixera ningunha venda.
*/
SELECT DISTINCT emp.emp_id , emp.emp_apelidos , emp.emp_nome , IF(ven.ven_id IS NULL,'No','Si') AS vendas
FROM empregados emp 
LEFT JOIN vendas ven ON ven.ven_empregado = emp.emp_id ;

