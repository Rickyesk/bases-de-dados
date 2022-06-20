/* Qual o nome do retalhista (ou retalhistas) responsáveis pela reposição do maior número de categorias? */

SELECT name
FROM (SELECT tin, Count()
FROM responsavel_por
GROUP BY tin) 
AS tab NATURAL JOIN retalhista
WHERE count >= ALL(SELECT Count()
                  FROM responsavel_por
                  	GROUP BY tin);

/* Qual o nome do ou dos retalhistas que são responsáveis por todas as categorias simples? */

SELECT name
FROM (SELECT tin, count(DISTINCT nome_cat)
FROM responsavel_por
WHERE nome_cat IN (SELECT * FROM categoria_simples)
GROUP BY tin AS TAB) NATURAL JOIN retalhista 
HAVING count = (SELECT count(*) FROM categoria_simples);


/* Quais os produtos (ean) que nunca foram repostos? */

	SELECT ean FROM produto WHERE ean NOT IN(SELECT ean FROM evento_reposicao);

/* Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista? */

	SELECT ean FROM evento_reposicao GROUP BY ean HAVING COUNT(distinct tin)=1;



SELECT categoria FROM tem_outra
WHERE categoria NOT IN (SELECT super_categoria 
FROM tem_outra)

SELECT nome
FROM (SELECT tin, count(DISTINCT nome_cat)
FROM responsavel_por
WHERE nome_cat IN (SELECT categoria FROM tem_outra
WHERE categoria NOT IN (SELECT super_categoria FROM tem_outra))
GROUP BY tin AS TAB) NATURAL JOIN retalhista
HAVING count 


SELECT name
FROM (SELECT tin, count(DISTINCT nome_cat)
FROM responsavel_por
WHERE nome_cat IN (SELECT * FROM categoria_simples)
GROUP BY tin AS TAB) NATURAL JOIN retalhista 
HAVING count = (SELECT count(*) FROM categoria_simples)
