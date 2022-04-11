-- Procedimiento Almacenado
CREATE OR ALTER PROCEDURE SP_UPDATE_CLIENT @CUENTA INT
AS
BEGIN
	UPDATE CAT_CLIENTES SET CAT_CLI_SALARY = CAT_CLI_SALARY * 2
	WHERE CAT_CLI_OID = @CUENTA;
END

-- Funciones
CREATE OR ALTER FUNCTION FN_CONTAR_PERSONAS (@NOMBRE NVARCHAR(100))
RETURNS INT
AS
BEGIN		
	RETURN (SELECT COUNT(*) FROM CAT_CLIENTES WHERE CAT_CLI_NAME LIKE '%' +  @NOMBRE + '%');
END

-- Ejercicios

SELECT dbo.FN_CONTAR_PERSONAS('Martin')

CREATE OR ALTER PROCEDURE SP_CALL_CONTAR @NAME NVARCHAR(100)
AS
BEGIN
	DECLARE @VALUESS INT = 0;
	SET @VALUESS = dbo.FN_CONTAR_PERSONAS(@NAME);
	SELECT CASE @VALUESS 
	WHEN 1 THEN
	'Uno' 
	WHEN 0 THEN
	'Cero'
	END
END

EXEC SP_CALL_CONTAR 'Martin'