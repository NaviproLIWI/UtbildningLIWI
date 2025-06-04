codeunit 50201 "Math Lexer"
{
    SingleInstance = false;

    var
        Text: Text;
        Pos: Integer;
        CurrentChar: Char;

    procedure Init(InputText: Text)
    begin
        Text := DelChr(InputText, '=', ' '); //TODO: DelCHr här
        Pos := 1;
        if StrLen(Text) >= 1 then //TODO: ändrade till 0
            CurrentChar := Text[Pos]
        else
            CurrentChar := ' ';
    end;

    procedure GetNextToken(): Record MathToken
    var
        TokenRec: Record MathToken;
        TokenManager: Codeunit "Math Token Manager";
    begin
        // while CurrentChar <> ' ' do begin
        //     if CurrentChar = ' ' then begin
        //         Advance();

        //     end else begin

        // Om vi har gått utanför strängens längd, returnera EOF
        if Pos > StrLen(Text) then begin
            TokenRec.Init();
            TokenRec.TokenType := Enum::TokenType::EOF;
            TokenRec.Value := '';
            exit(TokenRec);
        end;

        // Hoppa över eventuella mellanslag
        while (Pos <= StrLen(Text)) and (Text[Pos] = ' ') do begin
            Advance();
        end;

        // Kontrollera igen om vi nått slutet efter att ha hoppat över mellanslag
        if Pos > StrLen(Text) then begin
            TokenRec.Init();
            TokenRec.TokenType := Enum::TokenType::EOF;
            TokenRec.Value := '';
            exit(TokenRec);
        end;

        if IsDigit(CurrentChar) then
            exit(CreateNumberToken());

        // if IsDigit(CurrentChar) or (CurrentChar = ',') or (CurrentChar = '.') then
        //     exit(CreateNumberToken());

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
            else
         // Error('Unknown character: %1', CurrentChar);
         // exit(TokenRec);
         begin
                // Returnera ett token med typen INVALID istället för att kasta ett fel.
                TokenRec.Init();
                TokenRec.TokenType := Enum::TokenType::INVALID;
                TokenRec.Value := CurrentChar;
                Advance();
                exit(TokenRec);
            end;

        end;
    end;
    // end;
    //         TokenRec.Init();
    //         TokenRec.TokenType := Enum::TokenType::EOF;
    //         TokenRec.Value := '';
    //         exit(TokenRec);
    //     end;
    // end;



    local procedure Advance()
    begin
        pos += 1; //TODO: ändrade till två st Pos
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
        DecimalPointUsed := false; //TODO: kolla denna

        while (IsDigit(CurrentChar)) or ((CurrentChar = '.') or (CurrentChar = ',') and not DecimalPointUsed) do begin
            if (CurrentChar = '.') or (CurrentChar = ',') then begin
                DecimalPointUsed := true;
                NumberStr += '.';
            end else
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