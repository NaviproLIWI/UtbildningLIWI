codeunit 50209 Calculator
{
    SingleInstance = true;

    trigger OnRun()
    begin

    end;

    var
        CalculationText: Text[250];
        CalculationResult: Decimal;
        CalculationAccomplished: Boolean;
        ErrorText: Text[250];

    procedure SetText(InputText: Text)
    begin
        CalculationText := InputText; //TODO: steg 2
    end;

    procedure GetResult(): Decimal
    begin
        exit(CalculationResult);
    end;

    procedure GetErrorText(): Text
    begin
        exit(ErrorText);
    end;

    procedure Execute(): Boolean
    var
        Parser: Codeunit MathParser;
        Succes: Boolean;
    begin
        CalculationResult := 0;
        ErrorText := '';
        CalculationAccomplished := false;

        Succes := Parser.ParseAndEval(CalculationText, CalculationResult, ErrorText);

        if Succes then begin
            CalculationAccomplished := true;
        end else begin
            CalculationAccomplished := false;
        end;
        exit(CalculationAccomplished);
    end;


}