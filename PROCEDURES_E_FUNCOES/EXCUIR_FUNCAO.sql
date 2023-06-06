CREATE FUNCTION Enderecocompleto2
(@ENDERECO VARCHAR(100),
@BAIRRO VARCHAR(50),
@CIDADE VARCHAR(50),
@ESTADO VARCHAR(2),
@CEP VARCHAR(20))
RETURNS VARCHAR(250)
AS
BEGIN
DECLARE @ENDERECO_COMPLETO VARCHAR(250)
SET @ENDERECO_COMPLETO = @ENDERECO + ' - ' + @BAIRRO + ' - ' + @CIDADE + ' - ' + @ESTADO + ' - ' + @CEP
RETURN @ENDERECO_COMPLETO
END

CREATE FUNCTION Enderecocompleto3
(@ENDERECO VARCHAR(100),
@BAIRRO VARCHAR(50),
@CIDADE VARCHAR(50),
@ESTADO VARCHAR(2),
@CEP VARCHAR(20))
RETURNS VARCHAR(250)
AS
BEGIN
DECLARE @ENDERECO_COMPLETO VARCHAR(250)
SET @ENDERECO_COMPLETO = @ENDERECO + ' - ' + @BAIRRO + ' - ' + @CIDADE + ' - ' + @ESTADO + ' - ' + @CEP
RETURN @ENDERECO_COMPLETO
END

DROP FUNCTION dbo.[Enderecocompleto2] -- excluir a fun��o

IF OBJECT_ID('Enderecocompleto2', 'FN') IS NOT NULL -- SERVE PARA VERIFICAR SE A FUN��O EXISTE E ASSIM DELETA ELAC
DROP FUNCTION dbo.[Enderecocompleto2] 