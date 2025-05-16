DROP FUNCTION IF EXISTS nome_nota;

DELIMITER $$

CREATE FUNCTION nome_nota(nota TINYINT UNSIGNED)
  RETURNS VARCHAR(20)
  DETERMINISTIC
BEGIN  
  	IF nota < 0 OR NOTA > 10 THEN
  		SIGNAL SQLSTATE '45000' SET	message_text = 'A nota debe ter un valor entre 0 e 10';
  	ELSEIF NOTA < 5 THEN
  		RETURN 'suspenso';
  	ELSEIF NOTA < 6 THEN
  		RETURN 'aprobado';
  	ELSEIF NOTA < 7 THEN
  		RETURN 'ben';
  	ELSEIF NOTA < 9 THEN
  		RETURN 'notable';
  	ELSE
  		RETURN 'sobresaliente';
  	END IF;
END;
$$

DELIMITER ;
SELECT nome_nota(11);


/*
Ejercicio 3. Crear una función en la base de datos utilidades que 
pasándole como parámetro las 8 cifras correspondientes al número del 
DNI, devuelva la letra que le corresponde.
*/

DROP FUNCTION IF EXISTS letra_dni;

DELIMITER $$ 

CREATE FUNCTION letraDni(num_dni INT UNSIGNED) 
	RETURNS CHAR(1)
	DETERMINISTIC
BEGIN
	RETURN substring('TRWAGMYFPDXBNJZSQVHLCKE', num_dni % 23 + 1, 1);
END
$$

DELIMITER ;

SELECT letra_dni(35587030)