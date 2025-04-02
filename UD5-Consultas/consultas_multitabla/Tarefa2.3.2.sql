-- q2. Mostrar el número, nombre y salario de todos los empleados que tienen un salario mayor que el salario del
-- empleado número 180. Añadir en la lista de selección una columna para mostrar el salario del empleado número 180.
SELECT  emp.empNumero , emp.empNome , emp.empSalario , refer.empSalario AS salario_180
FROM empregado refer
JOIN empregado emp ON emp.empSalario > refer.empSalario 
WHERE refer.empNumero = 180
ORDER BY emp.empNumero;