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


        }
    }






}