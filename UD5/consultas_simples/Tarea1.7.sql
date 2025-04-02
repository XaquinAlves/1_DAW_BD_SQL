-- q0. Muestra a los clientes que no son de los siguientes países: 'Spain', 'USA', 'United Kingdom'.
-- Si desconocemos la nacionalidad de un cliente, debemos mostrarlo.
SELECT *
FROM Customer c 
WHERE c.Country NOT IN('Spain','USA', 'United kingdom') OR c.Country IS NULL
ORDER BY c.CustomerId;

-- q1. Todas las ventas tienen un margen de beneficio del 30%. Sobre la tabla facturas (Invoice)
-- muestra los campos InvoiceDate, BillingState, BillingCountry, Total y un campo nuevo llamado beneficio
-- con el beneficio que generó dicha factura. Filtra por facturas con un beneficio de al menos 10$ y ordena el
-- resultado de mayor a menor beneficio. Recuerda que cuando trabajamos con dólares sólo podemos mostrar 
-- cantidades con 2 decimales. Recuerda usar una tabla derivada.
SELECT *
FROM(
	SELECT i.InvoiceDate , i.BillingState , i.BillingCountry , i.Total ,ROUND( i.Total * 0.3, 2) AS beneficio
	FROM Invoice i 
) AS tabla_derivada 
WHERE beneficio >= 7
ORDER BY tabla_derivada.InvoiceDate, tabla_derivada.BillingState;

-- q2. Muestra los campos InvoiceDate, BillingState, BillingCountry, Total. De las facturas realizadas en
--  enero y febrero de 2017 que se han realizado desde los países USA, Germany o Canada. Ordena por fecha de factura.
SELECT i.InvoiceDate , i.BillingState , i.BillingCountry , i.Total 
FROM Invoice i 
WHERE  i.InvoiceDate >= '2010-01-01' AND i.InvoiceDate < '2010-03-01' AND i.BillingCountry IN ('USA','Germany','Canada')  
ORDER BY i.InvoiceDate;

-- q3. Muestra nombre, apellidos, pais y email de los clientes (customer) que viven en USA o Canada y
-- que tienen una cuenta de correo de Gmail (terminada en @gmail.com) o una cuenta de hotmail
-- (terminada en @hotmail.com). Ordena por apellidos y nombre.
SELECT c.FirstName , c.LastName , c.Country , c.Email 
FROM Customer c 
WHERE c.Country IN ('USA','Canada') AND ((c.Email LIKE '%@gmail.com') OR c.Email LIKE '%@hotmail.com')
ORDER by c.LastName, c.FirstName;

-- q4. Muestra las canciones (Tracks) compuestas por Angus Young o Steven Tyler (no tienen porque ser los 
-- únicos compositores) con una duración de entre 3 y 4 minutos, tamaño  no supere los 10MB. Ordena las canciones
-- por tamaño descendente.
SELECT *
FROM Track t 
WHERE (t.Bytes /(1024*1024)) < 10 AND (t.Milliseconds/60000 BETWEEN 3 AND 4) AND (t.Composer LIKE '%Steven Tyler%' OR t.Composer LIKE '%Angus Young%')
ORDER BY t.Bytes DESC;

-- q5. Muestra la duración media en minutos (alias duracion_min) y el peso en MB promedio (alias MB) 
-- de las canciones que existen en la base de datos.
SELECT (AVG(t.Milliseconds) / 60000) AS duracion_min, (AVG(t.Bytes / 1048576)) AS MB   
FROM Track t
ORDER BY duracion_min, MB;

-- q6. Muestra la duración media en minutos (alias duracion_min) y el peso en MB promedio (alias MB) de
-- las canciones que existen en la base de datos de las canciones que contienen la palabra Love en el título,
-- pertenezcan al género 1, 2 o 3 y tenga una duración de entre 3 y 5 minutos.
SELECT (AVG(t.Milliseconds) / 60000) AS duracion_min, (AVG(t.Bytes / 1048576)) AS MB    
FROM Track t 
WHERE t.Name LIKE '%Love%' AND t.GenreId IN (1,2,3) AND (t.Milliseconds / 60000) BETWEEN 3 AND 5
ORDER BY duracion_min, MB;

-- q7. Busca las canciones compuestas por Mercury (pueden ser colaboraciones) que duren más de 3 minutos,
-- pesen entre 6 y 12MB y pertenezcan al álbum 185 y 186  o sean del género 3.
SELECT *
FROM Track t 
WHERE t.Composer LIKE '%Mercury%' AND t.Milliseconds > 180000 AND t.Bytes BETWEEN 6291456 AND 12582912 AND
	(t.AlbumId IN (185,186) OR t.GenreId = 3)
ORDER BY t.TrackId;

-- q8. Busca a los clientes Canadienses o Estado unidenses que tienen un email de yahoo o gmail y tienen asignado
-- como support a 3, 4 o 5.
SELECT *
FROM Customer c 
WHERE c.Country IN ('Canada','USA') AND (c.Email LIKE '%@gmail.com' OR c.Email LIKE '%@yahoo.com') AND
	c.SupportRepId IN (3,4,5)
ORDER BY c.CustomerId; 

-- q9. Muestra a los clientes que no son de los siguientes países: 'USA', 'Canada' o 'India'.
-- Si no sabemos la nacionalidad del cliente, no mostramos su registro.
SELECT *
FROM Customer c 
WHERE c.Country NOT IN ('USA','Canada','India')
ORDER BY c.CustomerId;














