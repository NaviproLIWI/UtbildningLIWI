/// <summary>
/// TableExtension NPXLIWIPEBTempSalesDocLine (ID 50205) extends Record PEB Temp Sales Doc Line.
/// </summary>
tableextension 50205 "NPXLIWIPEBTempSalesDocLine" extends "PEB Temp Sales Doc Line"
{
    fields
    {
        field(50205; "Test Code"; Code[20])
        {
            Caption = 'Test Code';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."Document Type";
        }
    }
}