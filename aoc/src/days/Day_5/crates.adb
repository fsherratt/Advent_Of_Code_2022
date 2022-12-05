with Ada.Text_IO; use Ada.Text_IO;

package body Crates with SPARK_Mode  is

    procedure Stack_Init is
    begin
        for i in Stack_Row_Index'Range loop
            for j in Stack_Column_Index'Range loop
                Crate_Stack(i, j) := '-';
            end loop;
        end loop;
    end;

    procedure Add_Crate (Crate : in Character;
                         Row : in Stack_Row_Index;
                         Column : in Stack_Column_Index;
                         Success : out Boolean) is
    begin
        Success := False;

         if Stack_Manifest (Column) /= Max_Crate_Per_Stack then
            Crate_Stack (Row, Column) := Crate_T (Crate);
            Stack_Manifest (Column) := Stack_Manifest (Column) + 1;

            Success := True;
        end if;
    end;

    procedure Print_Crate_Stack with SPARK_Mode => Off is
    begin
        for j in Stack_Column_Index'Range loop
            Put (Stack_Manifest(j)'Image & " ");
        end loop;
        Put_Line("");
        
        for i in Stack_Row_Index'Range loop
            for j in Stack_Column_Index'Range loop
                Put (Character (Crate_Stack (i, j))'Image);
            end loop;
            Put_Line ("");
        end loop;
    end;

    procedure Add_Move (Move_Count : Positive; 
                        From_Column : Stack_Column_Index; 
                        To_Column : Stack_Column_Index;
                        Success : out Boolean) is
        Move : constant Move_T := (Move_Count => Move_Count,
                                   From_Column => From_Column,
                                   To_Column => To_Column);
    begin
        Success := False;

        if Next_Move_Index /= Max_Moves then
            Move_List (Next_Move_Index) := Move;
            Next_Move_Index := Next_Move_Index + 1;

            Success := True;
        end if;
    end;

    procedure Print_Moves with SPARK_Mode => Off is
    begin
        Put_Line (Move_List(Move_Index'First .. Next_Move_Index - 1)'Image);
    end;

    procedure Push_Crate (Crate : in Character;
                          Column : in Stack_Column_Index;
                          Success : out Boolean) is
    begin
        if Stack_Manifest (Column) = Max_Crate_Per_Stack then
            Success := False;

        else
            Stack_Manifest (Column) := Stack_Manifest (Column) + 1;
            Crate_Stack(Stack_Manifest(Column), Column) := Crate;
            
            Success := True;
        end if;
    end;

    procedure Pop_Crate (Column : in Stack_Column_Index;
                         Popped_Crage : out Crate_T;
                         Success : out Boolean) is
    begin
        Success := False;

        if Stack_Manifest (Column) /= 0 then
            Popped_Crage := Crate_Stack(Stack_Manifest(Column), Column);
            Crate_Stack(Stack_Manifest(Column), Column) := '-';
            Stack_Manifest (Column) := Stack_Manifest (Column) - 1;

            Success := True;
        end if;
    end;

    procedure Pop_Push ( Pop_Stack : Stack_Column_Index; 
                         Push_Stack : Stack_Column_Index; 
                         Success : out Boolean ) is
        Tmp_Crate: Crate_T;
    begin
        Success := False;
        Pop_Crate(Pop_Stack, Tmp_Crate, Success);

        if Success then
            Push_Crate(Tmp_Crate, Push_Stack, Success);
        end if;
    end;

    procedure Remove_Crate (Row : in Stack_Row_Index;
                            Column : in Stack_Column_Index;
                            Crate : out Crate_T;
                            Success : out Boolean) is
    begin
        Crate := Crate_Stack(Row, Column);
        Crate_Stack(Row, Column) := '-';
        Stack_Manifest (Column) := Stack_Manifest (Column) - 1;

        Success := True;
    end;

    procedure Execute_Moves (Success : out Boolean) is
    begin
        Success := False;
        for Move_Idx in Move_Index'First .. Next_Move_Index - 1 loop
            for Repeat in 1 .. Move_List(Move_Idx).Move_Count loop
                Pop_Push(Move_List(Move_Idx).From_Column, Move_List(Move_Idx).To_Column, Success);
            end loop;
        end loop;
    end;

    procedure Execute_Moves_9001 (Success : out Boolean) is
        Tmp_Crate: Crate_T;
        Tmp_Row: Integer;
    begin
        Success := False;
        for Move_Idx in Move_Index'First .. Next_Move_Index - 1 loop
            Tmp_Row := Stack_Manifest (Move_List(Move_Idx).From_Column);
            for Repeat in reverse 1 .. Move_List(Move_Idx).Move_Count loop
                Remove_Crate(Tmp_Row - Repeat + 1,
                             Move_List(Move_Idx).From_Column,
                             Tmp_Crate,
                             Success);
                Push_Crate(Tmp_Crate, Move_List(Move_Idx).To_Column, Success);
            end loop;
        end loop;
    end;
end Crates;