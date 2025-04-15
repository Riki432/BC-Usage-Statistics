table 50102 "Usage Statistics Configuration"
{
    Caption = 'Usage Statistics Configuration';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table No."; Integer)
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
        field(2; "Table Name"; Text[50])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Table No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}