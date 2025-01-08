DROP DATABASE IF EXISTS espectaculos;

CREATE DATABASE espectaculos CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE espectaculos;

CREATE TABLE espectaculo(
    cod_espectaculo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    fecha_inicial DATE NOT NULL,
    fecha_final DATE NOT NULL,
    cod_recinto INT UNSIGNED
)ENGINE=InnoDB;

CREATE TABLE precios_espectaculos(
    cod_espectaculo INT UNSIGNED,
    cod_recinto INT UNSIGNED,
    zona VARCHAR(255),
    precio DECIMAL(8,2)
)ENGINE=InnoDB;

CREATE TABLE recintos(
    cod_recinto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nobre VARCHAR(255),
    
)ENGINE=InnoDB;

CREATE TABLE zonas_recintos()ENGINE=InnoDB;

CREATE TABLE asientos()ENGINE=InnoDB;

CREATE TABLE representaciones()ENGINE=InnoDB;

CREATE TABLE entradas()ENGINE=InnoDB;

CREATE TABLE espectadores()ENGINE=InnoDB;