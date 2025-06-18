pageextension 50206 "NPX LEA Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(Receiving)
        {
            field("NPX LEA Default Cargo Routing"; Rec."NPX LEA Default Cargo Routing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NPX LEA Default Cargo Routing field.', Comment = '%';
            }
        }
    }
}