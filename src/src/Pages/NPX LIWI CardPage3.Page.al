page 50205 "NPX LIWI CardPage3"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "NPX LIWI Test Table3";
    Caption = 'UTMANING';


    layout
    {
        area(Content)
        {
            group(Kunder)
            {
                field("Field No."; Rec."Field No.")
                {
                    Caption = 'Field No.';
                    ApplicationArea = all;
                    LookupPageId = "NPX LIWI Customer Lookup";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        if Page.RunModal(Page::"NPX LIWI Customer Lookup", CustomerRec) = Action::LookupOK then begin
                            Rec."Field No." := CustomerRec."No.";
                            rec.Validate("Field No.");

                        end;
                    end;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = all;

                }
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = all;
                }
            }
        }
    }





}