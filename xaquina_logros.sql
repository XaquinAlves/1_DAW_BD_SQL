DROP DATABASE IF EXISTS xaquina_logros;
CREATE DATABASE xaquina_logros CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;

USE xaquina_logros;

CREATE TABLE categoria(
    id_categoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    id_padre INT UNSIGNED
)ENGINE = InnoDB;

CREATE TABLE proveedor(
    cif VARCHAR(9) PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    website VARCHAR(255) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefono VARCHAR(12)
)ENGINE = InnoDB;

CREATE TABLE producto(
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    proveedor VARCHAR(9) NOT NULL,
    coste DECIMAL(7,2) NOT NULL,
    margen DECIMAL(5,2) NOT NULL,
    stock INT UNSIGNED NOT NULL,
    iva INT UNSIGNED NOT NULL,
    id_categoria INT UNSIGNED
)ENGINE = InnoDB;

ALTER TABLE producto
    ADD CONSTRAINT fk_producto_proveedor FOREIGN KEY (proveedor) REFERENCES proveedor(cif)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE categoria
    ADD CONSTRAINT fk_categoria_padre FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON DELETE RESTRICT ON UPDATE CASCADE;