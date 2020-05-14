//%*********************************************** 
//*  @script str.asl 
//* 
//*  @comment test ops on str variable 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.47 C-He-Ag]                                
//*  @date Thu May 14 09:46:53 2020 
//*  @cdate Thu May 14 09:46:53 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();///
///
///


checkIn(_dblevel)

str s = "hi there";
 

<<"%V $s \n"

checkStr(s,"hi there")

s= Supper(s,0,1);

<<"%V $s \n"

s->reverse()

<<" $s \n"

<<"%V $s \n"



char c;

c = pickc(s,3)

<<"%V %c $c  $c     $s\n"


d= sele(s,2,3)

<<"%V %c $c %d $c $d    $s\n"
str name = "johndoe"


char C[];

scpy(C,name);

<<"%V $name \n"

<<"%V %s $C \n"


char R[]



   len = slen(name)

<<"%V $len\n"


for (i= 0; i < len; i++)
{
  R[i] = C[i] + i;
}

<<"%V $R\n"

<<"%V %s $R\n"


checkOut()





