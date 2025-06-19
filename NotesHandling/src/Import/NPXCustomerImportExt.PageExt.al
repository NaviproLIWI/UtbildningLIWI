/// <summary>
/// PageExtension NPX Customer Import (ID 50410) extends Record Customer List.
/// </summary>
pageextension 50410 "NPX Customer Import" extends "Customer List"
{
    actions
    {
        addfirst(processing)
        {
            action(ImportNotesFMExcel)
            {
                Caption = 'Import Notes From Excel';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportNotesFromExcel();
                end;
            }
            action(ImportNoteDates)
            {

                Caption = 'Import Note Dates';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                trigger OnAction()
                begin
                    UpdateNoteDatesFromExcelOnly();
                end;

            }
            action(ExportNotesToExcel) //CustomerExport
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
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
        LastLinkID: Integer;

    local procedure ImportNotesFromExcel()
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        headerCreatedCol: Integer;
        headerUserIdCol: Integer;
        headerVal: Text;
        FullNote: Text;
        Chunk: Text;
        CustNo: Text;
        UserIdText: Text;
        CreatedText: Text;
        RecordLink: Record "Record Link";
        Customer: Record Customer;
        RecordLinkMgt: Codeunit "Record Link Management";
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No."
        else
            exit;

        headerCreatedCol := 0;
        headerUserIdCol := 0;

        for ColNo := 1 to 50 do begin
            headerVal := GetValueAtCell(1, ColNo);
            if headerVal = RecordLink.FieldCaption(Created) then
                headerCreatedCol := ColNo;
            if headerVal = RecordLink.FieldCaption("User ID") then
                headerUserIdCol := ColNo;
            if (headerCreatedCol > 0) and (headerUserIdCol > 0) then
                break;


        end;

        GetLastLinkID();
        for RowNo := 2 to MaxRowNo do begin
            CustNo := GetValueAtCell(RowNo, 1);
            UserIdText := GetValueAtCell(RowNo, headerUserIdCol);
            if Customer.Get(CustNo) then begin
                LastLinkID += 1;
                RecordLink.Init();
                RecordLink."Link ID" := LastLinkID;
                RecordLink.Insert();
                RecordLink.Company := CompanyName;
                RecordLink.Type := RecordLink.Type::Note;

                CreatedText := GetValueAtCell(RowNo, headerCreatedCol);
                if not Evaluate(RecordLink.Created, CreatedText) then
                    RecordLink.Created := CurrentDateTime;

                RecordLink."User ID" := UserIdText;
                Customer.Get(GetValueAtCell(RowNo, 1));
                RecordLink."Record ID" := Customer.RecordId;

                FullNote := '';
                for ColNo := 3 to headerCreatedCol - 1 do begin
                    chunk := GetValueAtCell(RowNo, ColNo);
                    if Chunk <> '' then
                        FullNote += Chunk
                end;
                RecordLinkMgt.WriteNote(RecordLink, FullNote);
                RecordLink.Modify();
            end;


        end;
        Message(ExcelImportSucess);
    end;


    local procedure GetLastLinkID()
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.Reset();
        if RecordLink.FindLast() then
            LastLinkID := RecordLink."Link ID"
        else
            LastLinkID := 0;
    end;

    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile = '' then
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, TempExcelBuffer.SelectSheetsNameStream(IStream));
        TempExcelBuffer.ReadSheet();
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    local procedure UpdateNoteDatesFromExcelOnly()
    var
        ExcelRow: Integer;
        ColNo: Integer;
        MaxRowNo: Integer;
        hdrLinkIdCol: Integer;
        hdrCreatedCol: Integer;
        hdrUserIdCol: Integer;
        hdrCustNrCol: Integer;
        headerVal: Text;
        LinkIDText: Text;
        LinkID: Integer;
        CreatedText: Text;
        CustNoText: Text;
        FullNote: Text;
        Chunk: Text;
        NoteText: Text;
        CustNo: Integer;
        CreatedDT: DateTime;
        RecLink: Record "Record Link";
        Customer: Record Customer;
        RecordLinkMgt: Codeunit "Record Link Management";
    begin
        ReadExcelSheet();


        TempExcelBuffer.Reset();
        if not TempExcelBuffer.FindLast() then
            exit;
        MaxRowNo := TempExcelBuffer."Row No.";

        hdrCustNrCol := 0;
        hdrCreatedCol := 0;
        hdrUserIdCol := 0;
        for ColNo := 1 to 50 do begin
            headerVal := GetValueAtCell(1, ColNo);

            if headerVal = Customer.FieldCaption("No.") then
                hdrCustNrCol := ColNo;
            if headerVal = RecLink.FieldCaption(Created) then
                hdrCreatedCol := ColNo;
            if headerVal = RecLink.FieldCaption("User ID") then
                hdrUserIdCol := ColNo;


            if (hdrCreatedCol > 0) and (hdrUserIdCol > 0) and (hdrCustNrCol > 0) then
                break;
        end;
        if hdrCustNrCol = 0 then
            Error('Kolumnen "%1" saknas i Excel.', Customer.FieldCaption("No."));
        if hdrCreatedCol = 0 then
            Error('Kolumnen "%1" saknas i Excel.', RecLink.FieldCaption(Created));
        if hdrUserIdCol = 0 then
            Error('Kolumnen "%1" saknas i Excel.', RecLink.FieldCaption("User ID"));

        for ExcelRow := 2 to MaxRowNo do begin
            CreatedText := GetValueAtCell(ExcelRow, hdrCreatedCol);
            CustNoText := GetValueAtCell(ExcelRow, hdrCustNrCol);

            if (CustNoText <> '') and Evaluate(CreatedDT, CreatedText) then begin
                if Customer.Get(CustNoText) then begin
                    FullNote := GetValueAtCell(ExcelRow, 4) + GetValueAtCell(ExcelRow, 5);
                end;

                RecLink.Reset();
                RecLink.SetRange("Record ID", Customer.RecordId);
                RecLink.SetRange(Type, RecLink.Type::Note);
                RecLink.SetRange("User ID", GetValueAtCell(ExcelRow, hdrUserIdCol));
                if RecLink.FindSet() then
                    repeat
                        RecLink.CalcFields(Note);
                        NoteText := RecordLinkMgt.ReadNote(RecLink);
                        if NoteText = FullNote then begin
                            RecLink.Created := CreatedDT;
                            RecLink.Modify();
                            break;
                        end;
                    until RecLink.Next() = 0;

            end;
        end;

        Message('Dates Updated.');

    end;

    local procedure ExportNotesToExcel(var Customer: Record Customer) //CustomerExport
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
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption("Link ID"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
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
                        TempExcelBuffer.AddColumn(RecordLink."Link ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
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
