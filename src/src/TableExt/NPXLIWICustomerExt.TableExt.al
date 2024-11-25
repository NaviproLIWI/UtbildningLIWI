tableextension 50202 "NPX LIWI Cutomer Extension" extends Customer
{
    fields
    {
        field(50200; "Test Code"; code[20])
        {
            Caption = 'Test Code';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        // Add changes to table fields here
    }


}