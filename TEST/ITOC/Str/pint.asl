//%*********************************************** 
//*  @script pint.asl 
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
  proc chain of int variable
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

//allowErrors(-1)

chkIn(_dblevel)

int cart( int pn)
{
<<"$_proc   arg is <|$pn|>\n"

  //  sdb(2,@trace,@steptrace)
    pn->info(1);
 
    xn= pn + 5

    xn->info(1)
//    return xn;
}


void pint( int val)
{

<<"$_proc val <|$val|>\n"

   val->Info(1)
     pval = val + 2;
 <<"%V$pval \n"    

    cart(val)
    cart(val+1)
//   ret=cart(val)
//<<"%V$ret\n"

}
//===========================//

int av = 7;
<<"$av \n"


 pint (6)

chkT(1)
 chkOut()
 

















//===========================//

//===========================//
void cart_y( int pxn, int arg2)
{
<<"$_proc arg1 is <|$pxn|>  arg2 is <|$arg2|\n"

     arg2->info(1)
     
     pxn->Info(1)

    xn=pxn + 7
    xn->info(1)

}
//===========================//



av = 77


 pint (av)






chkT(1)

chkOut()




