pageextension 50204 "NPX LIWI Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("NPX LIWI No. of Lines"; Rec."NPX LIWI No. of Lines")
            {
                ApplicationArea = all;
                Caption = 'No. of Lines';
            }
            field("NPX LIWI No. of Item Lines"; Rec."NPX LIWI No. of Item Lines")
            {
                ApplicationArea = All;
                Caption = 'No. of Item Lines';
            }
            field("NPX LIWI No. of Ordered Items"; Rec."NPX LIWI No. of Ordered Items")
            {
                ApplicationArea = All;
                Caption = 'No. of Ordered Items';
            }
            field("NPX LIWI No. of Received Items"; Rec."NPX LIWI No. of Recieved Items")
            {
                ApplicationArea = All;
                Caption = 'No. of Received Items';
            }


        }

    }


}