reportextension 50200 "NPX Sales Order" extends "PEB Sales Order"
{
    dataset
    {
        add(CopyLoop)
        {


        }
        add("Sales Header")
        {
            column(Test_Code_Header; "Test Code")
            {
                Caption = 'Test Code';
            }
        }

        add(TempSalesDocLine)
        {
            column(Test_Code_Line; "Test Code")
            {
                Caption = 'Test Code';
            }
        }

        modify(TempSalesDocLine)
        {
            trigger OnAfterAfterGetRecord()
            begin
                if TempSalesDocLine."No." = '' then
                    CurrReport.Skip();

                T.SetENULanguage(CurrReport.ObjectId(false));
                T.SetLanguage('ENU', CurrReport.ObjectId(false));


                T.x('Test Code');


            end;
        }



    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'ExtLayout/mylayout.rdl';
        }
    }

    var
        T: Record "PEB Document Translation" temporary;
        SalesLine: Record "Sales Line";
}