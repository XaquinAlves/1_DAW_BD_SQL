DROP DATABASE IF EXISTS laboral;
CREATE DATABASE laboral CHARSET = utf8mb4 COLLATE utf8mb4_unicode_520_ci;

USE laboral;

CREATE TABLE empleados{
    dni INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL,
    apellido1 VARCHAR(15) NOT NULL,
    apelido2 VARCHAR(15),
    direcc1 VARCHAR(25),
    direcc2 VARCHAR(20),
    ciudad VARCHAR(20),
    provincia VARCHAR(20),
    cod_postal VARCHAR(5),
    sexo ENUM('H', 'M'),
    fecha_nac DATE,
}ENGINE = InnoDB;

CREATE TABLE historial_laboral{
    empleado_dni INT UNSIGNED,
    trabajo_cod MEDIUMINT UNSIGNED,
    fecha_inicio DATE,
    fecha_fin DATE,
    dpto_cod MEDIUMINT UNSIGNED,
    supervisor_dni INT UNSIGNED
    PRIMARY KEY (empleado_dni, trabajo_cod, fecha_inicio)
}ENGINE = InnoDB

CREATE TABLE historial_salarial{
    empleado_dni INT UNSIGNED,
    salario DECIMAL(8,2) UNSIGNED NOT NULL,
    fecha_comienzo DATE,
    fecha_fin DATE,
    PRIMARY KEY (empleado_dni, salario, fecha_comienzo)
}ENGINE = InnoDB;

CREATE TABLE departamentos{
    dpto_cod MEDIUMINT UNSIGNED PRIMARY KEY,
    nombre_dpto VARCHAR(30) UNIQUE,
    dpto_padre MEDIUMINT UNSIGNED,
    presupuesto DECIMAL(12,2) UNSIGNED NOT NULL,
    pres_actual DECIMAL(12,2) UNSIGNED
}ENGINE = InnoDB;

CREATE TABLE estudios{
    empleado_dni INT UNSIGNED,
    universidad MEDIUMINT UNSIGNED,
    año SMALLINT UNSIGNED,
    grado VARCHAR(3),
    especialidad VARCHAR(20),
    PRIMARY KEY (empleado_dni, universidad, especialidad)
}ENGINE = InnoDB;

CREATE TABLE universidades{
    univ_cod MEDIUMINT UNSIGNED PRIMARY KEY,
    nombre_univ VARCHAR(25)  NOT NULL,
    ciudad VARCHAR(20),
    municioio VARCHAR(2),
    cod_postal VARCHAR(5)
}ENGINE = InnoDB;

CREATE TABLE trabajos{
    trabajo_cod MEDIUMINT UNSIGNED PRIMARY KEY,
    nombre_trabajo VARCHAR(20) UNIQUE,
    salario_min DECIMAL(10,2) NOT NULL,
    salario_max DECIMAL(10,2) NOT NULL,
)ENGINE = InnoDB;

ALTER TABLE historial_laboral
    ADD CONSTRAINT fk_historial_laboral_empleado FOREIGN KEY (empleado_dni) REFERENCES empleados(dni)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_historial_laboral_trabajo FOREIGN KEY (trabajo_cod) REFERENCES trabajos(trabajo_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_historial_laboral_dpto FOREIGN KEY (dpto_cod) REFERENCES departamentos(dpto_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_historial_laboral_supervisor FOREIGN KEY (supervisor_dni) REFERENCES empleados(dni);

ALTER TABLE historial_salarial
    ADD CONSTRAINT fk_historial_salarial_empleado FOREIGN KEY (empleado_dni) REFERENCES empleados(dni)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE departamentos
    ADD CONSTRAINT fk_departamento_padre FOREIGN KEY (dpto_padre) REFERENCES departamentos(dpto_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE estudios
    ADD CONSTRAINT fk_estudios_empleados FOREIGN KEY (empleado_dni) REFERENCES empleados(dni)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_estudios_universidad FOREIGN KEY (universidad) REFERENCES universidades(univ_cod)
        ON DELETE RESTRICT ON UPDATE CASCADE;
