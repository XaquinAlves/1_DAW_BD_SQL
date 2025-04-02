DROP DATABASE IF EXISTS historial_laboral;

CREATE DATABASE historial_laboral CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE historial_laboral;

CREATE TABLE empleados(
    dni INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL,
    apelido1 VARCHAR(15) NOT NULL,
    apelido2 VARCHAR(15),
    direcc1 VARCHAR(25),
    direcc2 VARCHAR(20),
    ciudad VARCHAR(20),
    provincia VARCHAR(20),
    cod_postal VARCHAR(5),
    sexo ENUM('M','F'),
    fecha_nac DATE
)ENGINE=InnoDB;

CREATE TABLE historial_laboral(
    empleado_dni INT UNSIGNED,
    trabajo_cod MEDIUMINT UNSIGNED,
    fecha_inicio DATE,
    fecha_fin DATE,
    dpto_cod MEDIUMINT UNSIGNED,
    supervisor_dni INT UNSIGNED,
    PRIMARY KEY(empleado_dni, trabajo_cod, fecha_inicio)
)ENGINE=InnoDB;

CREATE TABLE historial_salarial(
    empleado_dni INT UNSIGNED,
    salario DECIMAL(8,2),
    fecha_comienzo DATE,
    fecha_fin DATE,
    PRIMARY KEY(empleado_dni, salario, fecha_comienzo)
)ENGINE=InnoDB;

CREATE TABLE departamentos(
    dpto_cod MEDIUMINT UNSIGNED PRIMARY KEY,
    nombre_dpto VARCHAR(30) UNIQUE NOT NULL,
    dpto_padre MEDIUMINT UNSIGNED,
    presupuesto DECIMAL(10,2) NOT NULL,
    pres_actual DECIMAL(10,2)
)ENGINE=InnoDB;

CREATE TABLE estudios(
    empleado_dni INT UNSIGNED,
    universidad MEDIUMINT UNSIGNED,
    año SMALLINT UNSIGNED,
    grado VARCHAR(3),
    especialidad VARCHAR(20),
    PRIMARY KEY(empleado_dni, universidad, especialidad)
)ENGINE=InnoDB;

CREATE TABLE universidades(
    univ_cod MEDIUMINT UNSIGNED PRIMARY KEY,
    nombre_univ VARCHAR(25) NOT NULL,
    ciudad VARCHAR(20),
    municipio VARCHAR(2),
    cod_postal VARCHAR(5)
)ENGINE=InnoDB;

CREATE TABLE trabajos(
    trabajo_cod MEDIUMINT UNSIGNED PRIMARY KEY,
    nombre_trab VARCHAR(20) UNIQUE NOT NULL,
    salario_min DECIMAL(8,2) NOT NULL,
    salario_max DECIMAL(8,2) NOT NULL
)ENGINE=InnoDB;

ALTER TABLE historial_laboral
    ADD FOREIGN KEY (empleado_dni) REFERENCES empleados(dni) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (trabajo_cod) REFERENCES trabajos(trabajo_cod) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (dpto_cod) REFERENCES departamentos(dpto_cod) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (supervisor_dni) REFERENCES empleados(dni) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE historial_salarial
    ADD FOREIGN KEY (empleado_dni) REFERENCES empleados(dni) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE departamentos
    ADD FOREIGN KEY (dpto_padre) REFERENCES departamentos(dpto_cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE estudios
    ADD FOREIGN KEY (empleado_dni) REFERENCES empleados(dni) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (universidad) REFERENCES universidades(univ_cod) ON DELETE RESTRICT ON UPDATE CASCADE;