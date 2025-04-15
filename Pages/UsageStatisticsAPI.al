page 50104 "Usage Statistics API"
{
    PageType = API;
    Caption = 'Usage Statistics API';
    APIPublisher = 'BCUsageStats';
    APIGroup = 'usage';
    APIVersion = 'v1.0';
    EntityName = 'usageStatistics';
    EntitySetName = 'usageStatistics';
    SourceTable = "Usage Statistics";
    Editable = false;
    ODataKeyFields = "Entry No.";
    DataAccessIntent = ReadOnly;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }
                field(tableNo; Rec."Table No.")
                {
                    Caption = 'Table No.';
                }
                field(tableName; Rec."Table Name")
                {
                    Caption = 'Table Name';
                }
                field(count; Rec.Count)
                {
                    Caption = 'Count';
                }
            }
        }
    }
}