table 50101 "Usage Statistics Setup"
{
    Caption = 'Usage Statistics Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;
        }
        field(3; "Schedule Frequency"; Enum "Usage Statistics Frequency")
        {
            Caption = 'Schedule Frequency';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if xRec."Schedule Frequency" <> "Schedule Frequency" then
                    UpdateJobQueueEntry();
            end;
        }
        field(4; "Skip Users"; Text[2048])
        {
            Caption = 'Skip Users';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure UpdateJobQueueEntry()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueCategory: Record "Job Queue Category";
        DateFormula: DateFormula;
    begin
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", Report::"Generate Usage Statistics");
        JobQueueEntry.DeleteAll();

        if "Schedule Frequency" = "Schedule Frequency"::" " then
            exit;

        if not JobQueueCategory.Get('USAGESTATS') then begin
            JobQueueCategory.Init();
            JobQueueCategory.Code := 'USAGESTATS';
            JobQueueCategory.Description := 'Usage Statistics';
            JobQueueCategory.Insert();
        end;

        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Report;
        JobQueueEntry."Object ID to Run" := Report::"Generate Usage Statistics";
        JobQueueEntry."Job Queue Category Code" := 'USAGESTATS';
        JobQueueEntry.Description := 'Generate Usage Statistics';
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime();
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."Report Output Type" := JobQueueEntry."Report Output Type"::"None (Processing only)";

        case "Schedule Frequency" of
            "Schedule Frequency"::Daily:
                Evaluate(DateFormula, '<1D>');
            "Schedule Frequency"::Weekly:
                Evaluate(DateFormula, '<1W>');
            "Schedule Frequency"::Monthly:
                Evaluate(DateFormula, '<1M>');
        end;

        JobQueueEntry."Next Run Date Formula" := DateFormula;
        JobQueueEntry.Insert(true);
    end;

    trigger OnInsert()
    begin
        Validate("Primary Key", 'DEFAULT');
    end;

    procedure SelectSkipUsers()
    var
        User: Record User;
        UserSelection: Page "User Selection";
        SelectedUsers: Text;
    begin
        UserSelection.LookupMode(true);
        if UserSelection.RunModal() = Action::LookupOK then begin
            UserSelection.GetSelectedUsers(User);
            if User.FindSet() then
                repeat
                    if SelectedUsers = '' then
                        SelectedUsers := User."User Name"
                    else
                        SelectedUsers += '|' + User."User Name";
                until User.Next() = 0;
            Rec.Validate("Skip Users", SelectedUsers);
            Rec.Modify(true);
        end;
    end;
}