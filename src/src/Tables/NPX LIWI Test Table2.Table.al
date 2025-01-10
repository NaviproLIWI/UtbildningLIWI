table 50201 "NPX LIWI Test Table2"
{
    Caption = 'TestTable 2';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Type; Enum NewType)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
        field(3; Text; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Valid := true;
                Error := '';
                Result := '';
            end;
        }
        field(4; Valid; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; Result; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Error; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created DT"; DateTime)
        {
            DataClassification = ToBeClassified;
        }






    }

    keys
    {
        key(PK; "No.", Type)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Created DT" := CurrentDateTime();
    end;



}