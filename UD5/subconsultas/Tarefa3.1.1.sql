/*
 * 1. Seleccionar código e peso dos artigos que teñen o peso máis pequeno có peso do
 *  artigo de código '077WN45'.
 */
 SELECT art.art_codigo , art.art_peso 
 FROM artigos art
 WHERE art.art_peso < (SELECT art2.art_peso 
  							FROM artigos art2 
  							WHERE art2.art_codigo = '077WN45' )
 ORDER BY art.art_codigo, art.art_peso;

/* 
 * 2. Seleccionar código, nome, peso e cor dos artigos da mesma cor có artigo de
 *  código '242C283', e que teñan un peso maior ou igual co peso medio de todos os artigos.
 */
SELECT art.art_codigo , art.art_nome , art.art_peso , art.art_color 
FROM artigos art
WHERE art.art_color = (SELECT art2.art_color 
						FROM artigos art2
						WHERE art2.art_codigo = '242C283')
AND art.art_peso >= (SELECT AVG(art3.art_peso) 
					 FROM artigos art3)
ORDER BY art.art_codigo, art.art_nome;

/*
 * 3. Seleccionar código da tenda e nome do xerente das tendas nas que se vendeu polo
 *  menos unha unidade do artigo de código ' 077WN45'.
 */
SELECT tda.tda_id , (SELECT emp.emp_nome 
				  	 FROM empregados emp 
					 WHERE emp.emp_id = tda.tda_xerente) AS nome_xerente
FROM tendas tda
WHERE tda.tda_id IN (
	SELECT ven.ven_tenda 
	FROM vendas ven
	WHERE ven.ven_id IN (
		SELECT dvn.dev_venda  
		FROM detalle_vendas dvn 
		WHERE dvn.dev_artigo =  '077WN45'
	)
)

/*
 * 4. Mostrar a lista de artigos cun prezo de venta maior có prezo de venta do artigo 
 * máis barato de cor negra. Obter o mesmo resultado nos dous casos seguintes:
 */
--  Utilizando any.
SELECT art.*
FROM artigos art
WHERE art.art_pv > ANY (SELECT art2.art_pv
					FROM artigos art2
					WHERE art2.art_color = 'Negro')
ORDER BY art.art_codigo;

-- Utilizando a función min().
SELECT art.*
FROM artigos art
WHERE art.art_pv > (SELECT MIN(art2.art_pv)
					FROM artigos art2
					WHERE art2.art_color = 'Negro')
ORDER BY art.art_codigo;

/* 
 * 5. Seleccionar código de artigo, nome do artigo e código do provedor para
 *  os artigos que subministra o provedor que ten o nome SEAGATE.
 */
SELECT  art.art_codigo , art.art_nome 
FROM artigos art
WHERE art.art_provedor = ANY (SELECT prv.prv_id 
						  FROM provedores prv
						  WHERE prv.prv_nome = 'SEAGATE')
ORDER BY art.art_codigo, art.art_nome;
-- utilizamos ANY porque o campo prv_nome non é unico

/* 
 * 6. Mostrar información do artigo máis caro, Seleccionando o seu código, nome,
 * prezo de venta e nome do provedor que o subministra.
 */ 
SELECT art.art_codigo , art.art_nome , art.art_pv 
FROM artigos art 
WHERE art.art_pv = (SELECT MAX(art2.art_pv)
					FROM artigos art2)
ORDER BY art.art_codigo, art.art_nome;
