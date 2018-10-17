//if user deletes from "Gen. journal line" table we have to modify "Vendor Ledger Entry" so we can syncronise.
tableextension 50121 GenJouLineExt extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
    }

    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedEntryModify: Record "Vendor Ledger Entry";
        GenJoLine: Record "Gen. Journal Line";

        //trigger OnDelete()
        //begin
        //Message("Applies-to ID");
        //VendLedEntry.Reset;
        //VendLedEntry.SetRange("Vendor No.", "Account No.");
        //VendLedEntry.setrange("Applies-to ID", "Applies-to ID");
        //IF VendLedEntry.IsEmpty then



        //IF VendLedEntry.FindSet then begin
        //   repeat
        //       VendLedEntry."Applies-to ID" := '';
        //       VendLedEntry.AlreadyDone := False;
        //       VendLedEntry.Modify;
        //   until VendLedEntry.Next = 0;
        //END;
        //end;
    LOCAL procedure ClearVendApplnEntryFields()
    begin
        VendLedgEntry.AlreadyDone := False;
        //Event OnAfterClearVendApplnEntryFields(VendLedgEntry);
    End;
}