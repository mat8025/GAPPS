// BUG_FIX 

SetPCW("writeexe","writepic")
SetDebug(1)

// version 1.2.53
stype= ""

   //FIX    Stat=readln(":-) ",stype)
// BAD the round bracket is not protected



   Stat=readln(":-) ",stype)

<<"$Stat \n"


<<"$stype \n"



   Stat=readln(":-) ",stype )

<<"$Stat \n"


<<"$stype \n"


   Stat=readln(":-)()) ",stype)

<<"$Stat \n"


<<"$stype \n"




   Stat=readln(":-> ",stype)

<<"$Stat \n"


<<"$stype \n"


STOP!


////////// FIX WAS /////////
// checking mathing brackets in strip_outer_bracket failed to check for )(  within quotes