codeunit 50207 "ASTDivide" implements I_ASTNode
{
    SingleInstance = false;

    var
        LeftNode: Interface "I_ASTNode";
        RightNode: Interface "I_ASTNode";

    procedure InitDivide(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode")
    begin
        LeftNode := Left;
        RightNode := Right;
    end;

    procedure Eval(): Decimal
    var
        Denom: Decimal;
    begin
        Denom := RightNode.Eval();
        if Denom = 0 then
            exit(0);
        exit(LeftNode.Eval() / Denom);

        // if RightNode.Eval() = 0 then
        //     Error('Division med noll är inte tillåten.');

        // exit(LeftNode.Eval() / RightNode.Eval());
    end;

    procedure ToString(): Text
    begin
        exit('(' + LeftNode.ToString() + ' / ' + RightNode.ToString() + ')');
    end;

    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}