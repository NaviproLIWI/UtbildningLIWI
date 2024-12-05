page 50200 "NPX LIWI ListPage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "NPX LIWI Test Table";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ShowVariants)
            {
                Caption = 'Show Variants';
                ApplicationArea = all;
                image = Process;


                trigger OnAction()
                var
                    ItemVariant: Record "Item Variant";
                    PageNoLbl: Label 'the article %1 has no variants';
                    PageHasLbl: Label 'the article %1 has %2 variants.';
                begin
                    if Rec."No." = '' then
                        Message('No article number is selected.')
                    else begin
                        ItemVariant.SetFilter("Item No.", Rec."No.");
                        if ItemVariant.Count = 0 then
                            Message(PageNoLbl, Rec."No.")
                        else
                            Message(PageHasLbl, Rec."No.", ItemVariant.Count);
                    end;

                end;
            }
            action("Selected Rows")
            {
                ApplicationArea = All;
                image = Process;

                trigger OnAction()
                var
                    SelectedRows: Record "NPX LIWI Test Table";
                    SelectedCount: Integer;
                    SelectedRowMessageLbl: Label 'You have selected %1 row(s).';
                begin
                    CurrPage.SetSelectionFilter(SelectedRows);
                    SelectedCount := SelectedRows.Count;
                    Message(SelectedRowMessageLbl, SelectedCount);
                end;



            }
            group(Descriptions)
            {
                action("Article Description")
                {
                    ApplicationArea = All;
                    image = Process;

                    trigger OnAction()
                    var
                        SelectedRow: Record "NPX LIWI Test Table";
                        DescriptionLbl: Label 'Fetched description: %1.';
                        DefaultDescription: Text[100];
                    begin
                        DefaultDescription := 'Default description';

                        CurrPage.SetSelectionFilter(SelectedRow);

                        if SelectedRow.FindFirst() then begin
                            if SelectedRow."No." <> '' then begin
                                if SelectedRow.Description <> '' then
                                    Message(DescriptionLbl, SelectedRow.Description)
                                else
                                    Message(DescriptionLbl, DefaultDescription);
                            end else
                                Message('The row is not an article');
                        end else
                            Message('No rows selected');

                    end;

                }
                action("Check All Articles")
                {
                    Caption = 'Check All Descriptions';
                    ApplicationArea = All;
                    image = Process;

                    trigger OnAction()
                    var
                        SelectedRows: Record "NPX LIWI Test Table";
                        DescriptionLbl: Label 'Row No: %1 - Description: %2.';
                        DefaultDescriptionLbl: Label 'Row No: %1 - Description is empty. Using default: %2.';
                        DefaultDescription: Text[100];
                    begin
                        DefaultDescription := 'Default description';

                        // Sätt filter för markerade rader
                        CurrPage.SetSelectionFilter(SelectedRows);

                        if SelectedRows.FindSet() then begin
                            repeat
                                if SelectedRows.Description <> '' then
                                    Message(DescriptionLbl, SelectedRows."No.", SelectedRows.Description)
                                else
                                    Message(DefaultDescriptionLbl, SelectedRows."No.", DefaultDescription);
                            until SelectedRows.Next() = 0;
                        end else
                            Message('No rows selected.');
                    end;
                }
            }



        }
    }






}