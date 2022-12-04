with Ada.Text_IO; use Ada.Text_IO;
package body Backpack with SPARK_Mode is

   function Create_Backpack (Input: Input_String; String_Len: Positive) return Backpack_T is
      Mid_Index : constant Pocket_Size_T := String_Len / 2;
      Return_Val : Backpack_T := (Pocket_Size => Mid_Index, 
                                  Pack_Content => Input,
                                  Pocket_A_Content => (others => Character'Val(0)),
                                  Pocket_B_Content => (others => Character'Val(0)));
   begin
      for Idx in 1 .. Mid_Index loop
         Return_Val.Pocket_A_Content (Idx) := Input (Idx);
         Return_Val.Pocket_B_Content (Idx) := Input (Idx + Mid_Index);
      end loop;
      return Return_Val;
   end;

   procedure Add_Backpack (Content : Backpack_T; Success : out Boolean) is
   begin
      if Next_Inventory_Slot = Inventory_Count_T'Last then
         Success := False;

      else
         Inventory (Next_Inventory_Slot) := Content;
         Next_Inventory_Slot := Next_Inventory_Slot + 1;

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
      
      function Exists ( Check_Value : Character; Values : Backpack_Pocket_T; Range_Max: Pocket_Size_T) return Boolean is
        (for some Idx in Backpack_Pocket_T'First .. Range_Max => Values (Idx) = Check_Value);

   begin
      for Char_Idx in Pocket_Size_T'First .. pack.Pocket_Size loop
         if Char_Idx = Backpack_Pocket_T'First or else 
            not Exists (pack.Pocket_A_Content (Char_Idx), pack.Pocket_A_Content, Char_Idx - 1) then

            if Exists (pack.Pocket_A_Content (Char_Idx), pack.Pocket_B_Content, pack.Pocket_Size) then
               Running_Total := Running_Total + Get_Item_Prioirty (pack.Pocket_A_Content (Char_Idx));
            end if;
         end if;
         
         pragma Loop_Variant (Increases => Char_Idx);
         pragma Loop_Invariant (Running_Total <= Backpack_Priority_Score_T(Char_Idx) * Max_Item_Priority);
      end loop;

      return Running_Total;
   end;
   
   function Score_All_Backpack return Natural is
      Total_Score : Base_Priority_Score_T := 0;
   begin     
      for Pack_Idx in Inventory_Count_T'First .. Next_Inventory_Slot -1 loop
        
         Total_Score := Total_Score + Score_Backpack (Inventory (Pack_Idx));
         
         pragma Loop_Variant (Increases => Pack_Idx);
         pragma Loop_Invariant (Total_Score <= Base_Priority_Score_T(Pack_Idx) * Max_Item_Priority * Max_Pocket_Items);
      end loop;

      return Total_Score;
   end;
   
   function Score_Group_Backpack (Packs : Inventory_Group_T) return Backpack_Priority_Score_T is
      Running_Total : Backpack_Priority_Score_T := 0;
      
      function Exists ( Check_Value : Character; Values : Input_String; Range_Max: Input_Size_T) return Boolean is
        (for some Idx in Backpack_Pocket_T'First .. Range_Max => Values (Idx) = Check_Value);
            
   begin
      Search_Loop : for Char_Idx in Input_String'First .. 2 * Packs(1).Pocket_Size loop        
         if Char_Idx = Input_String'First or else 
           not Exists (Packs(1).Pack_Content (Char_Idx), Packs(1).Pack_Content, Char_Idx - 1) then
            
            if Exists (Packs(1).Pack_Content (Char_Idx), Packs(2).Pack_Content, 2 * Packs(2).Pocket_Size) and then
               Exists (Packs(1).Pack_Content (Char_Idx), Packs(3).Pack_Content, 2 * Packs(3).Pocket_Size) then
               Running_Total := Running_Total + Get_Item_Prioirty (Packs(1).Pack_Content (Char_Idx));
               exit Search_Loop when True;
            end if;
         end if;
         
         pragma Loop_Variant (Increases => Char_Idx);
         pragma Loop_Invariant (Running_Total <= Max_Item_Priority);
      end loop Search_Loop;
      
      return Running_Total;
   end;
   
   function Score_All_Group_Backpack return Natural is
      Total_Score : Base_Priority_Score_T := 0;
      Loop_Count : Inventory_Count_T := 1;
      
      Group : Inventory_Group_T;

   begin
      while Loop_Count <= Next_Inventory_Slot - Group_Size loop
         for I in Inventory_Group_Index'Range loop
            Group (I) := Inventory (Loop_Count - 1 + Inventory_Count_T(I));
         end loop;
         
         Total_Score := Total_Score + Score_Group_Backpack (Group);
         Loop_Count := Loop_Count + Group_Size;
         
         pragma Loop_Variant (Increases => Loop_Count);
         pragma Loop_Invariant(Loop_Count <= Inventory_Count_T'Last);
         pragma Loop_Invariant (Total_Score <= Base_Priority_Score_T(Loop_Count/3) * Max_Item_Priority * Max_Pocket_Items);
      end loop;
      
      return Total_Score;
   end;
  
end Backpack;
