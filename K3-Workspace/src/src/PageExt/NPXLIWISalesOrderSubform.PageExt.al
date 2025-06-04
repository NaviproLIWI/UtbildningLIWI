pageextension 50202 "NPX LIWIW SOS Extension" extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Test Code"; Rec."Test Code")
            {
                Caption = 'Test Code';
                ApplicationArea = all;

            }

        }
        // Add changes to page layout here
    }

}