report 50204 UtmaningCustomerOrderSummary
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlcLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(CustomerNo; "Bill-to Customer No.")
            {
                CaptionML = ENU = 'Customer No.';
            }
            column(SellToName; "Sell-to Customer Name")
            {
                CaptionML = ENU = 'Customer Name';
            }
            column(Country; "Bill-to Country/Region Code")
            {
                CaptionML = ENU = 'Country';
            }
            column(Filter; FilterText)
            {
                CaptionML = ENU = 'Filters';
            }
            column(OrderNo; "No.")
            {
                CaptionML = ENU = 'Order No.';
            }
            column(OrderDate; "Order Date")
            {
                CaptionML = ENU = 'Order Date';
            }
            column(ShowDetailsParam; ShowDetails)
            {
                CaptionML = ENU = 'Show Details';
            }
            column(ShowSummariesOnlyParam; ShowSummariesOnly)
            {
                CaptionML = ENU = 'Show Summaries Only';
            }


        }

    }
}
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
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
            area(processing)
            {
                action(LayoutName)
                {
                    
                }
            }
        }
    }
    
    rendering
    {
        layout(ExcelLayout)
        {
            Type = Excel;
            LayoutFile = 'Layout2/CustomerOrderSummary.xlsx';
        }
        layout(RdlcLayout)
        {
            Type = RDLC;
            LayoutFile = 'Layout2/CustomerOrderSummary.Rdlc';
        }
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Layout2/CustomerOrderSummary.docx';
        }
    }
    
    var
        ShowLines: Boolean;
        ShowDetails: Boolean;
        ShowSummariesOnly: Boolean;
        FilterText: Text[250];

}