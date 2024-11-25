pageextension 50204 "NPX LIWI Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("NPX LIWI No. of Lines"; Rec."NPX LIWI No. of Lines")
            {
                ApplicationArea = all;
            }

        }

    }


}