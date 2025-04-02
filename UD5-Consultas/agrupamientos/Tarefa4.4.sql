/*
 * 1. Mostrar a extensión telefónica asignada a máis empregados indicando o número
 * de empregados que a comparten. Se hai máis dunha, deben aparecer todas.
 * BD traballadores
 */ 
SELECT e.empExtension, COUNT(e.empNumero)
FROM empregado e
GROUP BY e.empExtension
HAVING COUNT(e.empNumero ) >= ALL (SELECT COUNT(e2.empNumero) 
  								  	FROM empregado e2 
  									GROUP BY e2.empExtension);

/* 
 * 2. Mostrar identificador de cliente, apelidos e nome na mesma columna separados
 *  por coma, para os clientes que só teñen unha venda. O resultado estará ordenado
 *  polo identificador do cliente. BD tendaBD
 */
SELECT clt.clt_id, CONCAT(clt.clt_apelidos,', ',clt.clt_nome) AS nome_cliente
FROM clientes clt
JOIN vendas ven ON ven.ven_cliente = clt.clt_id
GROUP BY clt.clt_id
HAVING COUNT(ven.ven_id) = 1;

/*
 * 3. Mostrar o número de departamento e o número de empregados dos departamentos
 *  que teñen un presuposto anual superior a 36000 euros.BD traballadores
 */
SELECT dep.depNumero , COUNT(emp.empNumero) AS numero_empregados
FROM departamento dep
JOIN empregado emp ON emp.empDepartamento = dep.depNumero
WHERE dep.depPresuposto > 36000
GROUP BY dep.depNumero;

/*
 *  4. Mostrar número de empregados e suma dos salarios, comisións e fillos,
 *  para os departamentos nos que existe algún empregado cun salario base mensual
 *  maior de 2000 euros. BD traballadores
 */
SELECT dep.depNumero, COUNT(emp.empNumero) AS numero_empregados, SUM(emp.empSalario) AS suma_salarios,
	SUM(IFNULL(emp.empComision, 0)) AS suma_comisions, SUM(emp.empFillos) AS suma_fillos
FROM departamento dep
JOIN empregado emp ON emp.empDepartamento = dep.depNumero
WHERE dep.depNumero IN (SELECT emp2.empDepartamento
						FROM empregado emp2
						WHERE emp2.empSalario > 2000)
GROUP BY dep.depNumero;

/*
 *  5. Mostrar as vendas diarias para cada tenda. A información que se debe 
 *  mostrar é: código e poboación da tenda, data das vendas, suma dos importes das
 *  vendas na tenda nesa data con dous decimais, e acumulado dos importes das vendas
 *  feitas pola tenda ata esa data, con dous decimais. BD tendaBD  
 */
SELECT tda.tda_id, tda.tda_poboacion, ven.ven_data,
	SUM(ROUND((dv.dev_cantidade * dv.dev_prezo_unitario * (1-dv.dev_desconto/100)),2)) AS suma_importes,
	(SELECT SUM(ROUND((dv2.dev_cantidade * dv2.dev_prezo_unitario * (1-dv2.dev_desconto/100)),2))
 		FROM tendas tda2
		JOIN vendas ven2 ON ven2.ven_tenda = tda2.tda_id
 		JOIN detalle_vendas dv2 ON dv2.dev_venda = ven2.ven_id
 		WHERE tda2.tda_id = tda.tda_id AND ven2.ven_data <= ven.ven_data
	) AS acumulado
FROM tendas tda
JOIN vendas ven ON ven.ven_tenda = tda.tda_id
JOIN detalle_vendas dv ON dv.dev_venda = ven.ven_id
GROUP BY tda.tda_id, ven.ven_data;




/* 
 *  6. Seleccionar o número de departamento, a media dos salarios do departamento,
 *  e o salario medio de todos os empregados da empresa, para os departamentos que
 *  teñen un salario medio maior que o salario medio de todos os empregados da empresa.
 *  BD traballadores
 */
SELECT dep.depNumero, AVG(emp.empSalario) AS media_salario_departamento,
	(SELECT AVG(emp2.empSalario)
	FROM empregado emp2 ) AS media_salario
FROM departamento dep
JOIN empregado emp ON emp.empDepartamento = dep.depNumero
GROUP BY dep.depNumero
HAVING AVG(emp.empSalario) > (SELECT AVG(emp2.empSalario)
								FROM empregado emp2);







