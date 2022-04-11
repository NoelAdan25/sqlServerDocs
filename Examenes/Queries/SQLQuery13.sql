USE [UPIITA_BASE]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [usuarios]
GO
USE [UPIITA_BASE]
GO
ALTER ROLE [db_ddladmin] DROP MEMBER [usuarios]
GO

REVOKE ALL user_conta FROM [UPIITA_BASE];
GRANT SELECT 
ALTER ROLE [db_ddladmin] DROP MEMBER user_conta
ALTER ROLE [db_accessadmin] DROP MEMBER user_conta