page 50202 "NPX LIWI CardPage2"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "NPX LIWI Test Table2";

    layout
    {
        area(Content)
        {

            group(GroupName)
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
                field("Text"; Rec."Text")
                {
                    ToolTip = 'Specifies the value of the Text field.', Comment = '%';
                    Editable = true;
                }
                field(Valid; Rec.Valid)
                {
                    ToolTip = 'Specifies the value of the Valid field.', Comment = '%';
                    Editable = false;
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                    Editable = false;
                    Importance = Additional;
                }
                field(Error; Rec.Error)
                {
                    ToolTip = 'Specifies the value of the Error field.', Comment = '%';
                    Editable = false;
                }
                field("Created DT"; Rec."Created DT")
                {
                    ToolTip = 'Specifies the value of the Created DT field.', Comment = '%';
                    Editable = false;

                }
            }
        }
    }


}