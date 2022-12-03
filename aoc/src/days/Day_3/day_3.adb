with Ada.Text_IO; use Ada.Text_IO;

package body Day_3 is
   procedure Runner (Input_File_Path : String) is
      Score : Natural := 0;
   begin
      Load_Content(Input_File_Path => Input_File_Path);
      Score := Score_All_Backpack;

      Put_Line (Score'Image);
   end;

   procedure Load_Content (Input_File_Path : in String) is
      Len : Natural range Input_String'Range;
      Buffer : Input_String;
      Input_File : File_Type;

   begin
      Open (File => Input_File, Mode => In_File, Name => Input_File_Path);

      while not End_Of_File (Input_File) loop
         Get_Line (Input_File, Buffer, Len);
         --  Put_Line (Buffer (1 .. Len));

         if len > 0 and len < Input_String'Last then
            declare
               Tmp_Backpack : Backpack_T := Create_Backpack (Buffer, Len);
               Success : Boolean;
            begin
               Add_Backpack (Tmp_Backpack, Success);
               if not Success then
                  Put_Line ("Failed to add Backpack");
               end if;
            end;
         end if;

      end loop;

      Close(File => Input_File);
   end;


end Day_3;
