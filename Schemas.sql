CREATE LOGIN Adancito WITH PASSWORD = 'Paramore11!*';
CREATE SCHEMA MIESQUEMA AUTHORIZATION Adancito
CREATE TABLE CAT_SEXOS(
	CAT_SEX_ID INTEGER PRIMARY KEY,
	CAT_SEX_DESC NVARCHAR(15) NOT NULL
)

CREATE SCHEMA MIESQUEMA AUTHORIZATION Adancito  
    CREATE TABLE CAT_SEXOS (CAT_SEX_ID INTEGER PRIMARY KEY, CAT_SEX_DESC NVARCHAR(15) NOT NULL)   
GO