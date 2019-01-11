codeunit 50101 Subscribe
{
    // trigger OnRun()
    //begin

    //end;

    //local [EventSubscriber]
    //Procedure ClearVendAppliedEntry()
    //OnAfterClearVendApplnEntryFields(VendLedgEntry);
    //[EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnAfterDeleteEvent', '', true, true)]

    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterClearVendApplnEntryFields', '', true, true)]
    procedure ClearVendAppliedEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry");
    begin
        VendorLedgerEntry.AlreadyDone := FALSE;
    end;
}