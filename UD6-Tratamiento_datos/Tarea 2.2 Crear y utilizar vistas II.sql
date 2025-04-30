-- q1.Escriba una vista que se llame listado_pagos_clientes que muestre un listado 
-- donde aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos. 
-- La vista deberá tener las siguientes columnas: nombre y apellidos del cliente 
-- concatenados, teléfono, ciudad, pais, fecha_pago, total del pago, id de la transacción
CREATE OR REPLACE VIEW listado_pagos_clientes
AS
SELECT CONCAT(c.apellido_contacto,', ',c.nombre_contacto) AS cliente_nombre, 
	c.telefono, c.ciudad, c.pais, p.fecha_pago, p.total, p.id_transaccion
FROM cliente c 
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente;

SELECT * FROM listado_pagos_clientes;

-- q2.Escriba una vista que se llame listado_pedidos_clientes que muestre un listado 
-- donde aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos.
-- La vista deberá tener las siguientes columnas: nombre y apellidos del cliente 
-- concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido, 
-- fecha esperada, fecha de entrega y la cantidad total del pedido, que será la 
-- suma del producto de todas las cantidades por el precio de cada unidad, que 
-- aparecen en cada línea de pedido.
CREATE OR REPLACE VIEW listado_pedidos_clientes
AS
SELECT CONCAT(c.apellido_contacto,', ',c.nombre_contacto) AS cliente_nombre, 
	c.telefono, c.ciudad, c.pais, pe.codigo_pedido, pe.fecha_pedido, pe.fecha_esperada,
	pe.fecha_entrega, SUM(dp.cantidad * dp.precio_unidad) AS cantidad_total
FROM cliente c 
LEFT JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
JOIN detalle_pedido dp ON dp.codigo_pedido = pe.codigo_pedido
GROUP BY c.codigo_cliente, pe.codigo_pedido;

SELECT * FROM listado_pedidos_clientes;

-- q3.Utilice las vistas que ha creado en los pasos anteriores para devolver un 
-- listado de los clientes de la ciudad de Madrid que han realizado pagos.
SELECT *
FROM listado_pagos_clientes
WHERE ciudad = 'Madrid' AND fecha_pago IS NOT NULL;

-- q4.Utilice las vistas que ha creado en los pasos anteriores para devolver un 
-- listado de los clientes que todavía no han recibido su pedido.
SELECT *
FROM listado_pedidos_clientes
WHERE fecha_entrega IS NULL;

-- q5.Utilice las vistas que ha creado en los pasos anteriores para calcular el 
-- número de pedidos que se ha realizado cada uno de los clientes.
SELECT cliente_nombre, COUNT(codigo_pedido)
FROM listado_pedidos_clientes
GROUP BY cliente_nombre;

-- q6.Utilice las vistas que ha creado en los pasos anteriores para calcular el 
-- valor del pedido máximo y mínimo que ha realizado cada cliente.
SELECT cliente_nombre, MAX(cantidad_total) AS pedido_maximo, MIN(cantidad_total) AS pedido_minimo
FROM listado_pedidos_clientes
GROUP BY cliente_nombre;

-- q7.Modifique el nombre de las vista listado_pagos_clientes y asígnele el nombre 
-- listado_de_pagos. Una vez que haya modificado el nombre de la vista ejecute una 
-- consulta utilizando el nuevo nombre de la vista para comprobar que sigue funcionando 
-- correctamente.
RENAME TABLE listado_pagos_clientes TO listado_de_pagos;

SELECT * FROM listado_de_pagos;

-- q8.Elimine las vistas que ha creado en los pasos anteriores.
DROP VIEW IF EXISTS  listado_de_pagos, listado_pedidos_clientes;


