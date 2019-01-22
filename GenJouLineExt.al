//if user deletes from "Gen. journal line" table we have to modify "Vendor Ledger Entry" so we can syncronise.
tableextension 50121 GenJouLineExt extends "Gen. Journal Line"
{
    var
        VendLedEntry: Record "Vendor Ledger Entry";

    trigger OnBeforeDelete()
    begin
        //    VendLedEntry.Reset;
        //    VendLedEntry.SetRange("Vendor No.", "Account No.");
        //    VendLedEntry.setrange("Applies-to ID", "Applies-to ID");
        //    IF VendLedEntry.FindSet then;
        //    VendLedEntry.AlreadyDone := FALSE;
        ///    VendLedEntry.Modify;
        //OnBeforeDeleteVLE(VendLedEntry);
    End;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteVLE(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        //OnAfterDeleteEvent
    end;
    //VendLedgEntry: Record "Vendor Ledger Entry";
    //VendLedEntryModify: Record "Vendor Ledger Entry";
    //GenJoLine: Record "Gen. Journal Line";
    //subs: Codeunit Subscriber;

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
    //  [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnAfterDeleteEvent', '', true, true)]

    local procedure ItemOnAfterDelete(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean);
    BEGIN
        IF Rec.ISTEMPORARY THEN
            EXIT;
        // <perform operations>
    END;

    // event OnAfterClearVendApplnEntryFields()


    //LOCAL procedure ClearVendApplnEntryFields()
    //begin
    //    VendLedgEntry.AlreadyDone := False;
    //    VendLedgEntry.Modify;

    //End;

    //Local procedure OnAfterClearVendApplnEntryFields(VendLedgEntry: Record "Vendor Ledger Entry")
    //begin
    //    VendLedgEntry.AlreadyDone := False;
    //    VendLedgEntry.Modify;
    //END;
}