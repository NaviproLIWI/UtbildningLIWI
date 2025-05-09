codeunit 50206 "ASTMultiply" implements I_ASTNode
{
    SingleInstance = false;

    var
        LeftNode: Interface "I_ASTNode";
        RightNode: Interface "I_ASTNode";

    procedure InitMultiply(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode")
    begin
        LeftNode := Left;
        RightNode := Right;
    end;

    procedure Eval(): Decimal
    begin
        exit(LeftNode.Eval() * RightNode.Eval());
    end;

    procedure ToString(): Text
    begin
        exit('(' + LeftNode.ToString() + ' * ' + RightNode.ToString() + ')');
    end;

}