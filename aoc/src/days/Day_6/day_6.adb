with Ada.Text_IO; use Ada.Text_IO;

package body Day_6 with SPARK_Mode is
   Unique_Char_Len : constant := 14;
   function Find_Unique ( Test_String : String ) return Natural with
      Pre => Test_String'Length > Unique_Char_Len;
   
   procedure Load_Content (Input_File_Path : in String) with SPARK_Mode => off is
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
      Put_Line( Find_Unique (Buffer (1 .. len))'Image );
   end;
   
   function Find_Unique ( Test_String : String ) return Natural is 
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
      for I in  Test_String'First + Unique_Char_Len .. Test_String'Length loop
         FIFO_Push ( Test_String(I), Unique );
         
         if not Char_Repeat(Unique) then
            return I;
         end if;
      end loop;
      
      return 0;
   end;

   procedure Runner(Input_File_Path : String) with SPARK_Mode => off is
   begin
      Load_Content (Input_File_Path);
   end;

end Day_6;
