-- q1
-- Unha nova normativa non permite que as comisións superen o 10% do salario. Mostrar información ordenada por 
-- número de departamento, dos departamentos nos que exista algún empregado que incumpra esta normativa,
-- nos seguintes casos.
SELECT DISTINCT d.*
FROM empregado e 
INNER JOIN departamento d ON e.empDepartamento = d.depNumero 
WHERE e.empComision > e.empSalario * 0.1
ORDER BY d.depNumero ;

-- q2
-- A campaña de axuda familiar posta en marcha pola empresa, establece que os empregados que teñan máis de 3 fillos, 
-- cobrarán unha paga extra de 30 euros por fillo a partir do terceiro e incluíndo este. 
-- Mostrar nome, salario, comisión, número de fillos, importe da paga extra e salario mensual final dos empregados, 
-- ordenados alfabeticamente polo nome, aplicando a axuda familiar.
SELECT e.empNome , e.empSalario , e.empComision , e.empFillos , (e.empFillos - 2)*30 AS paga_extra, ((e.empFillos - 2)*30) + e.empSalario AS salario_final 
FROM empregado e 
WHERE e.empFillos >= 3
ORDER BY e.empNome; 
-- q3
-- Mostrar os nomes dos empregados con apelido 'MORA' ou que empece por 'MORA' ordenados alfabeticamente.
SELECT e.empNome 
FROM empregado e
WHERE e.empNome LIKE 'MORA%'
ORDER BY e.empNome ;
-- q4
-- A empresa vai organizar un espectáculo para os fillos dos empregados que durará dous días. 
-- O primeiro día invitarase aos empregados con apelido que empece polas letras dende a 'A' ata a 'L', ambas inclusive.
-- O segundo día invitarase ao resto dos empregados. Cada empregado recibirá unha invitación por fillo e dúas máis. 
-- Cada fillo recibirá un regalo durante o espectáculo. Mostrar unha lista ordenada alfabeticamente polo nome do 
-- empregado na que aparezan os nomes dos empregados que se invitarán no primeiro día, o número de invitación que 
-- lle corresponden e o número de regalos que hai que preparar para el.
SELECT e.empNome, (e.empFillos + 2) AS invitacions, (e.empFillos) AS regalos
FROM empregado e 
WHERE e.empNome REGEXP '^[a-l]' AND e.empFillos > 0
ORDER BY e.empNome; 

-- q5
-- Mostrar os nomes e salarios dos empregados que cumpran algunha das seguintes condicións:
--      Non teñen fillos e gañan máis de 1200 euros.
--      Teñen fillos e gañan menos de 1800 euros.
SELECT e.empNome , e.empSalario 
FROM empregado e 
WHERE (e.empFillos = 0 AND e.empSalario > 1200) OR (e.empFillos > 0 AND e.empSalario < 1800);

-- q6
-- Mostrar nome e salario base dos empregados que non teñen fillos ordenados de maior a menor polo salario base.
SELECT e.empNome , e.empSalario 
FROM empregado e 
WHERE e.empFillos = 0
ORDER BY e.empSalario DESC;

-- q7
-- Mostrar por orden alfabético, os nomes e salarios base dos empregados que traballen no departamento 111 e 
-- teñan unha comisión que supere o 15% do seu salario base.
SELECT e.empNome , e.empSalario 
FROM empregado e 
WHERE e.empDepartamento = 111 and e.empComision > (e.empSalario * 0.15)
ORDER BY e.empNome ;

-- q8
-- A empresa decide aumentar a comisión nun 15% aos empregados que teñan máis de 2 fillos. Mostrar ordenados 
-- alfabeticamente polo nome de empregado: nome do empregado, número de fillos, importe da comisión antes do aumento 
-- e importe da comisión despois do aumento. 
SELECT e.empNome, e.empFillos, e.empComision AS comison_preaumento, (e.empComision * 1.15) AS comision_postaumento  
FROM empregado e 
WHERE e.empFillos > 2
ORDER BY e.empNome; 
