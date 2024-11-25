pageextension 50203 "NPX LIWI CL Extension" extends "Customer List"
{
    Caption = 'CL Extension';

    layout
    {
        addafter("No.")
        {
            field("Test Code"; Rec."Test Code")
            {
                Caption = 'Test Code';
                ApplicationArea = All;
            }
        }

        // Add changes to page layout here
    }

    actions
    {
        addafter(ShowLog)
        {
            action("Show Test Code")
            {
                Caption = 'Show Test Code';
                ApplicationArea = all;
                ToolTip = 'Open Page';
                Image = View;

                trigger OnAction()
                var
                    TestCodeRec: Record "NPX LIWI Test Table3";
                begin
                    Page.Run(Page::"NPX LIWI CardPage3", TestCodeRec);
                end;


            }

        }

        // Add changes to page actions here
    }

    var
        myInt: Integer;
}