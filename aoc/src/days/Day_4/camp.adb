package body Camp with SPARK_Mode is

   procedure Add_Clean_Pair ( Pair : Clean_Pair; Success : out Boolean ) is
   begin
      if Next_Entry_Index = Max_Entries then
         Success := False;
         
      else
         Entries (Next_Entry_Index) := Pair;
         Next_Entry_Index := Next_Entry_Index + 1;
         
         Success := True;
      end if;
   end;
   
   function Check_Full_Overlap ( Pair : Clean_Pair ) return Boolean is
     ((Pair.Elf_A_Start <= Pair.Elf_B_Start and Pair.Elf_A_End >= Pair.Elf_B_End) or else
          (Pair.Elf_B_Start <= Pair.Elf_A_Start and Pair.Elf_B_End >= Pair.Elf_A_End) );
   
   function Count_Full_Overlap return Integer is
      Count : Integer := 0;
   begin
      if Next_Entry_Index = 1 then
         return 0;
      end if;
      
      for I in 1 .. Next_Entry_Index - 1 loop
         if Check_Full_Overlap (Entries (I)) then
            Count := Count + 1;
         end if;
         
         pragma Loop_Invariant (Count <= I);
      end loop;
      
      return Count;
   end;
   
   
   function Check_Overlap ( Pair : Clean_Pair ) return Boolean is
     (Pair.Elf_A_End >= Pair.Elf_B_Start and Pair.Elf_B_End >= Pair.Elf_A_Start);
   
   function Count_Overlap return Integer is
      Count : Integer := 0;
   begin
      if Next_Entry_Index = 1 then
         return 0;
      end if;
      
      for I in 1 .. Next_Entry_Index - 1 loop
         if Check_Overlap (Entries (I)) then
            Count := Count + 1;
         end if;
         
         pragma Loop_Invariant (Count <= I);
      end loop;
      
      return Count;
   end;
   
   
end Camp;
