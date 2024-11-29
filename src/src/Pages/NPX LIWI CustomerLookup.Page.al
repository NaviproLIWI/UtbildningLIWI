page 50206 "NPX LIWI Customer Lookup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = all;

                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = all;
                }
            }
        }
    }
}