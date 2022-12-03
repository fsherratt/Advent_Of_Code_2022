package Arg_Parse is
   
   type Day is new Integer range 0 .. 25;

   function Get_Filename (Required: Boolean) return String;
   function Get_Day (Required: Boolean) return Day;
   function Help_Menu return Boolean;

end Arg_Parse;
