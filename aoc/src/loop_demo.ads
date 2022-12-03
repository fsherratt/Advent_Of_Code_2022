package Loop_Demo with SPARK_Mode is

   type Array_Value_T is new Natural;
   type Array_Index is new Positive;
   type Loop_Array is array ( Array_Index range <> ) of Array_Value_T;

   function Get_Array_Max ( Test_Array : Loop_Array ) return Array_Value_T with
     Post => (for all A of Test_Array => Get_Array_Max'Result >= A);

end Loop_Demo;
