DROP DATABASE IF EXISTS tablas1;

CREATE DATABASE tablas1 CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE tablas1;

CREATE TABLE tiendas(
    nif VARCHAR(10),
    nombre VARCHAR(20),
    direccion VARCHAR(20),
    poblacion VARCHAR(20),
    provincia VARCHAR(20),
    codpostal CHAR(5)
);

ALTER TABLE tiendas
    ADD PRIMARY KEY (nif),
    MODIFY nombre VARCHAR(30) NOT NULL;

CREATE TABLE fabricantes(
    cod_fabricante INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(15) NOT NULL,
    pais VARCHAR(15) NOT NULL
);

CREATE TABLE articulos(
    articulo VARCHAR(20),
    cod_fabricante INT UNSIGNED,
    peso SMALLINT UNSIGNED CHECK (peso>0) ,
    categoria ENUM('primera','segunda','tercera'),
    precio_venta DECIMAL(7,2) NOT NULL CHECK (precio_venta>0),
    precio_costo DECIMAL(7,2) NOT NULL CHECK (precio_costo>0),
    existencias INT UNSIGNED,
    PRIMARY KEY (articulo, cod_fabricante, peso, categoria)
);

ALTER TABLE articulos ADD FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante) ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE ventas(
    nif VARCHAR(10),
    articulo VARCHAR(20),
    cod_fabricante INT UNSIGNED,
    peso INT UNSIGNED,
    categoria ENUM('primera','segunda','tercera'),
    fecha_venta DATE,
    unidades_vendidas SMALLINT UNSIGNED NOT NULL CHECK(unidades_vendidas > 0),
    PRIMARY KEY(nif, articulo, cod_fabricante, peso, categoria, fecha_venta)
);

ALTER TABLE ventas
    ADD FOREIGN KEY (nif) REFERENCES tiendas(nif) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES articulos(articulo, cod_fabricante, peso, categoria);