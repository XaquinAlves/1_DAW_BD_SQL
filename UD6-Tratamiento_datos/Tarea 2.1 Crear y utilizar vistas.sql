-- 1. Crear una vista sin CHECK OPTION con los siguientes datos, referidos a los 
-- artículos: código y nombre del artículo y nombre de proveedor que lo suministra.

CREATE OR REPLACE VIEW artigos_vista
AS
SELECT a.art_codigo, a.art_nome, p.prv_nome
FROM artigos a
JOIN provedores p ON p.prv_id = a.art_provedor
WHERE a.art_codigo = 4065091;

-- Utilizar la vista para:
--  • Insertar los datos del artículo '4065091' que existe en la tabla artículos, 
-- 		suministrado por el proveedor 1 que existe en la tabla de proveedores.
--  • Insertar los datos del artículo '0001122' que no existe en la tabla artículos,
--		suministrado por el proveedor 100 que no existe en la tabla de proveedores.
--  • Insertar los datos del artículo '0001122' que no existe en la tabla artículos, 
--  	suministrado por el proveedor 1 que existe en la tabla de proveedores.
--  • Consultar los datos ordenados alfabéticamente por el nombre del artículo.

INSERT INTO artigos_vista (art_codigo, p.prv_nome)
VALUES ();

SHOW CREATE VIEW artigos_vista;

SELECT * FROM artigos_vista;


-- 2. Crear una vista sin CHECK OPTION asociada a la tabla detalle_ventas que muestra
-- código de artículo y número total de unidades vendidas ordenados por código. 
-- Utilizar la vista para consultar los datos y comprobar si es posible utilizarla con 
-- INSERT, DELETE o UPDATE.
CREATE OR REPLACE VIEW detalles_ventas_vista
AS
SELECT dv.dev_artigo, SUM(dv.dev_cantidade) AS unidades_vendidas
FROM detalle_vendas dv
GROUP BY dv.dev_artigo;

SELECT * FROM detalles_ventas_vista;



-- 3. Crear una vista con CHECK OPTION que permita ver los datos de las ventas
-- realizadas en la tienda 30. Utilizar la vista para:
CREATE OR REPLACE VIEW ventas_tienda_30
AS
SELECT *
FROM vendas v  
WHERE v.ven_tenda = 30
WITH CASCADED CHECK OPTION;

SELECT * FROM ventas_tienda_30;

--  • Modificar el cliente de la venta 98 que existe en la tabla creada por la 
-- vista poniendo el cliente 101 que no existe en la tabla de clientes.
--  • Utilizar la vista para modificar el cliente de la venta 200 que no existe en la tabla creada por la vista poniendo el cliente 100 que existe en la tabla de clientes.
--  • Modificar el cliente de la venta 98 que existe en la tabla creada por la vista poniendo el cliente 100 que existe en la tabla de clientes.



-- 4. Crear una vista sin CHECK OPTION que permita mostrar código, nombre, stock, 
-- fecha de alta y proveedor de los artículos dados de alta antes del 1-1-2010, 
-- ordenados por proveedor, stock (de forma descendente) y código. 
-- Utilizar la vista para:
CREATE OR REPLACE VIEW artigos_alta
AS
SELECT a.art_codigo, a.art_nome, a.art_stock, a.art_alta, p.prv_id, p.prv_nome
FROM artigos a 
JOIN provedores p ON p.prv_id = a.art_provedor
WHERE a.art_alta < '2010-01-01';

SELECT * FROM artigos_alta;

--  • Eliminar el artículo de código '00112233' que no existe en la tabla que crea la vista.
--  • Eliminar el artículo de código '00112233' que no existe en la tabla que crea la vista y está registrada en alguna venta.