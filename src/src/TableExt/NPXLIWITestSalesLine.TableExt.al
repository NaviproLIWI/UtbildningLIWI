tableextension 50201 "NPX LIWI Test Sales Line" extends "Sales Line"
{
    fields
    {
        field(50200; "NPX Test Variant 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code where("Item No." = field("No."), Blocked = const(false));
        }

        field(50201; "NPX Test Flowfield"; Code[50])
        {

            Caption = 'Flowfield';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Description 2" where("Item No." = field("No."), Code = field("Variant Code")));
        }
        field(50202; "Test Code"; Code[20])
        {
            Caption = 'Test Code';

        }
        // Add changes to table fields here
    }


}