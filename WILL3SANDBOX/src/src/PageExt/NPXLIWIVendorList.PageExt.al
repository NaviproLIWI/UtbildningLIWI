pageextension 50207 "NPX LEA Vendor List" extends "Vendor List"
{
    layout
    {
        addlast(Control1)
        {
            field("NPX LEA Default Cargo Routing"; Rec."NPX LEA Default Cargo Routing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NPX LEA Default Cargo Routing field.', Comment = '%';
            }
        }
    }

}