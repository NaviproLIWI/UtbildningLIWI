codeunit 50200 "AST Exponent" implements I_ASTNode
{
    SingleInstance = false;

    var
        LeftNode: Interface "I_ASTNode";
        RightNode: Interface "I_ASTNode";

    procedure InitExponent(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode")
    begin
        LeftNode := Left;
        RightNode := Right;
    end;

    procedure Eval(): Decimal
    var
        Base: Decimal;
        Exponent: Decimal;
        i: Integer;
        TempResult: Decimal;
    begin
        Base := LeftNode.Eval();
        Exponent := RightNode.Eval();
        if Exponent < 0 then
            Error('Exponenten måste vara icke-negativ.');

        TempResult := 1;
        for i := 1 to Exponent do
            TempResult := TempResult * Base;

        exit(TempResult);
    end;

    procedure ToString(): Text
    begin
        exit('(' + LeftNode.ToString() + ' ^ ' + RightNode.ToString() + ')');
    end;

    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}