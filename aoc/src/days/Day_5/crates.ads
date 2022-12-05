package Crates with SPARK_Mode is
    Max_Stacks : constant := 9;
    Max_Crate_Per_Stack : constant := 60;
    Max_Moves : constant := 1000;

    subtype Crate_T is Character;

    subtype Stack_Column_Index is Natural range 1 .. Max_Stacks;
    subtype Stack_Row_Index is Natural range 1 .. Max_Crate_Per_Stack;

    procedure Stack_Init;
    procedure Add_Crate (Crate : in Crate_T;
                         Row : in Stack_Row_Index;
                         Column : in Stack_Column_Index;
                         Success : out Boolean);

    procedure Print_Crate_Stack;

    subtype Move_Index is Natural range 1 .. Max_Moves;

    procedure Add_Move (Move_Count : Positive; 
                        From_Column : Stack_Column_Index; 
                        To_Column : Stack_Column_Index;
                        Success : out Boolean);

    procedure Print_Moves;
    
    procedure Execute_Moves (Success : out Boolean);
    procedure Execute_Moves_9001 (Success : out Boolean);
    
private
    type Crate_Stack_T is array (Stack_Row_Index, Stack_Column_Index) of Crate_T;
    type Stack_Manifest_T is array (Stack_Column_Index) of Natural;

    Crate_Stack : Crate_Stack_T;
    Stack_Manifest : Stack_Manifest_T := (others => 0);

    type Move_T is record
        Move_Count : Move_Index;
        From_Column : Stack_Column_Index;
        To_Column : Stack_Column_Index;
    end record;

    type Move_List_T is array ( Move_Index ) of Move_T;
    
    Move_List : Move_List_T;
    Next_Move_Index : Move_Index := Move_Index'First;

    procedure Pop_Push ( Pop_Stack : Stack_Column_Index; 
                         Push_Stack : Stack_Column_Index; 
                         Success : out Boolean );
end Crates;