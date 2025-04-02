-- q1.
-- Mostrar apellidos, nombre, dni, fecha de nacimiento y edad de los empleados 
-- ordenados por edad actual, apellidos y nombre.
SELECT e.emp_apelidos , e.emp_nome , e.emp_dni , e.emp_dataNac , TIMESTAMPDIFF(YEAR, e.emp_dataNac, NOW()) as idade
FROM empregados e 
ORDER BY idade , e.emp_apelidos , e.emp_nome ;

-- q2.
-- Muestra apellidos, nombre, dni, fecha de nacimiento y edad de los empleados 
-- que tienen actualmente entre 18 y 35 años ordenados por edad actual, apellidos y nombre.
SELECT e.emp_apelidos , e.emp_nome , e.emp_dni , e.emp_dataNac , TIMESTAMPDIFF(YEAR, e.emp_dataNac, NOW()) as idade
FROM empregados e 
WHERE TIMESTAMPDIFF(YEAR, e.emp_dataNac, NOW()) BETWEEN 18 AND 35 
ORDER BY idade , e.emp_apelidos , e.emp_nome ;

-- q3.
-- Sin usar LIKE ni REGEXP muestra todos los datos de los clientes cuya dirección esté ubicada en la 
-- provincia de Pontevedra. La consulta debe funcionar con cualquier cliente existente o futuro.
SELECT c.*
FROM clientes c 
WHERE SUBSTRING(c.clt_cp,1,2) = '36' 
ORDER BY c.clt_id;

-- q4.
-- De la tabla clientes, muestra apellidos, nombre, población, fecha de ultima venta en formato europeo (dd/mm/yyyy) 
-- con el alias fecha_format.
SELECT c.clt_apelidos , c.clt_nome , c.clt_poboacion , DATE_FORMAT(c.clt_ultima_venda,'%d/%m/%Y') AS fecha_format
FROM clientes c 
ORDER BY c.clt_apelidos, c.clt_nome;

-- q5.
-- Muestra apellidos, nombre, población, fecha de ultima venta de todos los clientes. Si el cliente no ha 
-- realizado ninguna venta debe mostrarse el texto sin ventas.
SELECT c.clt_apelidos , c.clt_nome , c.clt_poboacion , IFNULL(c.clt_ultima_venda,'Sin ventas')
FROM clientes c 
ORDER BY c.clt_apelidos, c.clt_nome;

-- q6.
-- De la tabla clientes, muestra apellidos, nombre, población, día de la semana ultima venta en formato texto 
-- (lunes, martes...) con el alias dia_ultima_venta ordenado por el día de la semana de venta de domingo a a sábado.
-- Puedes ver en qué idioma está instalado MariaDb con la siguiente consulta: 


-- q7.
-- De la tabla clientes, muestra apellidos, nombre, población, fecha de ultima venta en formato europeo 
-- (dd/mm/yyyy) con el alias fecha_format si el cliente no ha realizado ninguna venta debe mostrarse el texto 
-- 'Sin ventas'.


-- q8.
-- La empresa paga una prima del 3% a los empleados mayores de 40 años. De la tabla empregados,
-- muestra apellidos, nombre, edad y el campo prima que será 'SÍ' si recibe prima y 'NO' si no la recibe. 
-- Ordena el resultado por edad actual, apellidos y nombre.


-- q9.La empresa paga una prima del 3% a los empleados mayores de 40 años y una prima del 5% a los empleados de 
-- 55 años o más. Muestra apellidos, nombre, edad y prima de los empleados 
-- ordenados por edad actual, apellidos y nombre.


-- q10. Muestra por pantalla el coste total de compra de todo el stock que se tiene en la tienda.


-- q11. Muestra por pantalla el coste total de compra de todos los discos duros HD con conexión 
-- SATA (asume que siempre va el tipo de disco duro antes que el tipo de conexión).


-- q12.
-- Muestra por pantalla el precio medio de venta todos los disco duros HD con capacidad de 1TB.


-- q13.
-- Muestra por pantalla el precio del artículo con precio de venta más caro de la tienda.


-- q14.
-- Muestra por pantalla el nombre y el precio del artículo con precio de venta más caro de la tienda.


-- q15.
-- Muestra por pantalla el precio del portátil que se vende más caro de la tienda.


-- q16.
-- Muestra por pantalla el nombre y el precio del portátil que se vende más caro de la tienda.


-- q17.
-- Muestra por pantalla el precio del portátil que se vende más caro (preciov_max), el precio del portátil que
-- se vende más barato (preciov_min), la diferencia de precio de venta (diferenciav) y compra (diferenciac) 
-- entre ambos y el precio de venta medio de todo el catálogo (precio_medio).


-- q18.
-- Muestra la edad media, la edad máxima y la edad mínima de la plantilla.


-- q19.
-- Muestra por pantalla cuantos empleados de la plantilla tienen más de 40 años.

-- q20.
-- Muestra por pantalla cuantos empleados tienen menos de 40 años.

