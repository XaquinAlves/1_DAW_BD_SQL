-- q1.1
INSERT INTO centro VALUES (40, 'FRANQUICIA LUGO', 'C/ PROGRESO, 8 - LUGO');

-- q1.2
INSERT INTO empregado VALUES
	();

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

-- q1.9. Borra o empregado co número 380.
DELETE FROM empregado 
WHERE empNumero = 380;

-- q1.10. Borrar da táboa dos empregados aos que teñan cumpridos os 60 anos e 
-- non sexan directores de ningún departamento.
DELETE e FROM empregado e 
WHERE TIMESTAMPDIFF(YEAR, empDataNacemento , CURDATE()) >= 60 AND 
	empNumero NOT IN (SELECT d.depDirector FROM departamento d );

-- q1.11. Escribir unha única sentenza que permita borrar da táboa departamento 
-- o departamento número 121 e da táboa empregado todos os empregados que 
-- traballan nese departamento.
DELETE FROM empregado e straight_join departamento d
WHERE e.empDepartamento = d.depNumero AND d.depNumero = 121


-- q1.12. Executar o seguinte script para poder crear unha táboa temporal co nome 
-- empregado_120:
CREATE TEMPORARY TABLE empregado_120 LIKE empregado;
SELECT * FROM empregado_120;

-- Inserir na táboa empregado_120 os datos de todas as filas da táboa empregado 
-- que teñan o valor 120 na columna empDepartamento: 
INSERT INTO empregado_120 
SELECT * FROM empregado WHERE empDepartamento = 120;

/** Sobre a base de datos tendaBD. **/

-- q1.13. Inserir filas na táboa facturas collendo os datos de todos os clientes 
-- que teñan vendas no mes 5 de 2015 sen facturar (ven_factura toma o valor null).
-- As columnas que non se obteñen da táboa clientes, teñen os seguintes valores:
INSERT INTO facturas (fac_mes, fac_ano, fac_data, fac_clt_cif, fac_clt_apelidos,
	fac_clt_nome, fac_clt_enderezo, fac_clt_cp, fac_clt_poboacion, fac_clt_pais, 
	fac_importe)
SELECT 5, 2015, CURDATE(), clt.clt_cif, clt.clt_apelidos, clt.clt_nome, 
	clt.clt_enderezo, clt.clt_cp, clt.clt_poboacion, clt.clt_pais, 0 
FROM clientes clt
WHERE clt.clt_id IN (
	SELECT v.ven_cliente FROM vendas v 
	WHERE v.ven_factura IS NULL AND MONTH(v.ven_data) = 5 
						AND YEAR(v.ven_data) = 2015
); 


-- q1.14. Inserir na táboa vendas unha fila cos seguintes datos;
-- se existe unha venda co mesmo id, debe ser substituída por esta:
INSERT INTO vendas (ven_id,ven_tenda, ven_empregado, 
	ven_cliente, ven_data, ven_factura) VALUES (151, 8, 25, 12,
	'2015-06-10 12:25:00', NULL) 
ON DUPLICATE KEY UPDATE	ven_tenda = VALUES(ven_tenda);






















