ALTER TABLE dbo.Accounts
ADD 
    CreateUser NVARCHAR(100)      NULL,
    CreateStation NVARCHAR(100)   NULL,
    CreateDate DATETIME           NULL,
    ModifyUser NVARCHAR(100)      NULL,
    ModifyStation NVARCHAR(100)   NULL,
    ModifyDate DATETIME           NULL;

ALTER TABLE dbo.Persons
ADD 
    CreateUser NVARCHAR(100)      NULL,
    CreateStation NVARCHAR(100)   NULL,
    CreateDate DATETIME           NULL,
    ModifyUser NVARCHAR(100)      NULL,
    ModifyStation NVARCHAR(100)   NULL,
    ModifyDate DATETIME    

ALTER TABLE dbo.Transactions
ADD 
    CreateUser NVARCHAR(100)      NULL,
    CreateStation NVARCHAR(100)   NULL,
    CreateDate DATETIME           NULL,
    ModifyUser NVARCHAR(100)      NULL,
    ModifyStation NVARCHAR(100)   NULL,
    ModifyDate DATETIME    