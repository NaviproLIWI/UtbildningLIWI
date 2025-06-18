// /// <summary>
// /// PageExtension NPX Sales Order Import (ID 50413) extends Record Sales Order List.
// /// </summary>
// pageextension 50413 "NPX Sales Order Import" extends "Sales Order List"
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
//         OrderNo: Text;
//         UserIdText: Text;
//         CreatedText: Text;
//         RecordLink: Record "Record Link";
//         SalesOrder: Record "Sales Header";
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
//             OrderNo := GetValueAtCell(RowNo, 1);
//             UserIdText := GetValueAtCell(RowNo, headerUserIdCol);
//             if SalesOrder.Get(SalesOrder."Document Type"::Order, OrderNo) then begin
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
//                 OrderNo := GetValueAtCell(RowNo, 1);
//                 SalesOrder.Get(SalesOrder."Document Type"::Order, OrderNo);
//                 RecordLink."Record ID" := SalesOrder.RecordId;

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


// }