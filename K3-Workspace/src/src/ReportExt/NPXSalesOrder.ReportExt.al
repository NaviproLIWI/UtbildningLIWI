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

                T.SetLanguage('ENU', CurrReport.ObjectId(false));
                T.x('Test Code');


            end;
        }

        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                T.SetLanguage('ENU', CurrReport.ObjectId(false));
                T.x('Test Code');

                DocMgt.SetHeaderCaption(T.x(LeftCaption), 2);
                DocMgt.SetHeaderCaption(T.x(RightCaption), 3);

                DocMgt.GetArrayData(SourceType::Customer, "Sales Header"."Test Code", "Sales Header"."Currency Code", "Sales Header"."Sell-to Country/Region Code", "Sales Header"."Language Code", CurrReport.ObjectId(false), LeftAddress, RightAdress);


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
        TempTrans: Record "PEB Translation Texts-2";
        SalesLine: Record "Sales Line";
        SourceType: Option " ",Customer,Vendor,"Bank Account","Fixed Asset";
        // NPXDocMgt: Codeunit "PEB Document Text Mgt.";
        LeftAddress: array[8] of Text[100];
        LeftCaption: Text;
        RightAdress: array[8] of Text[100];
        RightCaption: Text;
}