codeunit 50200 "NPX LIWI Calculator"
{
    trigger OnRun()
    begin


    end;

    procedure SetText(InputText: Text)
    begin
        Text := InputText;
        Result := 0;
        CalculationAccomplished := false;
        ErrorTxt := '';
    end;

    procedure GetResultandError(var Res: Decimal; var Err: Text[100])
    begin
        Res := Result;
        Err := ErrorTxt;
    end;



    procedure ExecuteCalculation(): Boolean //TODO: man kan inte köra try catch i AL
    var
        Interpreter: Codeunit "NPX LIWI Math Interpreter";
    begin
        Clear(Result);
        Clear(ErrorTxt);
        CalculationAccomplished := false;

        Interpreter.CalculateExpression(Text, Result, ErrorTxt);
        if Result <> 0 then begin
            CalculationAccomplished := true;
            exit(true);
        end else begin
            ErrorTxt := 'An error occurred during evaluation';
            CalculationAccomplished := false;
            exit(false);
        end;
    end;

    procedure Calculate(): Boolean
    begin
        exit(ExecuteCalculation());
    end;


    var
        Text: Text[100];
        Result: Decimal;
        CalculationAccomplished: Boolean;
        ErrorTxt: Text[250];
}
