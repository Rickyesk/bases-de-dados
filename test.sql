 drop table categoria cascade;
 drop table categoria_simples cascade;
 drop table super_categoria cascade;
 drop table tem_outra cascade;
 drop table produto cascade;
 drop table tem_categoria cascade;
 drop table ivm cascade;
 drop table ponto_de_retalho cascade;
 drop table instalada_em cascade;
 drop table prateleira cascade;
 drop table planograma cascade;
 drop table retalhista cascade;
 drop table responsável_por cascade;
 drop table evento_reposicao cascade;


create table categoria (
  nome VARCHAR(100) NOT NULL, 
  constraint pk_categoria primary key(nome)
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
  cat VARCHAR(100) NOT NULL,
  descr VARCHAR(100),
  primary key (ean),
  foreign key (cat) references categoria(nome)
);

create table tem_categoria (
  ean CHAR(13) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  primary key(ean, nome),
  foreign key (ean) references produto(ean),
  foreign key (nome) references categoria(nome)
);

create table ivm (
  num_serie CHAR(8) NOT NULL,
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
  num_serie CHAR(8) NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  locl VARCHAR(20) NOT NULL,
  primary key(num_serie, fabricante),
  foreign key (locl) references ponto_de_retalho(nome), ----Questionar stor sobre o local
  foreign key (num_serie, fabricante) references ivm(num_serie, fabricante)
);

create table prateleira (
  nro INT NOT NULL,
  num_serie CHAR(8) NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  altura INT NOT NULL,
  cat VARCHAR(100) NOT NULL, 
  primary key (nro, num_serie, fabricante),
  foreign key (num_serie, fabricante) references ivm(num_serie, fabricante),
  foreign key cat references categoria(nome)
);

create table planograma (
  ean CHAR(13) NOT NULL,
  nro INT NOT NULL,
  num_serie CHAR(8) NOT NULL,
  fabricante VARCHAR(100),
  faces INT NOT NULL,
  unidades INT NOT NULL,
  loc INT NOT NULL,
  primary key (ean, nro, num_serie, fabricante),
  foreign key (ean) references produto(ean),
  foreign key (nro, num_serie, fabricante) references prateleira(nro, num_serie, fabricante)
);

create table retalhista (
  tin CHAR(11) NOT NULL,
  nome VARCHAR(100) NOT NULL UNIQUE,
  primary key (TIN)
);

create table responsavel_por(
  num_serie CHAR(8) NOT NULL,
  fabricante VARCHAR(100) NOT NULL,
  tin CHAR(11) NOT NULL,
  nome_cat char(20) NOT NULL,
  primary key (num_serie, fabricante),
  foreign key (num_serie, fabricante) references ivm(num_serie, fabricante),
  foreign key (tin) references retalhista(tin),
  foreign key (nome_cat) references categoria(nome)
);

create table evento_reposicao(
  ean CHAR(13) NOT NULL,
  nro INT NOT NULL,
  num_serie CHAR(8) NOT NULL,
  fabricante VARCHAR(100),
  instante timestamp,
  units INT NOT NULL,
  tin CHAR(11) NOT NULL,
  primary key (ean, nro, num_serie, fabricante, instante),
  foreign key (tin) references retalhista(tin),
  foreign key (ean, nro, num_serie, fabricante) references planograma(ean, nro, num_serie, fabricante)
);