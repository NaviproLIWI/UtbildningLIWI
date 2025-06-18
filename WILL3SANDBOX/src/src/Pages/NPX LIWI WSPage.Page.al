page 50204 "NPX LIWI WSPage"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "NPX LIWI Test Table2";

    layout
    {
        area(Content)
        {
            group("Filter Group")
            {
                field("No."; FilteredNo)
                {
                    ApplicationArea = all;
                    caption = 'No.';
                    ToolTip = 'No.';
                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;

                }
                field(Type; FilteredType)
                {
                    ApplicationArea = all;
                    Caption = 'Type';
                    ToolTip = 'Type';
                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;

                }
            }
            repeater("Lines")
            {
                field("List No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = all;
                }
                field("List Type"; Rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = all;
                }
                field("Text"; Rec."Text")
                {
                    ToolTip = 'Specifies the value of the Text field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(Valid; Rec.Valid)
                {
                    ToolTip = 'Specifies the value of the Valid field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(Error; Rec.Error)
                {
                    ToolTip = 'Specifies the value of the Error field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Created DT"; Rec."Created DT")
                {
                    ToolTip = 'Specifies the value of the Created DT field.', Comment = '%';
                    ApplicationArea = all;
                }


            }
        }

    }



    actions
    {
        area(Processing)
        {
            action(MyAction)
            {
                Caption = 'Process selected Rows';
                ApplicationArea = all;
                image = Process;


                trigger OnAction()
                begin
                    Message('Processing selected rows..');

                end;
            }

        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."No." := ''; // Sätter No. till blankt vid ny post
        Rec.Type := Rec.Type::" "; // Sätter Type till tomt Enum-värde vid ny post
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."No." = '' then
            Rec."No." := ''; // Återställ No. till blankt om det är tomt
        if Rec.Type = Rec.Type::" " then
            Rec.Type := Rec.Type::" "; // Återställ Type till blankt Enum-värde
    end;

    var
        FilteredNo: Code[10];
        FilteredType: Option " ","Text","Number";

    local procedure ApplyFilters()
    begin
        Rec.Reset();
        if FilteredNo <> '' then
            Rec.SetRange("No.", FilteredNo);
        if FilteredType <> FilteredType::" " then
            Rec.SetRange(Type, FilteredType);
        CurrPage.Update();
    end;

}