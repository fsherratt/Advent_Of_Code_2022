with Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;

package body Arg_Parse is

    function Get_Filename (Required: Boolean) return String is
        package CLI renames Ada.Command_Line;
    begin
      for i in 1 .. CLI.Argument_Count loop
         if( CLI.Argument(i) =  "--file") then
            return CLI.Argument(i+1);
         end if;
      end loop;

      if Required then
         Put_Line ("--File <FILE_PATH> is required. See --help for guidanece");
      end if;

      return "";
    end Get_Filename;

    function Get_Day (Required: Boolean) return Day is
        --  Get the day for the command line flag --day
    begin
      for i in 1 .. Ada.Command_Line.Argument_Count loop
         if( Ada.Command_Line.Argument(i) = "--day") then
            return Day'Value (Ada.Command_Line.Argument(i+1));
         end if;
      end loop;

      if Required then
         Put_Line ("--Day <DAY_NUM> is required. See --help for guidanece");
      end if;

      return 0;
   end Get_Day;

   function Help_Menu return Boolean is
   begin
      for i in 1 .. Ada.Command_Line.Argument_Count loop
         if( Ada.Command_Line.Argument(i) = "--help") then
            Put_Line ("Advent Of Code 2022 Runner");
            Put_Line ("--day <DAY_NUM>: To select the day to run");
            Put_Line ("--file <FILE_PATH>: To provide the input file path");

            return True;
         end if;
      end loop;

      return False;
   end Help_Menu;

end Arg_Parse;
