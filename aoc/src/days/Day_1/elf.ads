package Elf with SPARK_Mode is

   Max_Elves : constant :=  1000;
   Max_Snacks : constant := 20;
   Max_Calories : constant := 100_000;

   subtype Base_Calories_T is Natural range 0 .. 3 * Max_Snacks * Max_Calories;
   subtype Elf_Calories_T is Base_Calories_T range 0 .. Max_Snacks * Max_Calories;
   subtype Elf_Calorie_T is Elf_Calories_T range 0 .. Max_Calories;

   type Elves_Index is range 1 .. Max_Elves;
   type Elves is array (Elves_Index) of Elf_Calories_T;

   subtype Elf_Count_T is Natural range 1 .. Max_Elves;

end Elf;
