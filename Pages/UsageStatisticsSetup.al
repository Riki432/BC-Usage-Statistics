page 50101 "Usage Statistics Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Usage Statistics Setup";
    Caption = 'Usage Statistics Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether usage statistics collection is enabled.';
                }
                field("Schedule Frequency"; Rec."Schedule Frequency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how often the usage statistics should be generated.';
                }

                field("Skip Users"; Rec."Skip Users")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies users to skip from usage statistics collection.';

                    trigger OnDrillDown()
                    var
                        UserSelection: Page "User Selection";
                        User: Record User;
                    begin
                        UserSelection.LookupMode(true);
                        if UserSelection.RunModal() = Action::LookupOK then begin
                            UserSelection.GetSelectedUsers(User);
                            if User.FindSet() then
                                repeat
                                    if Rec."Skip Users" = '' then
                                        Rec."Skip Users" := '<>' + User."User Name"
                                    else
                                        Rec."Skip Users" += '&<>' + User."User Name";
                                until User.Next() = 0;
                            Rec.Modify(true);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(OpenConfigurationActionRef; OpenConfiguration)
            {
            }
            actionref(OpenStatisticsListActionRef; OpenStatisticsList)
            {
            }
            actionref(DeleteAllStatisticsActionRef; DeleteAllStatistics)
            {
            }

        }
        area(Processing)
        {
            action(DeleteAllStatistics)
            {
                ApplicationArea = All;
                Caption = 'Delete All Statistics';
                Image = Delete;
                ToolTip = 'Delete all usage statistics records.';

                trigger OnAction()
                var
                    UsageStatistics: Record "Usage Statistics";
                    ConfirmDeleteQst: Label 'Are you sure you want to delete all usage statistics?';
                begin
                    if not Confirm(ConfirmDeleteQst) then
                        exit;

                    UsageStatistics.DeleteAll();
                    Message('All usage statistics have been deleted.');
                end;
            }

        }
        area(Navigation)
        {
            action(OpenConfiguration)
            {
                ApplicationArea = All;
                Caption = 'Table Configuration';
                Image = Setup;
                ToolTip = 'Open the table configuration page to manage which tables to collect statistics for.';
                RunObject = page "Usage Statistics Configuration";
            }

            action(OpenStatisticsList)
            {
                ApplicationArea = All;
                Caption = 'Usage Statistics';
                Image = Statistics;
                ToolTip = 'Open the usage statistics list to view collected statistics.';
                RunObject = page "Usage Statistics List";
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}