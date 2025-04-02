/* 
 * 6. Mostrar o número de empregados que utiliza cada extensión telefónica.
 */
SELECT emp.empExtension, COUNT(emp.empNumero) AS numero_empregados
FROM empregado emp
GROUP BY emp.empExtension;

/* 
 * 7. Mostrar o número de empregados que teñen 0, 1, 2, 3, ... fillos.
 */
SELECT  emp.empFillos, COUNT(emp.empNumero) AS numero_empregados
FROM empregado emp
GROUP BY emp.empFillos;

/* 
 * 8. Mostrar, para cada departamento, o número de empregados que teñen 0, 1, 2, ... fillos.
 */
SELECT emp.empDepartamento, emp.empFillos, COUNT(emp.empNumero) AS numero_empregados
FROM empregado emp
GROUP BY emp.empDepartamento, emp.empFillos;

/*
 * 9. Mostrar o número de departamentos que dependen de cada centro.
 */
SELECT dep.depCentro AS numero_centro, COUNT(dep.depNumero) AS numero_departamentos
FROM departamento dep
GROUP BY dep.depCentro;

/*
 * 10. Seleccionar, para cada departamento, o maior salario, o menor salario e a
 *  diferenza que hai entre o salario máis alto e o salario máis baixo.
 */
SELECT emp.empDepartamento, MAX(emp.empSalario) AS maior_salario, MIN(emp.empSalario) AS menor_salario,
	MAX(emp.empSalario) - MIN(emp.empSalario) AS diferenza_salarios
FROM empregado emp
GROUP BY emp.empDepartamento;

/*
 * 11. Mostrar, para cada departamento, a cantidade que queda do presuposto despois
 *  de restar o importe dos salarios e comisións a pagar aos empregados.
 */
SELECT emp.empDepartamento , ((dep.depPresuposto - SUM(emp.empSalario)) - SUM(IFNULL(emp.empComision,0))) AS presuposto_restante
FROM empregado emp
JOIN  departamento dep ON dep.depNumero = emp.empDepartamento
GROUP BY emp.empDepartamento;







 