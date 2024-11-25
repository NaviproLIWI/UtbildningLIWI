tableextension 50203 "NPX LIWI Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50200; "NPX LIWI No. of Lines"; Integer)
        {
            Caption = 'No. Lines Flowfield';
            TableRelation = "Salesperson/Purchaser".Code;
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Document Type" = field("Document Type"), "Document No." = field("No.")));

        }

    }

}