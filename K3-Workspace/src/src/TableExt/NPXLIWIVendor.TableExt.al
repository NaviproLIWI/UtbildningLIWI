tableextension 50204 "NPX LEA Vendor" extends "Vendor"
{
    fields
    {
        field(52143; "NPX LEA Default Cargo Routing"; Code[20])
        {
            Caption = 'Default Cargo Routing';
            DataClassification = ToBeClassified;
            TableRelation = "K3BM Cargo Routing Header";
        }

        // Add changes to table fields here
    }
}