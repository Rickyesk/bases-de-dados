DROP VIEW vendas;

CREATE VIEW vendas(ean, cat, ano, trimestre, dia_mes, dia_semana, distrito, concelho, unidades)
	AS SELECT 
		(SELECT ean FROM produto AS prod),
		(SELECT cat FROM produto AS categ),
		(SELECT distrito FROM ponto_de_retalho AS dist),
		(SELECT concelho FROM ponto_de_retalho AS conc),
		(SELECT unidades FROM evento_reposicao AS unid),
		(SELECT EXTRACT(YEAR FROM TIMESTAMP (SELECT instante FROM evento_reposicao)) AS ano),
		(SELECT EXTRACT(QUARTER FROM TIMESTAMP (SELECT instante FROM evento_reposicao)) AS trim),
		(SELECT EXTRACT(DAY FROM TIMESTAMP (SELECT instante FROM evento_reposicao)) AS dia),
		(SELECT EXTRACT(ISODOW FROM TIMESTAMP (SELECT instante FROM evento_reposicao)) AS dia_semana);


		