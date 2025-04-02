-- q1
-- Muestra el precio y el nombre los tres portátiles que se venden más caro de la tienda.
SELECT a.art_pv , a.art_nome 
FROM artigos a 
WHERE a.art_nome LIKE 'PORTATIL%' 
ORDER BY a.art_pv DESC
LIMIT 3;

-- q2
-- Muestra el precio y el nombre del cuarto, quinto y sexto portátiles más caros de la tienda.
SELECT a.art_pv , a.art_nome 
FROM artigos a 
WHERE a.art_nome LIKE 'PORTATIL%' 
ORDER BY a.art_pv DESC
LIMIT 3,3;

-- q3
-- Estamos realizando un aplicación web con paginación. Las consultas deben devolver código, nombre y precio de venta 
-- de los artículos y debe estar ordenada por nombre.
-- Crea la consulta que devuelve los primeros 10 artículos.
SELECT a.art_codigo , a.art_nome , a.art_pv 
FROM artigos a 
ORDER BY a.art_nome
LIMIT 10;
-- Crea la consulta que devuelve los segundos 10 artículos.
SELECT a.art_codigo , a.art_nome , a.art_pv 
FROM artigos a 
ORDER BY a.art_nome
LIMIT 10,10;
-- Crea la consulta que devuelve los artículos 21-30
SELECT a.art_codigo , a.art_nome , a.art_pv 
FROM artigos a 
ORDER BY a.art_nome
LIMIT 20,10;

-- q4
-- Muestra por pantalla la información de las últimas 5 ventas realizadas.
SELECT v.*
FROM vendas v
ORDER BY v.ven_data DESC
LIMIT 5;

-- q5
-- Sobre la tabla clientes muestra todos los clientes cuyo nombre empieza por la letra J mayúscula y tiene una longitud
-- de exactamente seis letras.
SELECT c.*
FROM clientes c
WHERE c.clt_nome LIKE 'J_____'
ORDER BY c.clt_id;

-- q6
-- Sobre la tabla clientes muestra todos los clientes cuyo nombre tiene un tamaño de entre 4 y 6 letras. 
-- En el caso de personas con nombres compuestos valdrá con que alguno de los nombres cumpla este requisito.
-- Ordena por nombre, apellidos. Muestra los resultados del 6 al 10.
SELECT c.*
FROM clientes c 
WHERE c.clt_nome REGEXP '\\b[a-z]{4,6}\\b'
ORDER BY c.clt_nome , c.clt_apelidos
LIMIT 5,5;

-- q7
-- Sobre la tabla clientes muestra todos los clientes cuyo nombre tiene un tamaño mayor de 4 letras y cuyo nombre no contenga la letra a.
-- En el caso de personas con nombres compuestos valdrá con que alguno de los nombres cumpla este requisito.
-- Ordena por nombre, apellidos. Muestra los resultados del 6 al 10.
SELECT c.*
FROM clientes c 
WHERE c.clt_nome REGEXP '\\b[b-z]{5,}\\b'
ORDER BY c.clt_nome, c.clt_apelidos
LIMIT 5,5;

-- q8
-- Sobre la tabla clientes muestra todos los clientes con un CIF formado por exactamente 8 números y cuya letra sea una vocal.
-- Ordena por apellidos, nombre.
SELECT c.*
FROM clientes c 
WHERE c.clt_cif REGEXP '^[0-9]{8}[a,e,i,o,u]$'
ORDER BY c.clt_nome, c.clt_apelidos;

-- q9
-- Sobre la tabla clientes muestra todos los clientes con una dirección cuyo número de calle entre el 100 y el 199.
-- Ordénalos por apellidos, nombre.
SELECT c.*
FROM clientes c 
WHERE c.clt_enderezo REGEXP '\\b1[0-9][0-9]\\b'
ORDER BY c.clt_nome, c.clt_apelidos;

-- q10
-- Sobre la tabla clientes, muestra todos los clientes que viven en Madrid, Vigo o Zaragoza y el valor de ctl_vendas es mayor que 0
-- o tienen un descuento del 4%. Ordena por población, ctl_vendas, descuento.


-- q11
-- Sobre la tabla artículos, muestra los artículos que tengan un margen de beneficio de al menos el 25%, estén distribuidos por el 
-- proveedor 7, 12 o 23 y tengan un stock mayor que 12. Muestra también los artículos con un stock menor de 5 que tengan un margen de 
-- beneficio de, como máximo, el 12%.

-- q12 Sobre la tabla artículos, muestra los artículos que sean del tipo monitor (sabemos por el nombre que son monitores) y estén 
-- distribuidos por los proveedores 1, 2 o 3 y que tengan stock inferior a 5. Ordena por nombre de artículo.
-- Campos a mostrar: art_codigo, art_nombre, art_proveedor, art_stock.

-- q13
-- Sobre la tabla artículos busca todos los pcs con un precio de venta entre 400 y 600 euros que nos proveen los proveedores 1 y 3 
-- con una diferencia entre el precio de compra y de venta de al menos 80 euros. 
-- Datos a mostrar: art_codigo, art_nombre, art_proveedor, art_pc, art_pv, diferencia. Ordena por diferencia de precio, art_nombre.
















