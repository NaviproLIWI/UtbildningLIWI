// /// <summary>
// /// PageExtension NPX Customer Import (ID 50410) extends Record Customer List.
// /// </summary>
// pageextension 50410 "NPX Customer Import" extends "Customer List"
// {
//     actions
//     {
//         addfirst(processing)
//         {
//             action(ImportNotesFMExcel)
//             {
//                 Caption = 'Import Notes From Excel';
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = Import;
//                 trigger OnAction()
//                 begin
//                     ReadExcelSheet();
//                     ImportNotesFromExcel();
//                 end;
//             }
//             action(ImportNoteDates)
//             {

//                 Caption = 'Import Note Dates';
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = Import;
//                 trigger OnAction()
//                 begin
//                     UpdateNoteDatesFromExcelOnly();
//                 end;

//             }
//         }
//     }
//     var
//         TempExcelBuffer: Record "Excel Buffer" temporary;
//         UploadExcelMsg: Label 'Please Choose the Excel file.';
//         NoFileFoundMsg: Label 'No Excel file found!';
//         ExcelImportSucess: Label 'Excel is successfully imported.';
//         LastLinkID: Integer;

//     local procedure ImportNotesFromExcel()
//     var
//         RowNo: Integer;
//         ColNo: Integer;
//         LineNo: Integer;
//         MaxRowNo: Integer;
//         headerCreatedCol: Integer;
//         headerUserIdCol: Integer;
//         headerVal: Text;
//         FullNote: Text;
//         Chunk: Text;
//         CustNo: Text;
//         UserIdText: Text;
//         CreatedText: Text;
//         RecordLink: Record "Record Link";
//         Customer: Record Customer;
//         RecordLinkMgt: Codeunit "Record Link Management";
//     begin
//         TempExcelBuffer.Reset();
//         if TempExcelBuffer.FindLast() then
//             MaxRowNo := TempExcelBuffer."Row No."
//         else
//             exit;

//         headerCreatedCol := 0;
//         headerUserIdCol := 0;

//         for ColNo := 1 to 50 do begin
//             headerVal := GetValueAtCell(1, ColNo);
//             if headerVal = RecordLink.FieldCaption(Created) then
//                 headerCreatedCol := ColNo;
//             if headerVal = RecordLink.FieldCaption("User ID") then
//                 headerUserIdCol := ColNo;
//             if (headerCreatedCol > 0) and (headerUserIdCol > 0) then
//                 break;


//         end;

//         GetLastLinkID();
//         for RowNo := 2 to MaxRowNo do begin
//             CustNo := GetValueAtCell(RowNo, 1);
//             UserIdText := GetValueAtCell(RowNo, headerUserIdCol);
//             if Customer.Get(CustNo) then begin
//                 LastLinkID += 1;
//                 RecordLink.Init();
//                 RecordLink."Link ID" := LastLinkID;
//                 RecordLink.Insert();
//                 RecordLink.Company := CompanyName;
//                 RecordLink.Type := RecordLink.Type::Note;

//                 CreatedText := GetValueAtCell(RowNo, headerCreatedCol);
//                 if not Evaluate(RecordLink.Created, CreatedText) then
//                     RecordLink.Created := CurrentDateTime;

//                 RecordLink."User ID" := UserIdText;
//                 Customer.Get(GetValueAtCell(RowNo, 1));
//                 RecordLink."Record ID" := Customer.RecordId;

//                 FullNote := '';
//                 for ColNo := 3 to headerCreatedCol - 1 do begin
//                     chunk := GetValueAtCell(RowNo, ColNo);
//                     if Chunk <> '' then
//                         FullNote += Chunk
//                 end;
//                 RecordLinkMgt.WriteNote(RecordLink, FullNote);
//                 RecordLink.Modify();
//             end;


//         end;
//         Message(ExcelImportSucess);
//     end;


//     local procedure GetLastLinkID()
//     var
//         RecordLink: Record "Record Link";
//     begin
//         RecordLink.Reset();
//         if RecordLink.FindLast() then
//             LastLinkID := RecordLink."Link ID"
//         else
//             LastLinkID := 0;
//     end;

//     local procedure ReadExcelSheet()
//     var
//         FileMgt: Codeunit "File Management";
//         IStream: InStream;
//         FromFile: Text[100];
//     begin
//         UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
//         if FromFile = '' then
//             Error(NoFileFoundMsg);
//         TempExcelBuffer.Reset();
//         TempExcelBuffer.DeleteAll();
//         TempExcelBuffer.OpenBookStream(IStream, TempExcelBuffer.SelectSheetsNameStream(IStream));
//         TempExcelBuffer.ReadSheet();
//     end;

//     local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
//     begin
//         TempExcelBuffer.Reset();
//         If TempExcelBuffer.Get(RowNo, ColNo) then
//             exit(TempExcelBuffer."Cell Value as Text")
//         else
//             exit('');
//     end;

//     local procedure UpdateNoteDatesFromExcelOnly()
//     var
//         ExcelRow: Integer;
//         ColNo: Integer;
//         MaxRowNo: Integer;
//         hdrLinkIdCol: Integer;
//         hdrCreatedCol: Integer;
//         hdrUserIdCol: Integer;
//         headerVal: Text;
//         LinkIDText: Text;
//         LinkID: Integer;
//         CreatedText: Text;
//         CreatedDT: DateTime;
//         RecLink: Record "Record Link";
//     begin
//         ReadExcelSheet();


//         TempExcelBuffer.Reset();
//         if not TempExcelBuffer.FindLast() then
//             exit;
//         MaxRowNo := TempExcelBuffer."Row No.";


//         hdrLinkIdCol := 0;
//         hdrCreatedCol := 0;
//         hdrUserIdCol := 0;
//         for ColNo := 1 to 50 do begin
//             headerVal := GetValueAtCell(1, ColNo);
//             if headerVal = RecLink.FieldCaption("Link ID") then
//                 hdrLinkIdCol := ColNo;
//             if headerVal = RecLink.FieldCaption(Created) then
//                 hdrCreatedCol := ColNo;
//             if headerVal = RecLink.FieldCaption("User ID") then
//                 hdrUserIdCol := ColNo;
//             if (hdrLinkIdCol > 0) and (hdrCreatedCol > 0) and (hdrUserIdCol > 0) then
//                 break;
//         end;

//         if hdrLinkIdCol = 0 then
//             Error('Kolumnen "%1" saknas i Excel.', RecLink.FieldCaption("Link ID"));
//         if hdrCreatedCol = 0 then
//             Error('Kolumnen "%1" saknas i Excel.', RecLink.FieldCaption(Created));


//         for ExcelRow := 2 to MaxRowNo do begin
//             LinkIDText := GetValueAtCell(ExcelRow, hdrLinkIdCol);
//             CreatedText := GetValueAtCell(ExcelRow, hdrCreatedCol);
//             if Evaluate(LinkID, LinkIDText) and Evaluate(CreatedDT, CreatedText) then begin
//                 if RecLink.Get(LinkID) then begin
//                     RecLink.Created := CreatedDT;
//                     RecLink."User ID" := GetValueAtCell(ExcelRow, hdrUserIdCol);
//                     Reclink.Modify();
//                 end;
//             end;
//         end;

//         Message('Datum uppdaterade på %1 anteckningar via Link ID.', MaxRowNo - 1);
//     end;








// }
