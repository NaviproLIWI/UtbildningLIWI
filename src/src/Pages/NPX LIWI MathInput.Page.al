page 50207 "NPX LIWI MathInput"
{
    PageType = Card;
    ApplicationArea = All;
    Editable = true;
    UsageCategory = Administration;
    SourceTable = "NPX LIWI Math Input";

    layout
    {
        area(Content)
        {
            group("Expressions")
            {
                field(Expression; Rec.Expression)
                {
                    ApplicationArea = All;
                    Caption = 'Mathematical Expression';
                    ToolTip = 'Enter a mathematical expression';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("OK")
            {
                Caption = 'OK';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MathCalc: Codeunit "NPX LIWI Calculator";
                    Res: Decimal;
                    Err: Text;
                begin
                    MathCalc.SetText(Rec.Expression);
                    if MathCalc.ExecuteCalculation() then begin
                        MathCalc.GetResultandError(Res, Err);
                        Message('Result: %1', Res);
                    end else begin
                        MathCalc.GetResultandError(Res, Err);
                        Message('Error: %1', Err);
                    end;
                    CurrPage.Close();

                end;
            }
            action("Cancel")
            {
                Caption = 'Cancel';
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = false;

                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        TempRec: Record "NPX LIWI Math Input" temporary;
}