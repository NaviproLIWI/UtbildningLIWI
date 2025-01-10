codeunit 50202 "AST Leaf" implements I_ASTNode
{
    SingleInstance = false;

    var
        Num: Decimal;

    procedure InitLeaf(Number: Decimal)
    begin
        Num := Number;
    end;

    procedure Eval(): Decimal
    begin
        exit(Num);
    end;

    procedure ToString(): Text
    begin
        exit(Format(Num));
    end;

}