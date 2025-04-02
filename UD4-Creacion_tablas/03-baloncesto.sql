DROP DATABASE IF EXISTS baloncesto;

CREATE DATABASE baloncesto CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE baloncesto;

CREATE TABLE equipo(
    codigo VARCHAR(4) PRIMARY KEY,
    nome_club VARCHAR(200) NOT NULL,
    nome_equipo VARCHAR(200) NOT NULL,
    pavillon VARCHAR(200),
    capacidade_pavillon INT UNSIGNED NOT NULL,
    web VARCHAR(255)
);


CREATE TABLE nacionalidade(
    codigo CHAR(3) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE xogador(
    numero_licencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero TINYINT CHECK(numero >= 1 AND numero <=99),
    codigo_equipo VARCHAR(4) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    posicion ENUM('F','B','A','P','E') NOT NULL,
    nacionalidade CHAR(3) NOT NULL DEFAULT('ESP'),
    ficha ENUM('','EUR','JFL','EXT') NOT NULL,
    estatura DECIMAL(3,2),
    data_nacemento DATE,
    temporadas INT
   -- CONSTRAINT min_numero 
   --     CHECK(numero > 0), 
   -- CONSTRAINT max_numero 
   --     CHECK(numero <100)
);

ALTER TABLE xogador
    ADD CONSTRAINT fk_xogador_equipos FOREIGN KEY (codigo_equipo) REFERENCES equipo(codigo) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_xogador_nacionalidade FOREIGN KEY (nacionalidade) REFERENCES nacionalidade(codigo) ON DELETE RESTRICT ON UPDATE CASCADE;
--Modfificaciones
ALTER TABLE equipo
    ADD COLUMN nacionalidade CHAR(3) DEFAULT('ESP'),
    ADD CONSTRAINT fk_equipo_nacionalidade FOREIGN KEY(nacionalidade) REFERENCES nacionalidade(codigo) 
        ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE posiciones(
    idposicion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombreposicion VARCHAR(50) UNIQUE
);

ALTER TABLE xogador
    ALTER ficha SET DEFAULT('EUR'),
    DROP posicion,
    ADD COLUMN idposicion INT UNSIGNED NOT NULL,
    ADD CONSTRAINT fk_xogador_posicion FOREIGN KEY(idposicion) REFERENCES posiciones(idposicion) 
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE xogador
    ADD COLUMN salario DECIMAL(11,2) NOT NULL CHECK(salario < 100000000);

CREATE TABLE club(
    cod_club CHAR(3) PRIMARY KEY,
    nombre_club VARCHAR(100)
);

ALTER TABLE equipo
    DROP nome_club,
    ADD COLUMN cod_club CHAR(3) NOT NULL AFTER codigo,
    ADD FOREIGN KEY (cod_club) REFERENCES club(cod_club) ON DELETE RESTRICT ON UPDATE CASCADE;