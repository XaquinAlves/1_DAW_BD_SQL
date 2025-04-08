-- q1.1
INSERT INTO centro VALUES (40, 'FRANQUICIA LUGO', 'C/ PROGRESO, 8 - LUGO');

-- q1.2


-- q1.3  Acórdase aumentar o salario a todos os empregados un 5% e a comisión 
-- un 6,5% como consecuencia da revisión do convenio. Facer as modificacións 
-- correspondentes na base de datos.

UPDATE empregado 
SET empSalario = empSalario * 1.05, empComision = empComision * 1.065;

-- q1.4. Cambiarlle a data de ingreso na empresa do empregado número 752,
-- asignándolle a data que corresponde ao día 1 do mes seguinte ao mes actual.
UPDATE empregado
SET empDataIngreso = ADDDATE(LAST_DAY(CURRENT_DATE()),1)
WHERE empNumero = 752;

-- q1.5. Aumentar un 2% o salario a todos os empregados do departamento 120.
UPDATE empregado
SET empSalario = empSalario * 1.02
WHERE empDepartamento = 120;

-- q1.6. Aumentarlle 50 euros á comisión de todos os empregados que traballen
-- nun departamento que dependa do centro de traballo que ten por nome 'SEDE 
-- CENTRAL'.
UPDATE empregado AS em, departamento AS de, centro AS ce
SET em.empComision = em.empComision + 50
WHERE em.empDepartamento = de.depNumero 
	AND de.depCentro = ce.cenNumero AND ce.cenNome = 'SEDE CENTRAL';

-- q1.7. Reducir nun 10% o presuposto anual do departamento que teña o presuposto
-- máis alto na actualidade.
UPDATE departamento 
SET depPresuposto = depPresuposto * 0.9
ORDER BY depPresuposto DESC
LIMIT 1;

UPDATE departamento d 
SET d.depPresuposto = d.depPresuposto * 0.9
WHERE d.depPresuposto = (SELECT MAX(d2.depPresuposto) FROM departamento d2);

-- q1.8. Escribir un script para facer todos os seguintes cambios nos 
-- presupostos dos departamentos pero sen modificar o presuposto total:
-- Traspasar 20000 do presuposto do departamento de 'PERSOAL' ao departamento de
-- PROCESO DE DATOS.
-- Reducir en 10000 o presuposto do departamento de 'SECTOR INDUSTRIAL', dos 
-- que 4000 se traspasan ao departamento de 'ORGANIZACION' e 6000 ao departamento
-- de 'DIRECCION COMERCIAL'.
UPDATE departamento dp, departamento dpd
SET dp.depPresuposto = dp.depPresuposto - 20000, 
	dpd.depPresuposto = dpd.depPresuposto + 20000
WHERE dp.depNome = 'PERSOAL' AND dpd.depNome = 'PROCESO DE DATOS';

UPDATE departamento dsi, departamento do, departamento ddc 
SET
	dsi.depPresuposto = dsi.depPresuposto - 10000,
	do.depPresuposto = do.depPresuposto + 4000,
	ddc.depPresuposto = ddc.depPresuposto + 6000
WHERE dsi.depNome = 'SECTOR INDUSTRIAL' AND do.depNome = 'ORGANIZACION' AND
	ddc.depNome = 'DIRECCION COMERCIAL';
