# Livraria-Devsaber
Mini Projeto SQL
Markdown
 Mini-Projeto: Pipeline de Dados e Análise com SQL no BigQuery
9d
Aluna: Michele Cristina Fonseca 
Grupo 3_14

1_ Visão Geral do Projeto.
Este projeto implementa um pipeline de dados completo para a Livraria DevSaber, uma loja online fictícia. O objetivo é estruturar os dados de vendas, que estavam originalmente em um formato de planilha, em um Data Warehouse no Google BigQuery. A partir dessa estrutura, são realizadas análises para extrair insights de negócio valiosos.

O pipeline consiste em três etapas principais:
1.Criação do Schema (DDL): Definição das tabelas Clientes, Produtos e Vendas.
2.Ingestão de Dados (DML): Inserção dos dados normalizados nas tabelas.
3.Análise e Automação: Execução de consultas analíticas e criação de uma VIEW para simplificar relatórios.

__
2.Estrutura do Banco de Dados Schema.
O schema foi modelado para ser normalizado, evitando redundância e garantindo a integridade dos dados.
Clientes: Armazena dados únicos dos clientes.
 ID_Cliente INT64: Identificador único do cliente.
 Nome_Cliente STRING: Nome do cliente.
 Email_Cliente STRING: Email do cliente.
 Estado_Cliente STRING: Estado de residência do cliente.
Produtos: Armazena dados únicos dos produtos.
ID_Produto INT64: Identificador único do produto.
Nome_Produto STRING: Nome do produto.
Categoria_Produto STRING: Categoria do produto.
Preco_Produto NUMERIC: Preço unitário do produto.
Vendas: Tabela de fatos que registra as transações, conectando clientes e produtos.
ID_Venda INT64: Identificador único da venda.
ID_Cliente INT64: Chave lógica que referencia a tabela Clientes.
ID_Produto INT64: Chave lógica que referencia a tabela Produtos.
Data_Venda DATE: Data em que a venda ocorreu.
Quantidade INT64: Quantidade de itens vendidos na transação.

__
3_Perguntas e Respostas Documentação.
Por que uma planilha não é ideal para uma empresa que quer analisar suas vendas a fundo?

Planilhas são ótimas para tarefas simples, mas se tornam ineficientes e arriscadas para análises de negócio por várias razões:
Redundância de Dados: Informações como nome e email de um cliente são repetidas a cada compra, aumentando a chance de erros de digitação e inconsistências.
Falta de Integridade: Não há como garantir que um produto ou cliente inserido em uma nova venda realmente exista ou que os dados como preço estejam corretos.
Dificuldade em Consultas Complexas: Cruzar informações ex: total de vendas por categoria de produto para clientes de SP é manual, complexo e lento.
Escalabilidade Limitada: Planilhas sofrem com grandes volumes de dados, ficando lentas e difíceis de gerenciar.

__
1) Se o BigQuery não tem chaves estrangeiras, como garantimos que um ID_Cliente na tabela de vendas realmente existe na tabela de clientes?

R) A responsabilidade pela integridade referencial é transferida do banco de dados para o desenvolvedor ou para o processo de ETL Extração, Transformação e Carga. No meu caso, garanti a integridade de duas formas:

A) Na Carga INSERT: Inseri primeiro os dados mestres Clientes e Produtos e só depois os dados transacionais Vendas, utilizando os IDs já existentes.
B) Na Consulta SELECT: Utilizei a cláusula INNER JOIN. Um INNER JOIN entre Vendas e Clientes ON Vendas.ID_Cliente = Clientes.ID_Cliente só retornará registros de vendas que possuam um cliente correspondente. Vendas com um ID_Cliente inválido seriam naturalmente excluídas do resultado, agindo como um filtro de integridade.

__
2) Qual é a principal vantagem de usar uma VIEW em vez de simplesmente salvar o código em um arquivo de texto?

R) A principal vantagem de uma VIEW é a abstração e o reuso com governança.
 Abstração: Ela esconde a complexidade dos JOINs e cálculos. Um analista pode simplesmente fazer SELECT  FROM v_relatorio_vendas_detalhado sem precisar saber como o Valor_Total_Venda é calculado ou como as tabelas são unidas.
 Consistência: Garante que todos na empresa usem a mesma lógica de negócio. Se a fórmula para calcular o valor total mudar, alteramos apenas na VIEW, e todos os relatórios que a utilizam são atualizados automaticamente. Um arquivo de texto não oferece essa centralização.
 Segurança: É possível conceder permissão de acesso à VIEW sem dar acesso direto às tabelas base.
__
3) Se o preço de um produto mudar na tabela Produtos, o Valor_Total na VIEW será atualizado automaticamente na próxima vez que a consultarmos?

R) Sim. Uma VIEW no BigQuery por padrão é uma entidade lógica, não materializada. Isso significa que ela não armazena os dados. Ela é, essencialmente, uma consulta salva. Toda vez que a VIEW é executada, o BigQuery roda a consulta SQL subjacente em tempo real sobre os dados mais atuais das tabelas. Portanto, se o preço de um produto for alterado na tabela Produtos, a VIEW refletirá esse novo preço imediatamente na próxima consulta.
