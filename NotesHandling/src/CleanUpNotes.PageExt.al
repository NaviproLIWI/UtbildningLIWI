// pageextension 50414 "Clean Up Notes" extends "Customer List"
// {


//     actions
//     {
//         addfirst(Processing)
//         {
//             action(DeleteAllNotes)
//             {
//                 Caption = 'Delete All Notes';
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = Import;
//                 trigger OnAction()
//                 begin
//                     ConfirmAndDeleteNotes(Rec);
//                 end;
//             }
//         }
//     }

//     procedure ConfirmAndDeleteNotes(var Customer: Record Customer)
//     var
//         Recordlink: Record "Record Link";
//         Msg: text;
//     begin
//         Msg := StrSubstNo('Are you sure you want to delete all notes for customer %1 (%2)?', Customer."No.", Customer.Name);
//         if not Confirm(Msg, true) then
//             exit;

//         Recordlink.Reset();
//         Recordlink.SetRange(Type, Recordlink.Type::Note);
//         Recordlink.SetRange("Record ID", customer.RecordId);

//         if Recordlink.FindSet() then
//             repeat
//                 Recordlink.Delete(true)
//             until Recordlink.Next() = 0;
//         Message('All notes deleted for customer %1.', Customer."No.");

//     end;


// }