DROP DATABASE IF EXISTS espectaculos;
CREATE DATABASE espectaculos CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;

USE espectaculos;

CREATE TABLE espectaculos(
    cod_espectaculo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    fecha_inicial DATE NOT NULL,
    fecha_final DATE,
    interprete VARCHAR(20) NOT NULL,
    cod_recinto INT UNSIGNED NOT NULL
)ENGINE = InnoDB;

CREATE TABLE precio_espectaculos(
    cod_espectaculo INT UNSIGNED,
    cod_recinto INT UNSIGNED,
    zona VARCHAR(100),
    precio DECIMAL(7,2) UNSIGNED NOT NULL,
    PRIMARY KEY(cod_espectaculo, cod_recinto, zona)
)ENGINE = InnoDB;

CREATE TABLE recintos(
    cod_recinto INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(20) UNIQUE,
    direccion VARCHAR(50),
    ciudad VARCHAR(20),
    telefono char(9),
    horario VARCHAR(40)
);

CREATE TABLE zonas_recintos(
    cod_recinto INT UNSIGNED,
    zona VARCHAR(100),
    capacidad INT UNSIGNED NOT NULL,
    PRIMARY KEY (cod_recinto, zona)
);

CREATE TABLE asientos(
    cod_recinto INT UNSIGNED,
    zona VARCHAR(100),
    fila SMALLINT UNSIGNED,
    numero SMALLINT UNSIGNED,
    PRIMARY KEY (cod_recinto, zona, fila, numero)
);

CREATE TABLE representaciones(
    cod_espectaculo INT UNSIGNED,
    fecha DATE,
    hora TIME,
    PRIMARY KEY (cod_espectaculo, fecha, hora)
);

CREATE TABLE entradas(
    cod_espectaculo INT UNSIGNED,
    fecha DATE,
    hora TIME,
    cod_recinto INT UNSIGNED,
    fila SMALLINT UNSIGNED,
    numero SMALLINT UNSIGNED,
    zona VARCHAR(100),
    dni_cliente INT UNSIGNED,
    PRIMARY KEY (cod_espectaculo, fecha, hora, cod_recinto, fila, numero, zona, dni_cliente)
);

CREATE TABLE espectadores(
    dni_cliente VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    direccion VARCHAR(50),
    telefono CHAR(9) NOT NULL,
    ciudad VARCHAR(20),
    ntarjeta CHAR(16)
);

ALTER TABLE espectaculos
    ADD CONSTRAINT fk_espectaculos_recinto FOREIGN KEY (cod_recinto) REFERENCES recintos(cod_recinto)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE precio_espectaculos
    ADD CONSTRAINT fk_precio_espectaculos_espectaculos FOREIGN KEY (cod_espectaculo) REFERENCES espectaculos(cod_espectaculo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_precio_espectaculos_zonas FOREIGN KEY (cod_recinto, zona) REFERENCES zonas_recintos(cod_recinto, zona)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE zonas_recintos
    ADD CONSTRAINT fk_zonas_recintos_recintos FOREIGN KEY (cod_recinto) REFERENCES recintos(cod_recinto)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE asientos
    ADD CONSTRAINT fk_asientos_zonas FOREIGN KEY (cod_recinto, zona) REFERENCES zonas_recintos(cod_recinto, zona)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE representaciones
    ADD CONSTRAINT fk_representaciones_espectaculos FOREIGN KEY (cod_espectaculo) REFERENCES espectaculos(cod_espectaculo)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE entradas
    ADD CONSTRAINT fk_entradas_representaciones FOREIGN KEY (cod_espectaculo, fecha, hora) REFERENCES representaciones(cod_espectaculo, fecha, hora)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_entradas_asientos FOREIGN KEY (cod_recinto, zona, fila, numero) REFERENCES asientos(cod_recinto, zona, fila, numero)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_entradas_cliente FOREIGN KEY (dni_cliente) REFERENCES espectadores(dni_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE;