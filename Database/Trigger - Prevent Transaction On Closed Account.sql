CREATE TRIGGER trg_PreventTransactionOnClosedAccount
ON dbo.Transactions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any payment is for a closed account
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Accounts a ON i.account_code = a.code
        WHERE a.IsOpen = 0
    )
    BEGIN
        RAISERROR('Cannot insert transaction for a closed account.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;