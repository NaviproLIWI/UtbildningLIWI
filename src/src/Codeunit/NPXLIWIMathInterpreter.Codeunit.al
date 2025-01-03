codeunit 50201 "NPX LIWI Math Interpreter"
{
    SingleInstance = true;
    Subtype = Normal;

    trigger OnRun()
    begin

    end;

    procedure CalculateExpression(Expression: Text; var Result: Decimal; var ErrorMsg: Text): Boolean
    var
        Tokens: List of [Text];
        RPN: List of [Text];
    begin
        Tokens := Tokenize(Expression);
        if Tokens.Count() = 0 then begin
            ErrorMsg := 'No tokens found';
            exit(false);
        end;
        RPN := ConvertToRPN(Tokens);
        if RPN.Count() = 0 then begin
            ErrorMsg := 'No RPN tokens found';
            exit(false);
        end;

        if not EvaluateRPN(RPN, Result, ErrorMsg) then
            exit(false);
        exit(true);

    end;

    local procedure Tokenize(Expression: Text): List of [Text]
    var
        i: Integer;
        CurrentChar: Char;
        NumberBuffer: Text[100];
        Tokens: List of [Text];
    begin
        NumberBuffer := '';
        for i := 1 to StrLen(Expression) do begin
            CurrentChar := Expression[i];

            if ((CurrentChar >= '0') and (CurrentChar <= '9')) or (CurrentChar = '.') then begin
                NumberBuffer += CurrentChar;
            end else if CurrentChar = ' ' then begin
                // Skip spaces
            end else if IsOperator(CurrentChar) or (CurrentChar = '(') or (CurrentChar = ')') then begin
                if NumberBuffer <> '' then begin
                    Tokens.Add(NumberBuffer);
                    NumberBuffer := '';
                end;
                Tokens.Add(Format(CurrentChar));
            end else begin
                Error('Ogiltigt tecken: %1', CurrentChar);
            end;
        end;
        if NumberBuffer <> '' then
            Tokens.Add(NumberBuffer);
        exit(Tokens);
    end;

    local procedure IsOperator(c: Text): Boolean
    begin
        exit((c = '+') or (c = '-') or (c = '*') or (c = '/') or (c = '^'));
    end;

    local procedure GetPrecedence(op: Text): Integer
    begin
        case op of
            '+', '-':
                exit(1);
            '*', '/':
                exit(2);
            '^':
                exit(3);
        end;
    end;

    local procedure ConvertToRPN(Tokens: List of [Text]): List of [Text]
    var
        Output: List of [Text];
        OperatorStack: List of [Text];
        Token: Text;
        i: Integer;
        DecValue: Decimal;
    begin
        for i := 1 to Tokens.Count() do begin
            Token := Tokens.Get(i);
            if IsNumber(Token, DecValue) then begin
                Output.Add(Token);
            end else if IsOperator(Token) then begin
                while (OperatorStack.Count() > 0) and (IsOperator(OperatorStack.Get(OperatorStack.Count()))) and
                    ((GetPrecedence(OperatorStack.Get(OperatorStack.Count())) > GetPrecedence(Token)) or
                    ((GetPrecedence(OperatorStack.Get(OperatorStack.Count())) = GetPrecedence(Token)) and (Token <> '^'))) and
                    (OperatorStack.Get(OperatorStack.Count()) <> '(') do begin
                    Output.Add(OperatorStack.Get(OperatorStack.Count()));
                    OperatorStack.RemoveAt(OperatorStack.Count());
                end;
                OperatorStack.Add(Token);
            end else if Token = '(' then begin
                OperatorStack.Add(Token);
            end else if Token = ')' then begin
                while ((OperatorStack.Count() > 0) and (OperatorStack.Get(OperatorStack.Count()) <> '(')) do begin
                    Output.Add(OperatorStack.Get(OperatorStack.Count()));
                    OperatorStack.RemoveAt(OperatorStack.Count());
                end;
                if (OperatorStack.Count() = 0) then
                    Error('Felaktig parentes');
                //ta bort parentes '(' från stacken
                OperatorStack.RemoveAt(OperatorStack.Count());
            end else begin
                Error('Ogiltigt token: %1', Token);
            end;

        end;
        while OperatorStack.Count() > 0 do begin
            if (OperatorStack.Get(OperatorStack.Count()) = '(') or (OperatorStack.Get(OperatorStack.Count()) = ')') then
                Error('Felaktig parentes');
            Output.Add(OperatorStack.Get(OperatorStack.Count()));
            OperatorStack.RemoveAt(OperatorStack.Count());
        end;
        exit(Output);

    end;

    local procedure IsNumber(Token: Text; var DecValue: Decimal): Boolean
    begin
        exit(Evaluate(DecValue, Token));
    end;

    local procedure EvaluateRPN(RPN: List of [Text]; var FinalResult: Decimal; var ErrorMsg: Text): Boolean
    var
        Stack: List of [Decimal];
        Token: Text;
        a, b, res : Decimal;
        i: Integer;
    begin
        for i := 1 to RPN.Count() do begin
            Token := RPN.Get(i);
            if IsNumber(Token, a) then begin
                Stack.Add(a);
            end else if IsOperator(Token) then begin
                if Stack.Count() < 2 then
                    ErrorMsg := 'För få argument';
                exit(false);
            end;

            b := Stack.Get(Stack.Count());
            Stack.RemoveAt(Stack.Count());
            a := Stack.Get(Stack.Count());
            Stack.RemoveAt(Stack.Count());
            case Token of
                '+':
                    res := a + b;
                '-':
                    res := a - b;
                '*':
                    res := a * b;
                '/':
                    begin
                        if b = 0 then
                            Error('Division med noll');
                        res := a / b;
                    end;
                '^':
                    res := Power(a, b);
                else
                    ErrorMsg := 'Ogiltigt token: %1';
                    exit(false);
            end;
            Stack.Add(res);
        end;
        if Stack.Count() <> 1 then begin
            ErrorMsg := 'För många argument';
            exit(false);
        end;
        FinalResult := Stack.Get(1);
        exit(true);
    end;


    local procedure Power(a: Decimal; b: Decimal): Decimal
    var
        i: Integer;
        Result: Decimal;
        Exponent: Integer;
    begin
        if (b mod 1) <> 0 then begin
            exit(0);
        end;

        Exponent := b DIV 1;

        if Exponent < 0 then begin
            exit(0);
        end;

        Result := 1;
        for i := 1 to Exponent do begin
            Result := Result * a;
        end;
        exit(Result);
    end;

    var
        myInt: Integer;
}