with Ada.Text_IO; use Ada.Text_IO;
with Crates; use Crates;
package body Day_5 is
   procedure Load_Content (Input_File_Path : in String) is
      Len : Natural;
      Buffer : String (1 .. 256);
      Input_File : File_Type;

      Line_Num : Natural := 0;
      File_Division : Natural := 9;
   begin
      Open (File => Input_File, Mode => In_File, Name => Input_File_Path);

      while not End_Of_File (Input_File) loop
         Line_Num := Line_Num + 1;

         Get_Line (Input_File, Buffer, Len);

         if len = 0 then
            null;
         elsif Line_num < File_Division then
            for I in 1 .. len loop
               if Buffer (I) = '[' then
                  declare
                     Column : Stack_Column_Index;
                     Row : Stack_Row_Index;
                     Tmp_Crate : Crate_T;
                     Success : Boolean;
                  begin
                     Row := 9 - Line_Num;
                     Column := 1 + (I / 4);
                     Tmp_Crate := Buffer (I + 1);

                     Add_Crate (Tmp_Crate, Row, Column, Success);

                     if not Success then
                        Put_Line ("Failed to add crate: No space in stack " & Column'Image);
                     end if;
                  end;
               end if;
            end loop;
         -- Calculate moves
         elsif Line_num > File_Division then
            declare
               Success : Boolean;
               Move_Count : Move_Index;
               From_Column : Stack_Column_Index := 1;
               To_Column : Stack_Column_Index := 1;
            begin
               -- Skip first 4 letters
               if len = 19 then
                  Move_Count := Natural'Value (buffer (6 .. 7));
               else
                  Move_Count := Natural'Value (buffer (6 .. 6));
               end if;

               From_Column := Stack_Column_Index'Value ( buffer(len - 5 ..  len - 5) );
               To_Column := Stack_Column_Index'Value ( buffer(len .. len) );

               Add_Move (Move_Count, From_Column, To_Column, Success);

               if not Success then
                  Put_Line ("Failed to add move: No space in stack ");
               end if;
            end;
         end if;
         
      end loop;
      --  Print_Crate_Stack;
      --  Print_Moves;
      Close(File => Input_File);
   end;

   procedure Runner (Input_File_Path : String) is
      Success : Boolean;
   begin
      Stack_Init;
      Load_Content(Input_File_Path);
      --  Execute_Moves(Success);
      Execute_Moves_9001 (Success);
      if Success then
         Print_Crate_Stack;
      end if;
   end;

end Day_5;