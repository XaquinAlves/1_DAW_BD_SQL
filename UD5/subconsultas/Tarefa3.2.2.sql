/*
 * 2. Seleccionar o nome e número de departamento dos empregados que pertenzan
 *  a un departamento cun presuposto comprendido entre os presupostos dos
 *  departamentos 122 e 121 (incluídos). Os datos deben mostrarse ordenados
 *  de menor a maior polo número do departamento.
 */
 SELECT emp.empNome , emp.empDepartamento 
 FROM empregado emp
 WHERE emp.empDepartamento IN (SELECT dep.depNumero 
 							  FROM departamento dep
 							  WHERE dep.depPresuposto BETWEEN (SELECT dep2.depPresuposto
 								  								FROM departamento dep2
 								  								WHERE dep2.depNumero = 122
 								 					 		  ) 
 								 					  AND (SELECT dep3.depPresuposto 
 								 						   FROM departamento dep3
 								 						WHERE dep3.depNumero = 121
 								 	   					  ) 
 							 )
 ORDER BY emp.empDepartamento;

