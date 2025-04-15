/// <summary>
/// Report to generate usage statistics for configured tables.
/// This report counts the number of records in each configured table within a specified date range.
/// </summary>
report 50101 "Generate Usage Statistics"
{
    Caption = 'Generate Usage Statistics';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        /// <summary>
        /// Iterates through all configured tables in the Usage Statistics Configuration table.
        /// For each table, counts the records within the specified date range and creates a usage statistics entry.
        /// </summary>
        dataitem(Configuration; "Usage Statistics Configuration")
        {
            DataItemTableView = sorting("Table No.");

            /// <summary>
            /// For each configured table:
            /// 1. Opens the table using RecordRef
            /// 2. Counts records within the specified date range using SystemCreatedAt field
            /// 3. Creates a new entry in the Usage Statistics table with the count
            /// </summary>
            trigger OnAfterGetRecord()
            var
                RecordRef: RecordRef;
                FieldRef: FieldRef;
                UsageStatistics: Record "Usage Statistics";
                Count: Integer;
            begin
                RecordRef.Open("Table No.");
                FieldRef := RecordRef.Field(RecordRef.SystemCreatedAtNo());
                FieldRef.SetRange(StartDate, EndDate);
                FieldRef := RecordRef.Field(RecordRef.SystemCreatedByNo());
                if UsageStatisticsSetup."Skip Users" <> '' then
                    FieldRef.SetFilter(UsageStatisticsSetup."Skip Users");

                Count := RecordRef.Count();
                RecordRef.Close();

                UsageStatistics.Init();
                UsageStatistics."Entry No." := UsageStatistics.GetLastEntryNo() + 1;
                UsageStatistics."Start Date" := StartDate;
                UsageStatistics."End Date" := EndDate;
                UsageStatistics."Table No." := "Table No.";
                UsageStatistics."Table Name" := "Table Name";
                UsageStatistics.Count := Count;
                UsageStatistics.Insert(true);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    /// <summary>
                    /// Specifies the start date for the statistics period.
                    /// If left blank, will be calculated based on the schedule frequency.
                    /// </summary>
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    /// <summary>
                    /// Specifies the end date for the statistics period.
                    /// If left blank, will be set to today's date.
                    /// </summary>
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    /// <summary>
    /// Sets the date range automatically if not specified in the request page.
    /// The date range is calculated based on the schedule frequency in the Usage Statistics Setup:
    /// - Daily: Last 24 hours
    /// - Weekly: Last 7 days
    /// - Monthly: Last 30 days
    /// </summary>
    trigger OnPreReport()
    begin
        if (StartDate = 0D) or (EndDate = 0D) then begin
            if not UsageStatisticsSetup.Get() then
                Error('Usage Statistics Setup not found.');

            EndDate := Today;
            case UsageStatisticsSetup."Schedule Frequency" of
                UsageStatisticsSetup."Schedule Frequency"::Daily:
                    StartDate := CalcDate('<-1D>', EndDate);
                UsageStatisticsSetup."Schedule Frequency"::Weekly:
                    StartDate := CalcDate('<-1W>', EndDate);
                UsageStatisticsSetup."Schedule Frequency"::Monthly:
                    StartDate := CalcDate('<-1M>', EndDate);
                else
                    Error('Please specify both Start Date and End Date.');
            end;
        end;
    end;

    /// <summary>
    /// Sets the date range programmatically.
    /// This allows the report to be called from code with predefined dates.
    /// </summary>
    /// <param name="NewStartDate">The start date for the statistics period.</param>
    /// <param name="NewEndDate">The end date for the statistics period.</param>
    procedure SetDates(NewStartDate: Date; NewEndDate: Date)
    begin
        StartDate := NewStartDate;
        EndDate := NewEndDate;
    end;

    var
        UsageStatisticsSetup: Record "Usage Statistics Setup";
        /// <summary>
        /// The start date for the statistics period.
        /// </summary>
        StartDate: Date;
        /// <summary>
        /// The end date for the statistics period.
        /// </summary>
        EndDate: Date;
}
