CREATE TRIGGER trg_PreventZeroTransaction
ON dbo.Transactions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check for any payments with Amount = 0 or NULL
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Amount IS NULL OR Amount = 0
    )
    BEGIN
        RAISERROR('Transaction amount must be greater than 0.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

END;