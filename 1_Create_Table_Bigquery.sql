CREATE OR REPLACE TABLE `t1engenhariadados.livraria_devsabert1.Clientes`(
  ID_Cliente INT64 NOT NULL,
  Nome_Cliente STRING,
  Email_Cliente STRING,
  Estado_Cliente STRING
);

CREATE TABLE `t1engenhariadados.livraria_devsabert1.Produtos`(
  ID_Produto INT64,
  Nome_Produto STRING,
  Categoria_Produto STRING,
  Preco_Produto NUMERIC
);

CREATE TABLE `t1engenhariadados.livraria_devsabert1.Vendas`(
  ID_Venda INT64, 
  ID_Cliente INT64,
  ID_Produto INT64,
  Data_Venda DATE,
  Quantidade INT64
);