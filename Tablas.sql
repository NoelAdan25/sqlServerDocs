
CREATE TABLE USUARIOS(
	ID_UDUARIO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRES NVARCHAR(50),
	EDAD INT,
	USUARIO NVARCHAR(15),
	PASS NVARCHAR(10)
);
CREATE TABLE AUDITORIA_USUARIO(
	AUD_ID INT,
	NOMBRES NVARCHAR(50),
	EDAD INT,
	USUARIO NVARCHAR(15),
	PASS NVARCHAR(10),
	CREADOR NVARCHAR(100),
	FECHA DATETIME
);

CREATE TABLE [dbo].[CLIENTES_AUDITORIA](
	[ID_CLIENTE] [int] NOT NULL,
	[NOMBRE] [nvarchar](80) NOT NULL,
	[PATERNO] [nvarchar](80) NOT NULL,
	[MATERNO] [nvarchar](80) NOT NULL,
	[EDAD] [int] NULL,
	FECHA DATETIME NOT NULL,
	USUARIO [nvarchar](80) NOT NULL,
) ON [PRIMARY]