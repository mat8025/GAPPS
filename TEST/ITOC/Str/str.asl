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

///
///
<|Use_=
S string but should be able to be accessed like a dynamic char array
|>


//#define DIF !~
#define DIF 

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn(_dblevel)

DoVarId = 1;
DoInfo = 0;

void pstr( str val)
{

<<"\nval <|$val|>\n"
   id = val->varid()
<<"%V $id\n"   
!~   val->Info(1)

!!  val->Info(1)
   iv = vgen(INT_,10,0,1)
   <<"$iv\n"
   iv->reverse()
   <<"$iv\n"
   iv->info(1)
!a
  cart(val)

}
//===========================//

void cart( str pname)
{
<<"$_proc   arg is <|$pname|>\n"
//str xn;

   if (DoVarId) {
     id = pname->varid()
<<"%V $id\n"
    }


DIF pname->info(1);

    xn=scat(pname," Senor")

DIF xn->info(1)

    cart_y(xn, pname) ;  // fails
    //xn2 = pname
    //cart_y(xn, xn2) ;  // ok made a copy
!t on ret from cart_y xn ?    
//!i xn



}

//===========================//
void cart_xic( str pxname)
{

<<"\n arg is <|$pxname|>\n"
   id = pxname->varid()
<<"%V $id\n"   
DIF pxname->Info(1)

}

//===========================//
void cart_y( str pxname, str arg2)
{
<<"IN $_proc arg1 is <|$pxname|>  arg2 is <|$arg2|\n"
     sdb(2,@step)

    if (DoVarId) {
     id = pxname->varid()
<<"%V $id\n"
    }

DIF pxname->Info(1)


DIF arg2->info(1)


    xn=scat(pxname," Que Pasa?")
     id = xn->varid()
<<"%V $id\n"   

     if (DoInfo) xn->info(1)

     cart_z(xn, arg2)
!t on ret from cart_z xn ?    
       if (DoInfo)   xn->info(1)

}
//===========================//
void cart_z( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
     id = arg1->varid()
<<"%V $id\n"   
        if (DoInfo) arg1->Info(1)
        if (DoInfo) arg2->Info(1)

    zn=scat(arg1," hasta luego")
         id = zn->varid()
<<"%V $id\n"   

DIF zn->info(1)


    cart_w(zn, arg2)

!t on ret from cart_w ?    
     id = zn->varid()
<<"%V $id\n"   
DIF zn->info(1)


}

//===========================//

void cart_w( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
   id = arg1->varid()
<<"%V $id\n"   
      if (DoInfo)   arg1->Info(1)
      if (DoInfo)  arg2->Info(1)

     cart_v (arg1,arg2);

}
//===========================//
void cart_v( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
   id = arg1->varid()
<<"%V $id\n"   
      if (DoInfo)  arg1->Info(1)
   
   cart_u (arg1,arg2);

}
//===========================//
void cart_u( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
   id = arg1->varid()
<<"%V $id\n"   
      if (DoInfo)  arg1->Info(1)
      if (DoInfo)  arg2->Info(1)
!t begin return down call chain     

}
//===========================//


void do_carts (str wprg)
{
//  str wprg = aprog;
<<"$_proc  $wprg \n"

   id = wprg->varid()
<<"%V $id\n"   
     if (DoInfo) wprg->info(1)

<<"run cart vers  $wprg \n"

      cart (wprg);
      
       if (DoInfo)  wprg->info(1)

 <<"run xic vers  $wprg \n"

       cart_xic (wprg);

<<"after cart_xic  $wprg \n"
 

}
//===============================

str abc = "abcdefg"
str xyz = "xyz"


  abc->info(1);

<<"$abc\n"


 pstr(abc);


 pstr("defgh")


 pstr(xyz);


 chkT(1)
 chkOut()


/*
str vstr= "hola que pasa"

 pstr(vstr);


 pstr("hola que pasa")

 pstr("Estoy muy bien gracias")
*/


  do_carts("Buenos días")


//  do_carts("Estoy muy bien gracias")

chkT(1)



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


char c2;

c2 = pickc(s,3)

<<"%V %c $c2       $s\n"


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

abc = "abcdefg"
xyz = "xyz"

<<"$abc"

chkOut()





