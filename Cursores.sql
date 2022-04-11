
-- 1.- 
-- 2.- El cursor entre todas las edades que sean pares
--- CURSOR CON PARAMETROS
-- TRAER A TODOS LOS CARLOS
DECLARE @CAT_ID AS NVARCHAR(50);
DECLARE C_V1 CURSOR FOR SELECT CAT_CLI_NAME FROM CAT_CLIENTES WHERE CAT_CLI_AGE%2 = 0;
BEGIN
	OPEN C_V1
		FETCH NEXT FROM C_V1 INTO @CAT_ID
			PRINT @CAT_ID
			WHILE @@FETCH_STATUS = 0
				FETCH NEXT FROM C_V1
				PRINT @CAT_ID
	CLOSE C_V1
	DEALLOCATE C_V1
END


/*
DECLARE @Nombre VARCHAR(50)
DECLARE @apPaterno VARCHAR(50)
DECLARE @apMaterno VARCHAR(50)
DECLARE @cursor CURSOR

SET @cursor = CURSOR FOR
      SELECT Nombre, ApPaterno, ApMaterno FROM C_Empleados WHERE Tipo = 'STAFF'
OPEN @cursor 
FETCH NEXT FROM @cursor INTO @Nombre, @apPaterno, @apMaterno
WHILE @@FETCH_STATUS = 0
BEGIN
 --- CODIGO
      PRINT @Nombre
FETCH NEXT FROM @cursor INTO @Nombre, @apPaterno, @apMaterno
END
CLOSE @cursor
DEALLOCATE @cursor*/