/* 
 *  @script proc_ptrarg.asl 
 * 
 *  @comment test ptr arg
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.3 C-Li-Li] 
 *  @date Thu Dec 31 13:34:29 2020 
 *  @cdate Sat May 9 10:35:36 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
 
                                                                        
#include "debug"

if (_dblevel >0) {
   debugON()
}

filterFileDebug(REJECT_,"scopesindex_e","scope_e","scope_findvar","rdp_token");

chkIn()


void goo(ptr a)
{
<<"$_proc $a\n"

a<-pinfo()
   b = $a;

<<"%V $a $b\n"
   b->info(1)
//   $a +=1
     $a = $a +1
     
<<"%V $a $b\n"

}
//===============//


   x =1;
   px = &x;

   $px = 3;

chkN(x,3)

   $px = $px + 1;

<<"$px $x\n"

chkN(x,4)

float y = 2.1;

    px = &y;

   $px = $px + 1;

<<"$px $y\n"

chkR(y,3.1)


   px = &x;
   
   px<-pinfo();

  z=x;

   goo(px)

<<"after call goo(px) $x\n"
  chkN(x,(z+1));
   z=x;
  goo(&x)

<<"after call goo(&x) $x\n"

  chkN(x,(z+1));



chkOut()