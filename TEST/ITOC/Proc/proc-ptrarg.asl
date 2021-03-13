/* 
 *  @script proc-ptrarg.asl 
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
  
chkIn(_dblevel)


void goo(ptr a)
{
<<"$_proc $a\n"
   b = $a;

<<"%V $a $b\n"
   b->info(1)
//   $a +=1
     $a = $a +1
     
<<"%V $a $b\n"

}



   x =1;
   px = &x;
   goo(px)

<<"after call goo(px) $x\n"
  chkN(x,2);

  goo(&x)

<<"after call goo(&x) $x\n"

  chkN(x,3);



chkOut()