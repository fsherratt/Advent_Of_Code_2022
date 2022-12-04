with Ada.Text_IO; use Ada.Text_IO;

with Camp; use Camp;

package body Day_4 is
   procedure Load_Content (Input_File_Path : in String) is
      Len : Natural;
      Buffer : String (1 .. 256);
      Input_File : File_Type;

   begin
      Open (File => Input_File, Mode => In_File, Name => Input_File_Path);

      while not End_Of_File (Input_File) loop
         Get_Line (Input_File, Buffer, Len);
         Put_Line (Buffer (1 .. Len));

         if len > 0 then
            declare
               Value_Count : Integer := 0;
               Value_Start : Integer := 1;
               Tmp_Value : Integer;

               Output : Clean_Pair;
               Success : Boolean;
            begin
               for I in 1 .. len loop
                  Tmp_Value := -1;
                  if I = len then
                     Tmp_Value := Integer'Value (Buffer (Value_Start .. I));
                     Value_Count := Value_Count + 1;

                  elsif I /= 1 and (Buffer(I) = '-' or Buffer(I) = ',') then
                     Tmp_Value := Integer'Value (Buffer (Value_Start .. I-1));
                     Value_Start := I + 1;
                     Value_Count := Value_Count + 1;
                  end if;

                  if Tmp_Value > 0 then
                     case Value_Count is
                        when 1 => Output.Elf_A_Start := Tmp_Value;
                        when 2 => Output.Elf_A_End := Tmp_Value;
                        when 3 => Output.Elf_B_Start := Tmp_Value;
                        when 4 => Output.Elf_B_End := Tmp_Value;
                        when others => null;
                     end case;
                  end if;
               end loop;

               Put_Line( Output'Image );
               Add_Clean_Pair (Output, Success);

               if not Success then
                  Put_Line ("Run out of space");
               end if;
            end;
         end if;

      end loop;

      Close(File => Input_File);
   end;

   procedure Runner (Input_File_Path : String) is
      Count : Integer;
   begin
      Load_Content(Input_File_Path => Input_File_Path);

      Count := Count_Full_Overlap;
      Put_Line ("Full Overlap: " & Count'Image);

      Count := Count_Overlap;
      Put_Line ("Some Overlap: " & Count'Image);
   end;

end Day_4;
