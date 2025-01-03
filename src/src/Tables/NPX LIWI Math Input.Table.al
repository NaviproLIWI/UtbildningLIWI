table 50203 "NPX LIWI Math Input"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Expression; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}
    
    