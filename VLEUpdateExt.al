tableextension 50120 VLEUpdate extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; AlreadyDone; Boolean)
        {
            Caption = 'Already Done';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}