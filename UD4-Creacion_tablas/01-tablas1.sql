DROP DATABASE IF EXISTS tablas1;

CREATE DATABASE tablas1 CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE tablas1;

CREATE TABLE tiendas(
    nif VARCHAR(10),
    nombre VARCHAR(20),
    direccion VARCHAR(20),
    poblacion VARCHAR(20),
    provincia VARCHAR(20),
    codpostal CHAR(5),
    tipo_tienda ENUM('Principal','Secundaria','Digital') NOT NULL DEFAULT 'Principal'
);

CREATE TABLE fabricantes(
    cod_fabricante INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(15) NOT NULL,
    continente ENUM('EU','AM','AF','OC','AS') DEFAULT 'EU'
);

CREATE TABLE articulos(
    articulo VARCHAR(20),
    cod_fabricante INT UNSIGNED,
    peso INT UNSIGNED CHECK (peso>0) ,
    categoria ENUM('primera','segunda','tercera'),
    precio_venta DECIMAL(8,2) CHECK (precio_venta>0),
    precio_costo DECIMAL(8,2) CHECK (precio_costo>0),
    existencias INT UNSIGNED NOT NULL,
    PRIMARY KEY (articulo, cod_fabricante, peso, categoria)
);


CREATE TABLE ventas(
    nif VARCHAR(10),
    articulo VARCHAR(20),
    cod_fabricante INT UNSIGNED,
    peso INT UNSIGNED,
    categoria ENUM('primera','segunda','tercera'),
    fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    unidades_vendidas SMALLINT UNSIGNED CHECK(unidades_vendidas > 0),
    tipo_venta ENUM('Mostrador','Bajo Pedido','web') NOT NULL,
    PRIMARY KEY(nif, articulo, cod_fabricante, peso, categoria, fecha_venta)
);

CREATE TABLE pedidos(
    nif VARCHAR(10),
    articulo VARCHAR(20),
    cod_fabricante INT UNSIGNED,
    peso INT UNSIGNED,
    categoria ENUM('primera','segunda','tercera'),
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    unidades_pedidas SMALLINT UNSIGNED CHECK(unidades_pedidas >0),
    existencias INT UNSIGNED NOT NULL,
    PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido)
);

ALTER TABLE tiendas
    MODIFY nombre VARCHAR(30) NOT NULL,
    ADD CONSTRAINT PK_tiendas PRIMARY KEY (nif);

ALTER TABLE articulos 
    ADD CONSTRAINT FK_articulos_fabricante FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ventas
    ADD CONSTRAINT FK_ventas_tienda FOREIGN KEY (nif) REFERENCES tiendas(nif) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT FK_venta_articulos FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES articulos(articulo, cod_fabricante, peso, categoria);

ALTER TABLE pedidos
    ADD CONSTRAINT FK_pedidos_tienda FOREIGN KEY (nif) REFERENCES tiendas(nif) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT FK_pedidos_articulos FOREIGN KEY(articulo, cod_fabricante, peso, categoria) REFERENCES articulos(articulo, cod_fabricante, peso, categoria) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE articulos
    MODIFY precio_venta DECIMAL(10,2) NOT NULL;

ALTER TABLE pedidos
    ADD COLUMN fecha_entrega DATE;