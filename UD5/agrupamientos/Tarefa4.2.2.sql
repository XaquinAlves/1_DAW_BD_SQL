/*5. 
 * Mostrar número e nome dos departamentos que teñan 5 empregados.
 */
SELECT dep.depNumero, dep.depNome
FROM departamento dep
JOIN empregado emp ON emp.empDepartamento = dep.depNumero
GROUP BY dep.depNumero 
HAVING COUNT(emp.empNumero) = 5
ORDER BY dep.depNumero, dep.depNome;

/*
 *  6. Para as extensións telefónicas que son utilizadas
 *  por máis dun empregado, mostrar o número de
 *  empregados que a comparten.
 */
SELECT emp.empExtension, COUNT(emp.empNumero) AS numero_empregados
FROM empregado emp
GROUP BY emp.empExtension
HAVING numero_empregados > 1
ORDER BY emp.empExtension;