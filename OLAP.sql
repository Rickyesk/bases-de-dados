1. num dado período (i.e. entre duas datas), por dia da semana, por concelho e no total

	SELECT dia_semana, conc, SUM(unid) FROM (SELECT * FROM vendas WHERE instante BETWEEN *input1* AND *input2*) GROUP BY ROLLUP(dia_semana, conc)


2. num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total

	SELECT conc, categ, dia_semana, COUNT(dist) FROM vendas GROUP BY ROLLUP(conc, categ, dia_semana)