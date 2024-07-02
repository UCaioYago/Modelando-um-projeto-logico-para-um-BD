use ecommerce;
-- inserindo dados

show tables;
desc cliente;
insert into cliente(Fname, Minit, Lname, CPF, Address)
values	('Antony','M','Fernando', 12345678987, 'rua armando de lavella 10, caxias - PI'),
	('Diego','O','Vilela', 98765432101,'rua farias 852, Centro - ES'),
	('Roberto','F','Antonio', 45678913158,'avenida alemao da silva 4856, Centro - BA');

desc produto;
insert into produto(Pname, Classification_kids, Category, Feedback, Size)
values	('Fone de ouvido',false,'Eletronico','4',null),
	('Boneco Mario',true,'Brinquedos','3',null),
	('Body Carters',true,'Roupa','5',null);

desc pedidos;
insert into pedidos (idPedidoClient, PedidoStatus, PedidoDescription, ShippingCost)
values	(1, default,'compra via aplicativo',null),
	(2,default,'compra via aplicativo',40),
	(3,'Confirmado',null,null);

desc produtoEstoque;
insert into produtoEstoque (LocalEstoque,Quantidade) 
values	('Bahia',7000),
	('Minas Gerais',200),
	('São Paulo',80);

insert into fornecedor (NomeSocial, CNPJ, contato)
values	('Almeida e filhos', 123456789123456,'21985474'),
	('Eletrônicos Silva',854519649143457,'21985484'),
	('Eletrônicos Valma', 934567893934695,'21975474');

insert into vendedor (NomeSocial, CNPJ, CPF, Local, Contato) 
values	('TudoTech', 123456789456321, null, 'Rio de Janeiro', 219946287),
	('Varejo da Nana',null,123456783,'Rio de Janeiro', 219567895),
	('Discovery de Kids',456789123654485,null,'São Paulo', 1198657484);

select * from produto;
insert into produtoVendedor (idPvendedor, idPproduto, prodQuantidade)
values	(1,23,80),
	(2,24,10);

select * from cliente;

-- Contando os clientes
select count(*) from cliente;

-- Recuperar pedidos de clientes
select c.idClient, Fname as Client_name, count(*) as Num_Pedidos
from cliente c
inner join pedidos o ON c.idCliente = o.idPedidoCliente
group by idClient;
