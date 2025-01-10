codeunit 50205 "Math Token Manager"
{
    SingleInstance = false;

    procedure CreateToken(TokenType: Enum TokenType; Value: Text): Record MathToken
    var
        TokenRec: Record MathToken;
    begin
        TokenRec.Init();
        TokenRec."TokenType" := TokenType;
        TokenRec."Value" := Value;
        TokenRec.Insert();
        exit(TokenRec);
    end;

    procedure TokenToString(TokenRec: Record MathToken): Text
    begin
        exit('' + Format(TokenRec."TokenType") + ':' + TokenRec."Value");
    end;

    trigger OnRun()
    begin

    end;

}