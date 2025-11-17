CREATE TRIGGER trg_Transactions_Audit
ON dbo.Transactions
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Update INSERTed rows with Create info
    UPDATE t
    SET 
        CreateUser = ISNULL(i.CreateUser, SYSTEM_USER),  -- default to current SQL user
        CreateStation = ISNULL(i.CreateStation, HOST_NAME()),
        CreateDate = ISNULL(i.CreateDate, GETDATE())
    FROM dbo.Transactions t
    INNER JOIN inserted i ON t.code = i.code
    WHERE NOT EXISTS (
        SELECT 1 
        FROM deleted d 
        WHERE d.code = i.code
    );

    -- Update modified info
    UPDATE t
    SET
        ModifyUser = SYSTEM_USER,
        ModifyStation = HOST_NAME(),
        ModifyDate = GETDATE()
    FROM dbo.Transactions t
    INNER JOIN inserted i ON t.code = i.code;
END;