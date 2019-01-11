page 50100 "Bank List"
{

    PageType = Worksheet;
    SourceTable = "Bank";
    Caption = 'Bank List';
    ApplicationArea = All;
    UsageCategory = Tasks;
    DelayedInsert = true;
    SaveValues = true;
    AutoSplitKey = True;

    layout
    {
        area(content)
        {
            Group(VendInfo)
            {
                Caption = 'Vendor Information';
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                }
                field(Vend; Vend)
                {
                    Caption = 'Vendor Name';
                    TableRelation = Vendor;
                }
            }
            group(bankInfo)
            {
                Caption = 'Bank Information';
                field(BankAcc; BankAcc)
                {
                    Caption = 'Bank Account';
                    TableRelation = "Bank Account";
                }
                field(PaymentMetCode; PaymentMetCode)
                {
                    Caption = 'Payment Method Code';
                    TableRelation = "Payment Method";
                }
            }

            repeater(General)
            {
                field("SendTo"; "SendTo")
                {
                    ApplicationArea = All;
                }
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = All;
                }
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = All;
                }
                field("VendorNo"; "VendorNo")
                {
                    ApplicationArea = All;
                }
                field("Amount"; "Amount")
                {
                    ApplicationArea = All;
                }
                field(RemainingAmount; RemainingAmount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DataLoad)
            {
                Caption = 'Data Load';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = Database;
                trigger OnAction()
                var
                    VLE: Record "Vendor Ledger Entry";
                    Bnk: Record Bank;
                begin
                    if (StartDate = 0D) OR (EndDate = 0D) then
                        Error('%1', 'Please Enter valid Date');
                    if Vend = '' then
                        Error('%1', 'Please Enter valid Vendor Name');


                    if Vend <> '' then begin
                        VLE.Reset;
                        vle.SetRange("Vendor No.", Vend);
                        vle.Setrange("Posting Date", StartDate, EndDate);
                        vle.SetRange(AlreadyDone, false);
                        vle.SetRange(Open, True);
                        IF vle.findset then begin
                            //vle.CalcFields("Amount (LCY)");
                            //Message('%1', vle."Amount (LCY)");

                            // Deleting old data
                            bnk.Reset;
                            if not Bnk.IsEmpty then
                                Bnk.DeleteAll;
                            repeat
                                vle.CalcFields("Amount (LCY)");
                                VLE.CalcFields(Amount);
                                VLE.CalcFields("Remaining Amount");
                                vle.CalcFields("Remaining Amt. (LCY)");
                                Bnk.Init;
                                Bnk.GenJouLineTemplate := GenJouTemp;
                                bnk.GenJouLineBatch := GenJouBatch;
                                Bnk."Entry No" := vle."Entry No.";
                                bnk.VendorNo := vle."Vendor No.";
                                bnk.Amount := vle.Amount;
                                bnk.RemainingAmtLCY := vle."Remaining Amt. (LCY)";
                                bnk.PostingDate := vle."Posting Date";
                                Bnk.RemainingAmount := vle."Remaining Amount";
                                bnk."Amount(LCY)" := VLE."Amount (LCY)";
                                Bnk.CurrencyCode := vle."Currency Code";
                                Bnk.DocNo := vle."Document No.";
                                bnk.SendTo := false;
                                bnk.AlreadySent := vle.AlreadyDone;
                                bnk.Insert;
                            until vle.Next = 0;
                        end;
                    end;
                    BankPayment.check(StartDate, EndDate, Vend, BankAcc, PaymentMetCode);
                end;
            }
            action(SenttoPmtLine)
            {
                Caption = 'Sent to Payment Line';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = SendConfirmation;
                trigger OnAction()
                var
                    GJL: Record "Gen. Journal Line";
                    FrmBnk: Record Bank;
                    LineNo: Integer;
                    VLEUpload: Record "Vendor Ledger Entry";
                    GenJnlBatch: Record "Gen. Journal Batch";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    Tobank: Record Bank;
                    DocNo: code[20];
                    DocNo1: code[20];
                    FLAG: Boolean;
                begin
                    //if (StartDate = 0D) OR (EndDate = 0D) then
                    //    Error('%1', 'Please Enter valid Date');

                    //Validation
                    if Vend = '' then
                        Error('%1', 'Please Enter valid Vendor Name');
                    if BankAcc = '' then
                        Error('%1', 'Please Enter valid Bank Name');
                    if PaymentMetCode = '' then
                        Error('%1', 'Please enter valid Payment method');



                    FrmBnk.reset;
                    FrmBnk.SetRange(SendTo, True);
                    FrmBnk.SetRange(AlreadySent, false);
                    if FrmBnk.FindSet then Begin
                        GenJnlBatch.GET(GenJouTemp, GenJouBatch);
                        IF GenJnlBatch."No. Series" = '' THEN
                            EXIT;
                        CLEAR(NoSeriesMgt);
                        DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", FrmBnk.PostingDate);
                        GenJnlBatch.GET(GenJouTemp, GenJouBatch);
                        IF GenJnlBatch."No. Series" = '' THEN
                            EXIT;
                        CLEAR(NoSeriesMgt);
                        DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", FrmBnk.PostingDate);
                        FLAG := true;
                        repeat
                            GJL.reset;
                            gjl.SetRange("Journal Template Name", GenJouTemp);
                            GJL.SetRange("Journal Batch Name", GenJouBatch);
                            //IF GJL.IsEmpty THEN
                            //    LineNo := 10000;
                            //ELSE
                            if GJL.FindLast THEN begin
                                LineNo := GJL."Line No." + 10000;
                                DocNo1 := GJL."Document No.";
                                //INCSTR(DocNo);
                            END;
                            GJL.init;
                            //IF LineNo <> 0 THEN
                            GJL."Line No." := LineNo;// + 10000;
                            gjl."Journal Template Name" := GenJouTemp;
                            gjl."Journal Batch Name" := GenJouBatch;
                            //GJL."Line No." := GJL."Line No." + 10000;
                            GJL."Posting Date" := FrmBnk.PostingDate;
                            GJL."Document Type" := GJL."Document Type"::Payment;
                            IF FLAG = true then begin
                                GJL."Document No." := DocNo;
                                flag := false;
                            end ELSE
                                GJL."Document No." := INCSTR(DocNo1);
                            GJL.Description := GJL."Journal Template Name" + '  ' + GJL."Journal Batch Name" + '  ' + vend;
                            gjl."Account Type" := gjl."Account Type"::Vendor;

                            ///GJL."Account No." := Vend;
                            gjl.validate("Account No.", Vend);
                            IF GJL."Account No." = '' then
                                //GJL."Account No." := FrmBnk.VendorNo;
                                gjl.validate("Account No.", FrmBnk.VendorNo);
                            GJL."Amount (LCY)" := FrmBnk."Amount(LCY)";
                            //GJL.Amount := FrmBnk.Amount;
                            GJL.VALIDATE(Amount, FrmBnk.Amount);
                            GJL."Currency Code" := FrmBnk.CurrencyCode;
                            GJL."Bal. Account Type" := GJL."Bal. Account Type"::"Bank Account";
                            GJL.validate("Bal. Account No.", BankAcc);
                            //GJL."Bal. Account No." := BankAcc;
                            GJL."Applies-to ID" := GJL."Document No.";
                            GJL."Payment Method Code" := PaymentMetCode;
                            //Message(PaymentMetCode);
                            //Message(gjl."Payment Method Code");
                            gjl.insert;
                            // modify Vendor for appling 
                            VLEUpload.Reset;
                            VLEUpload.SetRange("Document No.", FrmBnk.DocNo);
                            VLEUpload.SetRange("Vendor No.", FrmBnk.VendorNo);
                            if VLEUpload.FindSet then begin
                                VLEUpload."Applies-to ID" := gjl."Document No.";
                                VLEUpload.AlreadyDone := true;
                                VLEUpload.modify;
                            END;
                            //VLEUpload."Closed by Entry No.":= FrmBnk."Entry No";


                        until FrmBnk.Next = 0;
                    End ELSE
                        message('Please select "Send to" in the sheet')
                END;
            }
            action(CheckDetails)
            {
                Caption = 'Check Details';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = CheckDuplicates;
                trigger OnAction()
                begin
                    BankPayment.check(StartDate, EndDate, Vend, BankAcc, PaymentMetCode);
                end;
            }
            action(BankJou)
            {
                Caption = 'Bank Journals';
                ApplicationArea = All;
                //Promoted = true;
                //PromotedIsBig = true;
                Image = Bank;
                RunObject = page "Payment Journal";
            }
        }
    }

    var
        Vend: code[20];
        StartDate: Date;
        EndDate: Date;
        BankAccount: Record "Bank Account";
        BankAcc: Code[20];
        PaymentMetCode: code[20];
        BankPayment: Codeunit BankUpdateManagement;
        GenJouTemp: code[20];
        GenJouBatch: Code[20];

    trigger OnOpenPage()

    begin
        GenJouTemp := 'PAYMENT';
        GenJouBatch := 'BANK';
    end;

}