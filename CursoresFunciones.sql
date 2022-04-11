CREATE FUNCTION F_REST(@OP AS INT = 0)
RETURNS INT
AS
BEGIN
	DECLARE C_V1 CURSOR FOR SELECT CAT_CLI_AGE FROM CAT_CLIENTES;
	DECLARE @R AS INT = 0;
	DECLARE @V AS INT = 0;
	OPEN C_V1
		FETCH NEXT FROM C_V1 INTO @V
			WHILE(@@FETCH_STATUS = 0)
				BEGIN
					SET @R = @R + @V;
					FETCH NEXT FROM C_V1 INTO @V
				END
	Close C_V1
	DEALLOCATE C_V1
	RETURN @R;
END