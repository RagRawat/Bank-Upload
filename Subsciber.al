codeunit 50101 Subscribe
{
    trigger OnRun()
    begin

    end;

    //local [EventSubscriber]
    //Procedure ClearVendAppliedEntry()
    //OnAfterClearVendApplnEntryFields(VendLedgEntry);
    //[EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnAfterDeleteEvent', '', true, true)]


    //  EventSubscriberInstance = StaticAutomatic;

    //[EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterClearVendApplnEntryFields', '', true, true)]
    //procedure ClearVendAppliedEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry");
    //begin
    //    VendorLedgerEntry.AlreadyDone := FALSE;
    //    Message('What happen');
    //end;

    //[EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnDeleteVLE', '', false, false)]
    //local procedure OnDeleteVLE(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    //begin

    //  VendorLedgerEntry.AlreadyDone := FALSE;
    //  Message('What happen in OnDelete');
    //end;
    ////////////////
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure OnBeforeDeleteGenJnlLine(Rec: Record "Gen. Journal Line")
    var
        vendledEntry: Record "Vendor Ledger Entry";
    begin
        VendLedEntry.Reset;
        VendLedEntry.SetRange("Vendor No.", Rec."Account No.");
        VendLedEntry.setrange("Applies-to ID", rec."Applies-to ID");
        IF VendLedEntry.FindSet then begin
            vendledEntry.AlreadyDone := false;
            //Message('OnBefore Delte Trigger Call');
            vendledEntry.Modify()
        END;
    end;
    ///////////////////////
    //[EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeDeleteVLE', '', false, false)]
    //local procedure OnAfterDeleteEvent(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    //begin
    //    VendorLedgerEntry.AlreadyDone := FALSE;
    //    Message('What happen in OnDelete');
    //end;
}