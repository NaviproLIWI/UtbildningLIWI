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

    local procedure CreateASTPlus(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode"): Interface I_ASTNode
    var
        PlusInstance: codeunit ASTPlus;
    begin
        PlusInstance.InitPlus(Left, Right);
        exit(PlusInstance);
    end;

    local procedure CreateASTMinus(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode"): Interface I_ASTNode
    var
        MinusInstance: codeunit ASTMinus;
    begin
        MinusInstance.InitMinus(Left, Right);
        exit(MinusInstance);
    end;

    local procedure CreateASTMultiply(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode"): Interface I_ASTNode
    var
        MultiplyInstance: codeunit ASTMultiply;
    begin
        MultiplyInstance.InitMultiply(left, right);
        exit(MultiplyInstance);
    end;

    local procedure CreateASTDivide(Left: Interface "I_ASTNode"; Right: Interface "I_ASTNode"): Interface I_ASTNode
    // var
    //     DivideInstance: codeunit ASTDivide;
    begin
        // DivideInstance.InitDivide(left, right);
        // exit(DivideInstance);
    end;

    local procedure CreateASTExponent(Left: Interface I_ASTNode; Right: Interface I_ASTNode): Interface I_ASTNode
    var
        ExponentInstance: codeunit "AST Exponent";
    begin
        ExponentInstance.InitExponent(left, right);
        exit(ExponentInstance);
    end;

    local procedure Expr(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    var
        LeftNode: Interface I_ASTNode;
        RightNode: Interface I_ASTNode;
    begin
        if not Term(LeftNode, ErrorMsg) then
            exit(false);

        while CurrentToken.TokenType in [Enum::TokenType::ADD, Enum::TokenType::MINUS] do begin
            if CurrentToken.TokenType = Enum::TokenType::ADD then begin
                CurrentToken := Lexer.GetNextToken();
                if not Term(RightNode, ErrorMsg) then
                    exit(false);
                LeftNode := CreateASTPlus(LeftNode, RightNode);
            end else if CurrentToken.TokenType = Enum::TokenType::MINUS then begin
                CurrentToken := Lexer.GetNextToken();
                if not Term(RightNode, ErrorMsg) then
                    exit(false);
                LeftNode := CreateASTMinus(LeftNode, RightNode);
                // end else if CurrentToken.TokenType = Enum::TokenType::MULTIPLY then begin
                //     CurrentToken := Lexer.GetNextToken();
                //     if not Term(RightNode, ErrorMsg) then
                //         exit(false);
                //     LeftNode := CreateASTMultiply(LeftNode, RightNode);
                // end else if CurrentToken.TokenType = Enum::TokenType::DIVISION then begin
                //     CurrentToken := Lexer.GetNextToken();
                //     if not Term(RightNode, ErrorMsg) then
                //         exit(false);
                //     LeftNode := CreateASTDivide(LeftNode, RightNode);
            end;
        end;

        ASTNode := LeftNode;
        exit(true);
    end;

    local procedure Term(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    var
        LeftNode: Interface I_ASTNode;
        RightNode: Interface I_ASTNode;
    begin
        if not Factor(LeftNode, ErrorMsg) then
            exit(false);

        while true do begin
            // Debug: skriv ut aktuell token
            // Message('Term: CurrentToken = %1, Value = %2', Format(CurrentToken.TokenType), CurrentToken.Value);

            if CurrentToken.TokenType = Enum::TokenType::MULTIPLY then begin
                CurrentToken := Lexer.GetNextToken();
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                LeftNode := CreateASTMultiply(LeftNode, RightNode);
            end else if CurrentToken.TokenType = Enum::TokenType::DIVISION then begin
                CurrentToken := Lexer.GetNextToken();
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                LeftNode := CreateASTDivide(LeftNode, RightNode);
            end else if CurrentToken.TokenType = Enum::TokenType::EXPONENT then begin
                CurrentToken := Lexer.GetNextToken();
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                LeftNode := CreateASTExponent(LeftNode, RightNode);
            end
            // Om nästa token inleder en ny faktor (implicit multiplikation)
            else if //(CurrentToken.TokenType = Enum::TokenType::MINUS) or
                    (CurrentToken.TokenType = Enum::TokenType::NUMBER) or
                    (CurrentToken.TokenType = Enum::TokenType::LBRACE) then begin
                if not Factor(RightNode, ErrorMsg) then
                    exit(false);
                LeftNode := CreateASTMultiply(LeftNode, RightNode);
            end else begin
                break;
            end;
        end;

        ASTNode := LeftNode;
        exit(true);
    end;




    //MULTI

    // local procedure Term(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    // var
    //     LeftNode: Interface I_ASTNode;
    //     RightNode: Interface I_ASTNode;
    //     MultiplyNode: Codeunit "ASTMultiply";
    //     DivideNode: Codeunit "ASTDivide";
    //     ExponentNode: Codeunit "AST Exponent";
    // begin
    //     if not Factor(LeftNode, ErrorMsg) then
    //         exit(false);

    //     while true do begin
    //         // while CurrentToken.TokenType in [Enum::TokenType::MULTIPLY, Enum::TokenType::DIVISION, Enum::TokenType::EXPONENT] do begin
    //         if CurrentToken.TokenType = Enum::TokenType::MULTIPLY then begin
    //             CurrentToken := Lexer.GetNextToken();
    //             if not Factor(RightNode, ErrorMsg) then
    //                 exit(false);
    //             LeftNode := CreateASTMultiply(LeftNode, RightNode);
    //             // MultiplyNode.InitMultiply(LeftNode, RightNode);
    //             // LeftNode := MultiplyNode;
    //         end else if CurrentToken.TokenType = Enum::TokenType::DIVISION then begin
    //             CurrentToken := Lexer.GetNextToken();
    //             if not Factor(RightNode, ErrorMsg) then
    //                 exit(false);
    //             LeftNode := CreateASTDivide(LeftNode, RightNode);
    //         end else if CurrentToken.TokenType = Enum::TokenType::EXPONENT then begin
    //             CurrentToken := Lexer.GetNextToken();
    //             if not Factor(RightNode, ErrorMsg) then
    //                 exit(false);
    //             LeftNode := CreateASTExponent(LeftNode, RightNode);
    //             // ExponentNode.InitExponent(LeftNode, RightNode);
    //             // LeftNode := ExponentNode;
    //         end else if (CurrentToken.TokenType = Enum::TokenType::MINUS) or
    //                     (CurrentToken.TokenType = Enum::TokenType::NUMBER) or
    //                     (CurrentToken.TokenType = Enum::TokenType::LBRACE) then begin
    //             if Factor(RightNode, ErrorMsg) then
    //                 exit(false);
    //             LeftNode := CreateASTMultiply(LeftNode, RightNode);
    //             // end else begin
    //             //     break;
    //         end;
    //     end;

    //     ASTNode := LeftNode;
    //     exit(true);
    // end;

    local procedure Factor(var ASTNode: Interface "I_ASTNode"; var ErrorMsg: Text): Boolean
    var
        LeafNode: Codeunit "AST Leaf";
        ExprNode: Interface I_ASTNode;
        NumberValue: Decimal;
        NegativeOne: Codeunit "AST Leaf";
    begin
        if CurrentToken.TokenType = Enum::TokenType::INVALID then begin
            ErrorMsg := 'Ogiltigt tecken: ' + CurrentToken.Value;
            exit(false);
        end;
        if CurrentToken.TokenType = Enum::TokenType::MINUS then begin
            CurrentToken := Lexer.GetNextToken();
            if not Factor(ASTNode, ErrorMsg) then
                exit(false);
            NegativeOne.InitLeaf(-1);
            ASTNode := CreateASTMultiply(NegativeOne, ASTNode);
            exit(true);
        end;
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
    var
        ConvertedValue: Text;
    begin
        if Evaluate(Result, Value) then
            exit(true);

        ConvertedValue := Value.Replace('.', ',');
        if Evaluate(Result, ConvertedValue) then
            exit(true);
        ConvertedValue := Value.Replace(',', '.');
        if Evaluate(Result, ConvertedValue) then
            exit(true);

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