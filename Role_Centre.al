pageextension 50100 RoleCenter extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addbefore(Items)
        {
            action(BankProcess)
            {
                Caption = 'Bank Process';
                RunObject = page "Bank List";
                Promoted = true;
                PromotedIsBig = True;
            }
        }
    }


    var
        myInt: Integer;
}