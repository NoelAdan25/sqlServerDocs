-- Crear un respaldo en SQL server
CREATE DATABASE [hoyXD]
ON ( NAME = 'DATAUPIITA', 
   FILENAME = 'C:\Users\Adan\Desktop\UPIITA\Base de Datos Distribuidas\Respaldo\Hoy.mdf')
 AS SNAPSHOT OF DATAUPIITA;

 ;
 -- Sintaxis
CREATE DATABASE [estudiantes_upiita_respaldo]
	ON ( NAME = 'Nombre_Base_Datos', 
	FILENAME = 'Ruta\Respaldo\estudiantes_upiita.ss')
AS SNAPSHOT OF DATAUPIITA;


-- Procedimiento para ejecutar un
CREATE OR ALTER PROCEDURE SP_MAKE_BACKUP @BASENAME NVARCHAR(50), @PATH NVARCHAR(150)
AS
BEGIN	
	BACKUP DATABASE @BASENAME TO  DISK = @PATH 
	WITH NOFORMAT, NOINIT,  NAME = @BASENAME, 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
END;

EXEC.SP_MAKE_BACKUP 'DATAUPIITA', 'Ruta\Respaldo\test_db_back.mdf'

-- Hacer recuperación de la base de datos
USE MASTER;
RESTORE DATABASE DATAUPIITA FROM DATABASE_SNAPSHOT = 'hoyXD'