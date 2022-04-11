CREATE OR ALTER TRIGGER TG_PERMISOS
ON
HIST_REGISTROS_BITACORA
FOR INSERT
AS
BEGIN
	DECLARE @ID_USUARIO INT;
	DECLARE @USUARIO NVARCHAR(30);
	DECLARE @PERMISOS NVARCHAR(20);
	DECLARE @BASE NVARCHAR(20);
	DECLARE @QUERY NVARCHAR(MAX);
	DECLARE @EVENTO NVARCHAR(20);

	SET @ID_USUARIO = (SELECT HIST_USUARIO_ID FROM inserted);
	SET @USUARIO = (SELECT CAT_USU_NOMBRE FROM CAT_USUARIOS);
	SET @BASE = (SELECT HIST_REG_BASE FROM inserted);
	SET @QUERY = 'USE ' + @BASE + '; ' + @PERMISOS + ' ON SCHEMA ::[dbo] to ' + @USUARIO + ';';
	EXEC(@QUERY);
	SET @EVENTO = 'EXITOSO ' + @USUARIO;
	INSERT INTO HIST_AUDITORIA(HIST_AUDI_ID, HIST_EVENTO)VALUES((SELECT ISNULL(MAX(HIST_AUDI_ID),0) + 1 FROM HIST_AUDITORIA), @EVENTO)
END

