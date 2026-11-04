/* Prática 15 – Lanchonete – juntando as tabelas
   Salve este arquivo como pratica-15.sql antes de começar. */
USE lanchonete;

-- pergunta 1:
SELECT pedido.numero, cliente.nome
FROM pedido
INNER JOIN cliente ON pedido.cliente_codigo = cliente.codigo;

-- pergunta 2:
SELECT pedido.numero, unidade.nome
FROM pedido
INNER JOIN unidade ON pedido.unidade_codigo = unidade.codigo
WHERE unidade.nome = 'Ponta Verde';

-- pergunta 3:
SELECT pedido.data_hora, produto.nome, item_pedido.quantidade
FROM pedido
INNER JOIN item_pedido ON pedido.numero = item_pedido.pedido_numero
INNER JOIN produto ON item_pedido.produto_codigo = produto. codigo
WHERE pedido.numero = 4;

-- pergunta 4:
SELECT produto.nome, SUM(item_pedido.quantidade) AS unidades_vendidas
FROM produto
INNER JOIN item_pedido ON produto.codigo = item_pedido.produto_codigo
GROUP BY produto.codigo, produto.nome
ORDER BY unidades_vendidas DESC;

-- pergunta 5:
SELECT produto.nome
FROM produto
LEFT JOIN item_pedido ON produto.codigo = item_pedido.produto_codigo
WHERE item_pedido.produto_codigo IS NULL;

-- pergunta 6:
SELECT cliente.nome
FROM cliente
LEFT JOIN pedido ON cliente.codigo = pedido.cliente_codigo
WHERE pedido.cliente_codigo IS NULL;

-- pergunta 7:
SELECT nome, preco_tabela
FROM produto
WHERE preco_tabela > (
	SELECT AVG(preco_tabela)
    FROM produto
);

-- pergunta 8:
SELECT AVG(total_pedidos) AS media_pedidos
FROM (
	SELECT COUNT(*) AS total_pedidos
    FROM pedido
    GROUP BY unidade_codigo
) AS t;