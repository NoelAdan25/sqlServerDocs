USE [master]
GO
ALTER DATABASE [UPIITA_BASE] MODIFY FILE ( NAME = N'UPIITA_BASE', MAXSIZE = 204800KB , FILEGROWTH = 131072KB )
GO
ALTER DATABASE [UPIITA_BASE] MODIFY FILE ( NAME = N'UPIITA_BASE_log', FILEGROWTH = 131072KB )
GO


ALTER DATABASE [UPIITA_BASE]
MODIFY FILE
( NAME = 'estudiantes_upiita', 
   SIZE = 17,
   MAXSIZE = 100
 )

GO

ALTER DATABASE [UPIITA_BASE]
MODIFY FILE
( NAME = 'estudiantes_ipiita_log', 
   SIZE = 17,
   MAXSIZE = 100
 )
