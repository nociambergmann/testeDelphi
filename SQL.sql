ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123';

create database mercado;

CREATE TABLE CLIENTES
(
    Codigo  INT not null,
    Nome    VARCHAR(50) not null,
    Cidade  VARCHAR(150) not null,
    UF      VARCHAR(2) not null,
    primary key (codigo),
    INDEX idx_CLIENTES_NOME(Nome),
    INDEX idx_CLIENTES_NOME_CID(Nome, Cidade)
);
/* 
CREATE INDEX idx_CLIENTES_CODIGO ON CLIENTES(Codigo);
alter table clientes add index idx_CLIENTES_NOME (Nome, Cidade);
*/
CREATE TABLE PRODUTOS
(
    Codigo       INT not null auto_increment,
    Descricao    VARCHAR(250) not null,
    Preco_Venda  float not null,
    primary key (Codigo),
    INDEX idx_PRODUTOS_DESC(Descricao)
);
/*INSERT CLIENTES*/
insert into CLIENTES values (1,'Maicon Bergmann', 'Blumeanu', 'SC');
insert into CLIENTES values (2,'Bruna', 'Gaspar', 'SC');
insert into CLIENTES values (3,'Flavia', 'Blumeanu', 'SC');
insert into CLIENTES values (4,'Iago', 'Blumeanu', 'SC');
insert into CLIENTES values (5,'Peter Richard', 'Blumeanu', 'SC');
insert into CLIENTES values (6,'Andriele', 'Blumeanu', 'SC');
insert into CLIENTES values (7,'Julio', 'Blumeanu', 'SC');
insert into CLIENTES values (8,'Diogo', 'Blumeanu', 'SC');
insert into CLIENTES values (9,'Ana', 'Blumeanu', 'SC');
insert into CLIENTES values (10,'Paula', 'Gaspar', 'SC');
insert into CLIENTES values (11,'Paula', 'Blumeanu', 'SC');
insert into CLIENTES values (12,'Maicon Azevedo', 'Gaspar', 'SC');
insert into CLIENTES values (13,'Peter', 'Pomerode', 'SC');
insert into CLIENTES values (14,'Ana Cristina', 'Pomerode', 'SC');
insert into CLIENTES values (15,'Eloana', 'Blumeanu', 'SC');
insert into CLIENTES values (16,'Eva', 'Blumeanu', 'SC');
insert into CLIENTES values (17,'Maicon Borges', 'Pomerode', 'SC');
insert into CLIENTES values (18,'Bruno', 'Indaial', 'SC');
insert into CLIENTES values (19,'Jessica', 'Indaial', 'SC');
insert into CLIENTES values (20,'Paola', 'Blumeanu', 'SC');
/*INSERT PRODUTOS*/
insert into PRODUTOS(Descricao, Preco_Venda) values ('Coca-Cola 2l', 7.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Feijão', 4.55);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Feijão', 5.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Feijão', 4.55);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Arroz', 5.90);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Arroz', 2.29);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Sal', 1.29);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Batata', 0.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Alho', 1.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Tomate', 1.29);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Maionese', 2.39);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Milho', 4.59);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Banana', 2.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Azeite', 7.39);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Maça', 1.39);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Ovo', 4.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Coca-Cola Lata', 3.49);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Pão', 7.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Pão', 9.89);
insert into PRODUTOS(Descricao, Preco_Venda) values ('Leite', 4.89);
   
CREATE TABLE PEDIDOS_DADOS_GERAIS
(
    Numero_Pedido   INT not null auto_increment,
    Data_Emissao    date not null,
    Codigo_Cliente  INT not null,
    Valor_Total     float not null,
    primary key (Numero_Pedido),
    INDEX idx_PEDIDOS_DADOS_GERAIS_CLIENTE(Codigo_Cliente),
    INDEX idx_PEDIDOS_DADOS_GERAIS_DATA(Data_Emissao),
    INDEX idx_PEDIDOS_DADOS_GERAIS_CLI_DATA(Codigo_Cliente, Data_Emissao)
);

CREATE TABLE PEDIDOS_PRODUTO
(
    AUTOINCREM      INT not null auto_increment,
    Numero_Pedido   INT not null,
    Codigo_Produto  INT not null,
    Quantidade      INT not null,
    Valor_Unit      float not null,
    Valor_Total     float not null,
    primary key (AUTOINCREM),
    FOREIGN KEY (Numero_Pedido) REFERENCES PEDIDOS_DADOS_GERAIS(Numero_Pedido),
    INDEX idx_PEDIDOS_DADOS_GERAIS_CLIENTE(Numero_Pedido),
    INDEX idx_PEDIDOS_DADOS_GERAIS_DATA(Codigo_Produto)
);


