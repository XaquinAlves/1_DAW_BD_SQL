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

