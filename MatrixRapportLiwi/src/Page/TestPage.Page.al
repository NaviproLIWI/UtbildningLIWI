/// <summary>
/// Page TestPage (ID 50600).
/// </summary>
page 50600 "TestPage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TestTable;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(TestField; Rec.TestField)
                {
                    ApplicationArea = All;
                    ToolTip = 'This is a test field.';
                }
            }

            
        }
        
    }
   


}