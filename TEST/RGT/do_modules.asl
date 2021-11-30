/* 
 *  @script do_modules.asl 
 * 
 *  @comment module test -interactive 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.61 C-Li-Pm]                                
 *  @date 11/24/2021 21:07:42 
 *  @cdate 11/24/2021 21:07:42 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of module test -interactive 
/////////////////////// 
|>


#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)



int do_query = 0;

B=ofw("modules_that_pass")
C=ofw("modules_that_fail")
D=ofw("modules_stat")
void inter()
{
int ask = 0;
str ans;
!!"cat mod_score"
A=ofr("mod_score")
L=readfile(A)
iv= sstr(L,"PASS")
cf(A)
ask =0
if (iv[0] == -1) {
 ask = 1;
<<[C]"$L\n"
<<[D]"$L[2]\n"
}
else {
<<[B]"$L\n"

}
 if (do_query && ask) {

  ans= query("->")

  if (ans == "c") {

    do_query = 0;

  }

  if (ans == "q") {

      exit()

  }

 }
}





!!"asl ASL_TEST_VER module command > mod_score";

inter()


!!"asl ASL_TEST_VER module paraex > mod_score ";

inter()



!!"asl ASL_TEST_VER module  pan > mod_score";

inter()

!!"asl ASL_TEST_VER module stat > mod_score";

inter()

!!"asl ASL_TEST_VER module  sfunc > mod_score";

inter()



!!"asl ASL_TEST_VER module  scope > mod_score";

inter()



//!!"asl ASL_TEST_VER module syntax ";

//inter()



!!"asl ASL_TEST_VER module include  > mod_score";

inter()

!!"asl ASL_TEST_VER module if  > mod_score";

inter()

!!"asl ASL_TEST_VER module declare  > mod_score";

inter()

!!"asl ASL_TEST_VER module bops  > mod_score";

inter()

!!"asl ASL_TEST_VER module bit  > mod_score";

inter()

!!"asl ASL_TEST_VER module proc  > mod_score";

inter()

!!"asl ASL_TEST_VER module logic  > mod_score";

inter()

 !!"asl ASL_TEST_VER module try  > mod_score";

inter()

!!"asl ASL_TEST_VER module exp  > mod_score";

inter()

!!"asl ASL_TEST_VER module types  > mod_score";





 !!"asl ASL_TEST_VER module enum  > mod_score";

inter()

!!"asl ASL_TEST_VER module for  > mod_score";

inter()

!!"asl ASL_TEST_VER module do  > mod_score";

inter()

!!"asl ASL_TEST_VER module while  > mod_score";

inter()

!!"asl ASL_TEST_VER module matrix > mod_score ";

inter()



!!"asl ASL_TEST_VER module math > mod_score ";

inter()



!!"asl ASL_TEST_VER module switch > mod_score ";

inter()



 !!"asl ASL_TEST_VER module func  > mod_score ";

inter()

 

!!"asl ASL_TEST_VER module proc > mod_score ";

inter()







!!"asl ASL_TEST_VER module vops  > mod_score ";

inter()



!!"asl ASL_TEST_VER module sops  > mod_score ";

inter()



!!"asl ASL_TEST_VER module mops  > mod_score ";

inter()



 !!"asl ASL_TEST_VER module svar  > mod_score ";

inter()

 !!"asl ASL_TEST_VER module record  > mod_score ";

inter()

 !!"asl ASL_TEST_VER module ivar  > mod_score ";

inter()

 !!"asl ASL_TEST_VER module lists  > mod_score ";

inter()



 !!"asl ASL_TEST_VER module lhsubsc  > mod_score ";

inter()

 !!"asl ASL_TEST_VER module dynv  > mod_score ";

inter()



 !!"asl ASL_TEST_VER module unary  > mod_score ";

inter()

 !!"asl ASL_TEST_VER module ptrs  > mod_score ";

inter()

 !!"asl ASL_TEST_VER module vmf  > mod_score ";

inter()



!!"asl ASL_TEST_VER module array > mod_score ";

inter()



 !!"asl ASL_TEST_VER module class  > mod_score ";

inter()

!!"asl ASL_TEST_VER module  oo  > mod_score ";

inter()

cf(B)

/*



!!"asl ASL_TEST_VER module do_bugs ";

 do_define 

 do_recurse 



 do_scope 



 do_stat 

 do_threads 



 do_tests 

*/
