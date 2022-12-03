package body Loop_Demo with SPARK_Mode  is

   function Get_Array_Max ( Test_Array : Loop_Array ) return Array_Value_T is
      Max : Array_Value_T := Array_Value_T'First;
   begin
      for A_Idx in Test_Array'Range loop
         if Test_Array(A_Idx) > Max then
            Max := Test_Array(A_Idx);
         end if;

         pragma Loop_Invariant(for all Idx in Test_Array'First .. A_Idx => Max >= Test_Array(Idx));
      end loop;

      return Max;
   end;

end Loop_Demo;
