report 50102 "Usage Statistics Matrix Report"
{
    Caption = 'Usage Statistics Matrix';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayoutss/UsageStatisticsMatrixReport.rdl';

    dataset
    {
        dataitem(UsageStatistics; "Usage Statistics")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Start Date", "End Date", "Table No.";

            column(TableName; "Table Name")
            {
            }

            column(EndDate; "End Date")
            {
            }

            column(Count; Count)
            {
            }
        }
    }
}