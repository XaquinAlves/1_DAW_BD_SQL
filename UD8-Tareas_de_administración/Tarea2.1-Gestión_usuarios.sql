SELECT `user`, host, Grant_priv  FROM mysql.`user`;

-- q1.Crea un usuario jefe con contraseña abc123. con los máximos 
-- privilegios y que solamente pueda acceder desde lo equipo local.
CREATE USER 'jefe'@'localhost' IDENTIFIED BY 'abc123.';
GRANT ALL ON *.* TO 'jefe'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

-- q2.Crea un usuario usuario1 con contraseña abc123. con permiso 
-- de creación, alteración y borrado de tablas en la base de datos 
-- sakila y que solo pueda acceder desde lo equipo local. Después 
-- borra o usuario.
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'abc123.';
GRANT CREATE, ALTER, DROP ON sakila.* TO 'usuario1'@'localhost';

FLUSH PRIVILEGES;

DROP USER 'usuario1'@'localhost';

-- q3.Crea un usuario usuario1 con contraseña abc123. con permiso de 
-- creación, alteración y borrado de tablas en la base de datos sakila
-- y que pueda acceder a la base de datos desde cualquiera equipo. 
CREATE USER 'usuario1'@'%' IDENTIFIED BY 'abc123.';
GRANT CREATE, ALTER, DROP ON sakila.* TO 'usuario1'@'%';

FLUSH PRIVILEGES;

-- q4.Crea un usuario usuario2 con contraseña abc123. con permiso 
-- de consulta, inserción y actualización de la tabla actor 
-- (de la base de datos sakila) y que pueda acceder a la base de datos 
-- desde cualquiera equipo. Después le quita (revócale) al usuario el 
-- permiso de actualización.
CREATE USER 'usuario2' IDENTIFIED BY 'abc123.';
GRANT SELECT, INSERT, UPDATE ON sakila.actor TO 'usuario2';
REVOKE UPDATE ON sakila.actor FROM 'usuario2';

-- q5.Cambia la contraseña del usuario2 a abc.
SET PASSWORD FOR 'usuario2'=PASSWORD('abc');

-- q6.Elimina los usuarios creados.
DROP USER 'usuario1', 'usuario2', 'jefe'@'localhost';






