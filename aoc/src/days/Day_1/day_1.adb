with Ada.Text_IO; use Ada.Text_IO;
with Elf;
package body Day_1 is
   
   procedure Runner ( Input_File_Path : String ) is
      Len : Natural;
      Buffer : String (1 .. 255);
   
      Input_File : File_Type;
      Elf_List : Elf.Elves := (others => 0);
      Elf_Snacks : Natural := 0;
      Elf_Count : Elf.Elf_Count_T := Elf.Elf_Count_T'First;

      New_Calorie : Elf.Elf_Calorie_T;

      Max_Calorie_1 : Elf.Elf_Calories_T := 0;
      Max_Calorie_2 : Elf.Elf_Calories_T := 0;
      Max_Calorie_3 : Elf.Elf_Calories_T := 0;

      Top_3 : Elf.Base_Calories_T;

      function String_To_Num( Int_Buffer : String ) return Elf.Elf_Calorie_T with
        Post => (String_To_Num'Result <= Elf.Elf_Calorie_T'Last)
      is
      begin
         return Elf.Elf_Calorie_T'Value (Int_Buffer);
      end;

   begin
      Open (File => Input_File, Mode => In_File, Name => Input_File_Path);

      while (not End_Of_File (Input_File) and Elf_Count < Elf.Elf_Count_T'Last) loop
         Get_Line (Input_File, Buffer, Len);

         if Len = 0 then
            Elf_Count := Elf_Count + 1;
            Elf_Snacks := 0;

         elsif Elf_Snacks < Elf.Max_Snacks then
            New_Calorie := String_To_Num(Buffer(1 .. Len));
            Elf_List (Elf.Elves_Index (Elf_Count)) := Elf_List (Elf.Elves_Index (Elf_Count))
              + New_Calorie;
            Elf_Snacks := Elf_Snacks + 1;

         else
            Put_Line("Too Many Snacks!");

         end if;

         pragma Loop_Invariant(Elf_Count <= Elf.Elf_Count_T'Last);
      end loop;

      Close (Input_File);

      for Elf of Elf_List loop
         if Elf > Max_Calorie_1 then
            Max_Calorie_3 := Max_Calorie_2;
            Max_Calorie_2 := Max_Calorie_1;
            Max_Calorie_1 := Elf;

         elsif Elf > Max_Calorie_2 then
            Max_Calorie_3 := Max_Calorie_2;
            Max_Calorie_2 := Elf;

         elsif Elf > Max_Calorie_3 then
            Max_Calorie_3 := Elf;
         end if;
      end loop;

      Put_Line ("Max 1: " & Max_Calorie_1'Image);
      Put_Line ("Max 2: " & Max_Calorie_2'Image);
      Put_Line ("Max 3: " & Max_Calorie_3'Image);

      Top_3 := Max_Calorie_1 + Max_Calorie_2 + Max_Calorie_3;

      Put_Line ("Top 3: " & Top_3'Image);
   end Runner;
end Day_1;
