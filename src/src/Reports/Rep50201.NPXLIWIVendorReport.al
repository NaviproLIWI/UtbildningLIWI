report 50201 "NPX LIWI Vendor Report"
{
    ApplicationArea = All;
    Caption = 'NPX LIWI Vendor Report';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'NPX LIWI Vendor Report.xlsx';
    DefaultLayout = Excel;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            column(Name; Name)
            {
            }
            column(City; City)
            {
            }
            column(PartnerType; "Partner Type")
            {
            }
            column(PurchasesLCY; "Purchases (LCY)")
            {
            }
            column(Balance; Balance)
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
