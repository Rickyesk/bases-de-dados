DROP TRIGGER num_unidades_trig ON evento_reposicao IF EXISTS
DROP TRIGGER categoria_produto_prateleira_trig ON prateleira IF EXISTS


/* (RI-1) Uma Categoria não pode estar contida em si própria */

	CREATE OR REPLACE FUNCTION chk_conteudo_categoria_proc() 
	RETURNS TRIGGER AS $$ BEGIN 
	DECLARE N int;
	DECLARE cat VARCHAR(100) := '';
	DROP TEMPORARY TABLE IF EXISTS children;
	CREATE TEMPORARY TABLE children AS (SELECT super_categoria FROM tem_outra);
	DROP TEMPORARY TABLE IF EXISTS prev_children;
	CREATE TEMPORARY TABLE prev_children AS (SELECT * FROM children);
	SET N = (SELECT count(*) FROM children);
	WHILE (N > 0) DO
		DROP TEMPORARY TABLE IF EXISTS aux;
		CREATE TEMPORARY TABLE aux AS (SELECT super_categoria FROM categoria INNER JOIN prev_children C ON C.)
	RETURN NEW; 
	END; 
	$$ LANGUAGE plpgsql;

CREATE TRIGGER chk_conteudo_categoria
BEFORE INSERT ON tem_outra
FOR EACH ROW EXECUTE PROCEDURE che
 /* (RI-4) O número de unidades repostas num Evento de Reposição não pode exceder o número de unidades especificado no Planograma */

	CREATE OR REPLACE FUNCTION num_unidades_proc() 
	RETURNS TRIGGER AS $$ 
	DECLARE unid_reposicao INT := 0;
	DECLARE unid_planograma INT := 0;
	BEGIN 
		SELECT (SELECT unidades INTO unid_reposicao FROM evento_reposicao), (SELECT unidades INTO unid_planogram FROM planograma);
		IF unid_reposicao > unid_planograma THEN
			RAISE EXCEPTION ‘O número de unidades repostas num Evento de Reposição excede o número de unidades especificado no Planograma’;
		END IF;
	RETURN NEW; 
	END; 
	$$ LANGUAGE plpgsql;

	CREATE CONSTRAINT TRIGGER num_unidades_trig AFTER INSERT OR
	UPDATE ON evento_reposicao
	FOR EACH ROW EXECUTE PROCEDURE num_unidades_proc();


  /* (RI-5) Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos) uma das Categorias desse produto */

	CREATE OR REPLACE FUNCTION categoria_produto_prateleira_proc() 
	RETURNS TRIGGER AS $$ 
	DECLARE prod VARCHAR(100) := '';
	BEGIN 
		SELECT ean INTO prod FROM produto WHERE (ean IN tem_categoria AND ean IN planograma);
		IF prod IS NULL THEN
			RAISE EXCEPTION ‘O Produto não pode ser reposto porque não existe essa categoria na Prateleira’;
		END IF;
	RETURN NEW; 
	END; 
	$$ LANGUAGE plpgsql;

	CREATE CONSTRAINT TRIGGER categoria_produto_prateleira_trig AFTER INSERT OR
	UPDATE ON prateleira
	FOR EACH ROW EXECUTE PROCEDURE categoria_produto_prateleira_proc();
