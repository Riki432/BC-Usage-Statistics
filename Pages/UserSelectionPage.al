page 50103 "User Selection"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = User;
    Caption = 'Select Users';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Select)
            {
                ApplicationArea = All;
                Caption = 'Select';
                Image = Select;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    CurrPage.Close();
                end;
            }
        }
    }

    procedure GetSelectedUsers(var User: Record User)
    begin
        CurrPage.SetSelectionFilter(User);
    end;
}