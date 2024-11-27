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
        field(50201; "NPX LIWI No. of Item Lines"; Integer)
        {
            Caption = 'No. if Item Lines';
            TableRelation = "Salesperson/Purchaser".Code;
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const(Item)));
        }
        field(50202; "NPX LIWI No. of Ordered Items"; Decimal)
        {
            Caption = 'No. of Ordered Items';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;



        }
        field(50203; "NPX LIWI No. of Recieved Items"; Decimal)
        {
            Caption = 'No. of Recieved Items';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Qty. Received (Base)" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;



        }

    }

}