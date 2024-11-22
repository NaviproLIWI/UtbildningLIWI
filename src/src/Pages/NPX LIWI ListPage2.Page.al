page 50203 "NPX LIWI ListPage2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "NPX LIWI Test Table2";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Editable = true;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                    Editable = true;
                }
                field(Valid; Rec.Valid)
                {
                    ToolTip = 'Specifies the value of the Valid field.', Comment = '%';
                    Editable = false;
                }
                field("Created DT"; Rec."Created DT")
                {
                    ToolTip = 'Specifies the value of the Created DT field.', Comment = '%';
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}