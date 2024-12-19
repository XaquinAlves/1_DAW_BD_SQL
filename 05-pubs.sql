DROP DATABASE IF EXISTS pubs;

CREATE DATABASE pubs CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE pubs;

CREATE TABLE localidad(
    codLocalidad INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE empleado(
    dniEmpleado CHAR(9) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    domicilio VARCHAR(255)
);

CREATE TABLE pub(
    codPub CHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    licenciaFiscal VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255),
    fechaApertura DATE NOT NULL,
    horario ENUM('HOR1','HOR2','HOR3') NOT NULL,
    codLocalidad INT UNSIGNED NOT NULL
);

CREATE TABLE pub_empleado(
    codPub CHAR(20),
    dniEmpleado CHAR(9),
    funcion ENUM('CAMARERO','SEGURIDAD','LIMPIEZA'),
    PRIMARY KEY(codPub,dniEmpleado,funcion)
);

CREATE TABLE titular(
    dniTitular CHAR(9) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    domicilio VARCHAR(255),
    codPub CHAR(20) NOT NULL
);

CREATE TABLE existencias(
    codArticulo CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    precio DECIMAL(7,2) UNSIGNED NOT NULL CHECK(precio > 0),
    codPub CHAR(20) NOT NULL
);

ALTER TABLE pub
    ADD FOREIGN KEY(codLocalidad) REFERENCES localidad(codLocalidad) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE pub_empleado
    ADD FOREIGN KEY(codPub) REFERENCES pub(codPub) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY(dniEmpleado) REFERENCES empleado(dniEmpleado) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE titular
    ADD FOREIGN KEY(codPub) REFERENCES pub(codPub) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE existencias
    ADD FOREIGN KEY(codPub) REFERENCES pub(codPub) ON DELETE RESTRICT ON UPDATE CASCADE;