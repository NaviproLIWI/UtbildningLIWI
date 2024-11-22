table 50202 "NPX LIWI Test Table3"
{
    Caption = 'TestTable 3';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type"; Enum "NPX LIWI Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';


        }
        field(2; "Table No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Table No.';
        }
        field(3; "Field No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Field No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if CustomerRec.Get("Field No.") then begin
                    "Table No." := CustomerRec."No. of Blanket Orders";

                end;
            end;

        }
        field(4; "Table Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Table Name';

        }
        field(5; "Field Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Field Name';

        }
        field(6; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Active';
            Editable = true;
            Enabled = true;
            trigger OnValidate()
            begin
                Message('Active Field was Clicked');
            end;

        }

    }

    keys
    {
        key(PK; "Table Name", "Field No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Field No.")
        {

        }
        fieldgroup(Brick; Active) { }
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}