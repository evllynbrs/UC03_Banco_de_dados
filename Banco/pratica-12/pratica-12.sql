/* Prática 12 – Lanchonete – os dados no banco
   Salve este arquivo como pratica-12.sql antes de começar. */
USE lanchonete;

INSERT INTO unidade (nome, endereco) VALUES
  ('Ponta Verde', 'Av. A, 1000'), ('Pajuçara', 'Rua B, 20'), ('Jatiúca', 'Rua C, 300');
INSERT INTO cliente (nome, telefone) VALUES
  ('Cliente 1', '99000-0001'), ('Cliente 2', '99000-0002'), ('Cliente 3', '99000-0003');
INSERT INTO produto (nome, preco_tabela) VALUES
  ('Açaí 300 ml', 12.00), ('Açaí 500 ml', 18.00), ('Tapioca de queijo', 13.00), ('Teste', 1.00);
INSERT INTO entregador (nome) VALUES ('Entregador 1'), ('Entregador 2');

-- passos 5 e 6: o pedido 1 e os itens
INSERT INTO pedido (data_hora, cliente_codigo, unidade_codigo, entregador_codigo) VALUES
('2026-10-03 19:10', 1, 1, 1);

INSERT INTO item_pedido (pedido_numero, produto_codigo, quantidade, preco_cobrado) VALUES 
(1, 1, 1, 12.00),
(1, 2, 1, 18.00),
(1, 3, 1, 13.00);

-- passos 8 e 9: o UPDATE e o DELETE
UPDATE unidade SET endereco = 'Av A, 100' WHERE codigo = 1;

DELETE FROM produto WHERE codigo = 4;

-- passo 11: o cliente 1 (depois de executar, ponha -- na frente)
-- DELETE FROM cliente WHERE codigo = 1

-- passos 13 e 14: a transação desfeita
START TRANSACTION;

UPDATE produto SET preco_tabela = preco_tabela * 2 WHERE codigo = 1;

SELECT nome, preco_tabela FROM produto WHERE codigo = 1; 
