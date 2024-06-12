//%*********************************************** 
//*  @script svar-arg.asl 
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

///
///

<|Use_=
 proc chain call with svar variable
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}




chkIn()

str pstr( str val)
{
 Str spv;
 Str xpv = "xpv";
<<"\nval <|$val|>\n"

   val->Info(1)
   spv = val;
   spv->info(1)

<<"ret $spv\n"
   return spv;
}
//===========================//


void psvar( svar val)
{

<<"\nval <|$val|>\n"

   val->info(1)
!z
   cart(val)

}
//===========================//

void cart(svar pname)
{

<<"$_proc  arg is <|$pname|>\n"

  pname->info(1)
!z
    svar xn;


      xn=scat(pname,"_xic")

     xn->info(1)
!z
    cart_xic(xn)

!i xn    
!t on ret from proc xn ?

}

//===========================//
void cart_xic( svar pxname)
{

<<"$_proc arg is <|$pxname|>\n"
!z
  pxname->info(1)
!z
}

//===========================//

svar abc = "abcdefg"
svar xyz = "xyz"

<<"$abc\n"

 psvar(abc);


 //psvar("defgh")


 psvar(xyz);


svar vsv= "hola que pasa"

 psvar(vsv);


// pstr("hola que pasa")



char c= abc[3];

c->info(1)


abc[4] = 'A'

<<"$abc\n"



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

 abc = "abcdefghiklmnopqrstuvwxyz"

<<"$abc"

chkOut()





