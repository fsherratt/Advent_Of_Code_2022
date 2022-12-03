package Backpack with 
SPARK_Mode
is
   
      
   Max_Backpacks : Constant := 1000;
   Max_Pocket_Items : Constant := 256;
   
   subtype Input_String is String (1 .. 2 * Max_Pocket_Items);
   subtype Backpack_Pocket_T is String (1 .. Max_Pocket_Items);
   
   subtype Pocket_Size_T is Natural range 1 .. Max_Pocket_Items;
   
   type Backpack_T is record
      Pocket_Size: Pocket_Size_T;
      Pocket_A_Content: Backpack_Pocket_T;
      Pocket_B_Content: Backpack_Pocket_T;
   end record;
   
   function Create_Backpack (Input: Input_String; String_Len: Pocket_Size_T) return Backpack_T with
      Pre => String_Len > Pocket_Size_T'First * 2;
   procedure Add_Backpack (Content : Backpack_T);
   
private
   type Inventory_Count_T is new Positive range 1 .. Max_Backpacks;
   subtype Inventory_Index is Inventory_Count_T range 1 .. Max_Backpacks;
   type Inventory_T is array(Inventory_Index) of Backpack_T;
   
   Inventory : Inventory_T;
   Inventory_Count : Inventory_Count_T := Inventory_Count_T'First;
end Backpack;
