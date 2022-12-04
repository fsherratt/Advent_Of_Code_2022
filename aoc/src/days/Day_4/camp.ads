package Camp with SPARK_Mode is
   Max_Entries : constant := 1001;
   
   type Clean_Pair is Record
      Elf_A_Start : Positive;
      Elf_A_End : Positive;
      Elf_B_Start : Positive;
      Elf_B_End : Positive;
   end Record;
   
   procedure Add_Clean_Pair ( Pair : Clean_Pair; Success : out Boolean );
   
   function Count_Full_Overlap return Integer;
   
   function Count_Overlap return Integer;
   
private
   
   subtype Entry_Index is Integer range 1 .. Max_Entries;
   type Entries_T is array (Entry_Index) of Clean_Pair;
   
   Entries : Entries_T;
   Next_Entry_Index : Entry_Index := 1;
   

end Camp;
