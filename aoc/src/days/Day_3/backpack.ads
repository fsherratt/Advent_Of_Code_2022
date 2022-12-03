package Backpack with SPARK_Mode is  
   Max_Backpacks : Constant := 1000;
   Max_Pocket_Items : Constant := 256;
   Max_Item_Priority : constant := 52;

   subtype Input_String is String (1 .. 2 * Max_Pocket_Items);
   subtype Backpack_Pocket_T is String (1 .. Max_Pocket_Items);
   
   subtype Pocket_Size_T is Integer range 1 .. Max_Pocket_Items;

   subtype Base_Priority_Score_T is Integer range 0 ..  Max_Item_Priority * Max_Pocket_Items * Max_Backpacks;
   subtype Backpack_Priority_Score_T is Base_Priority_Score_T range 0 .. Max_Item_Priority * Max_Pocket_Items;
   subtype Priority_Score_T is Backpack_Priority_Score_T range 0 ..  Max_Item_Priority;
   
   type Backpack_T is record
      Pocket_Size: Pocket_Size_T;
      Pocket_A_Content: Backpack_Pocket_T;
      Pocket_B_Content: Backpack_Pocket_T;

      Priority_Score: Backpack_Priority_Score_T;
   end record;
   
   function Create_Backpack (Input: Input_String; String_Len: Pocket_Size_T) return Backpack_T with
      Pre => String_Len > Pocket_Size_T'First * 2;
   procedure Add_Backpack (Content : Backpack_T; Success: out Boolean);

   function Score_All_Backpack return Base_Priority_Score_T;

private
   type Inventory_Count_T is new Integer range 1 .. Max_Backpacks;
   subtype Inventory_Index is Inventory_Count_T range 1 .. Max_Backpacks;
   type Inventory_T is array(Inventory_Index) of Backpack_T;
   
   Inventory : Inventory_T;
   Next_Inventory_Entry : Inventory_Count_T := Inventory_Count_T'First;

   function Score_Backpack (pack : in Backpack_T) return Backpack_Priority_Score_T;

   function Get_Item_Prioirty (item : Character) return Priority_Score_T;
end Backpack;
