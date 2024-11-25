pageextension 50200 "NPX LIWI Test Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field("Test Code"; Rec."Test Code")
            {
                ApplicationArea = all;
            }

        }

        addafter("Sell-to Customer No.")
        {
            field("NPX LIWI Test Field"; Rec."NPX LIWI Test Field")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Test Field field.', Comment = '%';
            }
        }
        addlast(General)
        {

            field("NPX LIWI Test Total Qty,"; Rec."NPX LIWI Test Total Qty,")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NPX LIWI Test Total Qty, field.', Comment = '%';
            }
            field("NPX LIWI Test No. of Lines"; Rec."NPX LIWI Test No. of Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NPX LIWI Test No. of Lines field.', Comment = '%';

            }


        }


    }

}