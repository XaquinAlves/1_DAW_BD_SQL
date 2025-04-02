-- q10.
-- Seleccionar o número e nome de departamento, xunto co nome do director, para os departamentos independentes,
-- é dicir, que non dependen de ningún outro departamento.
SELECT dep.depNumero , dep.depNome , dir.empNome 
FROM departamento dep
JOIN empregado dir ON (dep.depDirector = dir.empNumero)
WHERE dep.depDepende IS NULL
ORDER BY dep.depNumero, dep.depNome;

-- q11.
-- Mostrar nome (só nome, sen apelidos) e enderezo do centro ao que pertence o departamento no que traballa,
-- dos empregados cun nome (sen ter en conta os apelidos) que empece por 'A'.
SELECT emp.empNome , cen.cenEnderezo 
FROM empregado emp
JOIN  departamento dep ON (emp.empDepartamento = dep.depNumero )
JOIN centro cen ON (dep.depCentro = cen.cenNumero )
WHERE emp.empNome LIKE '%, A%'
ORDER BY emp.empNome, cen.cenEnderezo;


-- q12.
-- Seleccionar para todos os empregados que non son directores, o nome de departamento no que traballa, o seu
-- nome e salario, o nome e salario do director do seu departamento, e a diferenza do seu salario e o salario
-- do director do departamento. Ordenar o resultado polo nome do departamento.
-- Solicítase esta información para facer un estudio da diferenza de salarios entre os directores dos departamento 
-- e os traballadores que traballan no departamento.
SELECT dep.depNome , emp.empNome , emp.empSalario , dir.empNome AS nome_director, dir.empSalario AS salario_director, (dir.empSalario - emp.empSalario) AS diferenza_salario 
FROM empregado emp
JOIN departamento dep ON (emp.empDepartamento = dep.depNumero )
JOIN empregado dir ON (dep.depDirector = dir.empNumero )
WHERE dep.depDirector != emp.empNumero
ORDER BY dep.depNome;





