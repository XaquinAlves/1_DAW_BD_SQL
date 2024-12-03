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
    ADD PRIMARY KEY nif,
    MODIFY nombre VARCHAR(30) NOT NULL;

CREATE TABLE fabricantes(
    cod_fabricante NUMBER(3) PRIMARY KEY,
    nombre VARCHAR(15),
    pais VARCHAR(15)
);
