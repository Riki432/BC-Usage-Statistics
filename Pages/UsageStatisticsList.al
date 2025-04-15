page 50100 "Usage Statistics List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    Editable = false;
    SourceTable = "Usage Statistics";
    Caption = 'Usage Statistics';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
                field(Count; Rec.Count)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}