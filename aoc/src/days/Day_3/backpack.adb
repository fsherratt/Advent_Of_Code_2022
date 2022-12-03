with Ada.Text_IO; use Ada.Text_IO;

package body Backpack with 
  SPARK_Mode
is

   
   function Create_Backpack (Input: Input_String; String_Len: Pocket_Size_T) return Backpack_T is
      Mid_Index : constant Pocket_Size_T := String_Len / 2;
      Return_Val : Backpack_T := (Pocket_Size => Mid_Index, 
                                  Pocket_A_Content => (others => Character'Val(0)),
                                   Pocket_B_Content => (others => Character'Val(0)));
   begin
      for Idx in 1 .. Mid_Index loop
         Return_Val.Pocket_A_Content (Idx) := Input (Idx);
         Return_Val.Pocket_B_Content (Idx) := Input (Idx + Mid_Index);
      end loop;
      return Return_Val;
   end;
   
   procedure Add_Backpack (Content : Backpack_T) is
   begin
      if Inventory_Count = Inventory_Count_T'Last then
         return;
      end if;
      
      Inventory (Inventory_Count) := Content;
      Inventory_Count := Inventory_Count + 1;
   end;
   
   function Check_Backpack return Natural is
      
   begin
      
   end;
end Backpack;
