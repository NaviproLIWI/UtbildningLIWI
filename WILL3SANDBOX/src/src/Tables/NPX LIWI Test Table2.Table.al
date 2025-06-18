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

            // trigger OnValidate() //TODO: Lade OnValidate I table istället för test.
            // var
            //     Calculator: Codeunit Calculator;
            //     Succes: Boolean;
            //     LocalResult: Decimal;
            //     LocalError: Text[250];
            // begin
            //     rec.Valid := true; //TODO: steg1
            //     rec.Error := '';
            //     rec.Result := '';

            //     if rec.Text = '' then begin
            //         rec.Error := 'Inget uttryck angivet.';
            //         exit;
            //     end;



            //     // if Rec.Text <> '' then begin
            //     Calculator.SetText(rec.Text);
            //     Succes := Calculator.Execute();

            //     if Succes then begin
            //         LocalResult := Calculator.GetResult();
            //         Rec.Result := Format(LocalResult, 0, '<Integer>'); //TODO: ta bort mellanslag
            //         Rec.Error := '';
            //     end else begin
            //         LocalError := Calculator.GetErrorText();
            //         rec.Error := LocalError;
            //         Rec.Result := '';

            //     end;
            //     Rec.Modify(true);


            // end;

            trigger OnValidate() //SENASTE
            var
                Calculator: Codeunit Calculator;
                Succes: Boolean;
                LocalResult: Decimal;
                LocalError: Text[250];
                TempStr: Text;
            begin
                Rec.Valid := true;
                Rec.Error := '';
                Rec.Result := '';

                if Rec.Text = '' then begin
                    Rec.Error := 'Inget uttryck angivet.';
                    exit;
                end;

                Calculator.SetText(Rec.Text);
                Succes := Calculator.Execute();
                if Succes then begin
                    LocalResult := Calculator.GetResult();
                    if LocalResult < 0 then begin
                        TempStr := Format(LocalResult);
                        TempStr := TempStr.Replace(' ', '');
                        Rec.Result := TempStr;
                    end else begin
                        TempStr := Format(LocalResult);
                        TempStr := TempStr.Replace(' ', '');
                        Rec.Result := TempStr;
                    end;
                    Rec.Error := '';
                end else begin
                    LocalError := Calculator.GetErrorText();
                    Rec.Error := LocalError;
                    Rec.Result := '';
                end;

                // OBS! Ta inte med Rec.Modify(true) här, eftersom ändringar i OnValidate sparas automatiskt.
            end;
        }
        field(4; Valid; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; Result; Text[100])
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
        TestRec: Record "NPX LIWI Test Table2";
        NewNo: Integer;
        NewNoStr: Text[10];
    begin
        // Sätt filter på den aktuella typen
        TestRec.Reset();
        TestRec.SetRange(Type, Rec.Type);

        // Om det finns poster med samma Type, hämta det högsta "No."-värdet och öka med 1,
        // annars starta på 0.
        if TestRec.FindLast() then begin
            if Evaluate(NewNo, TestRec."No.") then
                NewNo := NewNo + 1
            else
                NewNo := 0;
        end else
            NewNo := 0;

        // Om en post med den kombinationen redan finns, öka NewNo tills ett ledigt nummer hittas.
        repeat
            NewNoStr := Format(NewNo);
            TestRec.Reset();
            TestRec.SetRange("No.", NewNoStr);
            TestRec.SetRange(Type, Rec.Type);
            if TestRec.FindFirst() then
                NewNo += 1;
        until not TestRec.FindFirst();

        Rec."No." := NewNoStr;
        Rec."Created DT" := CurrentDateTime();
    end;


    // trigger OnInsert()
    // var
    //     MaxRec: Record "NPX LIWI Test Table2";
    //     MaxNo: Integer;
    //     MaxNoStr: Text[10];
    // begin
    //     if MaxRec.FindLast() then begin
    //         if Evaluate(MaxNo, MaxRec."No.") then
    //             MaxNo := MaxNo + 1
    //         else
    //             MaxNo := 0;
    //     end else
    //         MaxNo := 0;

    //     MaxNoStr := Format(MaxNo);
    //     "No." := MaxNoStr;

    //     "Created DT" := CurrentDateTime();
    // end;

    // if FindLast() then begin
    //     if Evaluate(MaxNo, "No.") then
    //         MaxNo := MaxNo + 1
    //     else
    //         MaxNo := 0;
    // end else
    //     MaxNo := 0;

    // MaxNoStr := Format(MaxNo);
    // "No." := MaxNoStr;

    local procedure Power10(Exponent: Integer): Decimal
    var
        i: Integer;
        Res: Decimal;
    begin
        Res := 1;
        for i := 1 to Exponent do
            Res := Res * 10;
        exit(Res);
    end;

}