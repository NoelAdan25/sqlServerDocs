-- 1.- ------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER TG_INSERTINTO_SECOND
ON PRIMERA
FOR INSERT
AS
BEGIN	
	DECLARE @IDU INT = (SELECT ID_PERSONA FROM inserted);
	DECLARE @LETRA NVARCHAR(50) = (SELECT LETRA FROM inserted);
	DECLARE @FECHA DATE = (SELECT FECHA FROM inserted);
	INSERT INTO SEGUNDA(ID_PERSONA_I,FECHA, LETRA,USUARIO)VALUES(@IDU, @FECHA, @LETRA,CURRENT_USER);
END;
INSERT INTO PRIMERA(ID_PERSONA, FECHA, LETRA)VALUES(1, GETDATE(), 'I')
-- 2.- ------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER TG_CONTADOR
ON CAT_EMPLEADOS
AFTER
DELETE,INSERT
AS
BEGIN
	SELECT COUNT(*) FROM inserted;
	IF(SELECT COUNT(*) FROM inserted) > 0
			UPDATE CAT_CONTEOS SET CAT_CON_CUENTA = CAT_CON_CUENTA + 1 WHERE CAT_CON_ID = 1;
	IF(SELECT COUNT(*) FROM deleted) > 0		
			UPDATE CAT_CONTEOS SET CAT_CON_CUENTA = CAT_CON_CUENTA - 1 WHERE CAT_CON_ID = 1;
END;
-- 3.- ------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER TG_CONTADOR_PRODUCTOS2
ON CAT_PRODUCTOS
AFTER
DELETE,INSERT
AS
BEGIN
	IF(SELECT COUNT(*) FROM inserted) > 0
			UPDATE CAT_CONTEOS SET CAT_CON_CUENTA = CAT_CON_CUENTA + 1 WHERE CAT_CON_ID = 2;
	IF(SELECT COUNT(*) FROM deleted) > 0		
			UPDATE CAT_CONTEOS SET CAT_CON_CUENTA = CAT_CON_CUENTA - 1 WHERE CAT_CON_ID = 2;
END;
-- 4.- ------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER TG_PRODUCTOS
ON CAT_PRODUCTOS
AFTER
DELETE
AS
BEGIN
	INSERT INTO HIST_CAT_PRODUCTOS SELECT CAT_PRO_ID, CAT_PRO_DESC, CAT_PRO_CANTIDAD, SYSDATETIME(), CURRENT_USER FROM deleted;
END;
-- 5.- ------------------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION FN_AREAS(@A INT, @B INT)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @AREA DECIMAL(18,2) = @A * @B;
	RETURN CAST(@AREA AS NVARCHAR(30)) + ' metros cuadrados';
END
-- 6.- ------------------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION FN_PERIMETRO(@A INT, @B INT)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @PERI DECIMAL(18,2) = 2*(@A + @B);
	RETURN CAST(@PERI AS NVARCHAR(30)) + ' metros';
END
-- 7.- ------------------------------------------------------------------------------------------
-- PROCEDIMIENTO	
	-- ESTADO 0->NO ADMITIDO, 1->ADMITIDO
CREATE OR ALTER PROCEDURE SP_DONACIONES
AS
BEGIN
	UPDATE CAT_PERSONAS SET CAT_PER_ESTADO = 1 WHERE CAT_PER_PESO > 50 AND CAT_PER_STATUS_PASAR = 0;
END;
-- TRIGGER
CREATE OR ALTER TRIGGER TG_DONADORES
ON CAT_PERSONAS
FOR	UPDATE
AS
BEGIN
	INSERT INTO DONADORES 
	SELECT TOP 5 CAT_PER_ID, CAT_PER_PESO FROM CAT_PERSONAS 
	WHERE CAT_PER_ESTADO = 1 ORDER BY 1;

	DELETE CAT_PERSONAS WHERE CAT_PER_ID IN(SELECT CAT_DON_ID FROM DONADORES);
	-- Pensamos que los donadores son limpiados por otro proceso cuando estos ya terminan la donación
END