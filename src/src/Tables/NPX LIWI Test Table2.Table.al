table 50201 "NPX LIWI Test Table2"
{
    Caption = 'TestTable 2';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Type; Enum NewType)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
        field(3; Text; Text[100])
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     Valid := true;
            //     Error := '';
            //     Result := ''; 
            // end;

            trigger OnValidate() //TODO: Lade OnValidate I table istället för test.
            var
                Calculator: Codeunit Calculator;
                Succes: Boolean;
                LocalResult: Decimal;
                LocalError: Text[250];
            begin
                rec.Valid := true; //TODO: steg1
                rec.Error := '';
                rec.Result := '';

                if rec.Text = '' then begin
                    rec.Error := 'Inget uttryck angivet.';
                    exit;
                end;



                // if Rec.Text <> '' then begin
                Calculator.SetText(rec.Text);
                Succes := Calculator.Execute();

                if Succes then begin
                    LocalResult := Calculator.GetResult();
                    Rec.Result := Format(LocalResult, 0, '<Integer>'); //TODO: ta bort mellanslag
                    Rec.Error := '';
                end else begin
                    LocalError := Calculator.GetErrorText();
                    rec.Error := LocalError;
                    Rec.Result := '';

                end;
                Rec.Modify(true);


            end;
        }
        field(4; Valid; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; Result; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Error; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created DT"; DateTime)
        {
            DataClassification = ToBeClassified;
        }






    }

    keys
    {
        key(PK; "No.", Type)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        MaxRec: Record "NPX LIWI Test Table2";
        MaxNo: Integer;
        MaxNoStr: Text[10];
    begin
        if MaxRec.FindLast() then begin
            if Evaluate(MaxNo, MaxRec."No.") then
                MaxNo := MaxNo + 1
            else
                MaxNo := 0;
        end else
            MaxNo := 0;

        MaxNoStr := Format(MaxNo);
        "No." := MaxNoStr;

        "Created DT" := CurrentDateTime();
    end;

    // if FindLast() then begin
    //     if Evaluate(MaxNo, "No.") then
    //         MaxNo := MaxNo + 1
    //     else
    //         MaxNo := 0;
    // end else
    //     MaxNo := 0;

    // MaxNoStr := Format(MaxNo);
    // "No." := MaxNoStr;









}