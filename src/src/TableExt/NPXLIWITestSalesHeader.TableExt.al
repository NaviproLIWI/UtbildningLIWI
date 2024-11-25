tableextension 50200 "NPX LIWI Test Sales Header" extends "Sales Header"
{
    fields
    {
        field(50200; "NPX LIWI Test Field"; Code[20])
        {
            Caption = 'Test Field';
            Tablerelation = "Salesperson/Purchaser".Code;

        }
        field(50201; "NPX LIWI Test No. of Lines"; Integer)
        {
            Caption = 'Test No. Lines';
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50202; "NPX LIWI Test Total Qty,"; Decimal)
        {
            Caption = 'Test Total Qty.';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const(item)));
        }
        // Add changes to table fields here

        field(50203; "Test Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."Document Type";
        }
    }

}