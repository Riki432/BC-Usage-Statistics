page 50102 "Usage Statistics Configuration"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Usage Statistics Configuration";
    Caption = 'Usage Statistics Configuration';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the table number for which usage statistics will be collected.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the table.';
                }
            }
        }
    }
}
