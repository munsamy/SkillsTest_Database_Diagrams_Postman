CREATE TRIGGER trg_UpdateAccountBalance
ON dbo.Transactions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the balance of accounts based on the inserted payments
    UPDATE a
    SET a.outstanding_balance = a.outstanding_balance + i.Amount  -- adjust + or - depending on your business logic
    FROM dbo.Accounts a
    INNER JOIN inserted i ON a.code = i.account_code;
END;