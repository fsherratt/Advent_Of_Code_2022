with Ada.Text_IO; use Ada.Text_IO;
with Arg_Parse;
with Day_1;
with Day_2;

procedure Aoc is
   Day_Num : constant Arg_Parse.Day := Arg_Parse.Get_Day ( Required => True );
   Input_File : constant String := Arg_Parse.Get_Filename ( Required => False );
begin
   if Arg_Parse.Help_Menu then
      return;
   end if;

   Put_Line ("Running Day: " & Day_Num'Image );

   if Input_File'Length > 0 then
      Put_Line ("With Input: " & Input_File );
   end if;

   case Day_Num is
      when 1 => Day_1.Runner(Input_File_Path => Input_File);

      when others => Put_Line ("Error: Invalid Day");
   end case;
end Aoc;
