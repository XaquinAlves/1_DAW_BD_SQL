DROP DATABASE IF EXISTS xogadoras;

CREATE DATABASE xogadoras CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE xogadoras;

CREATE TABLE xogodora(
    nome_xogadora VARCHAR(255) PRIMARY KEY,
    data_nacemento DATE NOT NULL
)ENGINE = InnoDB;

CREATE TABLE cidade(
    nome_cidade VARCHAR(255) PRIMARY KEY,
    provincia VARCHAR(255) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE adestradora(
    nome_adestradora VARCHAR(255) PRIMARY KEY,
    data_nacemento_adestradora DATE NOT NULL
)ENGINE = InnoDB;

CREATE TABLE equipo(
    nome_equipo VARCHAR(255) PRIMARY KEY,
    cidade VARCHAR(255) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE patrocinador(
    nome_xogadora VARCHAR(255) NOT NULL,
    temporada_patrocinio CHAR(9) NOT NULL,
    patrocinio VARCHAR(255) NOT NULL,
    PRIMARY KEY(nome_xogadora, temporada_patrocinio, patrocinio)
)ENGINE = InnoDB;

CREATE TABLE xogadora_info(
    nome_xogadora VARCHAR(255) NOT NULL,
    temporada VARCHAR(9) NOT NULL,
    posto INT UNSIGNED NOT NULL,
    equipo VARCHAR(255) NOT NULL,
    puntos INT UNSIGNED NOT NULL,
    PRIMARY KEY(nome_xogadora, temporada)
)ENGINE = InnoDB;

CREATE TABLE equipo_adestradora(
    equipo VARCHAR(255) NOT NULL,
    temporada_equipo CHAR(9) NOT NULL,
    adestradora VARCHAR(255) NOT NULL,
    PRIMARY KEY(equipo, temporada_equipo)
)ENGINE = InnoDB;

CREATE TABLE temporada(
    temporada CHAR(9) PRIMARY KEY
)ENGINE = InnoDB;

ALTER TABLE equipo 
    ADD FOREIGN KEY(cidade) REFERENCES cidade(nome_cidade) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE equipo_adestradora 
    ADD FOREIGN KEY(equipo) REFERENCES equipo(nome_equipo) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY(adestradora) REFERENCES adestradora(nome_adestradora) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY(temporada_equipo) REFERENCES temporada(temporada) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE xogadora_info 
    ADD FOREIGN KEY(nome_xogadora) REFERENCES xogodora(nome_xogadora) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY(equipo) REFERENCES equipo(nome_equipo) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY(temporada) REFERENCES temporada(temporada) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE patrocinador 
    ADD FOREIGN KEY(nome_xogadora) REFERENCES xogodora(nome_xogadora) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY(temporada_patrocinio) REFERENCES temporada(temporada) ON DELETE RESTRICT ON UPDATE CASCADE;

