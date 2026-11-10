CREATE TABLE Produto (
id_produto INT AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
preco_unitario DECIMAL(10, 2) NOT NULL,
id_resina INT NOT NULL,
CONSTRAINT PK_produto PRIMARY KEY (id_produto),
CONSTRAINT FK_produto_Resina FOREIGN KEY (id_resina)
REFERENCES Resina(id_resina) ON DELETE RESTRICT ON UPDATE CASCADE
);
 
 CREATE TABLE Estoque (
 id_unidade INT,
 id_produto INT,
 quantidade INT NOT NULL DEFAULT 0,
 CONSTRAINT PK_Estoque PRIMARY KEY (id_unidade, id_produto),
 CONSTRAINT FK_Estoque_Uniodade FOREIGN KEY (id_unidade)
 REFERENCES Unidade(id_unidade) ON DELETE CASCADE,
 CONSTRAINT FK_Estoque_Produto FOREIGN KEY (id_produto)
 REFERENCES Produto(id_produto) ON DELETE CASCADE
 
 CREATE TABLE Pedido (
 id_pedido INT AUTO_INCREMENT,
 cnpj_cliente VARCHAR(18) NOT NULL,
 id_unidade_venda INT NOT NULL,
 data_pedido DATETIME DEFAULT 'Pendente',
 CONSTRAINT PK_Pedido PRIMARY KEY (id_pedido)
 CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (cnpj_cliente)
 REFERENCES Cliente(cnpj) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT FK_Pedido_Unidade FOREIGN KEY (id_unidade_venda)
 REFERENCES Unidade(id_unidade) ON DELETE RESTRICT
 );
 
 CREATE TABLE Item_pedido (
 id_pedido INT,
 id_produto INT,
 quantidade INT NOT NULL,
 preco_aplicado DECIMAL(10, 2) NOT NULL,
 CONSTRAINT Pk_Item_Pedido_Produto PRIMARY KEY (id_pedido, id_produto),
 CONSTRAINT Fk_Item_Pedido_Produto FOREIGN KEY (id_pedido)
 REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
 CONSTRAINT FK_Item_Pedido_Produto FOREIGN KEY (id_produto)
 REFERENCES Produto(id_produto) ON DELETE RESTRICT
 );