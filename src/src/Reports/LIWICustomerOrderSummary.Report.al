report 50203 "LIWI Customer Order Summary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlcLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(SalesCustomerNo; "Sell-to Customer No.")
            {
                CaptionML = ENU = 'Customer No.';
            }
            column(SellToName; "Sell-to Customer Name")
            {
                CaptionML = ENU = 'Customer Name';
            }
            column(SellToCountry; "Sell-to Country/Region Code")
            {
                CaptionML = ENU = 'Country';
            }
            column(OrderNo; "No.")
            {
                CaptionML = ENU = 'Order No.';
            }
            column(OrderDate; "Order Date")
            {
                CaptionML = ENU = 'Order Date';
            }

            dataitem(SalesLine; "Sales Line")
            {

                column(ItemNo; "No.")
                {
                    CaptionML = ENU = 'Itemo No.';
                }
                column(Description; "Description")
                {
                    CaptionML = ENU = 'Description';
                }
                column(Quantity; "Quantity")
                {
                    CaptionML = ENU = 'Quantity';
                }
                column(Amount; "Line Amount")
                {
                    CaptionML = ENU = 'Amount';
                }

            }
        }
    }

    // requestpage
    // {
    //     AboutTitle = 'Teaching tip title';
    //     AboutText = 'Teaching tip content';
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(LayoutName)
    //             {

    //             }
    //         }
    //     }
    // }

    rendering
    {
        layout(ExcelLayout)
        {
            Type = Excel;
            LayoutFile = 'Layout/CustomerOrderSummary.xlsx';
        }
        layout(RdlcLayout)
        {
            Type = RDLC;
            LayoutFile = 'Layout/CustomerOrderSummary.Rdlc';
        }
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Layout/CustomerOrderSummary.docx';
        }
    }

}