/* Prática 18 – Lanchonete – o estoque e o log de preços
   Salve este arquivo como pratica-18.sql antes de começar. */
USE lanchonete;

-- passos 4 a 6: a trigger do estoque
DROP TRIGGER IF EXISTS tg_item_baixa_estoque;
DELIMITER //
CREATE TRIGGER tg_item_baixa_estoque AFTER INSERT ON item_pedido
FOR EACH ROW
BEGIN
  UPDATE estoque
  SET quantidade = quantidade - NEW.quantidade
  WHERE produto_codigo = NEW.produto_codigo
  AND unidade_codigo = (SELECT unidade_codigo FROM pedido WHERE numero = NEW.pedido_numero);
END //
DELIMITER ;
SHOW TRIGGERS;
select * from pedido;
-- passos 7 a 9: o log e a trigger de auditoria
CREATE TABLE log_preco_produto (
  id				INT AUTO_INCREMENT PRIMARY KEY,
  produto_codigo	INT NOT NULL,
  preco_antigo		DECIMAL(4, 2) NOT NULL,
  preco_novo		DECIMAL(4, 2) NOT NULL,
  alterado_em		DATETIME,
  usuario			VARCHAR(100) NOT NULL,
  FOREIGN KEY (produto_codigo) REFERENCES produto(codigo)
);
DROP TRIGGER IF EXISTS tg_produto_preco;
DELIMITER $$
CREATE TRIGGER tg_produto_preco AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
	IF OLD.preco_tabela <> NEW.preco_tabela THEN
    INSERT INTO log_preco_produto 
		(produto_codigo, preco_antigo, preco_novo, usuario, alterado_em)
	VALUES
		(OLD.codigo, OLD.preco_tabela,
        NEW.preco_tabela, CURRENT_USER(),
        NOW());
	END IF;
END $$
DELIMITER ;

-- passo 10: os testes do quadro 1
select * from item_pedido;
select * from produto;
select * from pedido;
INSERT INTO item_pedido (pedido_numero, produto_codigo, quantidade, preco_cobrado)
VALUES (11, 3, 2, 13.00);
select * from log_preco_produto;

-- passo 11: a ocorrência (pronta; não altere)
UPDATE produto SET preco_tabela = 9.00 WHERE codigo = 1;

-- passo 12: o que o log registrou (SELECT com JOIN)

