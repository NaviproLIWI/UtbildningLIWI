pageextension 50201 "NPX LIWI Customer CardExt" extends "Customer Card"
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