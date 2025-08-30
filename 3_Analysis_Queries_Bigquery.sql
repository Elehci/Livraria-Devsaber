SELECT
    C.Nome_Cliente,
    SUM(V.Quantidade * P.Preco_Produto) AS Valor_Total_Gasto
FROM `t1engenhariadados.livraria_devsabert1.Vendas` AS V
JOIN `t1engenhariadados.livraria_devsabert1.Clientes` AS C ON V.ID_Cliente = C.ID_Cliente
JOIN `t1engenhariadados.livraria_devsabert1.Produtos` AS P ON V.ID_Produto = P.ID_Produto
GROUP BY C.Nome_Cliente
ORDER BY Valor_Total_Gasto DESC;

SELECT
    P.Nome_Produto,
    SUM(V.Quantidade) AS Quantidade_Total_Vendida
FROM `t1engenhariadados.livraria_devsabert1.Vendas` AS V
JOIN `t1engenhariadados.livraria_devsabert1.Produtos` AS P ON V.ID_Produto = P.ID_Produto
GROUP BY P.Nome_Produto
ORDER BY Quantidade_Total_Vendida DESC
LIMIT 1;

SELECT
    C.Nome_Cliente,
    P.Nome_Produto,
    V.Data_Venda
FROM `t1engenhariadados.livraria_devsabert1.Vendas` AS V
JOIN `t1engenhariadados.livraria_devsabert1.Clientes` AS C ON V.ID_Cliente = C.ID_Cliente
JOIN `t1engenhariadados.livraria_devsabert1.Produtos` AS P ON V.ID_Produto = P.ID_Produto
ORDER BY V.Data_Venda;

CREATE VIEW t1engenhariadados.livraria_devsabert1.v_relatorio_vendas_detalhado AS
SELECT
    V.ID_Venda,
    V.Data_Venda,
    C.Nome_Cliente,
    C.Estado_Cliente,
    P.Nome_Produto,
    P.Categoria_Produto,
    V.Quantidade,
    P.Preco_Produto,
    (V.Quantidade * P.Preco_Produto) AS Valor_Total_Venda
FROM `t1engenhariadados.livraria_devsabert1.Vendas` AS V
JOIN `t1engenhariadados.livraria_devsabert1.Clientes` AS C ON V.ID_Cliente = C.ID_Cliente
JOIN `t1engenhariadados.livraria_devsabert1.Produtos` AS P ON V.ID_Produto = P.ID_Produto;

SELECT Nome_Cliente, Nome_Produto, Valor_Total_Venda
FROM t1engenhariadados.livraria_devsabert1.v_relatorio_vendas_detalhado
WHERE Estado_Cliente = 'SP'