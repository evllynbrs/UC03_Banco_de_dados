/* Prática 19 – Lanchonete – perfis de acesso e backup
   Salve este arquivo como pratica-19.sql antes de começar. */
USE lanchonete;

-- passos 7 e 8: um GRANT para cada linha do quadro 1
-- GRANT privilegio ON lanchonete.tabela TO 'usuario'@'localhost';
GRANT SELECT ON lanchonete.vw_expedicao TO 'lanch_expedicao'@'localhost';
GRANT SELECT ON lanchonete.log_preco_produto TO 'lanch_qualidade'@'localhost';
GRANT SELECT ON lanchonete.produto TO 'lanch_qualidade'@'localhost';
GRANT SELECT, UPDATE ON lanchonete.produto TO 'lanch_gerente'@'localhost';
GRANT SELECT, INSERT ON lanchonete.pedido TO 'lanch_gerente'@'localhost';
GRANT SELECT, INSERT ON lanchonete.item_pedido TO 'lanch_gerente'@'localhost';
GRANT SELECT ON lanchonete.estoque TO 'lanch_gerente'@'localhost';
GRANT ALL PRIVILEGES ON lanchonete.* TO 'lanch_admin'@'localhost';
GRANT DELETE ON lanchonete.produto TO 'lanch_gerente'@'localhost';

-- passo 9: tirar uma permissão (REVOKE)
-- REVOKE privilegio ON lanchonete.tabela FROM 'usuario'@'localhost';
REVOKE DELETE ON lanchonete.produto FROM 'lanch_gerente'@'localhost';

-- passo 10: SHOW GRANTS FOR cada perfil
SHOW GRANTS FOR 'lanch_expedicao'@'localhost';
SHOW GRANTS FOR 'lanch_qualidade'@'localhost';
SHOW GRANTS FOR 'lanch_gerente'@'localhost';
SHOW GRANTS FOR 'lanch_admin'@'localhost'