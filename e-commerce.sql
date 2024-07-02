create database ecommerce;
use ecommerce;
show tables;

-- criando tabela Cliente --

create table cliente(
	idClient INT AUTO_INCREMENT,
	Fname VARCHAR(15),
	Minit VARCHAR(3),
	Lname VARCHAR(20),
	CPF CHAR(11) NOT NULL,
	Adress VARCHAR(30),
	CONSTRAINT unique_cpf_client UNIQUE (CPF),
	PRIMARY KEY(idClient)
);

-- Agora vou Atualizar 'Adress' e corrigir a ortografia
alter table cliente change Adress Address VARCHAR(255);
alter table cliente auto_increment=1;
desc cliente;

-- Criando a tabela Produto --
CREATE TABLE produto(
	idProduto INT AUTO_INCREMENT,
	Pname VARCHAR(15) NOT NULL,
	Classification_kids BOOL DEFAULT FALSE,
	Category ENUM('Eletronico', 'Roupa', 'Brinquedos', 'Esportes', 'Comidas','Automotivos') NOT NULL,
	Feedback FLOAT DEFAULT 0,
	Size VARCHAR(10),
	PRIMARY KEY(idProduto)
);

alter table produto auto_increment=1;
                    
-- Criando tabela Pedido
CREATE TABLE pedidos(
	idPedido INT AUTO_INCREMENT,
	idPedidoClient INT,
	PedidoStatus ENUM('Cancelado', 'Confirmado', 'Em Processamento') DEFAULT 'Em Processamento',
	PedidoDescription VARCHAR(255),
	ShippingCost FLOAT DEFAULT 10,
	CONSTRAINT fk_pedidos_client FOREIGN KEY (idPedidoClient) references cliente(idClient),
	PRIMARY KEY(idPedido)   
);
alter table pedidos auto_increment=1;


-- Criando a tabela Estoque
CREATE TABLE produtoEstoque(
	idProdEstoque INT AUTO_INCREMENT,
	LocalEstoque VARCHAR(255),
	Quantidade INT DEFAULT 0,
	PRIMARY KEY(idProdEstoque)  
);

alter table produtoEstoque auto_increment=1;
                    
                    
-- Criando a tabela Fornecedor
CREATE TABLE fornecedor(
	idFornecedor INT AUTO_INCREMENT,
	NomeSocial VARCHAR(255) NOT NULL,
	CNPJ CHAR(15) NOT NULL,
	Contato CHAR(11) not null,
        CONSTRAINT unique_fornecedor UNIQUE (CNPJ),
	PRIMARY KEY(idFornecedor)
);

desc fornecedor;
alter table fornecedor auto_increment=1;
				
-- Criando a tabela Vendedor
CREATE TABLE vendedor(
	idVendedor INT AUTO_INCREMENT,
	NomeSocial VARCHAR(255) NOT NULL,
	CNPJ CHAR(15),
	CPF CHAR(9),
	Local VARCHAR(255),
	Contato CHAR(11) not null,
	CONSTRAINT unique_CNPJ_vendedor UNIQUE (CNPJ),
	CONSTRAINT unique_CPF_vendedor UNIQUE (CPF),
	PRIMARY KEY(idVendedor) 
);
                    
alter table vendedor auto_increment=1;


-- Criando relação M:N - Tabela produto/vendedor
create table produtoVendedor(
	idPvendedor INT,
	idPproduto INT,
	ProdQuantidade INT DEFAULT 1,
	PRIMARY KEY (idPvendedor, idPproduto),
	CONSTRAINT fk_produto_vendedor FOREIGN KEY (idPvendedor) REFERENCES vendedor(idVendedor),
	CONSTRAINT fk_produto_produto FOREIGN KEY (idPproduto) REFERENCES produto(idProduto)
);

-- M:N Produto/Pedido
create table produtoPedido(
	idPPproduto INT,
	idPPpedido INT,
	PpQuantidade INT DEFAULT 1,
	ppStatus ENUM('Disponivel', 'Sem Estoque') DEFAULT 'Disponivel',
	PRIMARY KEY (idPPproduto, idPPpedido),
	CONSTRAINT fk_produtoPedido_vendedor FOREIGN KEY (idPPproduto) REFERENCES produto(idProduto),
	CONSTRAINT fk_produtoPedido_produto FOREIGN KEY (idPPpedido) REFERENCES pedidos(idPedido)
);

-- M:N Estoque/Produto
create table estoqueLocal(
	idLproduto INT,
	idLestoque INT,
	local VARCHAR(255) NOT NULL,
	PRIMARY KEY (idLproduto, idLestoque),
	CONSTRAINT fk_estoque_local_produto FOREIGN KEY (idLproduto) REFERENCES produto(idProduto),
	CONSTRAINT fk_estoque_local_estoque FOREIGN KEY (idLestoque) REFERENCES produtoEstoque(idProdEstoque)
);                    
				
create table ProdutoFornecedor(
	idPfFornecedor INT,
	idPfProduto INT,
	Quantidade INT NOT NULL,
	PRIMARY KEY (idPfFornecedor, idPfProduto),
	CONSTRAINT fk_produto_fornecedor_fornecedor FOREIGN KEY (idPfFornecedor) REFERENCES fornecedor(idfornecedor),
	CONSTRAINT fk_produto_fornecedor_produto FOREIGN KEY (idPfProduto) REFERENCES produto(idProduto)
);     


show tables;

show databases;
use information_schema;
show tables;
desc referential_CONSTRAINTS;
select * from referential_constraints where CONSTRAINT_SCHEMA= 'ecommerce';
