DROP DATABASE IF EXISTS empregados;

CREATE DATABASE empregados CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE empregados;

CREATE TABLE centro(
    cenNumero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cenNome VARCHAR(100) NOT NULL,
    cenEnderezo VARCHAR(255)
);

CREATE TABLE empregado(
    empNumero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empDepartamento INT UNSIGNED NOT NULL,
    empExtension INT UNSIGNED NOT NULL,
    empDataNacemento DATE NOT NULL,
    empDataIngreso DATE NOT NULL,
    empSalario DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0,
    empComision DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0,
    empFillos SMALLINT UNSIGNED NOT NULL,
    empNome VARCHAR(100) NOT NULL
);

CREATE TABLE departamento(
    depNumero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    depNome VARCHAR(255) NOT NULL,
    depDirector INT UNSIGNED NOT NULL,
    depTipoDirector ENUM('P','F') NOT NULL,
    depPresuposto DECIMAL(12,2) UNSIGNED NOT NULL CHECK(depPresuposto > 10000),
    depDepende INT UNSIGNED,
    depCentro INT UNSIGNED NOT NULL,
    depEmpregados INT UNSIGNED NOT NULL DEFAULT 0
);

ALTER TABLE departamento
    ADD CONSTRAINT departamento_FK_1 FOREIGN KEY(depCentro) REFERENCES centro(cenNumero) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT departamento_FK_2 FOREIGN KEY(depDepende) REFERENCES departamento(depNumero) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT departamento_FK FOREIGN KEY(depDirector) REFERENCES empregado(empNumero) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE empregado
    ADD CONSTRAINT empregado_FK FOREIGN KEY(empDepartamento) REFERENCES departamento(depNumero) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE centro
    CHANGE cenEnderezo cenRuaNum VARCHAR(255),
    ADD COLUMN cod_localidade INT UNSIGNED;

CREATE TABLE localidad(
    cod_localidad INT UNSIGNED PRIMARY KEY,
    nome VARCHAR(100),
    cod_provincia INT UNSIGNED NOT NULL
);

CREATE TABLE provincia(
    cod_provincia INT UNSIGNED PRIMARY KEY,
    nome VARCHAR(100)
);

ALTER TABLE centro
    ADD FOREIGN KEY (cod_localidade) REFERENCES localidad(cod_localidad) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE localidad
    ADD FOREIGN KEY (cod_provincia) REFERENCES provincia(cod_provincia) ON DELETE RESTRICT ON UPDATE CASCADE;