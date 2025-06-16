pageextension 50411 "NPX Customer Export" extends "Customer List"
{
    actions
    {
        addfirst(processing)
        {
            action(ExportNotesToExcel)
            {
                Caption = 'Export Notes to Excel';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction()
                begin
                    ExportNotesToExcel(Rec);
                end;
            }
        }
    }

    var
        CurrentRow: Integer;
        CurrentCol: Integer;

    local procedure ExportNotesToExcel(var Customer: Record Customer)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        NotesLbl: Label 'Notes';
        ExcelFileName: Label 'Notes_%1_%2';
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
        NoteText: Text;
        maxChunks: Integer;
        needed: Integer;
        hdrChunk: Integer;
        dataChunk: Integer;
    begin
        maxChunks := 1;
        if Customer.FindSet() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Customer.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat
                        RecordLink.CalcFields(Note);
                        NoteText := RecordLinkMgt.ReadNote(RecordLink);
                        needed := (StrLen(NoteText) + 249) DIV 250;
                        if needed > maxChunks then
                            maxChunks := needed;
                    until RecordLink.Next() = 0;
            until customer.Next() = 0;

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Customer.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Customer.FieldCaption(Name), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        for hdrChunk := 1 to maxChunks do
            TempExcelBuffer.AddColumn(StrSubstNo('%1 part %2', RecordLink.FieldCaption(Note), hdrChunk),
            false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Created), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption("User ID"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


        if Customer.FindSet() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", customer.RecordId);
                RecordLink.SetRange(type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat

                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(Customer."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        RecordLink.CalcFields(Note);
                        NoteText := RecordLinkMgt.ReadNote(RecordLink);

                        for dataChunk := 1 to maxChunks do begin
                            TempExcelBuffer.AddColumn(CopyStr(NoteText, (dataChunk - 1) * 250 + 1, 250),
                                  false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        end;

                        TempExcelBuffer.AddColumn(RecordLink.Created, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink."User ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until Customer.Next() = 0;


        TempExcelBuffer.CreateNewBook(NotesLbl);
        TempExcelBuffer.WriteSheet(NotesLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;


}










