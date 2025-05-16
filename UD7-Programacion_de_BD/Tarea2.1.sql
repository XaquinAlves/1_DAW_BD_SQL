-- q1. Crear y probar un disparador en la base de datos practicas1 que
-- valide el contenido de la columna dni, antes de insertar una fila en
-- la tabla empleado. Si el dni es incorrecto porque la letra no es la
-- que corresponde a los dígitos del dni, hay que abortar la inserción y
-- mostrar el mensaje 'DNI no válido'.

DELIMITER $$

CREATE FUNCTION letraDni(num_dni INT UNSIGNED) 
	RETURNS CHAR(1)
	DETERMINISTIC
BEGIN
	RETURN SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', num_dni % 23 + 1, 1);
END
$$

CREATE TRIGGER empregado_BI
BEFORE INSERT ON empregado
FOR EACH ROW
BEGIN
	DECLARE num_dni INT UNSIGNED;
	DECLARE letra_dni CHAR(1);
	IF LENGTH(NEW.dni) = 0 THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'DNI vacio';
	END IF;
	SET num_dni = CAST( LEFT(NEW.dni, LENGTH(NEW.dni) - 1) AS INT);	
	SET letra_dni = RIGHT(NEW.dni, 1);
	IF letraDni(num_dni) != letra_dni THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'A letra do dni é incorrecta';
	END IF;	
END$$

DELIMITER ;

-- q2. Consultar los disparadores asociados a la base de datos 
-- practicas1, y mostrar información del disparador 
-- practicas1.empregadoBI  creado en la tarea1.
SHOW TRIGGERS FROM bd_practicas1;
SHOW CREATE TRIGGER empregado_BI;

-- q3. Crear y probar el funcionamiento de los disparadores necesarios 
-- en la base de datos tendabd para poder mantener actualizado el valor 
-- de las columnas clt_ventas y clt_ultima_venta en la tabla clientes. 
-- La columna clt_ventas guardia información del número de ventas que 
-- se le hicieron al cliente, y la columna clt_ultima_venta guardia 
-- información de la fecha en la que se le hizo la última venta.

CREATE TRIGGER vendas_AI AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
	UPDATE clientes AS c
	SET c.clt_vendas = c.clt_vendas + 1,
	c.clt_ultima_venda = NEW.ven_data
	WHERE clt_id = NEW.ven_cliente;		
END
$$

CREATE TRIGGER vendas_AD AFTER DELETE ON vendas
FOR EACH ROW
BEGIN
	UPDATE clientes AS c
	SET
	c.clt_vendas = c.clt_vendas - 1,
	c.clt_ultima_venda = NULL
	WHERE clt_id = OLD.ven_cliente;	
END
$$

CREATE TRIGGER vendas_AU AFTER UPDATE ON vendas
FOR EACH ROW
BEGIN
	UPDATE clientes AS cli_old
	SET cli_old.clt_vendas = cli_old.clt_vendas - 1,
	cli_old.clt_ultima_venda = NULL
	WHERE cli_old.clt_id = OLD.ven_cliente;

	UPDATE clientes AS cli_new
	SET cli_new.clt_vendas = cli_new.clt_vendas + 1,
	cli_new.clt_ultima_venda = NEW.ven_data
	WHERE clt_id = NEW.ven_cliente;		
END
$$

INSERT INTO vendas (ven_tenda, ven_empregado, ven_cliente, ven_data) VALUES (1,1,1,CURRENT_DATE());
UPDATE vendas SET ven_cliente = 2 WHERE ven_id = 171;

-- SOLUCIÓN ULTRA PRO MAX 420
CREATE PROCEDURE refresh_clientes_vendas(IN iid_cliente SMALLINT UNSIGNED)
BEGIN
	UPDATE clientes 
	SET 
	clt_vendas = (SELECT COUNT(*) FROM vendas WHERE ven_cliente = iid_cliente),
	clt_ultima_venda = (SELECT MAX(ven_data) FROM vendas WHERE ven_cliente = iid_cliente)
	WHERE clt_id = iid_cliente;		
END
$$

CREATE TRIGGER vendas_AI AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
	CALL refresh_clientes_vendas(NEW.ven_cliente);
END
$$

CREATE TRIGGER vendas_AD AFTER DELETE ON vendas
FOR EACH ROW
BEGIN
	CALL refresh_clientes_vendas(OLD.ven_cliente);
END
$$

CREATE TRIGGER vendas_AU AFTER UPDATE ON vendas
FOR EACH ROW
BEGIN
	IF NEW.ven_cliente != OLD.ven_cliente THEN
		CALL refresh_clientes_vendas(OLD.ven_cliente);
		CALL refresh_clientes_vendas(NEW.ven_cliente);
	ELSEIF OLD.ven_data != NEW.ven_data THEn
		CALL refresh_clientes_vendas(NEW.ven_cliente);
	END IF;
END
$$


-- q4. Crear y probar los disparadores necesarios para llevar 
-- el registro de todas las operaciones que modifiquen (insert, 
-- update y delete) los datos almacenados en las tablas que hay en su 
-- esquema (centro, departamento, empleado). Para eso se debe crear 
-- una tabla en la base de datos trabajadores para el registro de todas 
-- esas operaciones. El código para crear la tabla de registro es:
CREATE TABLE IF NOT EXISTS bd_traballadores.rexistroOperacions
(
	idOperacion integer UNSIGNED NOT NULL AUTO_INCREMENT, 
	usuario char(100),
	# usuario que fai oa modificación
	dataHora datetime,
	# data e hora na que se fai a modificación
	taboa char(50),
	# táboa na que se fai a modificación
	operacion char(6),
	# operación de modificación: INSERT, UPDATE, DELETE
	PRIMARY KEY (idOperacion)
)ENGINE = MYISAM;

CREATE TRIGGER centro_AI AFTER INSERT ON centro
FOR EACH ROW
BEGIN
	INSERT INTO rexistroOperaci
END





