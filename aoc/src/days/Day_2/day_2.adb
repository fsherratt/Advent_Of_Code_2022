with Ada.Text_IO; use Ada.Text_IO;
package body Day_2 is

   procedure Runner(Input_File_Path : String) is
      Len : Natural;
      Buffer : String (1 .. 255);
      Input_File : File_Type;
      
      Round_Count : Round_Count_T := Round_Count_T'First;
      Round_Hand : Round_T;
      
      Total_Score: Natural := 0;
   begin
      Open (File => Input_File, Mode => In_File, Name => Input_File_Path);
      
      while not End_Of_File (Input_File) loop
         Get_Line (Input_File, Buffer, Len);
         
         if len > 0 then
            Round_Hand (Round_Count) := (A => Character_To_RPC(Buffer(1)), 
                                         B => Character_To_RPC(Buffer(3)), 
                                         T => Character_To_WDL(Buffer(3)));
            Adjust_Hand(Round_Hand (Round_Count));
            Round_Count := Round_Count + 1;
         end if;
         
      end loop;
      
      Close (Input_File);
      
      for Hand of Round_Hand(1 .. Round_Count - 1) loop
         Total_Score := Total_Score + Score_Hand(Hand);
      end loop;
      
      Put_Line ("Score: " & Total_Score'Image);
   end;
   
   function Character_To_RPC( Input: Character ) return RPC is
   begin
      case Input is
         when 'A' => return Rock;
         when 'B' => return Paper;
         when 'C' => return Scissor;
         when 'X' => return Rock;
         when 'Y' => return Paper;
         when 'Z' => return Scissor;
         when others => return Invalid;
      end case;
   end;
   
   function Character_To_WDL( Input: Character ) return WDL is
   begin
      case Input is
         when 'X' => return Lose;
         when 'Y' => return Draw;
         when 'Z' => return Win;
         when others => return Invalid;
      end case;
   end;
   
   function Score_Hand( Hand: Hand_T ) return Natural is
      Score: Natural := 0;
   begin
      case Hand.B is
         when Rock => Score := Score + 1;
         when Paper => Score := Score + 2;
         when Scissor => Score := Score + 3;
         when others => Put_Line("Invalid Hand");
      end case;
      
      if Hand.A = Hand.B then
         score := score + 3;
      elsif (Hand.B = Scissor and Hand.A = Paper) or else
             (Hand.B = Paper and Hand.A = Rock) or else
             (Hand.B = Rock and Hand.A = Scissor) then
         score := score + 6;
      end if;
      
      return score;
   end;
   
   procedure Adjust_Hand( Hand: in out Hand_T ) is
      Score: Natural := 0;
   begin
      case Hand.T is
         when Draw => Hand.B := Hand.A;
         when Lose =>
                       case Hand.A is
                          when Scissor => Hand.B := Paper;
                          when Paper => Hand.B := Rock;
                          when Rock => Hand.B := Scissor;
                          when others => null;
                       end case;	
         when Win => 
                       case Hand.A is
                          when Scissor => Hand.B := Rock;
                          when Paper => Hand.B := Scissor;
                          when Rock => Hand.B := Paper;
                          when others => null;
                       end case;	
         when others => null;
      end case;
   end;
   
end Day_2;
