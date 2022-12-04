package Backpack with SPARK_Mode is  
   Max_Backpacks : Constant := 500;
   Max_Pocket_Items : Constant := 50;
   Max_Item_Priority : constant := 52;
   Group_Size : constant := 3;
   
   type Backpack_T is private;

   subtype Input_String is String (1 .. 2 * Max_Pocket_Items);
   subtype Backpack_Pocket_T is String (1 .. Max_Pocket_Items);
   
   subtype Pocket_Size_T is Natural range Backpack_Pocket_T'Range;
   subtype Input_Size_T is Natural range Input_String'Range;

   function Create_Backpack (Input: Input_String; String_Len: Positive) return Backpack_T with
     Pre => String_Len > Pocket_Size_T'First * 2 and String_Len / 2 <= Max_Pocket_Items;
   
   procedure Add_Backpack (Content : Backpack_T; Success: out Boolean);

   function Score_All_Backpack return Natural;
   function Score_All_Group_Backpack return Natural;
   
private
   subtype Base_Priority_Score_T is Natural range 0 .. Max_Item_Priority * Max_Pocket_Items * Max_Backpacks;
   subtype Backpack_Priority_Score_T is Base_Priority_Score_T range 0 .. Max_Item_Priority * Max_Pocket_Items;
   subtype Priority_Score_T is Backpack_Priority_Score_T range 0 ..  Max_Item_Priority;
   
   type Backpack_T is record
      Pocket_Size: Pocket_Size_T;
      Pack_Content : Input_String;

      Pocket_A_Content: Backpack_Pocket_T;
      Pocket_B_Content: Backpack_Pocket_T;
   end record;
   
   type Inventory_Count_T is new Integer range 1 .. Max_Backpacks;
   subtype Inventory_Index is Inventory_Count_T range 1 .. Max_Backpacks;
   type Inventory_T is array(Inventory_Index) of Backpack_T;
   
   type Inventory_Group_Index is new Inventory_Count_T range 1 .. Group_Size;
   type Inventory_Group_T is array(Inventory_Group_Index) of Backpack_T;
   
   Inventory : Inventory_T;
   Next_Inventory_Slot : Inventory_Count_T := Inventory_Count_T'First;

   function Score_Backpack (pack : Backpack_T) return Backpack_Priority_Score_T with
     Post => (Score_Backpack'Result >= 0 and Score_Backpack'Result <= Backpack_Priority_Score_T'Last);
   
   function Score_Group_Backpack (Packs : Inventory_Group_T) return Backpack_Priority_Score_T with
     Post => (Score_Group_Backpack'Result >= 0 and Score_Group_Backpack'Result <= Backpack_Priority_Score_T'Last);

   function Get_Item_Prioirty (item : Character) return Priority_Score_T with
     Post => Get_Item_Prioirty'Result <= Max_Item_Priority;
end Backpack;
