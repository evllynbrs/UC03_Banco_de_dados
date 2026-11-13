/* SA2 - Implementação e manipulação do banco de embalagens
   Aluno(a): Evellyn da Silva Barbosa
   Antes: execute o embalagens-base-sa2.sql. */
USE embalagens;

-- ETAPA 1: dados de teste (INSERT e UPDATE)
INSERT INTO ordem_producao(data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES	('2026-11-03', 5000, 4800, 200, 60, 1, 1),
		('2026-11-03', 5000, 4950, 50, 25, 1, 2),
        ('2026-11-04', 8000, 7650, 350, 160, 2, 3),
        ('2026-11-05', 3000, 2880, 120, 18, 3, 2),
        ('2026-11-05', 4000, 3900, 100, 48, 1, 1);
INSERT INTO expedicao (numero, data_saida, unidade_codigo, cliente_cnpj)
VALUES	(1, '2026-11-06', 1, '11.111.111/0001-11'),
		(2, '2026-11-06', 2, '22.222.222/0001-22');
INSERT INTO item_expedicao (expedicao_numero, produto_codigo, quantidade, preco_cobrado)
VALUES	(1, 1, 2000, 0.45),
		(1, 2, 2000, 0.12),
        (2, 3, 5000, 0.65);
UPDATE produto SET preco_table = 0.48 WHERE codigo = 1;

-- ETAPA 2: consultas 1 a 5
SELECT * FROM ordem_producao WHERE qtd_refugo > 100 ORDER BY qtd_refugo DESC;

SELECT produto_codigo, SUM(qtd_refugo) FROM ordem_producao GROUP BY produto_codigo ORDER BY SUM(qtd_refugo) DESC;

SELECT unidade_codigo, SUM(qtd_boa) FROM ordem_producao GROUP BY unidade_codigo HAVING SUM(qtd_boa) > 5000;

SELECT cliente.nome, expedicao.unidade_codigo, produto.nome, item_expedicao.quantidade, item_expedicao.quantidade * item_expedicao.preco_cobrado FROM item_expedicao
JOIN expedicao ON expedicao.numero = item_expedicao.expedicao_numero
JOIN cliente ON cliente.cnpj = expedicao.cliente_cnpj
JOIN produto ON produto.codigo = item_expedicao.produto_codigo;

SELECT * FROM cliente WHERE cnpj NOT IN (SELECT cliente_cnpj FROM expedicao);

-- ETAPA 3: view, procedure e trigger

-- View
CREATE OR REPLACE VIEW vw_refugo_produto 
	AS SELECT p.nomeo AS nome, SUM(o.qtd_refugo) AS total_refugo FROM ordem_producao o
	JOIN produto p ON o.produto_codigo = p.codigo
    GROUP BY p.codigo, p.nome

-- Procedure
DELIMITER //
CREATE PROCEDURE sp_registrar_item
(IN p_expedicao INT),
    (IN p_produto INT),
    (IN p_quantidade INT)
BEGIN
	DECLARE v_preco DECIMAL(8,2);
	SELECT preco_tabela INTO v_preco
	FROM produto 
    WHERE codigo = p.produto;
    
    INSERT INTO item_expedicao (expedicao_numero, produto_codigo, quantidade, preco_cobrado)
    VALUES (p_expedicao, p_produto, p_quantidade, v_preco);
END $$
DELIMITER $$

-- Trigger
DELIMITER //
CREATE TRIGGER tg_ordem_baixa_resina
	AFTER INSERT ON ordem_producao
    FOR EACH ROW
BEGIN 
	UPDATE estoque_resina
    SET quantidade_kg = quantidade_kg - NEW.consumo_kg
    WHERE codigo = NEW.produto_codigo
    ();
END //
DELIMITER ;


INSERT INTO ordem_producao (data_ordem, qtd_planejda, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES ('2026-11-09', 1000, 950, 50, 20, 2, 3);

SELECT * FROM estoque_resina
WHERE unidade_codigo = 2 AND resina_codigo = 3;

-- ETAPA 4: privilégios dos perfis e SHOW GRANTS
GRANT SELECT, INSERT ON embalagens.ordem_producao TO 'emb_operador'@'localhost';
GRANT SELECT ON embalagens.produto TO 'emb_operador'@'localhost';

GRANT SELECT ON embalagens.* TO 'emb-gerente'@'localhost';
GRANT ALTER ON embalagens_produto TO 'emb_gerente'@'localhost';

SHOW GRANTS FOR 'emb_operador'@'localhost';
SHOW GRANTS FOR 'emb_gerente'@'localhost';

USE embalagens;
SELECT COUNT(*) FROM ordem_producao;
SELECT COUNT(*) FROM item_expedicao;
SELECT COUNT(*) FROM produto;

use teste;
SELECT * FROM vw_refugo_produto;