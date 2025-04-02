/*
	1. Seleccionar todos los artículos negros, junto con los artículos que pesan más de 5000 gramos, escribiendo dos
 	consultas, y empleando el operador de unión de consultas.
*/
(SELECT art.* FROM artigos art WHERE art.art_color = 'Negro')
UNION
(SELECT art2.* FROM artigos art2 WHERE art2.art_peso > 5000)
ORDER BY art_codigo;

/*
	2. Para hacer un envío de cartas con información de una nueva campaña por correo postal, seleccionar apellidos,
 	nombre, dirección, código postal y población de todos  los clientes y de todos los empleados. En la lista hay que
 	diferenciar si la persona es cliente o empleado. Ordenar el resultado por orden alfabético de apellidos y nombre.
*/
(SELECT emp.emp_apelidos AS apelidos, emp.emp_nome AS nome, emp.emp_enderezo AS enderezo, emp.emp_cp AS cp,
	emp.emp_poboacion AS poboacion, 'Empregado' AS tipo FROM empregados emp)
UNION
(SELECT clt.clt_apelidos , clt.clt_nome , clt.clt_enderezo , clt.clt_cp , clt.clt_poboacion ,
	'Cliente' AS tipo FROM clientes clt)
ORDER BY apelidos, nome;