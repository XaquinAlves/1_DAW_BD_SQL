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

-- q4. Crear y probar los disparadores necesarios para llevar el registro de todas las operaciones que modifiquen (insert, update y delete) los datos almacenados en las tablas que hay en su esquema (centro, departamento, empleado). Para eso se debe crear una tabla en la base de datos trabajadores para el registro de todas esas operaciones. El código para crear la tabla de registro es: