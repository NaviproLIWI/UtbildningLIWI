codeunit 50208 MathParser
{
    SingleInstance = true;

    var
        Lexer: Codeunit "Math Lexer";
        CurrentToken: Record MathToken;
        TokenManager: Codeunit "Math Token Manager";

    procedure ParseAndEval(Expression: Text; var Result: Decimal; var ErrorMsg: Text): Boolean
    var
        RootASTNode: Interface I_ASTNode;
    begin
        Lexer.Init(Expression);
        CurrentToken := Lexer.GetNextToken();

        if not Expr(RootASTNode, ErrorMsg) then begin
            Result := 0;
            exit(false);
        end;

        if CurrentToken.TokenType <> Enum::TokenType::EOF then begin
            ErrorMsg := 'Ogiltigt uttryck';
            Result := 0;
            exit(false);
        end;

        Result := RootASTNode.Eval();
        exit(true);
    end;

    local procedure Expr(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    var
        LeftNode: Interface I_ASTNode;
        RightNode: Interface I_ASTNode;
        PlusNode: Codeunit "ASTPlus";
        MinusNode: Codeunit "ASTMinus";
    begin
        if not Term(LeftNode, ErrorMsg) then
            exit(false);

        while CurrentToken.TokenType in [Enum::TokenType::ADD, Enum::TokenType::MINUS] do begin
            if CurrentToken.TokenType = Enum::TokenType::ADD then begin
                CurrentToken := Lexer.GetNextToken();
                if not Term(RightNode, ErrorMsg) then
                    exit(false);
                PlusNode.InitPlus(LeftNode, RightNode);
                LeftNode := PlusNode;
            end else if CurrentToken.TokenType = Enum::TokenType::MINUS then begin
                CurrentToken := Lexer.GetNextToken();
                if not Term(RightNode, ErrorMsg) then
                    exit(false);
                MinusNode.InitMinus(LeftNode, RightNode);
                LeftNode := MinusNode;
            end;
        end;
        ASTNode := LeftNode;
        exit(true);
    end;

    //MULTI

    local procedure Term(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    var
        LeftNode: Interface I_ASTNode;
        RightNode: Interface I_ASTNode;
        MultiplyNode: Codeunit "ASTMultiply";
        DivideNode: Codeunit "ASTDivide";
        ExponentNode: Codeunit "AST Exponent";
    begin
        if not Factor(LeftNode, ErrorMsg) then
            exit(false);

        while CurrentToken.TokenType in [Enum::TokenType::MULTIPLY, Enum::TokenType::DIVISION, Enum::TokenType::EXPONENT] do begin
            if CurrentToken.TokenType = Enum::TokenType::MULTIPLY then begin
                CurrentToken := Lexer.GetNextToken();
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                MultiplyNode.InitMultiply(LeftNode, RightNode);
                LeftNode := MultiplyNode;
            end else if CurrentToken.TokenType = Enum::TokenType::DIVISION then begin
                CurrentToken := Lexer.GetNextToken();
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                DivideNode.InitDivide(LeftNode, RightNode);
                LeftNode := DivideNode;
            end else if CurrentToken.TokenType = Enum::TokenType::EXPONENT then begin
                CurrentToken := Lexer.GetNextToken();
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                ExponentNode.InitExponent(LeftNode, RightNode);
                LeftNode := ExponentNode;
            end;
        end;
        ASTNode := LeftNode;
        exit(true);
    end;

    local procedure Factor(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    var
        LeafNode: Codeunit "AST Leaf";
        ExprNode: Interface I_ASTNode;
        NumberValue: Decimal;
    begin
        if CurrentToken.TokenType = Enum::TokenType::NUMBER then begin
            if not TryParseDecimal(CurrentToken.Value, NumberValue) then begin
                ErrorMsg := 'Ogiltigt nummerformat: ' + CurrentToken.Value;
                exit(false);
            end;
            LeafNode.InitLeaf(NumberValue);
            CurrentToken := Lexer.GetNextToken();
            ASTNode := LeafNode;
            exit(true);
        end else if CurrentToken.TokenType = Enum::TokenType::LBRACE then begin
            CurrentToken := Lexer.GetNextToken();
            if not Expr(ExprNode, ErrorMsg) then
                exit(false);
            if CurrentToken.TokenType <> Enum::TokenType::RBRACE then begin
                ErrorMsg := 'Saknas stängande parentes';
                exit(false);
            end;
            CurrentToken := Lexer.GetNextToken();
            ASTNode := ExprNode;
            exit(true);
        end else begin
            ErrorMsg := 'Ogiltig token: ' + CurrentToken.Value;
            exit(false);
        end;

    end;

    local procedure TryParseDecimal(Value: Text; var Result: Decimal): Boolean
    begin
        if not Evaluate(Result, Value) then begin
            Result := 0;
            exit(false);
        end else
            exit(true);
    end;




    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}