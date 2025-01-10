enum 50201 TokenType
{
    Extensible = false;

    value(0; "NUMBER")
    {
        Caption = 'Number';
    }
    value(1; "ADD")
    {
        Caption = '+';
    }
    value(2; "MINUS")
    {
        Caption = '-';
    }
    value(3; "MULTIPLY")
    {
        Caption = '*';
    }
    value(4; "DIVISION")
    {
        Caption = '/';
    }
    value(5; "LBRACE")
    {
        Caption = '(';
    }
    value(6; "RBRACE")
    {
        Caption = ')';
    }
    value(7; "EOF")
    {
        Caption = 'End of file';
    }
    value(8; "EXPONENT")
    {
        Caption = '^';
    }
}