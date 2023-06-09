SELECT CPF, NOME, [DATA DE NASCIMENTO] IDADE FROM [TABELA DE CLIENTES]

SELECT DATEDIFF (YEAR, '2000-01-01', GETDATE())

--Procedure que atualiza a idade do cliente
CREATE PROCEDURE CalculaIdade
AS
BEGIN
 UPDATE [TABELA DE CLIENTES] SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
END


INSERT INTO [TABELA DE CLIENTES]
(CPF, NOME, [ENDERECO 1], BAIRRO, CIDADE, ESTADO, CEP, [DATA DE NASCIMENTO], IDADE, SEXO, [LIMITE DE CREDITO], [VOLUME DE COMPRA], [PRIMEIRA COMPRA])
VALUES
('123123123', 'JOAO MACHADO', 'RUA PROJETADA A', 'MADUREIRA', 'Rio de Janeiro', 'RJ', '20000', '2000-01-01', 10, 'M', 12000, 12000, 1)


SELECT * FROM [TABELA DE CLIENTES] WHERE CPF = '123123123'

--executando a Procedure
EXEC [dbo].CalculaIdade