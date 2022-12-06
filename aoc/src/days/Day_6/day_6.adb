with Ada.Text_IO; use Ada.Text_IO;

package body Day_6 is
   procedure Find_Unique ( Test_String : String );
   
   procedure Load_Content (Input_File_Path : in String) is
      Len : Natural;
      Buffer : String (1 .. 5000);
      Input_File : File_Type;
   begin
      Open (File => Input_File, Mode => In_File, Name => Input_File_Path);

      while not End_Of_File (Input_File) loop

         Get_Line (Input_File, Buffer, Len);
      end loop;
      
      Close(File => Input_File);
      
      --  Need to remove this from this procedure
      Find_Unique(Buffer (1 .. len));
   end;
   
   procedure Find_Unique ( Test_String : String ) is 
      Unique_Char_Len : constant := 14;
      subtype Char_Array_T is String (1 .. Unique_Char_Len);
      
      Unique : Char_Array_T := Test_String (Test_String'First .. Test_String'First + Unique_Char_Len - 1);
      
      procedure FIFO_Push ( New_entry: in Character; Buffer: in out Char_Array_T ) is
         New_Buffer : Char_Array_T := (Buffer ( Buffer'First + 1 .. Buffer'Length) & New_entry);
      begin
         Buffer := New_Buffer;
      end;
      
      function Char_Repeat ( Buffer: Char_Array_T ) return Boolean is
        (for some I in Buffer'Range => (for some J in Buffer'Range => (I /= J and Buffer(I) = Buffer(J))));
      
   begin
      for I in Unique_Char_Len + 1 .. Test_String'Length loop
         FIFO_Push ( Test_String(I), Unique );
         
         if not Char_Repeat(Unique) then
            Put_Line(Unique & ":" & I'Image);
            
            exit when True;
         end if;
      end loop;
      
   end;

   procedure Runner(Input_File_Path : String) is
   begin
      Load_Content (Input_File_Path);
   end;

end Day_6;
