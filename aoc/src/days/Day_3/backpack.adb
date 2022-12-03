with Ada.Text_IO; use Ada.Text_IO;
package body Backpack with SPARK_Mode is

   function Create_Backpack (Input: Input_String; String_Len: Pocket_Size_T) return Backpack_T is
      Mid_Index : constant Pocket_Size_T := String_Len / 2;
      Return_Val : Backpack_T := (Pocket_Size => Mid_Index, 
                                  Pocket_A_Content => (others => Character'Val(0)),
                                  Pocket_B_Content => (others => Character'Val(0)),
                                  Priority_Score => Backpack_Priority_Score_T'First);
   begin
      for Idx in 1 .. Mid_Index loop
         Return_Val.Pocket_A_Content (Idx) := Input (Idx);
         Return_Val.Pocket_B_Content (Idx) := Input (Idx + Mid_Index);
      end loop;
      return Return_Val;
   end;

   procedure Add_Backpack (Content : Backpack_T; Success : out Boolean) is
   begin
      if Next_Inventory_Entry = Inventory_Count_T'Last then
         Success := False;

      else
         Inventory (Next_Inventory_Entry) := Content;
         Next_Inventory_Entry := Next_Inventory_Entry + 1;

         Success := True;

      end if;
   end;

   function Get_Item_Prioirty (item : Character) return Priority_Score_T is
      Score: Natural;
   begin
      Score := Character'Pos(item);

      if Score >= 97 and Score <= 122 then
         Score := Score - 96;
      elsif Score >= 65 and Score <= 90 then
         Score := Score - 64 + 26;
      else
         Score := 0;
      end if;
      
      return Priority_Score_T(Score);
   end;

   function Score_Backpack (pack : Backpack_T) return Backpack_Priority_Score_T is
      Running_Total : Backpack_Priority_Score_T := 0;

      function Exists( Check_Value : Character; Values : Backpack_Pocket_T; Range_Max: Pocket_Size_T) return Boolean is
         (for some Idx in Backpack_Pocket_T'First .. Range_Max => Values(Idx) = Check_Value);

   begin
      for Outer_Idx in Pocket_Size_T'First .. pack.Pocket_Size loop
         if Outer_Idx = Backpack_Pocket_T'First or else 
            not Exists(pack.Pocket_A_Content(Outer_Idx), pack.Pocket_A_Content, Outer_Idx - 1) then

            if Exists(pack.Pocket_A_Content(Outer_Idx), pack.Pocket_B_Content, pack.Pocket_Size) then
               Running_Total := Running_Total + Get_Item_Prioirty(pack.Pocket_A_Content(Outer_Idx));
            end if;
         end if;
      end loop;

      return Running_Total;
   end;
   
   function Score_All_Backpack return Base_Priority_Score_T is
      Total_Score: Base_Priority_Score_T := 0;
   begin
      for I in Inventory_Count_T'First .. Next_Inventory_Entry - 1 loop
         Total_Score := Total_Score + Score_Backpack( Inventory(I));
      end loop;

      return Total_Score;
   end;


end Backpack;
