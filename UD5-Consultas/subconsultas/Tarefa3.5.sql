/*
 * 3. Mostrar o nome dos empregados que non son directores, e a diferenza
 *  do salario base respecto ao do empregado que menos cobra.
 *  Ordenar o resultado de forma descendente pola diferenza e ascendente polo nome. 
 */
SELECT emp.empNome, emp.empSalario - (SELECT MIN(emp2.empSalario) FROM empregado emp2) AS diferenza_salario
FROM empregado emp
WHERE emp.empNumero NOT IN (SELECT d.depDirector FROM departamento d)
ORDER BY diferenza_salario DESC, emp.empNome;