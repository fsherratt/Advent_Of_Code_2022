package Day_2 is
   Max_Rounds : constant := 100_000;
   
   procedure Runner(Input_File_Path : String);
   
   type RPC is (Rock, Paper, Scissor, Invalid);
   type WDL is (Win, Lose, Draw, Invalid);
   
   type Hand_T is record
      A : RPC;
      B : RPC;
      T : WDL;
   end record;
   
   type Round_Count_T is new Positive range 1 .. Max_Rounds;
   subtype Round_Index_T is Round_Count_T range 1 .. Max_Rounds;
   
   type Round_T is array (Round_Index_T) of Hand_T;
   
private
   function Character_To_RPC( Input: Character ) return RPC;
   function Character_To_WDL( Input: Character ) return WDL;
   function Score_Hand( Hand: Hand_T ) return Natural;
   procedure Adjust_Hand( Hand: in out Hand_T );
end Day_2;
