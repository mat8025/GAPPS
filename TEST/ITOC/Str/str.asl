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



//#define DIV 
//#define DIF 

#define DIV ~!
//#define DIF ~!
//#define DIF vi =

#define DIF 

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn(_dblevel)


str as = "aBc"

str bs = "aBc"

str cs = "dEf"


  if (as @= bs) {
<<"%V $as @=  $bs\n"
  }


  if (as == bs) {
<<"%V $as  ==  $bs\n"
  }


  if (as @= cs) {
<<"%V $as @=  $cs\n"
  }


  if (as == cs) {
<<"%V $as  ==  $cs\n"
  }


  if (as != cs) {
<<"%V $as  !=  $cs\n"
  }


  if (!(as @= cs)) {
<<"%V $as  ! @=  $cs\n"
  }






chkT(1)
chkOut()



 av = 1;
 <<"%V$av\n"

void pstr( str val)
{

<<"\nval <|$val|>\n"
   id = val->varid()
<<"%V $id\n"   
!~   val->Info(1)

DIF   val->pinfo()
   iv = vgen(INT_,10,0,1)
   <<"$iv\n"
   iv->reverse()
   <<"$iv\n"
DIF   iv->info(1)

  cart(val)

}
//===========================//

void cart( str pname)
{
<<"$_proc   arg is <|$pname|>\n"
//str xn;


DIV     id = pname->varid() ;
DIV <<"%V $id\n"

    vi =pname->pinfo();

    //pname->pinfo();
    
   // sz= Caz(pname);
    // <<"%V $sz\n"

DIF varinfo(pname,1)

    xn=scat(pname," Senor")

DIF varinfo(xn,1)

DIF xn->pinfo()

    cart_y(xn, pname) ;  // fails
    //xn2 = pname
    //cart_y(xn, xn2) ;  // ok made a copy
!t on ret from cart_y xn ?    
//!i xn

DIF    xn->pinfo()



}

//===========================//
void cart_xic( str pxname)
{

<<"\n arg is <|$pxname|>\n"
   id = pxname->varid()
<<"%V $id\n"   
DIF    pxname->pinfo()

}

//===========================//
void cart_y( str pxname, str arg2)
{
<<"IN $_proc arg1 is <|$pxname|>  arg2 is <|$arg2|\n"
    // sdb(2,@step)


DIV     id = pxname->varid();
DIV <<"%V $id\n";
   

     pxname->pinfo()
     sz= Caz(pxname);
     <<"%V $sz\n"

    varinfo(pxname,1)
     

DIF arg2->pinfo()


    xn=scat(pxname," Que Pasa?")
     id = xn->varid()
<<"%V $id\n"   

//DIF xn->pinfo()

     cart_z(xn, arg2)
!t on ret from cart_z xn ?    
DIF xn->pinfo()


}
//===========================//
void cart_z( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
     id = arg1->varid()
<<"%V $id\n"   
DIF arg1->pinfo()
DIF arg2->pinfo()

    zn=scat(arg1," hasta luego")
         id = zn->varid()
<<"%V $id\n"   

DIF zn->pinfo()


    cart_w(zn, arg2)

!t on ret from cart_w ?    

//DIV     id = zn->varid() ;<<"%V $id\n"   

DIF zn->pinfo()
    

}

//===========================//

void cart_w( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
DIV   id = arg1->varid() ;
DIV <<"%V $id\n"   
vi= arg1->pinfo()
DIF arg2->pinfo()

     cart_v (arg1,arg2);

}
//===========================//
void cart_v( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
DIV   id = arg1->varid();

DIV   <<"%V $id\n"

DIF arg1->pinfo()
   
   cart_u (arg1,arg2);

}
//===========================//
void cart_u( str arg1, str arg2)
{

<<"IN $_proc arg is <|$arg1|>  arg2 is <|$arg2|> \n"
   id = arg1->varid()
<<"%V $id\n"   
DIF arg1->pinfo()
DIF arg2->pinfo()
!t begin return down call chain     

}
//===========================//


void do_carts (str wprg)
{
//  str wprg = aprog;
<<"$_proc  $wprg \n"

   id = wprg->varid()
<<"%V $id\n"   
DIF wprg->pinfo()

<<"run cart vers  $wprg \n"

      cart (wprg);
      
DIF wprg->pinfo()

 <<"run xic vers  $wprg \n"

       cart_xic (wprg);

<<"after cart_xic  $wprg \n"
 

}
//===============================

str abc = "abcdefg"
str xyz = "xyz"


  abc->pinfo();

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

c->pinfo()


abc[4] = 'A'

<<"$abc\n"



Str s = "h";

<<"X<|$s|>\n"

s->pinfo()

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

s->pinfo()

<<"%V $s \n"



Str s3;

s3->pinfo()

 s3="goodbye"

<<"%V $s3 \n"

chkStr(s,"hi there")

s= Supper(s,0,1);

<<"%V $s \n"

s->reverse()

<<" $s \n"

<<"%V $s \n"


s->pinfo();


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





