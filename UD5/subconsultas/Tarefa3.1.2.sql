/*
 * 7. Mostrar nomes e salarios dos empregados que teñan salario maior có salario
 *  de tódolos empregados do departamento 122. O resultado móstrase ordenado por nome
 *  de empregado.
*/
SELECT emp.empNome , emp.empSalario 
FROM empregado emp 
WHERE emp.empSalario > ALL (SELECT emp2.empSalario
							FROM empregado emp2
							WHERE emp2.empDepartamento = 122)
ORDER BY emp.empNome, emp.empSalario;

/*
 * 8. Mostrar os nomes e salarios dos empregados con salarios maiores ou iguais a o 
 * de Claudia Fierro, ordenados alfabeticamente. Resolver esta consulta:
*/
-- con subconsulta.
SELECT emp.empNome , emp.empSalario 
FROM empregado emp
WHERE emp.empSalario >= (SELECT emp2.empSalario FROM empregado emp2 WHERE emp2.empNome = 'FIERRO, CLAUDIA')
ORDER BY emp.empNome;

-- sen subconsulta utilizando JOIN.
SELECT emp.empNome , emp.empSalario 
FROM empregado ref
JOIN empregado emp ON emp.empSalario >= ref.empSalario 
WHERE ref.empNome = 'FIERRO, CLAUDIA'
ORDER BY emp.empNome;
/* 
 * 9. Mostrar nome e presuposto dos departamentos que teñen o presuposto máis alto e o
 *  máis baixo.
 */
SELECT dep.depNome , dep.depPresuposto
FROM departamento dep
WHERE dep.depPresuposto = (SELECT MAX(dep2.depPresuposto) FROM departamento dep2) OR
	dep.depPresuposto = (SELECT MIN(dep3.depPresuposto) FROM departamento dep3)
ORDER BY dep.depNome , dep.depPresuposto;

/* 
 * 10. Mostrar número, nome, data de ingreso na empresa e nome do departamento no
 *  que traballa o empregado ou empregados que levan máis tempo na empresa.
*/
SELECT emp.empNumero , emp.empNome , emp.empDataIngreso , 
			(SELECT dep.depNome 
			 FROM departamento dep
			 WHERE emp.empDepartamento = dep.depNumero ) AS nome_departamento
FROM empregado emp
WHERE emp.empDataIngreso = (SELECT MIN(emp2.empDataIngreso)
							FROM empregado emp2)
ORDER BY emp.empNumero , emp.empNome;

/*
 * 11. Mostrar nome e salario dos empregados que cumpran algunha das seguintes condicións: 
 * 	• Ingresaron na empresa despois do 1-1-88.
 * 	• Ingresaron na empresa antes do 1-1-88 pero teñen un salario inferior ao 
 *  salario medio de todos os empregados da empresa.
 */
SELECT emp.empNome , emp.empSalario 
FROM empregado emp
WHERE emp.empDataIngreso > '1988-01-01' OR (emp.empSalario < (SELECT AVG(emp2.empSalario)
															  FROM empregado emp2
															 )
										   )
ORDER BY emp.empNome , emp.empSalario;









