-- 1.- ------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_NUEVO_EMPLEADO
	   @NOMBRE VARCHAR(20),
	   @ID     INT
	 
AS
DECLARE @APELLIDO AS VARCHAR(20);
DECLARE @EDAD AS INT;
DECLARE @SEXO AS VARCHAR(5);
DECLARE @DIRECCION AS VARCHAR(50);
DECLARE @FECHA AS VARCHAR(10);

SET @APELLIDO=NULL;
SET @EDAD=NULL;
SET @SEXO=NULL;
SET @DIRECCION=NULL;
SET @FECHA=NULL;

BEGIN
INSERT INTO CAT_EMPLEADOS  (
	   CAT_NOMBRE,
	   CAT_APELLIDO,
	   CAT_NUMID,
	   CAT_EDAD,
	   CAT_SEXO,
	   CAT_DIRECCION,
	   CAT_FECHA_INGRESO)
    VALUES (
	   @NOMBRE,
	   @ID,
	   @APELLIDO,
	   @EDAD,
	   @SEXO,
	   @DIRECCION,
	   @FECHA) 
END
-- 2.- ------------------------------------------------------------------------------------------
-- Solo devuelve años
CREATE OR ALTER FUNCTION FN_ANTIGUEDAD(	@FECHA date)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN 'Anios ' + CAST(YEAR(GETDATE()) - YEAR(@FECHA) AS NVARCHAR(20)) 
	+ ' Meses ' + CAST(MONTH(GETDATE()) - MONTH(@FECHA) AS NVARCHAR(20))
	+ ' Dias ' + CAST(DAY(GETDATE()) - DAY(@FECHA) AS NVARCHAR(20)); 
END;
-- 3.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_JEFES_JERAQUIA @ID INT
AS
BEGIN
WITH SEARCH AS
(    
    SELECT
		CR.ID_EMPLEADO, CR.ID_JEFE, 0 AS LEVEL
    FROM
		CAT_RELJEFES CR
    WHERE CR.ID_EMPLEADO = @ID
	UNION ALL
    SELECT
		CR.ID_EMPLEADO, CR.ID_JEFE, SEARCH.Level + 1 AS LEVEL
    FROM
		CAT_RELJEFES CR
    INNER JOIN SEARCH SEARCH on SEARCH.ID_JEFE = CR.ID_EMPLEADO
)
SELECT * FROM SEARCH ORDER BY SEARCH.LEVEL DESC;
END
-- 4.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_ANIOS_EMPLEADO(@MES INT)
AS
BEGIN
	SELECT CAT_EME_ID, CAT_EME_NOMBRE, (CAT_EME_EDAD + (YEAR(GETDATE()) - YEAR(CAT_EME_FECHA))) "Edad Actual"
	FROM CAT_EMPLEADOS_EMPRESA WHERE MONTH(CAT_EME_FECHA) = @MES;
END;
-- 5.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_VENTAS(@ID INT, @INICIO NVARCHAR, @FIN NVARCHAR)
AS
BEGIN
	SELECT CAST(ID_Empleado AS NVARCHAR(20)) AS ID, Tienda AS TIENDA, SUM(Ventas) AS TOTAL 
	FROM CAT_EMPLEADOS2 WHERE ID_Empleado = @ID AND Fecha BETWEEN @INICIO AND @FIN
	GROUP BY ID_Empleado,Tienda,Ventas
	UNION ALL
	SELECT 'TOTAL' AS ID, '' AS TIENDA, SUM(Ventas) AS TOTAL 
	FROM CAT_EMPLEADOS2 
	WHERE ID_Empleado = @ID AND Fecha BETWEEN @INICIO AND @FIN
END;
-- 6.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_VENTAS_DETALLE(@ID INT, @ANIO INT, @MES INT)
AS
BEGIN
	SELECT CAST(ID_Empleado AS NVARCHAR(20)) AS ID, Tienda AS TIENDA, MAX(Ventas) AS TOTAL 
	FROM CAT_EMPLEADOS2 WHERE ID_Empleado = @ID AND YEAR(Fecha) = @ANIO AND MONTH(Fecha) = @MES
	GROUP BY ID_Empleado,Tienda,Ventas
	UNION ALL
	SELECT 'TOTAL' AS ID, '' AS TIENDA, SUM(Ventas) AS TOTAL 
	FROM CAT_EMPLEADOS2 
	WHERE ID_Empleado = @ID AND YEAR(Fecha) = @ANIO AND MONTH(Fecha) = @MES;
END;
-- 7.- ------------------------------------------------------------------------------------------
	-- Yo considero que es mejor un procedimiento
CREATE OR ALTER PROCEDURE SP_MEJORTIENDA(@TIENDA NVARCHAR(30))
AS
BEGIN
	WITH CONSULTA AS(
		SELECT 
			DISTINCT(CE.Producto), 
			(SELECT SUM(C2.Cantidad) FROM CAT_EMPLEADOS2 C2 WHERE C2.Producto = CE.Producto) AS TOTAL 
				FROM CAT_EMPLEADOS2 CE
				WHERE TRIM(UPPER(CE.Tienda)) = TRIM(UPPER(@TIENDA))
	GROUP BY CE.Producto, CE.Cantidad)
	SELECT TOP 1 CONSULTA.Producto FROM CONSULTA;
END;
-- 8.- ------------------------------------------------------------------------------------------
	-- Yo considero que es mejor un procedimiento
CREATE OR ALTER PROCEDURE SP_MEJORTIENDA_VENTAS(@EMPLEADO INT)
AS
BEGIN
	WITH CONSULTA AS(
		SELECT 
			DISTINCT(CE.Tienda), 
			(SELECT SUM(C2.Cantidad) FROM CAT_EMPLEADOS2 C2 WHERE C2.Producto = CE.Producto) AS TOTAL 
				FROM CAT_EMPLEADOS2 CE
				WHERE CE.ID_Empleado = @EMPLEADO
	GROUP BY CE.Producto, CE.Cantidad,CE.Tienda)
	SELECT TOP 1 CONSULTA.Tienda FROM CONSULTA;
END;
-- 9.- ------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SP_VENTAS_ANIO(@EMPLEADO INT)
AS
BEGIN
	SELECT CAST(ID_Empleado AS NVARCHAR(20)) AS Id, 
		Tienda AS Tienda, 
		CAST(YEAR(Fecha) AS NVARCHAR(10)) "Año",
		SUM(Ventas) AS Total	
	FROM CAT_EMPLEADOS2 WHERE ID_Empleado = @EMPLEADO
	GROUP BY ID_Empleado,Tienda,Ventas, Fecha
	UNION ALL
	SELECT 'TOTAL' AS Id, '' AS Tienda, '' AS ANIO, SUM(Ventas) AS Total 
	FROM CAT_EMPLEADOS2 
	WHERE ID_Empleado = @EMPLEADO
END;
-- 10.- ------------------------------------------------------------------------------------------
	-- Considero que una vista podría ser mejor para optimizar las consultas
CREATE VIEW PRODUCTOS AS
	SELECT DISTINCT(Producto), (Ventas / Cantidad) Precio 
		FROM CAT_EMPLEADOS2 
GROUP BY Producto, Ventas, Cantidad;
	-- Procedimiento almacenado de consulta directa
CREATE OR ALTER PROCEDURE SP_CONSULTA_PRODUCTOS(@PRODUCTO NVARCHAR(30))
AS
BEGIN
	SELECT * FROM PRODUCTOS WHERE PRODUCTOS.Producto = @PRODUCTO;
END;