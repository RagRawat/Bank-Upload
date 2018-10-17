table 50101 Bank
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; SendTo; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; VendorNo; code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(5; RemainingAmount; Decimal)
        {
            Caption = 'Remaining Amount';
            DataClassification = ToBeClassified;
        }
        field(6; PostingDate; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;

        }
        field(7; AlreadySent; Boolean)
        {
            Caption = 'Already Sent';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
        field(9; RemainingAmtLCY; Decimal)
        {
            Caption = 'Remaining Amount (LCY)';
            DataClassification = ToBeClassified;
        }
        field(10; CurrencyCode; Code[20])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(11; DocNo; code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(12; GenJouLineTemplate; code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
        }
        field(13; GenJouLineBatch; code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(14; BankAcc; Code[20])
        {
            Caption = 'Bank Account';
            DataClassification = ToBeClassified;
        }
        field(15; StartDate; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(16; EndDate; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(17; vendNo; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(18; PayMetCode; Code[20])
        {
            Caption = 'Bank Account';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}