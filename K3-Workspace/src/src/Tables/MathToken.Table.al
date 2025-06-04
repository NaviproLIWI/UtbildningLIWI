table 50203 "MathToken"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "TokenType"; Enum TokenType)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Value"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; TokenType, "Value")
        {
            Clustered = true;
        }
    }


}