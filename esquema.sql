drop table categoria cascade;
drop table categoria_simples cascade;
drop table super_categoria cascade;
drop table tem_outra cascade;
drop table produto cascade;
drop table tem_categoria cascade;
drop table IVM cascade;
drop table ponto_de_retalho cascade;
drop table instalada_em cascade;
drop table prateleira cascade;
drop table planograma cascade;
drop table retalhista cascade;
drop table responsável_por cascade;
drop table evento_reposicao cascade;





create table categoria (
  nome VARCHAR(100) NOT NULL, 
  primary key(nome)
);

create table categoria_simples (
  nome VARCHAR(100) NOT NULL,
  primary key (nome),
  foreign key (nome) references categoria(nome)
);

create table super_categoria (
  nome VARCHAR(100) NOT NULL,
  primary key (nome),
  foreign key (nome) references categoria(nome)
);

create table tem_outra (
  super_categoria VARCHAR(100) NOT NULL,
  categoria VARCHAR(100) NOT NULL,
  primary key (categoria),
  foreign key (super_categoria) references super_categoria(nome),
  foreign key (categoria) references categoria(nome),
  check (super_categoria != categoria)
);

create table produto (
  ean CHAR(13) NOT NULL,
  descr VARCHAR(100),
  cat VARCHAR(100) NOT NULL,
  primary key (ean),
  foreign key (cat) references categoria(nome)
);

create table tem_categoria (
  ean INT NOT NULL,
  nome VARCHAR(20) NOT NULL,
  primary key(ean, nome),
  foreign key (ean) references produto(ean),
  foreign key (nome) references categoria(nome)
);

create table IVM (
  num_serie INT NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  primary key (num_serie, fabricante)
);

create table ponto_de_retalho (
  nome VARCHAR(20) NOT NULL,
  distrito VARCHAR(20) NOT NULL,
  concelho VARCHAR(20) NOT NULL,
  primary key (nome)
);

create table instalada_em (
  num_serie INT NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  local VARCHAR(20) NOT NULL,
  primary key(num_serie, fabricante)
  foreign key (local) references ponto_de_retalho(nome), ----Questionar stor sobre o local
  foreign key (num_serie, fabricante) references IVM(num_serie, fabricante)
);

create table prateleira (
  nro INT NOT NULL,
  num_serie INT NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  altura INT NOT NULL,
  nome VARCHAR(20) NOT NULL, 
  primary key (nro, num_serie, fabricante),
  foreign key (num_serie, fabricante) references IVM(num_serie, fabricante)
  foreign key nome references categoria(nome)
);

create table planograma (
  ean CHAR(13) NOT NULL,
  nro INT NOT NULL,
  num_serie INT NOT NULL,
  frabricante VARCHAR(100)
  faces INT NOT NULL,
  unidades INT NOT NULL,
  loc INT NOT NULL,
  primary key (ean, nro, num_serie, fabricante),
  foreign key (ean) references produto(ean),
  foreign key (nro, num_serie, fabricante) references prateleira(nro, num_serie, fabricante)
);

create table retalhista (
  tin VARCHAR(20) NOT NULL,
  nome VARCHAR(100) NOT NULL UNIQUE,
  primary key (TIN)
);

creates table responsavel_por(
  num_serie INT NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  tin VARCHAR(20) NOT NULL,
  nome_cat char(20) NOT NULL,
  primary key (num_serie, fabricante),
  foreign key (num_serie, fabricante) references IVM(num_series, fabricante),
  foreign key (tin) references retalhista(tin),
  foreign key (nome_cat) references categoria(nome)
);

create table evento_reposicao(
  ean CHAR(13) NOT NULL,
  nro INT NOT NULL,
  num_serie INT NOT NULL,
  units INT NOT NULL,
  tin INT NOT NULL,
  instante timestamp,
  primary key (ean, nro, num_serie, fabricante, instante),
  foreign key (tin) references retalhista(tin),
  foreign key (ean, nro, num_serie, fabricante) references planograma(ean, nro, num_serie, fabricante)
);

---------------------------------------------------------------------------------------------------------
----Preenchendo a nossa base de dados
---------------------------------------------------------------------------------------------------------
--Popular Categoria
insert into categorias values ('Padaria');
insert into categorias values ('Croissant');
insert into categorias values ('Pao c/ chourico');
insert into categorias values ('Sandes c/ atum');
insert into categorias values ('Sandes c/ frango');
insert into categorias values ('Bebidas');
insert into categorias values ('Refrigerantes');
insert into categorias values ('Agua');
insert into categorias values ('Bebidas energeticas');
insert into categorias values ('Sumo Natural');
insert into categorias values ('Laticinios');
insert into categorias values ('Iogurte');
insert into categorias values ('Leite');
insert into categorias values ('Quentes');
insert into categorias values ('Leite c/ chocolate');
insert into categorias values ('Cafe');
insert into categorias values ('Cafe c/ leite');
insert into categorias values ('Pizza');
insert into categorias values ('Pizza c/ fiambre');
insert into categorias values ('Pizza c/ bacon');
insert into categorias values ('Pizza marguerita');
insert into categorias values ('Frios');


--Popular categoria simples
insert into categoria_simples values ('Croissant');
insert into categoria_simples values ('Pao');
insert into categoria_simples values ('Pizza');
insert into categoria_simples values ('Refrigerantes');
insert into categoria_simples values ('Agua');
insert into categoria_simples values ('Bebidas energeticas');
insert into categoria_simples values ('Sumo Natural');
insert into categoria_simples values ('Iogurte');
insert into categoria_simples values ('Leite');
insert into categoria_simples values ('Cafe');
insert into categoria_simples values ('Gelatina');



--Popular super categoria
insert into super_categorias values ('Padaria');
insert into super_categorias values ('Bebidas');
insert into super_categorias values ('Quentes');
insert into super_categorias values ('Frios');
insert into super_categorias values ('Laticinios');



--tem_outra:
insert into tem_outra values ('Quentes', 'Padaria');
insert into tem_outra values ('Padaria', 'Croissant');
insert into tem_outra values ('Padaria', 'Pao');
insert into tem_outra values ('Padaria', 'Pizza');


insert into tem_outra values ('Frios', 'Laticinios');
insert into tem_outra values ('Frios', 'Gelatina');

insert into tem_outra values ('Laticinios', 'Iogurte');
insert into tem_outra values ('Laticinios', 'Leite');

insert into tem_outra values ('Bebidas', 'Bebidas energeticas');
insert into tem_outra values ('Bebidas', 'Refrigerantes');
insert into tem_outra values ('Bebidas', 'Agua');
insert into tem_outra values ('Bebidas', 'Sumo Natural');
insert into tem_outra values ('Bebidas', 'Cafe');




--Produtos:
insert into produto values ('6159538343286', 'Pao' ,'Pao c/ chourico');
insert into produto values ('9134602126170', 'Pao' ,'Pao rustico');
insert into produto values ('4536390997950', 'Pao' ,'Pao de lo');
insert into produto values ('6921433830393', 'Pao' ,'Sandes c/ atum');
insert into produto values ('5611703510556', 'Pao' ,'Sandes c/ frango');
insert into produto values ('3545375898387', 'Pao' ,'Sandes mista');
insert into produto values ('8756961320587', 'Croissant' ,'Croissant misto');
insert into produto values ('2017340983057', 'Croissant' ,'Croissant c/ nutella');
insert into produto values ('6919675729906', 'Croissant' ,'Croissant simples');
insert into produto values ('2409687517723', 'Leite' ,'Leite c/ chocolate');
insert into produto values ('9591365572101', 'Leite' ,'Leite de aveia');
insert into produto values ('5795024633075', 'Leite' ,'Leite de soja');
insert into produto values ('6505742074894', 'Leite' ,'Leite de amendoa');
insert into produto values ('7288389634162', 'Cafe' ,'Cafe c/ chocolate');
insert into produto values ('8370015832279', 'Cafe' ,'Cafe c/ leite');
insert into produto values ('9924300330778', 'Pizza' ,'Pizza c/ fiambre');
insert into produto values ('5862905836242', 'Pizza' ,'Pizza c/ bacon');
insert into produto values ('8994203857339', 'Pizza' ,'Pizza marguerita');
insert into produto values ('2199724666618', 'Pizza' ,'Pizza c/ atum');
insert into produto values ('5053153129698', 'Sumo natural' ,'Sumo de laranja');
insert into produto values ('9530418213046', 'Sumo natural' ,'Sumo de maca');
insert into produto values ('4140129892604', 'Sumo natural' ,'Sumo de pera');
insert into produto values ('6368408070710', 'Sumo natural' ,'Sumo de morango');
insert into produto values ('8641639593327', 'Sumo natural' ,'Sumo de ananas');
insert into produto values ('2316313104916', 'Sumo natural' ,'Sumo de manga');
insert into produto values ('2028635168293', 'Sumo natural' ,'Sumo de frutos vermelho');
insert into produto values ('9968900727985', 'Agua' ,'Agua c/ limao');
insert into produto values ('1159151793743', 'Agua' ,'Agua c/ gas');
insert into produto values ('3028797255994', 'Agua' ,'Agua c/ frutos vermelhos');
insert into produto values ('8634847685022', 'Bebidas energeticas' ,'Gatorade');
insert into produto values ('9701994078920', 'Bebidas energeticas' ,'Redbull');
insert into produto values ('6608315624211', 'Bebidas energeticas' ,'Monster');
insert into produto values ('9123072697945', 'Bebidas energeticas' ,'Powerade');
insert into produto values ('4299157272235', 'Refrigerantes' ,'Coca-cola');
insert into produto values ('4554676872748', 'Refrigerantes' ,'Fanta laranja');
insert into produto values ('4583109804963', 'Refrigerantes' ,'Fanta ananas');
insert into produto values ('7953761298314', 'Refrigerantes' ,'Pepsi');
insert into produto values ('3563580189818', 'Refrigerantes' ,'Guarana');
insert into produto values ('5074239694257', 'Refrigerantes' ,'Iced-tea limao');
insert into produto values ('8720667803817', 'Refrigerantes' ,'Iced-tea pessego');
insert into produto values ('4347236000783', 'Refrigerantes' ,'Iced-tea manga');
insert into produto values ('4220272526259', 'Iogurte' ,'Iogurte Grego');
insert into produto values ('2099623285807', 'Iogurte' ,'Iogurte c/ frutos vermelhos');
insert into produto values ('2786149147964', 'Iogurte' ,'Iogurte c/ morangos');


-- tem_categoria
insert into tem_categoria values ('6159538343286', 'Pao');
insert into tem_categoria values ('9134602126170', 'Pao');
insert into tem_categoria values ('4536390997950', 'Pao');
insert into tem_categoria values ('6921433830393', 'Pao');
insert into tem_categoria values ('5611703510556', 'Pao');
insert into tem_categoria values ('3545375898387', 'Pao');
insert into tem_categoria values ('8756961320587', 'Croissant');
insert into tem_categoria values ('2017340983057', 'Croissant');
insert into tem_categoria values ('6919675729906', 'Croissant');
insert into tem_categoria values ('2409687517723', 'Leite');
insert into tem_categoria values ('9591365572101', 'Leite');
insert into tem_categoria values ('5795024633075', 'Leite');
insert into tem_categoria values ('6505742074894', 'Leite');
insert into tem_categoria values ('7288389634162', 'Cafe');
insert into tem_categoria values ('8370015832279', 'Cafe');
insert into tem_categoria values ('9924300330778', 'Pizza');
insert into tem_categoria values ('5862905836242', 'Pizza');
insert into tem_categoria values ('8994203857339', 'Pizza');
insert into tem_categoria values ('2199724666618', 'Pizza');
insert into tem_categoria values ('5053153129698', 'Sumo natural');
insert into tem_categoria values ('9530418213046', 'Sumo natural');
insert into tem_categoria values ('4140129892604', 'Sumo natural');
insert into tem_categoria values ('6368408070710', 'Sumo natural');
insert into tem_categoria values ('8641639593327', 'Sumo natural');
insert into tem_categoria values ('2316313104916', 'Sumo natural');
insert into tem_categoria values ('2028635168293', 'Sumo natural');
insert into tem_categoria values ('9968900727985', 'Agua');
insert into tem_categoria values ('1159151793743', 'Agua');
insert into tem_categoria values ('3028797255994', 'Agua');
insert into tem_categoria values ('8634847685022', 'Bebidas energeticas');
insert into tem_categoria values ('9701994078920', 'Bebidas energeticas');
insert into tem_categoria values ('6608315624211', 'Bebidas energeticas');
insert into tem_categoria values ('9123072697945', 'Bebidas energeticas');
insert into tem_categoria values ('4299157272235', 'Refrigerantes');
insert into tem_categoria values ('4554676872748', 'Refrigerantes');
insert into tem_categoria values ('4583109804963', 'Refrigerantes');
insert into tem_categoria values ('7953761298314', 'Refrigerantes');
insert into tem_categoria values ('3563580189818', 'Refrigerantes');
insert into tem_categoria values ('5074239694257', 'Refrigerantes');
insert into tem_categoria values ('8720667803817', 'Refrigerantes');
insert into tem_categoria values ('4347236000783', 'Refrigerantes');
insert into tem_categoria values ('4220272526259', 'Iogurte');
insert into tem_categoria values ('2099623285807', 'Iogurte');
insert into tem_categoria values ('2786149147964', 'Iogurte');



--IVM 
insert into IVM values ('19276429', 'Prozis');
insert into IVM values ('52980030', 'Prozis');
insert into IVM values ('91607771', 'Fanuc');
insert into IVM values ('77094863', 'Fanuc');
insert into IVM values ('88371507', 'Sandstar');
insert into IVM values ('50071819', 'Sandstar');
insert into IVM values ('17908245', 'Tecnovending');
insert into IVM values ('17286838', 'Tecnovending');


--ponto_de_retalho
insert into ponto_de_retalho values ('Aldi', 'Lisboa', 'Lisboa');
insert into ponto_de_retalho values ('Pingo Doce', 'Braga', 'Guimaraes');
insert into ponto_de_retalho values ('Auchan', 'Lisboa', 'Sintra');
insert into ponto_de_retalho values ('Pingo Doce', 'Portalegre', 'Monforte');
insert into ponto_de_retalho values ('Auchan', 'Beja', 'Ourique');
insert into ponto_de_retalho values ('Pingo Doce', 'Coimbra', 'Lousa');
insert into ponto_de_retalho values ('Galp', 'Portalegre', 'Elvas');
insert into ponto_de_retalho values ('Lidl', 'Leiria', 'Nazare');


--instalada em
insert into instalada_em values ('19276429', 'Prozis', 'Aldi');
insert into instalada_em values ('52980030', 'Prozis', 'Pingo Doce');
insert into instalada_em values ('91607771', 'Fanuc', 'Galp');
insert into instalada_em values ('77094863', 'Fanuc', 'Lidl');
insert into instalada_em values ('88371507', 'Sandstar', 'Continente');
insert into instalada_em values ('50071819', 'Sandstar', 'Auchan');
insert into instalada_em values ('17908245', 'Tecnovending', 'Galp');
insert into instalada_em values ('17286838', 'Tecnovending', 'Continente');


--prateleira
insert into prateleira values ('1', '19276429', 'Prozis', '11.19', 'Croissant');
insert into prateleira values ('2', '19276429', 'Prozis', '7.83', 'Pizza c/ fiambre');
insert into prateleira values ('3', '19276429', 'Prozis', '6.42', 'Laticinios');
insert into prateleira values ('4', '19276429', 'Prozis', '10.72', 'Sumo Natural');
insert into prateleira values ('5', '19276429', 'Prozis', '7.88', 'Sumo Natural');
insert into prateleira values ('6', '19276429', 'Prozis', '11.97', 'Laticinios');
insert into prateleira values ('1', '52980030', 'Prozis', '11.33', 'Iogurte');
insert into prateleira values ('2', '52980030', 'Prozis', '12.44', 'Laticinios');
insert into prateleira values ('3', '52980030', 'Prozis', '9.1', 'Bebidas energeticas');
insert into prateleira values ('4', '52980030', 'Prozis', '12.82', 'Iogurte');
insert into prateleira values ('5', '52980030', 'Prozis', '15.39', 'Refrigerantes');
insert into prateleira values ('6', '52980030', 'Prozis', '14.52', 'Sandes c/ frango');
insert into prateleira values ('1', '91607771', 'Fanuc', '9.59', 'Pizza marguerita');
insert into prateleira values ('2', '91607771', 'Fanuc', '14.49', 'Frios');
insert into prateleira values ('3', '91607771', 'Fanuc', '9.49', 'Pizza marguerita');
insert into prateleira values ('4', '91607771', 'Fanuc', '14.82', 'Pizza marguerita');
insert into prateleira values ('5', '91607771', 'Fanuc', '5.69', 'Croissant');
insert into prateleira values ('6', '91607771', 'Fanuc', '12.05', 'Padaria');
insert into prateleira values ('1', '77094863', 'Fanuc', '7.72', 'Refrigerantes');
insert into prateleira values ('2', '77094863', 'Fanuc', '5.27', 'Leite c/ chocolate');
insert into prateleira values ('3', '77094863', 'Fanuc', '11.62', 'Leite');
insert into prateleira values ('4', '77094863', 'Fanuc', '12.66', 'Sumo Natural');
insert into prateleira values ('5', '77094863', 'Fanuc', '12.65', 'Laticinios');
insert into prateleira values ('6', '77094863', 'Fanuc', '5.67', 'Leite');
insert into prateleira values ('1', '88371507', 'Sandstar', '5.89', 'Padaria');
insert into prateleira values ('2', '88371507', 'Sandstar', '14.78', 'Leite');
insert into prateleira values ('3', '88371507', 'Sandstar', '15.38', 'Laticinios');
insert into prateleira values ('4', '88371507', 'Sandstar', '8.17', 'Pao c/ chourico');
insert into prateleira values ('5', '88371507', 'Sandstar', '8.66', 'Cafe c/ leite');
insert into prateleira values ('6', '88371507', 'Sandstar', '5.24', 'Pizza');
insert into prateleira values ('1', '50071819', 'Sandstar', '11.95', 'Agua');
insert into prateleira values ('2', '50071819', 'Sandstar', '11.76', 'Sandes c/ frango');
insert into prateleira values ('3', '50071819', 'Sandstar', '10.0', 'Frios');
insert into prateleira values ('4', '50071819', 'Sandstar', '5.09', 'Pizza c/ bacon');
insert into prateleira values ('5', '50071819', 'Sandstar', '7.1', 'Pizza marguerita');
insert into prateleira values ('6', '50071819', 'Sandstar', '15.16', 'Agua');
insert into prateleira values ('1', '17908245', 'Tecnovending', '5.1', 'Sandes c/ frango');
insert into prateleira values ('2', '17908245', 'Tecnovending', '14.6', 'Quentes');
insert into prateleira values ('3', '17908245', 'Tecnovending', '11.7', 'Pizza c/ fiambre');
insert into prateleira values ('4', '17908245', 'Tecnovending', '11.29', 'Iogurte');
insert into prateleira values ('5', '17908245', 'Tecnovending', '7.02', 'Quentes');
insert into prateleira values ('6', '17908245', 'Tecnovending', '15.17', 'Bebidas energeticas');
insert into prateleira values ('1', '17286838', 'Tecnovending', '10.39', 'Refrigerantes');
insert into prateleira values ('2', '17286838', 'Tecnovending', '11.86', 'Refrigerantes');
insert into prateleira values ('3', '17286838', 'Tecnovending', '6.65', 'Pao c/ chourico');
insert into prateleira values ('4', '17286838', 'Tecnovending', '14.29', 'Laticinios');
insert into prateleira values ('5', '17286838', 'Tecnovending', '11.27', 'Leite');
insert into prateleira values ('6', '17286838', 'Tecnovending', '9.77', 'Quentes');


--planograma
insert into planograma values ('4299157272235', '1', '19276429', 'Prozis', '5', '20', '1');
insert into planograma values ('6919675729906', '2', '19276429', 'Prozis', '5', '15', '15');
insert into planograma values ('2017340983057', '3', '19276429', 'Prozis', '2', '18', '43');
insert into planograma values ('2028635168293', '4', '19276429', 'Prozis', '4', '24', '9');
insert into planograma values ('5795024633075', '5', '19276429', 'Prozis', '2', '4', '26');
insert into planograma values ('4536390997950', '6', '19276429', 'Prozis', '5', '10', '9');
insert into planograma values ('2017340983057', '1', '52980030', 'Prozis', '2', '10', '37');
insert into planograma values ('8720667803817', '2', '52980030', 'Prozis', '7', '28', '38');
insert into planograma values ('2409687517723', '3', '52980030', 'Prozis', '5', '30', '36');
insert into planograma values ('4299157272235', '4', '52980030', 'Prozis', '6', '30', '31');
insert into planograma values ('6368408070710', '5', '52980030', 'Prozis', '1', '10', '4');
insert into planograma values ('4220272526259', '6', '52980030', 'Prozis', '6', '18', '48');
insert into planograma values ('6505742074894', '1', '91607771', 'Fanuc', '5', '20', '27');
insert into planograma values ('5862905836242', '2', '91607771', 'Fanuc', '2', '16', '6');
insert into planograma values ('5053153129698', '3', '91607771', 'Fanuc', '7', '49', '4');
insert into planograma values ('9591365572101', '4', '91607771', 'Fanuc', '5', '40', '47');
insert into planograma values ('5611703510556', '5', '91607771', 'Fanuc', '6', '54', '41');
insert into planograma values ('9701994078920', '6', '91607771', 'Fanuc', '7', '14', '36');
insert into planograma values ('4347236000783', '1', '77094863', 'Fanuc', '3', '9', '45');
insert into planograma values ('9530418213046', '2', '77094863', 'Fanuc', '5', '30', '3');
insert into planograma values ('5074239694257', '3', '77094863', 'Fanuc', '4', '20', '50');
insert into planograma values ('2099623285807', '4', '77094863', 'Fanuc', '1', '3', '22');
insert into planograma values ('6608315624211', '5', '77094863', 'Fanuc', '2', '20', '24');
insert into planograma values ('2028635168293', '6', '77094863', 'Fanuc', '5', '15', '48');
insert into planograma values ('2316313104916', '1', '88371507', 'Sandstar', '6', '42', '23');
insert into planograma values ('9123072697945', '2', '88371507', 'Sandstar', '5', '50', '27');
insert into planograma values ('9924300330778', '3', '88371507', 'Sandstar', '1', '10', '7');
insert into planograma values ('3563580189818', '4', '88371507', 'Sandstar', '3', '30', '33');
insert into planograma values ('8756961320587', '5', '88371507', 'Sandstar', '1', '5', '25');
insert into planograma values ('6921433830393', '6', '88371507', 'Sandstar', '6', '30', '1');
insert into planograma values ('4220272526259', '1', '50071819', 'Sandstar', '1', '5', '18');
insert into planograma values ('8994203857339', '2', '50071819', 'Sandstar', '3', '9', '30');
insert into planograma values ('6505742074894', '3', '50071819', 'Sandstar', '6', '60', '48');
insert into planograma values ('1159151793743', '4', '50071819', 'Sandstar', '1', '8', '26');
insert into planograma values ('5074239694257', '5', '50071819', 'Sandstar', '3', '24', '38');
insert into planograma values ('4583109804963', '6', '50071819', 'Sandstar', '6', '30', '41');
insert into planograma values ('5053153129698', '1', '17908245', 'Tecnovending', '3', '27', '25');
insert into planograma values ('2017340983057', '2', '17908245', 'Tecnovending', '7', '35', '2');
insert into planograma values ('4583109804963', '3', '17908245', 'Tecnovending', '5', '10', '33');
insert into planograma values ('4140129892604', '4', '17908245', 'Tecnovending', '3', '9', '32');
insert into planograma values ('6919675729906', '5', '17908245', 'Tecnovending', '2', '8', '47');
insert into planograma values ('6921433830393', '6', '17908245', 'Tecnovending', '1', '5', '29');
insert into planograma values ('4140129892604', '1', '17286838', 'Tecnovending', '4', '36', '37');
insert into planograma values ('9123072697945', '2', '17286838', 'Tecnovending', '7', '28', '23');
insert into planograma values ('4347236000783', '3', '17286838', 'Tecnovending', '6', '36', '4');
insert into planograma values ('9123072697945', '4', '17286838', 'Tecnovending', '5', '20', '27');
insert into planograma values ('8634847685022', '5', '17286838', 'Tecnovending', '6', '36', '50');
insert into planograma values ('8370015832279', '6', '17286838', 'Tecnovending', '2', '18', '19');'