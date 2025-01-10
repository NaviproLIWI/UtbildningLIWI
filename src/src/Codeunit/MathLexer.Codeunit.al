codeunit 50201 "Math Lexer"
{
    SingleInstance = false;

    var
        Text: Text;
        Pos: Integer;
        CurrentChar: Char;

    procedure Init(InputText: Text)
    begin
        Text := InputText;
        Pos := 1;
        if StrLen(Text) >= 1 then
            CurrentChar := Text[Pos]
        else
            CurrentChar := ' ';
    end;

    procedure GetNextToken(): Record MathToken
    var
        TokenRec: Record MathToken;
        TokenManager: Codeunit "Math Token Manager";
    begin
        while CurrentChar <> ' ' do begin
            if CurrentChar = ' ' then
                Advance()
            else
                if IsDigit(CurrentChar) then
                    exit(CreateNumberToken);

            if IsDigit(CurrentChar) then // or (CurrentChar = ',') or (CurrentChar = '.') then
                exit(CreateNumberToken());

            case CurrentChar of
                '+':
                    begin
                        Advance();
                        TokenRec.Init();
                        TokenRec.TokenType := Enum::TokenType::ADD;
                        TokenRec.Value := '+';
                        exit(TokenRec);
                    end;
                '-':
                    begin
                        Advance();
                        TokenRec.Init();
                        TokenRec.TokenType := Enum::TokenType::MINUS;
                        TokenRec.Value := '-';
                        exit(TokenRec);
                    end;
                '*':
                    begin
                        Advance();
                        TokenRec.Init();
                        TokenRec.TokenType := Enum::TokenType::MULTIPLY;
                        TokenRec.Value := '*';
                        exit(TokenRec);
                    end;
                '/':
                    begin
                        Advance();
                        TokenRec.Init();
                        TokenRec.TokenType := Enum::TokenType::DIVISION;
                        TokenRec.Value := '/';
                        exit(TokenRec);
                    end;
                '(':
                    begin
                        Advance();
                        TokenRec.Init();
                        TokenRec.TokenType := Enum::TokenType::LBRACE;
                        TokenRec.Value := '(';
                        exit(TokenRec);
                    end;
                ')':
                    begin
                        Advance();
                        TokenRec.Init();
                        TokenRec.TokenType := Enum::TokenType::RBRACE;
                        TokenRec.Value := ')';
                        exit(TokenRec);
                    end;
                else begin
                    exit(TokenRec);
                end;

            end
        end;
        TokenRec.Init();
        TokenRec.TokenType := Enum::TokenType::EOF;
        TokenRec.Value := '';
        exit(TokenRec);
    end;

    local procedure Advance()
    begin
        pos += 1;
        if Pos > StrLen(Text) then
            CurrentChar := ' '
        else
            CurrentChar := Text[Pos];
    end;

    local procedure IsDigit(c: Char): Boolean
    begin
        exit((c >= '0') and (c <= '9'));
    end;

    local procedure CreateNumberToken(): Record MathToken
    var
        TokenManager: Codeunit "Math Token Manager";
        NumberStr: Text;
        TokenRec: Record MathToken;
        DecimalPointUsed: Boolean;
    begin
        NumberStr := '';
        DecimalPointUsed := false;

        while (IsDigit(CurrentChar)) or ((CurrentChar = '.') and not DecimalPointUsed) do begin
            if CurrentChar = '.' then
                DecimalPointUsed := true;


            NumberStr += CurrentChar;
            Advance();
        end;
        TokenRec.Init();
        TokenRec.TokenType := Enum::TokenType::NUMBER;
        TokenRec.Value := NumberStr;
        exit(TokenRec);
    end;


    var
        myInt: Integer;
}