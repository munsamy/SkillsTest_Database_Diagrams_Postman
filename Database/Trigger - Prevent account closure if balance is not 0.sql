CREATE TRIGGER trg_PreventAccountClosure
ON dbo.Accounts
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if AccountOpen is being set to 0 while Balance is not zero
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN deleted d ON i.code = d.code
        WHERE i.IsOpen = 0         -- trying to close account
          AND d.IsOpen <> 0        -- was previously open
          AND i.outstanding_balance <> 0            -- balance is not zero
    )
    BEGIN
        RAISERROR('Cannot close account with non-zero balance.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;