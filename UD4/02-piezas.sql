DROP DATABASE IF EXISTS piezas1;

CREATE DATABASE piezas1 CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE piezas1;

CREATE TABLE suministradores(
    id_proveedor INT UNSIGNED,
    id_pieza INT UNSIGNED,
    id_proyecto INT UNSIGNED,
    cantidad INT UNSIGNED CHECK(cantidad > 0),
    PRIMARY KEY(id_proveedor, id_pieza, id_proyecto)
);

CREATE TABLE piezas(
    id_pieza INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombrepiez VARCHAR(20) NOT NULL,
    color VARCHAR(20) DEFAULT ("metalizado")
);

CREATE TABLE proveedores(
    id_proveedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombreprov VARCHAR(20) NOT NULL
);

CREATE TABLE proyectos(
    id_proyecto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombeproyecto VARCHAR(50) NOT NULL
);

ALTER TABLE proyectos
    ADD COLUMN presupuesto DECIMAL(9,2),
    MODIFY nombeproyecto VARCHAR(50) UNIQUE;

ALTER TABLE piezas
    MODIFY color VARCHAR(20) NOT NULL DEFAULT ("metalizado"),
    CHANGE nombrepiez nombre_pieza VARCHAR(20) UNIQUE;

ALTER TABLE proveedores
    MODIFY nombreprov VARCHAR(20) UNIQUE;

ALTER TABLE suministradores
    ADD FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (id_pieza) REFERENCES piezas(id_pieza) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto) ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE provincias(
    id_provincia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_provincia VARCHAR(50) UNIQUE NOT NULL
);

ALTER TABLE proveedores
    DROP nombreprov,
    ADD COLUMN  id_provincia INT UNSIGNED NOT NULL,
    ADD FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia) ON DELETE RESTRICT ON UPDATE CASCADE;
