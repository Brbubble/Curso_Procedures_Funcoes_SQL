DECLARE @NOME VARCHAR(200)
DECLARE CURSOR1 CURSOR FOR SELECT TOP 4 NOME FROM [TABELA DE CLIENTES] -- DECLARANDO O CURSOR E CARREGANDO ELA EM MEMORIA NO CURSOR1
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME
WHILE @@FETCH_STATUS = 0
BEGIN
PRINT @NOME
FETCH NEXT FROM CURSOR1 INTO @NOME
END

