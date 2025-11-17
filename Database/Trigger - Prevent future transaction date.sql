CREATE TRIGGER trg_PreventFutureTransactionDate
ON dbo.Transactions
AFTER INSERT
AS
BEGIN
    -- Check if any inserted row has a future date
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE transaction_date > GETDATE()
    )
    BEGIN
        RAISERROR('Transaction date cannot be in the future.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END


END;