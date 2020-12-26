//%*********************************************** 
//*  @script proc-loc-main-var.asl 
//* 
//*  @comment test proc arg main shadow 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Sun May  5 07:06:46 2019 
//*  @cdate Sun May  5 07:06:46 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


#include "debug"
debugON()

sdb(1,@pline)

void Foo()
 {

   <<"%V $A \n"

   b= A;
  int A = 7;
A->info(1)

   <<"%V $A \n"

<<"%V $::A \n"
    c= A;
<<"%V $A $b $c\n"

 }

//==========================//


void goo(int goo_a)
 {
 
<<"in $_proc  arg is $goo_a\n"

   goo_a->info(1)

   b = goo_a;

<<"%V $b $goo_a \n"

   int A = 7;

   A->info(1)

   <<"%V $A \n"

<<"%V $::A \n"
    goo_a++;
    c= A;
<<"%V $A $goo_a $b $c\n"

 }

//==========================//

proc hoo(int H)
 {
 
<<"in $_proc  arg is %V $H\n"

   H->info(1)

   b= H;

<<"%V $b $H \n"


 //  int H = 7; // BUG TBF -- should not be able to declare same name as arg!

   H->info(1)

   <<"%V $H \n"

<<"%V $::H \n"
    c= H;
    ::H += 1;
<<"%V $H $b $c\n"

 }

//==========================//

 chkIn()

 A = 1;
<<"$A\n"

A->info(1);


 H = NI_;


 d = O_


 goo(d);
 

 b4call = H;

<<"%V $H $d\n"

 H->info(1)
 
 hoo(d)

<<"%V $H $d\n"
 chkN(H,b4call+1)


 

 <<"%V $H $d\n"

chkN(H,CU_)

chkOut()

exit()

 H= AR_;
 hoo(H)
 

////////////////////////////////////////////////////////////////




d = 79

goo(d)

<<"%V $A  $d\n"

d = 47

goo(&d)

<<"%V $A  $d\n"


goo(&d)

Foo()


hoo(&d)

hoo(d)
