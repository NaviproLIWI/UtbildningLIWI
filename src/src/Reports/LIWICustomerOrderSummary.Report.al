report 50203 "LIWI Customer Order Summary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlcLayout;

    dataset
    {

        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = Sorting("No.");
            RequestFilterFields = "Bill-to Customer No.", "No.", "Status";

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

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = Sorting("Line No.");

                column(IncludeLines; ShowLines)
                {
                    CaptionML = ENU = 'Show Lines';
                }
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

    requestpage
    {
        CaptionML = ENU = 'Selection';
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                // group(Options)
                // {
                //     CaptionML = ENU = 'Options';
                //     field(ShowLines; ShowLines)
                //     {
                //         ApplicationArea = All;
                //         CaptionML = ENU = 'Show Details';
                //         ToolTipML = ENU = 'Include line details and summary';
                //     }
                // }
                group(Filters)
                {
                    CaptionML = ENU = 'Filters';
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Customer No.';
                    }
                }

                group(ViewOptions)
                {
                    CaptionML = ENU = 'Options';
                    field(ShowDetails; ShowDetails)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show Details';
                        ToolTipML = ENU = 'Include sales line details';
                    }
                    field(ShowSummariesOnly; ShowSummariesOnly)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show Summaries Only';
                        ToolTipML = ENU = 'Hide details and show only summaries';
                    }
                }
            }
        }
    }

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

    var
        ShowLines: Boolean;
        CustomerNo: Code[20];

        OrderNo: Code[20];
        FilterText: Text[100];
        ShowDetails: Boolean;
        ShowSummariesOnly: Boolean;



}

