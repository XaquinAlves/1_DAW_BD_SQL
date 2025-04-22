-- q1. Ejecutar la siguiente sentencia, analizar los errores que provocan,
-- e indicar las medidas que se deberían de adoptar para mantener la integridad
-- y consistencia de los datos.
INSERT INTO clientes ( clt_cif, clt_apelidos, clt_nome, clt_enderezo,
	clt_cp, clt_poboacion, clt_pais, clt_alta)
VALUES ('33956665D', 'Varela Montero', 'Luisa', 'Rua Vella, 5-2º', 
	'15006', 'Coruña', 73, curdate());
-- PK autoincrement -> no indicar campo clt_id

-- q2. Ejecutar la siguiente sentencia, analizar los errores que provocan, 
-- e indicar las medidas que se deberían de adoptar para mantener la
-- integridad y consistencia de los datos.
INSERT INTO clientes ( clt_cif, clt_apelidos, clt_nome, clt_enderezo, clt_cp, 
	clt_poboacion, clt_pais, clt_alta)
VALUES ('16137107P', 'Nuñez Castro', 'Maria', 'Rua Nova, 22 - 5º', '27001', 
	'Lugo', 73, curdate())
ON DUPLICATE KEY UPDATE clt_apelidos = VALUES(clt_apelidos), 
	clt_nome = VALUES(clt_nome), clt_enderezo = VALUES(clt_enderezo), 
	clt_cp =  VALUES(clt_cp), clt_poboacion = VALUES(clt_poboacion),
	clt_pais = VALUES(clt_pais), clt_alta = VALUES(clt_alta);
-- clt_cif UNIQUE repetido -> ON DUPLICATE KEY UPDATE

-- q3. Ejecutar la siguiente sentencia, analizar los errores que provocan, 
-- e indicar las medidas que se deberían de adoptar para mantener la 
-- integridad y consistencia de los datos.
INSERT INTO vendas (ven_tenda, ven_empregado, ven_cliente, ven_data, 
	ven_factura)
SELECT 24, t.tda_xerente, 55, now(), NULL
FROM tendas t WHERE t.tda_id = 24;
-- ven_empregado NOT NULL -> Indicar o empregado que realizou a venta, sacado
-- da tenda

-- q4. Ejecutar la siguiente sentencia, analizar los errores que provocan,
-- e indicar las medidas que se deberían de adoptar para mantener la 
-- integridad y consistencia de los datos.
INSERT INTO vendas (ven_tenda, ven_empregado, ven_cliente, ven_data, 
	ven_factura)
VALUES (24, 10, 155, now(), NULL);
-- o cliente 155 non esta rexistrado na BD 

-- q5. Ejecutar la siguiente sentencia, analizar los errores que provocan, 
-- e indicar las medidas que se deberían de adoptar para mantener la 
-- integridad y consistencia de los datos.
INSERT INTO vendas (ven_tenda, ven_empregado, ven_cliente)
VALUES (24, 10, 55);

-- 



