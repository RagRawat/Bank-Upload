codeunit 50100 BankUpdateManagement
{
    trigger OnRun()
    begin

    end;


    procedure check(StartDate: date; EndDate: date; Vend: code[20]; BankAcc: code[20]; PaymentMetCode: Code[20])
    var
        bankCheck: Record bank;
    begin
        if (StartDate = 0D) OR (EndDate = 0D) then
            Error('%1', 'Please Enter valid Date');
        if Vend = '' then
            Error('%1', 'Please Enter valid Vendor Name');
        if BankAcc = '' then
            Error('%1', 'Please Enter valid Bank Name');
        if PaymentMetCode = '' then
            Error('%1', 'Please enter valid Payment method');

        bankCheck.Reset;
        IF bankCheck.FindSet then begin

            if bankCheck."Entry No" <> 0 then begin
                repeat
                    bankCheck.GenJouLineTemplate := 'PAYMENT';
                    bankCheck.GenJouLineBatch := 'BANK';
                    bankCheck.StartDate := StartDate;
                    bankCheck.EndDate := EndDate;
                    bankCheck.vendNo := Vend;
                    bankCheck.BankAcc := BankAcc;
                    bankCheck.PayMetCode := PaymentMetCode;
                    bankCheck.Modify;
                until bankCheck.Next = 0;
            end;
        END;
    end;

    var
        myInt: Integer;
}