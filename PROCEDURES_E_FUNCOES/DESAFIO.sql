CREATE FUNCTION FaturamentoBairro(@BAIRRO VARCHAR(50))
RETURNS FLOAT
AS
BEGIN
   DECLARE @FATURAMENTO FLOAT
   SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PREÇO]) FROM [ITENS NOTAS FISCAIS] INF
INNER JOIN [NOTAS FISCAIS] NF
ON INF.NUMERO = NF.NUMERO
INNER JOIN [TABELA DE CLIENTES] TC
ON TC.CPF = NF.CPF
WHERE TC.BAIRRO = @BAIRRO
RETURN @FATURAMENTO

END;

--#########################################################

DECLARE @BAIRRO VARCHAR(50), @CIDADE VARCHAR(50) 
DECLARE @LINHAS_BAIRRO INT, @CONTADOR INT
DECLARE @TABELA_BAIRROS TABLE ([BAIRRO] VARCHAR(50))

SET @CIDADE = 'Rio de Janeiro'
SET @CONTADOR = 0

SELECT @LINHAS_BAIRRO = COUNT(*) FROM (
SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = @CIDADE) X

WHILE @CONTADOR < @LINHAS_BAIRRO
BEGIN
    SELECT DISTINCT @BAIRRO = BAIRRO FROM [TABELA DE CLIENTES]
    WHERE CIDADE = @CIDADE
    ORDER BY BAIRRO
    OFFSET @CONTADOR ROWS
    FETCH NEXT 1 ROWS ONLY
    INSERT INTO @TABELA_BAIRROS (BAIRRO) VALUES (@BAIRRO)
    SET @CONTADOR = @CONTADOR + 1
END
SELECT * FROM @TABELA_BAIRROS ORDER BY BAIRRO

--#########################################################

CREATE PROCEDURE faturamentoDepartamento (@dataInicial DATE, @dataFinal DATE)
AS
BEGIN
DECLARE @DEPARTAMENTO TABLE (SABOR VARCHAR(20), DEPARTAMENTO VARCHAR(20))
INSERT INTO @DEPARTAMENTO 
SELECT DISTINCT SABOR, 'FRUTAS NÃO CÍTRICAS' as DEPARTAMENTO 
FROM [TABELA DE PRODUTOS] WHERE 
SABOR IN ('Açai','Cereja','Cereja/Maça','Maça','Manga','Maracujá','Melância')
UNION
SELECT DISTINCT SABOR, 'FRUTAS CÍTRICAS' as DEPARTAMENTO 
FROM [TABELA DE PRODUTOS] WHERE 
SABOR IN ('Laranja','Uva','Limão','Morango','Morango/Limão','Lima/Limão')
SELECT DP.[DEPARTAMENTO]
, SUM(INF.QUANTIDADE * INF.[PREÇO]) AS FATURAMENTO
FROM [TABELA DE PRODUTOS] TP
INNER JOIN [ITENS NOTAS FISCAIS] INF
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF
ON NF.NUMERO = INF.NUMERO
INNER JOIN @DEPARTAMENTO DP
ON TP.SABOR = DP.SABOR
WHERE NF.DATA >= @dataInicial AND NF.DATA <= @dataFinal
GROUP BY DP.[DEPARTAMENTO]
END

exec faturamentoDepartamento '2016-01-01','2016-01-15';

--#########################################################

DECLARE @NOME VARCHAR(200), @PERCENTUALCOMISSAO FLOAT
DECLARE CURSOR_FUNCIONARIOS CURSOR FOR SELECT NOME, [PERCENTUAL COMISSÃO]
FROM [TABELA DE VENDEDORES]
OPEN CURSOR_FUNCIONARIOS
FETCH NEXT FROM CURSOR_FUNCIONARIOS INTO @NOME, @PERCENTUALCOMISSAO
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @NOME + ', Comissão: ' + CAST(@PERCENTUALCOMISSAO AS VARCHAR(20))
    FETCH NEXT FROM CURSOR_FUNCIONARIOS INTO @NOME, @PERCENTUALCOMISSAO
END
CLOSE CURSOR_FUNCIONARIOS
DEALLOCATE CURSOR_FUNCIONARIOS

--#########################################################

DECLARE @data_venda DATE, @valor_venda MONEY
DECLARE @janeiro MONEY, @fevereiro MONEY, @marco MONEY, @abril MONEY, @maio MONEY, @junho MONEY,
        @julho MONEY, @agosto MONEY, @setembro MONEY, @outubro MONEY, @novembro MONEY, @dezembro MONEY

SET @janeiro = 6.500
SET @fevereiro = 8.200
SET @marco = 3.400
SET @abril = 7.200
SET @maio = 3.450
SET @junho = 12.600
SET @julho = 25.360
SET @agosto = 9987.600
SET @setembro = 798.700
SET @outubro = 7988.630
SET @novembro = 178963.40
SET @dezembro = 210.600

DECLARE CURSOR_VENDAS CURSOR FOR
    SELECT DATA_VENDA, PREÇO
    FROM [NOTAS FISCAIS],[ITENS NOTAS FISCAIS]

OPEN CURSOR_VENDAS

FETCH NEXT FROM CURSOR_VENDAS INTO @data_venda, @valor_venda 

WHILE @@FETCH_STATUS = 1
BEGIN
    IF MONTH(@data_venda) = 1
        SET @janeiro = @janeiro + @valor_venda
    IF MONTH(@data_venda) = 2
        SET @fevereiro = @fevereiro + @valor_venda
    IF MONTH(@data_venda) = 3
        SET @marco = @marco + @valor_venda
    IF MONTH(@data_venda) = 4
        SET @abril = @abril + @valor_venda
    IF MONTH(@data_venda) = 5
        SET @maio = @maio + @valor_venda
    IF MONTH(@data_venda) = 6
        SET @junho = @junho + @valor_venda
    IF MONTH(@data_venda) = 7
        SET @julho = @julho + @valor_venda
    IF MONTH(@data_venda) = 8
        SET @agosto = @agosto + @valor_venda
    IF MONTH(@data_venda) = 9
        SET @setembro = @setembro + @valor_venda
    IF MONTH(@data_venda) = 10
        SET @outubro = @outubro + @valor_venda
    IF MONTH(@data_venda) = 11
        SET @novembro = @novembro + @valor_venda
    IF MONTH(@data_venda) = 12
        SET @dezembro = @dezembro + @valor_venda
FETCH NEXT FROM CURSOR_VENDAS INTO @data_venda, @valor_venda 
		END
		PRINT 'Janeiro: ' + CAST(@janeiro AS VARCHAR(20))
PRINT 'Fevereiro: ' + CAST(@fevereiro AS VARCHAR(20))
PRINT 'Março: ' + CAST(@marco AS VARCHAR(20))
PRINT 'Abril: ' + CAST(@abril AS VARCHAR(20))
PRINT 'Maio: ' + CAST(@maio AS VARCHAR(20))
PRINT 'Junho: ' + CAST(@junho AS VARCHAR(20))
PRINT 'Julho: ' + CAST(@julho AS VARCHAR(20))
PRINT 'Agosto: ' + CAST(@agosto AS VARCHAR(20))
PRINT 'Setembro: ' + CAST(@setembro AS VARCHAR(20))
PRINT 'Outubro: ' + CAST(@outubro AS VARCHAR(20))
PRINT 'Novembro: ' + CAST(@novembro AS VARCHAR(20))
PRINT 'Dezembro: ' + CAST(@dezembro AS VARCHAR(20))

CLOSE CURSOR_VENDAS
DEALLOCATE CURSOR_VENDAS

--#########################################################

DECLARE @VENDEDOR_ALEATORIO VARCHAR(12)
DECLARE @VAL_INICIAL INT
DECLARE @VAL_FINAL INT
DECLARE @ALEATORIO INT
DECLARE @CONTADOR INT

SET @VAL_INICIAL = 1
SET @CONTADOR = 1
SELECT @VAL_FINAL = COUNT(*) FROM [TABELA DE VENDEDORES]
SET @ALEATORIO = dbo.[NumeroAleatorio](@VAL_INICIAL,@VAL_FINAL)
DECLARE CURSOR1 CURSOR FOR SELECT MATRICULA FROM [TABELA DE VENDEDORES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @VENDEDOR_ALEATORIO
WHILE @CONTADOR < @ALEATORIO
BEGIN
   FETCH NEXT FROM CURSOR1 INTO @VENDEDOR_ALEATORIO
   SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
SELECT @VENDEDOR_ALEATORIO, @ALEATORIO
SELECT * FROM [TABELA DE VENDEDORES]