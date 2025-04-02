DROP DATABASE IF EXISTS espectaculos;

CREATE DATABASE espectaculos CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE espectaculos;

CREATE TABLE espectaculo(
    cod_espectaculo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    fecha_inicial DATE NOT NULL,
    fecha_final DATE NOT NULL,
    cod_recinto INT UNSIGNED NOT NULL
)ENGINE=InnoDB;

CREATE TABLE precios_espectaculos(
    cod_espectaculo INT UNSIGNED,
    cod_recinto INT UNSIGNED,
    zona CHAR(10),
    precio DECIMAL(8,2) UNSIGNED NOT NULL,
    CONSTRAINT PK_precios PRIMARY KEY(cod_espectaculo, cod_recinto, zona)
)ENGINE=InnoDB;

CREATE TABLE recintos(
    cod_recinto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    horario VARCHAR(255) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE zonas_recintos(
    cod_recinto INT UNSIGNED,
    zona CHAR(10),
    CAPACIDAD INT UNSIGNED NOT NULL,
    CONSTRAINT PK_zonas_recintos PRIMARY KEY(cod_recinto, zona)
)ENGINE=InnoDB;

CREATE TABLE asientos(
    cod_recinto INT UNSIGNED,
    zona CHAR(10),
    fila INT UNSIGNED,
    numero INT UNSIGNED,
    CONSTRAINT PK_asientos PRIMARY KEY(cod_recinto, zona, fila, numero) 
)ENGINE=InnoDB;

CREATE TABLE representaciones(
    cod_espectaculo INT UNSIGNED,
    fecha DATE,
    hora TIME,
    CONSTRAINT PK_representacion PRIMARY KEY(cod_espectaculo, fecha, hora)
)ENGINE=InnoDB;

CREATE TABLE entradas(
    cod_espectaculo INT UNSIGNED,
    fecha DATE,
    hora TIME,

    cod_recinto INT UNSIGNED NOT NULL,
    fila INT UNSIGNED,
    numero INT UNSIGNED,
    zona CHAR(10),

    dni_cliente VARCHAR(9),

    CONSTRAINT PK_entradas PRIMARY KEY(cod_espectaculo, fecha, hora, fila, numero, zona, dni_cliente)
)ENGINE=InnoDB;

CREATE TABLE espectadores(
    dni_cliente VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    telefono INT UNSIGNED NOT NULL,
    ciudad VARCHAR(255),
    ntarjeta INT UNSIGNED NOT NULL
)ENGINE=InnoDB;

ALTER TABLE espectaculo
    ADD CONSTRAINT FK_espectaculo_recinto FOREIGN KEY (cod_recinto) REFERENCES recintos(cod_recinto) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE precios_espectaculos
    ADD CONSTRAINT FK_precios_codEspectaculo FOREIGN KEY (cod_espectaculo) REFERENCES espectaculo(cod_espectaculo) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT FK_precios_recinto_zona FOREIGN KEY (cod_recinto, zona) REFERENCES zonas_recintos(cod_recinto,zona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE zonas_recintos
    ADD CONSTRAINT FK_zonas_codRecinto FOREIGN KEY (cod_recinto) REFERENCES recintos(cod_recinto) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE asientos
    ADD CONSTRAINT FK_asientos_recinto_zona FOREIGN KEY (cod_recinto,zona) REFERENCES zonas_recintos(cod_recinto, zona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE representaciones
    ADD CONSTRAINT FK_representaciones_espectaculo FOREIGN KEY (cod_espectaculo) REFERENCES espectaculo(cod_espectaculo) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE entradas
    ADD CONSTRAINT FK_entradas_espectaculo FOREIGN KEY (cod_espectaculo) REFERENCES espectaculo(cod_espectaculo) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT FK_entradas_asiento  FOREIGN KEY (cod_recinto,zona, fila, numero) REFERENCES asientos(cod_recinto, zona, fila, numero) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT FK_entradas_espectador FOREIGN KEY (dni_cliente) REFERENCES espectadores(dni_cliente) ON DELETE RESTRICT ON UPDATE CASCADE;