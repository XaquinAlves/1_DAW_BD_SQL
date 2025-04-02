-- q1.
-- A xubilación na empresa está establecida aos 67 anos. O empregado xubilado ten dereito a unha liquidación
-- que equivale ao salario dun mes por cada ano de servizo na empresa. Mostrar nome, data de nacemento, 
-- salario mensual base, antigüidade (número de anos dende que entrou a traballar na empresa ata a data de xubilación)
-- e importe da liquidación que lle corresponde aos empregados que se xubilarán no ano actual.
SELECT  e.empNome, e.empDataNacemento, e.empSalario,
TIMESTAMPDIFF(YEAR, e.empDataIngreso, DATE_ADD(e.empDataNacemento,INTERVAL 67 YEAR)) AS antiguedade,
(TIMESTAMPDIFF(YEAR, e.empDataIngreso, DATE_ADD(e.empDataNacemento,INTERVAL 67 YEAR))) * e.empSalario AS importe_liquidacion
FROM empregado e 
WHERE YEAR(NOW()) - YEAR(e.empDataNacemento) = 67; 

-- q2.
-- Mostrar nome, día e mes do aniversario dos empregados dos departamentos 110 e 111.
SELECT e.empNome , DAY(e.empDataNacemento) AS dia_aniversario, MONTH(e.empDataNacemento) AS mes_aniversario 
FROM empregado e
WHERE e.empDepartamento IN (110,111);

-- q3.
-- Mostrar o número de empregados que este ano cumpren 23 anos traballando na empresa e o salario medio de todos eles.
SELECT COUNT(*) AS numero_empregados, AVG(e.empSalario) AS salario_medio 
FROM empregado e 
WHERE YEAR(NOW()) - YEAR(e.empDataIngreso) = 23;   
-- q4.
-- Mostrar o importe anual (14 pagas) correspondente ao soldos dos empregados (soldo máis comisións).
SELECT (SUM(e.empSalario + IFNULL(e.empComision,0))) * 14 AS importe_anual
FROM  empregado e; 

-- q5.
-- Mostrar o número de departamentos que existen e o presuposto anual medio de todos eles.
SELECT COUNT(*) AS numero_departamentos, AVG(d.depPresuposto) AS presuposto_anual_medio
FROM departamento d; 

-- q6.
-- Mostrar o importe total das comisións dos empregados.
SELECT SUM(e.empComision) AS total_comisions
FROM empregado e; 

-- q7.
-- Mostrar nome, data de nacemento e idade dos empregados que teñan actualmente 62 anos ou máis.
-- Ordenar o resultado pola idade de maior a menor.
SELECT e.empNome , e.empDataNacemento , TIMESTAMPDIFF(YEAR,e.empDataNacemento,NOW()) as idade 
FROM empregado e
WHERE TIMESTAMPDIFF(YEAR,e.empDataNacemento,NOW()) >= 62
ORDER BY idade DESC; 

-- q8.
-- Mostrar nome de empregado, data de entrada na empresa con formato  dd/mm/aaaa e número de trienios completos 
-- que levan traballados os empregados que cumpren 66 anos no ano actual. Ordenar de forma descendente por número 
-- de trienios.
SELECT e.empNome, DATE_FORMAT(e.empDataIngreso,'%d/%m/%Y') AS data_ingreso, FLOOR( TIMESTAMPDIFF(YEAR,e.empDataIngreso,CURRENT_DATE()) / 3) AS trienios
FROM empregado e 
WHERE YEAR(CURRENT_DATE()) - YEAR(e.empDataNacemento) = 66
ORDER BY trienios DESC;

-- q9.
-- Mostrar a media de idade á que os empregados entran a traballar na empresa.
SELECT AVG(tabla.idade_ingreso) AS media_idade_ingreso
FROM(
	SELECT TIMESTAMPDIFF(YEAR,e.empDataNacemento,e.empDataIngreso) AS idade_ingreso 
	FROM empregado e 
) AS tabla;

-- q10.
-- Mostrar nome, data de entrada na empresa con formato dd/mm/aaaa e o número de anos completos que 
-- leva traballando na empresa, para os empregados que cumpren anos no mes actual.
SELECT e.empNome, DATE_FORMAT(e.empDataIngreso,'%d/%m/%Y') AS data_ingreso, FLOOR(TIMESTAMPDIFF(YEAR,e.empDataIngreso,NOW())) AS anos_completos
FROM empregado e 
WHERE MONTH(e.empDataNacemento) = MONTH(CURRENT_DATE());

-- q11.
-- Mostrar a diferenza de días traballados entre o empregado máis antigo e o máis recente, 
-- indicando a data de ingreso de ambos traballadores.
SELECT tabla.empregado_antigo, tabla.empregado_recente, DATEDIFF(tabla.empregado_recente,tabla.empregado_antigo) AS diferenza_dias
FROM(
	SELECT MIN(e.empDataIngreso) AS empregado_antigo,MAX(e.empDataIngreso) AS empregado_recente
	FROM empregado e 
) AS tabla

-- q12. 
-- Mostrar ordenados por número de empregado, o número de empregado, nome e 
-- salario mensual total (salario+comisión) dos empregados cun salario mensual total de máis de 1800 euros.
SELECT  e.empNumero , e.empNome , (e.empSalario + IFNULL(e.empComision,0)) AS salario_total
FROM empregado e 
WHERE (e.empSalario + IFNULL(e.empComision,0)) > 1800
ORDER BY e.empNumero; 














