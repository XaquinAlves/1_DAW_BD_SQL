-- q1. Obtener una lista de todos los artículos que tengan un precio de compra superior al precio de compra del
-- artículo con código ' 0713242'.
SELECT art.*
FROM artigos refer
JOIN artigos art ON art.art_pc > refer.art_pc 
WHERE refer.art_codigo = '0713242'
ORDER BY art.art_codigo;