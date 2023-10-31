show databases;

create database dbPadaria;

use dbPadaria;

create table fornecedores (
	idFornecedor int primary key auto_increment,
    nomeFornecedor varchar(50) not null,
    cnpjFornecedor varchar(20) not null,
    telefoneFornecedor varchar(20),
    emailFornecedor varchar(50) not null unique,
    cep varchar(9),
    enderecoFornecedor varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into fornecedores (nomeFornecedor, cnpjFornecedor, telefoneFornecedor, emailFornecedor, cep, enderecoFornecedor, numeroEndereco, bairro, cidade, estado) values 
("Vinicius de Souza", "52.582.435/0001-95", "(11) 99668-4596", "viniciusdesouza@gmail.com", "04848-000", "Avenida Joaquim Napoleão Machado", "638", "Jardim Santa Bárbara", "São Paulo", "SP");

select * from fornecedores;

create table produtos (
	idProduto int primary key auto_increment,
    nomeProduto varchar(50) not null,
    descricaoProduto text,
    precoProduto decimal(10,2) not null,
    estoqueProduto int not null,
    categoriaProduto enum("Pães", "Bolos", "Confeitaria", "salgados"),
    idFornecedor int not null,
    foreign key (idFornecedor) references fornecedores(idFornecedor)
);

insert into produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Torta de Frango c/ Catupiry", "A Torta de Frango com Catupiry é elaborada massa leve, recheio suculento, do jeitinho que você gosta. Experimente e apaixone- se!", "12.00", 20, "salgados", 1);
insert into produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Baguete", "Baguete tradição francesa au levain. Pão feito com fermentação natural, sem adição de melhoramentos. As farinhas são as verdadeiras 00 italianas, 100% naturais", "5.00", 30, "Pães", 1);

select * from produtos;
select * from produtos where categoriaProduto = "Pães";
select * from produtos where precoProduto < 50.00 order by precoProduto asc;

create table clientes (
	idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    cpfCliente varchar(15) not null unique,
    telefoneCliente varchar(20),
    emailCliente varchar(50) unique,
    cep varchar(9),
    enderecoCliente varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado) values
("Jennifer Mirella Mariah Campos", "946.740.472-93", "(11) 3630-8779", "jennifermirellacampos@live.com", "25947-000", "Rua Fiscal José Ventura",
 "641", "Cotia", "Guapimirim", "SP");
 
select * from clientes;
 
create table pedidos (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum("Pendente", "Finalizado", "Cancelado"),
    idCliente int not null,
    foreign key (idCliente) references clientes(idCliente)
);
 
insert into pedidos (statusPedido, idCliente) values ("Pendente", 1);
 
select * from pedidos;
select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;
 
create table itensPedidos (
	idItensPedidos int primary key auto_increment,
    idPedido int not null,
    idProduto int not null,
    foreign key (idPedido) references pedidos(idPedido),
    foreign key (idProduto) references produtos(idProduto),
    quantidade int not null
);
 
insert into itensPedidos (idPedido, idProduto, quantidade) values (1,1,2);
insert into itensPedidos (idPedido, idProduto, quantidade) values (1,2,3);

select itensPedidos.idItensPedidos, pedidos.idPedido, produtos.idProduto, clientes.nomeCliente, produtos.nomeProduto, produtos.precoProduto
from (itensPedidos inner join pedidos on itensPedidos.idPedido = pedidos.idPedido)
inner join produtos on itensPedidos.idProduto = produtos.idProduto
inner join clientes on produtos.idProduto = clientes.idCliente;