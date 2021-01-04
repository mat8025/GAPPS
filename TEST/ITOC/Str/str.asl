//%*********************************************** 
//*  @script str.asl 
//* 
//*  @comment test ops on Str variable 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.96 C-He-Cm]                             
//*  @date Sun Dec 20 12:05:33 2020   
//*  @cdate Thu May 14 09:46:53 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();///
///
///
#include "debug"
debugON()


chkIn(_dblevel)

void pstr( str val)
{

<<"val <|$val|>\n"

!!"echo $val"

}


Str s = "h";

<<"X<|$s|>\n"

s->info(1)

n=slen(s)

<<"%V$n $s\n"
<<"echo <|$s|>\n"
!!"echo $s"

pstr(s);

pstr("A");

str s2="OK?"

pstr(s2);

!!"echo $s2"

pstr("B");

exit()

s = "hi there";

s->info(1)

<<"%V $s \n"



Str s3;

s3->info(1)

 s3="goodbye"

<<"%V $s3 \n"

chkStr(s,"hi there")

s= Supper(s,0,1);

<<"%V $s \n"

s->reverse()

<<" $s \n"

<<"%V $s \n"


s->info(1);
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


chkOut()





