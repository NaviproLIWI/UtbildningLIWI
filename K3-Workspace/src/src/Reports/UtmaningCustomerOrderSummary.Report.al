report 50204 UtmaningCustomerOrderSummary
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlcLayout;


    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            DataItemTableView = Sorting("No.");


            column(CustomerNo; "No.")
            {

                CaptionML = ENU = 'Customer No.';

            }
            column(CustomerName; Name)
            {
                CaptionML = ENU = 'Customer Name';
            }
            column(Country; "Country/Region Code")
            {
                CaptionML = ENU = 'Country';
            }
            column(Filters; FilterText)
            {
                CaptionML = ENU = 'Filters';
            }

            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "Bill-to Customer No." = field("No.");
                DataItemTableView = Sorting("No.");

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
                    column(Exit_Point; Test)
                    {
                        CaptionML = ENU = 'Test';
                    }


                }


            }

            trigger OnPreDataItem()
            begin
                FilterText := Customer.GetFilter("No.");
            end;

            trigger OnAfterGetRecord()
            begin
                T.SetLanguage('SVE', CurrReport.ObjectId(false)); //Måste köras innan man sätter X-funktionen

                T.x('Customer Name');
                T.x('Country');
                T.x('Filters');
                T.x('Order No.');
                T.x('Order Date');
                T.x('Show Lines');
                T.x('Itemo No.');
                T.x('Description');
                T.x('Quantity');
                T.x('Amount');
                T.x('Test');

            end;

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
        T2: Record "PEB Translation Texts-2" temporary;
        T: Record "PEB Document Translation" temporary;
        docMgt: Codeunit "PEB Document Text Mgt.";
        ShowLines: Boolean;
        CustomerNo: Code[20];
        OrderNo: Code[20];
        FilterText: Text[100];
        ShowDetails: Boolean;
        ShowSummariesOnly: Boolean;
        Test: Text[100];


}