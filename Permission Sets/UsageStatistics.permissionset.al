namespace RahulB;

using RahulB.BCUsageStatistics;

permissionset 50100 UsageStatistics
{
    Assignable = true;
    Permissions = tabledata "Usage Statistics" = RIMD,
        tabledata "Usage Statistics Configuration" = RIMD,
        tabledata "Usage Statistics Setup" = RIMD,
        table "Usage Statistics" = X,
        table "Usage Statistics Configuration" = X,
        table "Usage Statistics Setup" = X,
        report "Generate Usage Statistics" = X,
        page "Usage Statistics API" = X,
        page "Usage Statistics Configuration" = X,
        page "Usage Statistics List" = X,
        page "Usage Statistics Setup" = X,
        page "User Selection" = X;
}