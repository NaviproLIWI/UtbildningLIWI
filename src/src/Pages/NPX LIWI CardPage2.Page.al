page 50202 "NPX LIWI CardPage2"
{
    Caption = 'MATEMATISK RÄKNARE';
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
                    Editable = false; //TODO: satte till false för test
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

                    trigger OnValidate()
                    var
                        Calculator: Codeunit Calculator;
                        Succes: Boolean;
                        LocalResult: Decimal;
                        LocalError: Text[250];
                    begin
                        rec.Valid := true;
                        rec.Error := '';
                        rec.Result := '';

                        if rec.Text = '' then begin
                            rec.Error := 'Inget uttryck angivet.';
                            exit;
                        end;



                        // if Rec.Text <> '' then begin
                        Calculator.SetText(rec.Text);
                        Succes := Calculator.Execute();

                        if Succes then begin
                            LocalResult := Calculator.GetResult();
                            Rec.Result := Format(LocalResult); //TODO: ta bort mellanslag , 0, '<Integer>'
                            Rec.Error := '';
                        end else begin
                            LocalError := Calculator.GetErrorText();
                            rec.Error := LocalError;
                            Rec.Result := '';

                        end;
                        Rec.Modify(true);


                    end;

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

    actions
    {
        area(Processing)
        {
            action("Calculate")
            {
                Caption = 'Beräkna';
                Image = Calculate;
                ApplicationArea = all;

                trigger OnAction()
                var
                    Parser: codeunit MathParser;
                    CalculationResult: Decimal;
                    CalculationError: Text[250];
                begin
                    if rec.Text <> '' then begin
                        if Parser.ParseAndEval(Rec.Text, CalculationResult, CalculationError) then begin
                            rec.Result := Format(CalculationResult);
                            rec.Valid := true;
                            rec.Error := '';
                            Message('Resultat: %1', CalculationResult);
                        end else begin
                            rec.Result := Format(0);
                            rec.Valid := false;
                            rec.Error := CalculationError;
                            Message('Fel: %1', CalculationError);
                        end;
                    end else begin
                        rec.Result := Format(0);
                        rec.Valid := false;
                        rec.Error := 'Inget uttryck angivet.';
                        Message('Fel: Ingen uttryck angiven.');
                    end;

                end;
            }
        }
    }




    var
        Expression: Text;

}