-- 1.- ------------------------------------------------------------------------------------------
SELECT * FROM AUDITORIA_USUARIO WHERE AUDITORIA_USUARIO.FECHA BETWEEN '2020-11-10' AND '2020-11-11';
-- 2.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_INSERT_CLI @NOMBRES NVARCHAR(50), @PAT NVARCHAR(50), @MAT NVARCHAR(50)
AS
BEGIN
	INSERT INTO CAT_EMPLEADOS(EMPLEADO, PAT, MAT)VALUES(@NOMBRES, @PAT, @MAT);
	COMMIT;
END
-- 3.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_SELECT_DATA @ID INT
AS BEGIN
	SELECT CD.CAT_DEP_ID "Numero Departamento", CD.CAT_DEP_DESC "Departamento", COUNT(CE.CAT_EMP_ID) "Numero de Personas" FROM CAT_DEPARTAMENTO CD INNER JOIN CAT_EMPLEADOS CE ON
	CD.CAT_DEP_ID = CE.DEPARTAMENTO
	WHERE CD.CAT_DEP_ID = @ID
	GROUP BY CD.CAT_DEP_ID, CD.CAT_DEP_DESC;
END;
-- 4.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_SELECT_DATA @NOMBRE NVARCHAR(50)
AS BEGIN
	SELECT CD.CAT_DEP_ID "Numero Departamento", CD.CAT_DEP_DESC "Nombre Departamento", COUNT(CE.EMPLEADO) "Numero Personas" FROM CAT_EMPLEADOS CE INNER JOIN CAT_DEPARTAMENTO CD ON CD.CAT_DEP_ID = CE.DEPARTAMENTO
	WHERE CE.EMPLEADO LIKE '%' +  @NOMBRE + '%'
	GROUP BY CE.EMPLEADO, CD.CAT_DEP_ID, CD.CAT_DEP_DESC;
END;
-- 5.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_TABLE_CREATE
AS
BEGIN
	IF OBJECT_ID('CAT_EMPLEADOS','U') IS NULL
		CREATE TABLE CAT_EMPLEADOS(
			CAT_EMP_ID INT PRIMARY KEY,
			CAT_EMP_DESC NVARCHAR(25) NOT NULL,
			EMPLEADO NVARCHAR(25),
			PAT NVARCHAR(25),
			MAT NVARCHAR(25)
		);
	IF OBJECT_ID('CAT_DIRECCIONES','U') IS NULL
		CREATE TABLE CAT_DIRECCIONES(
			CAT_DIC_ID INT PRIMARY KEY,
			CAT_DIC_DESC NVARCHAR(25) NOT NULL
		);
	IF OBJECT_ID('CAT_FOTOS','U') IS NULL
		CREATE TABLE CAT_FOTOS(
			CAT_FOT_ID INT PRIMARY KEY,
			CAT_FOT_DESC NVARCHAR(25) NOT NULL
		);
END;
-- 6.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_EMPLEADOS @ID INT, @DESCCRIPCION NVARCHAR(25)
AS BEGIN
	INSERT INTO CAT_EMPLEADOS(CAT_EMP_ID, CAT_EMP_DESC)VALUES(@ID, @DESCCRIPCION);
END;

CREATE OR ALTER PROCEDURE SP_DIRECCIONES @ID INT, @DESCCRIPCION NVARCHAR(25)
AS BEGIN
	INSERT INTO CAT_DIRECCIONES(CAT_DIC_ID, CAT_DIC_DESC)VALUES(@ID, @DESCCRIPCION);
END;

CREATE OR ALTER PROCEDURE SP_FOTOS @ID INT, @DESCCRIPCION NVARCHAR(25)
AS BEGIN
	INSERT INTO CAT_FOTOS(CAT_FOT_ID, CAT_FOT_DESC)VALUES(@ID, @DESCCRIPCION);
END;

CREATE OR ALTER PROCEDURE SP_CALL_PRODECURE_IN
AS BEGIN
	EXEC SP_EMPLEADOS 1, 'NUEVO';
	EXEC SP_DIRECCIONES 1, 'NUEVO';
	EXEC SP_FOTOS 1, 'NUEVO';
END;

-- 7.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_AVG @ID_DULCE INT
AS
BEGIN
	SELECT AVG(CD.CAT_PRECIO) "Promedio Precio" FROM CAT_DULCES CD WHERE CD.CAT_ID = @ID_DULCE AND CD.CAT_ALMACEN IN(SELECT CAT_ALMACEN FROM CAT_DULCES);
END;
-- 8.- ------------------------------------------------------------------------------------------
SELECT CURRENT_USER;
-- consulta las sesiones y número de veces
SELECT login_name ,COUNT(session_id) AS session_count,
FROM sys.dm_exec_sessions
GROUP BY login_name;  
-- 9.- ------------------------------------------------------------------------------------------
CREATE EVENT SESSION [Audi] ON SERVER 
ADD EVENT qds.query_store_size_retention_query_deleted,
ADD EVENT sqlserver.alter_table_update_data,
ADD EVENT sqlserver.auth_cache_update_begin,
ADD EVENT sqlserver.auth_cache_update_end,
ADD EVENT sqlserver.database_dropped,
ADD EVENT sqlserver.databases_bulk_insert_rows,
ADD EVENT sqlserver.databases_bulk_insert_throughput,
ADD EVENT sqlserver.memory_grant_updated_by_feedback,
ADD EVENT sqlserver.metadata_ddl_drop_column,
ADD EVENT sqlserver.stretch_table_hinted_admin_update_event
ADD TARGET package0.event_file(SET filename=N'C:\Auditorias.xel')
WITH (STARTUP_STATE=ON)
GO
-- 10.- ------------------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION FN_BISIESTO_fn (@ANIO INTEGER)
RETURNS NVARCHAR(15)
AS
BEGIN
	RETURN IIF(@ANIO%4 = 0, 'Bisiesto', 'No bisiesto');
END;
