/*	Crear la tabla aux_rol. Campos:
 		id_rol PK, int unsigned auto incremental.
 		nombre_rol: mismo tipo que campo usuario.rol. 
			No permitimos valores nulos.
	Rellena la tabla aux_rol con los diferentes roles que existen en la 
		tabla usuario.
	Crea un campo en la tabla usuario llamado id_rol. Tipo INT UNSIGNED.
	Actualiza todas las tuplas de la tabla usuario para establecer como 
		id_rol el valor del campo aux_rol.id_rol cuyo aux_rol.nombre_rol 
		sea igual al campo usuario.rol.
	Haz una consulta para comprobar que has hecho bien los updates. 
		La consulta hará un JOIN entre usuario y aux_rol mostrando username, 
		usuario.rol, usuario.id_rol, aux_rol.id_rol, aux_rol.nombre_rol.
	Elimina el campo usuario.rol.
	Establece que el campo usuario.id_rol es una FK que apunta a 
		aux_rol.id_rol.
	Al actualizar se propagan los cambios.
	Al borrar se restringe.
*/

CREATE TABLE aux_rol(
	id_rol INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre_rol VARCHAR(50)
);

INSERT INTO aux_rol (nombre_rol)
SELECT DISTINCT rol FROM usuario;

ALTER TABLE usuario ADD COLUMN id_rol INT UNSIGNED;

UPDATE usuario u
SET id_rol = (SELECT ar.id_rol FROM aux_rol ar WHERE ar.nombre_rol = u.rol);

SELECT u.username , u.rol , u.id_rol , ar.*
FROM usuario u 
JOIN aux_rol ar ON ar.id_rol = u.id_rol;

ALTER TABLE usuario DROP COLUMN rol,
	ADD CONSTRAINT FK_usuario_rol FOREIGN KEY (id_rol) REFERENCES aux_rol(id_rol) ON DELETE RESTRICT ON UPDATE CASCADE; 

	

