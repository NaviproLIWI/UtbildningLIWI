report 50200 "NPX LIWI Report Customer"
{
    ApplicationArea = All;
    Caption = 'Report Customer';
    UsageCategory = ReportsAndAnalysis;
    WordLayout = 'NPX LIWI Customer Report.docx';
    DefaultLayout = Word;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(Name; Name)
            {
            }
            column(City; City)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Contact; Contact)
            {
            }
            column(PartnerType; "Partner Type")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
