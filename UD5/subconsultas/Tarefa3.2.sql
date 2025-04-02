/*
 * 1. Mostrar nome e prezo de venda dos artigos que teñen un prezo de venda 
 * comprendido entre o prezo do artigo '0713242' e a media de prezos de todos 
 * os artigos. Os datos deben mostrarse ordenados alfabeticamente polo nome do artigo.
 */
 SELECT art.art_nome , art.art_pv 
 FROM artigos art
 WHERE art.art_pv BETWEEN (SELECT art2.art_pv 
 						   FROM artigos art2
 						   WHERE art2.art_codigo = '0713242' 
 							)
 							AND (SELECT AVG(art3.art_pv)
 								 FROM artigos art3
 								)
 ORDER By art.art_nome ;

