report 50202 "NPX LIWI Process Only"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(CleanOld; CleanOld)
                {
                    Caption = 'Clean Old Data.';
                    ToolTip = 'Check this option to delete old data before inserting new rows.';
                }
                field(HasNoVariants; HasNoVariants)
                {
                    Caption = 'Has No Variants';
                    ToolTip = 'Check this option to fetch articles with no variants';
                }

            }

        }
    }

    trigger OnPostReport()
    var
        FilterOkLbl: Label '10 rows have been fetched from "Item". Do you want to add them to the "NPX LIWI Test Table"?';
        FilterCancelLbl: Label 'Operation was canceled.';
        FilterDeleteLbl: Label 'Old data has been cleaned.';
    begin
        if CleanOld then
            CleanOldData();

        if Confirm(FilterOkLbl, false) then
            ProcessItems()
        else
            Message(FilterCancelLbl);
    end;

    procedure CleanOldData()
    var
        TestTable: Record "NPX LIWI Test Table";
        FilterDeleteLbl: Label 'Old data has been cleaned.';
    begin
        TestTable.DeleteAll();
        Message(FilterDeleteLbl);
    end;

    procedure ProcessItems()
    var
        TestTable: Record "NPX LIWI Test Table";
        Counter: Integer;
        ItemVariant: Record "Item Variant";
    begin
        counter := 0;

        if Item.FindSet() then begin
            repeat
                if HasNoVariants then begin
                    ItemVariant.SetRange("Item No.", Item."No.");
                    if ItemVariant.FindFirst() then
                        exit;

                end;

                if Counter >= 10 then
                    break;

                TestTable.Init();
                TestTable."No." := Item."No.";
                TestTable.Description := Item.Description;
                TestTable.Insert();

                Counter += 1;
            until Item.Next() = 0;
        end;
    end;

    var
        CleanOld: Boolean;
        HasNoVariants: Boolean;
}