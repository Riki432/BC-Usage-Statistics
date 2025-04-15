namespace RahulB.BCUsageStatistics;
using System.Reflection;

table 50100 "Usage Statistics"
{
    Caption = 'Usage Statistics';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(4; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter(Table));

            trigger OnValidate()
            var
                AllObjWithCaption: Record AllObjWithCaption;
            begin
                if "Table No." <> 0 then begin
                    AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Table, Rec."Table No.");
                    Rec."Table Name" := AllObjWithCaption."Object Caption";
                end
                else
                    Rec."Table Name" := '';
            end;

        }
        field(5; "Table Name"; Text[50])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; Count; Integer)
        {
            Caption = 'Count';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetLastEntryNo(): Integer
    var
        UsageStatistics: Record "Usage Statistics";
    begin
        if UsageStatistics.FindLast() then
            exit(UsageStatistics."Entry No.");
        exit(0);
    end;
}






