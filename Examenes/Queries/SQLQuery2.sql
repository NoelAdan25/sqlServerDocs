USE [UPIITA_BASE]
GO
CREATE USER [Usuarios] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[base_upiita]
GO

CREATE SCHEMA base_upiitas AUTHORIZATION Fernando
CREATE USER usuarios
FOR LOGIN Fernando
WITH DEFAULT SCHEMA = base_upiitas