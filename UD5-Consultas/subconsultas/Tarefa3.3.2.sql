/*
 * 8. Mostrar nome de departamento e de empregado para os empregados que traballan
 *  nalgún departamento que dependa do centro 'SEDE CENTRAL'.
 *  Os datos mostraranse ordenados por departamento e nome de empregado.
*/
SELECT (SELECT dep.depNome FROM departamento dep WHERE dep.depNumero = emp.empDepartamento) AS nome_departamento,
	emp.empNome 
FROM empregado emp
WHERE emp.empDepartamento IN (SELECT dep2.depNumero 
							 FROM departamento dep2
							 WHERE dep2.depCentro IN (SELECT cen.cenNumero  
							 						  FROM centro cen 
							 						  WHERE cen.cenNome = 'SEDE CENTRAL')
							 						  
							 )  
ORDER BY nome_departamento , emp.empNome;

/* 
 * 10. Mostrar o nome de todos os directores de departamento ordenados polo
 *  número de departamento. Resolver a consulta:
 */
--  • con subconsultas.
SELECT dire.empNome 
FROM empregado dire
WHERE dire.empNumero IN (SELECT dep.depDirector 
						FROM departamento dep)
ORDER BY dire.empDepartamento;

--  • sen subconsultas.
SELECT dire.empNome 
FROM empregado dire
JOIN departamento dep ON dire.empNumero = dep.depDirector  
ORDER BY dep.depNumero;

/*
 *  11. Mostrar os nomes dos directores de departamentos que dependen dun centro
 *  de traballo que ten un nome que empeza pola letra 'S'. Resolver a consulta:
 */
--  • con subconsultas.
SELECT dire.empNome 
FROM empregado dire 
WHERE dire.empNumero IN (SELECT dep.depDirector 
						FROM departamento dep
						WHERE dep.depDepende IN (SELECT dep2.depNumero 
												 FROM departamento dep2
												 WHERE dep2.depCentro IN (SELECT ctr.cenNumero 
												 						  FROM centro ctr 
												 						  WHERE ctr.cenNome LIKE 'S%')
												 )
						)
ORDER BY dire.empNome;		

--  • sen subconsultas.
SELECT dire.empNome 
FROM empregado dire 
JOIN departamento dep ON dep.depDirector = dire.empNumero
JOIN departamento dep2 ON dep2.depNumero = dep.depDepende 
JOIN centro ctr ON dep2.depCentro  = ctr.cenNumero
WHERE ctr.cenNome LIKE 'S%'
ORDER BY dire.empNome;  

/*
 * 12. A empresa decide gratificar aos directores en funcións incrementando o
 *  seu salario base un 5%. Mostrar ordenados alfabeticamente, os nomes destes
 *  empregados, o seu salario, a gratificación que lle corresponde, e o salario
 *  final que resulta de sumarlle a nova gratificación ao salario. Resolver a consulta:
 */
--  • con subconsultas.
SELECT dire.empNome , dire.empSalario , (dire.empSalario * 0.05) AS gratificacion, 
	(dire.empSalario) + (dire.empSalario * 0.05) AS salario_final
FROM empregado dire
WHERE dire.empNumero IN (SELECT dep.depDirector 
						 FROM departamento dep
						 WHERE dep.deptipoDirector = 'F') 
ORDER BY dire.empNome, dire.empSalario;

--  • sen subconsultas.
SELECT dire.empNome , dire.empSalario , (dire.empSalario * 0.05) AS gratificacion, 
	(dire.empSalario) + (dire.empSalario * 0.05) AS salario_final
FROM empregado dire
JOIN departamento dep ON dep.depDirector = dire.empNumero 
ORDER BY dire.empNome, dire.empSalario;

/*
 * 13. Mostrar nome e salario dos empregados co salario base maior cá media
 *  dos soldos dos directores que están en funcións.
 */
SELECT emp.empNome , emp.empSalario 
FROM empregado emp
WHERE emp.empSalario > (SELECT AVG(dire.empSalario)
						FROM empregado dire
						WHERE dire.empNumero IN (SELECT dep.depDirector 
						 						 FROM departamento dep
						 						 WHERE dep.deptipoDirector = 'F')  
						)
ORDER BY emp.empNome , emp.empSalario;

/*
 * 14. Mostrar nome e salario+comisións dos empregados do centro
 *  “RELACIÓN CON CLIENTES ” que gañan máis de 1500 euros entre salario e comisións,
 *  ordenados por departamento, salario+comisión e nome.
 */
SELECT emp.empNome , emp.empSalario + IFNULL(emp.empComision,0) AS salario_comision
FROM empregado emp
WHERE (emp.empSalario + IFNULL(emp.empComision,0)) > 1500 AND 
	emp.empDepartamento IN (SELECT dep.depNumero 
							FROM departamento dep 
							WHERE dep.depCentro = (SELECT cen.cenNumero  
												   FROM centro cen
												   WHERE cen.cenNome = 'RELACIÓN CON CLIENTES')		
							)
ORDER BY emp.empNome , salario_comision;

/*
 * 15. Mostrar os nomes dos empregados que traballan no mesmo departamento que
 *  Lavinia Sanz ou Cesar Pons.
 */
SELECT emp.empNome 
FROM empregado emp
WHERE emp.empDepartamento IN (SELECT refer.empDepartamento
							  FROM empregado refer 
							  WHERE refer.empNome ='SANZ, LAVINIA' OR refer.empNome ='PONS, CESAR' )
ORDER BY emp.empNome;

