codeunit 50204 "ASTMinus" implements I_ASTNode
{
    SingleInstance = false;

    var
        LeftNode: Interface "I_ASTNode";
        RightNode: Interface "I_ASTNode";

    procedure InitMinus(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode")
    begin
        LeftNode := Left;
        RightNode := Right;
    end;

    procedure Eval(): Decimal
    begin
        exit(LeftNode.Eval() - RightNode.Eval());
    end;

    // procedure Eval(): Decimal
    // var
    //     L: Decimal;
    //     R: Decimal;
    // begin
    //     L := LeftNode.Eval();
    //     R := RightNode.Eval();
    //     Message('ASTMinus.Eval: Left = %1, Right = %2', L, R);
    //     exit(L - R);
    // end;


    procedure ToString(): Text
    begin
        exit('(' + LeftNode.ToString() + ' - ' + RightNode.ToString() + ')');
    end;


    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}