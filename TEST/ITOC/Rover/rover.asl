//%*********************************************** 
//*  @script rover.asl 
//* 
//*  @comment Test rover SF  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.1 C-Li-H]                                  
//*  @date Sun Dec 27 22:00:20 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%





<|Use=
rover()

w3=rover(w1,w2,index)
replace a characters of w1 at index position with string w2.
The replacement will extend the string if needed, as long as index is within the first string.
If index is negative the replacement is offset to the end of the string
(-1 would have the replacement streing end at the current end of the string)
rover("growling","XY",1)   returns "gXYwling"
rover("growling","XY",-2)   returns "growlXYg" 
|>

proc showUse()
{
  <<"$Use\n"
}


#include "debug"

if (_dblevel >0) {
   debugON();
   showUse();
}
  
chkIn()



str s1 = "happyHolidays"
str s2 = "xyz"

<<"$s1\n"


s3= rover(s1,s2,4)

<<"$s3\n"

chkStr(s3,"happxyzli",9)



i = 0
while (i < 20) {
s3= rover(s1,s2,i)

<<"$s3\n"
i++

}


s3= rover(s1,s2,LAST_)


<<"LAST_ $s3\n"
chkStr(s3,"happyHolidxyz")

s3= rover(s1,s2,-3)


<<"-3: $s3\n"

chkOut()