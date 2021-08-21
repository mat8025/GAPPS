
//%*********************************************** 
//*  @script ifand.asl 
//* 
//*  @comment test if exp eval
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                               
//*  @date Sat May 23 15:08:41 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
   
<|Use_=
Demo  of if and/or
///////////////////////
|>


#include "debug.asl";



if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

   

  



 av =1;

 is_comment =0;
 is_proc =0;
 is_if  =0;
 cs ="ABC"
 sl = slen(cs)

  vv = sstr(";/{}\\",cs,1)
  <<"%V$vv \n"

  vv->pinfo()

  if ( vv[0] == -1)  {
    chkT(1)
  }
  else {
   chkT(0)
  }
  
<<"%V $is_comment $vv\n"

  vv = sstr("HABCDABC",cs,1,1)
  <<"%V$vv \n"

  vv->pinfo()

  if ( vv[0] != -1)  {
    chkT(1)
  }
  else {
   chkT(0)
  }
  
<<"%V $is_comment $vv\n"


 VI= vgen(INT_,10,1)
 <<"$VI\n"

  if (VI[2] == 1) {
    chkT(1)
  }

  if (VI == 1) {
    chkT(1)
  }

VI[0] = -4

  if (VI == 1) {
    chkT(1)
  }

 <<"$VI\n"

<<"%V $av $vv\n"

  if (av == 1 &&  vv== 1) {
     chkT(1)
  }
  else {
     chkT(0)
  }


  av = 4;
  if ( (is_comment == 0) && ( av == 4) ) {
    chkT(1)
  }
  else {
   chkT(0)
  }

  av = -1;
  if ( !is_comment && ( av == -1) ) {
    chkT(1)
  }
  else {
   chkT(0)
  }
  
vv = sstr(";/{}\\",cs,1)
  <<"%V$vv \n"

  vv->pinfo()

  if ( !is_comment && ( vv[0] == -1) ) {
    chkT(1)
  }
  else {
   chkT(0)
  }



<<"%V $is_comment && $is_proc && $is_if  && ($sl > 0) && ($vv == -1) \n"
<<"%V $(!is_comment) && $(!is_proc) && $(!is_if)  && $(sl > 0) && $(vv == -1) \n"
 
   if ( !is_comment && !is_proc && !is_if  && (sl > 0) && ( vv[0] == -1) ) {
     
    chkT(1)
  <<"fold 5 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

  }
 else {
    chkT(0)
<<"fold 5 not correct!\n";
 }




if ( 1 && 1 && 1  && 1   && 1 ) {
<<"all ones   1 && 1 && 1  && 1   && 1 \n"
chkT(1)
}

if ( 0 && 1 && 1  && 1   && 1 ) {
<<"all ones?   0 && 1 && 1  && 1   && 1 \n"
chkT(0)
}
else {
<<"NOT all ones?   0 && 1 && 1  && 1   && 1 \n"
chkT(1)
}

if ( 1 && 0 && 1  && 1   && 1 ) {
<<"all ones? 1 && 0 && 1  && 1   && 1 \n"
chkT(0)
}
else {
<<"NOT all ones? 1 && 0 && 1  && 1   && 1 \n"
chkT(1)
}

if ( 1 && 1 && 0  && 1   && 1 ) {
<<"all ones? 1 && 1 && 0  && 1   && 1\n"
chkT(0)
}
else {
<<"NOT all ones? 1 && 1 && 0  && 1   && 1 \n"
chkT(1)
}

if ( 1 && 1 && 1  && 1   && 0 ) {
<<"all ones? 1 && 1 && 1  && 1   && 0\n"
chkT(0)
}
else {
<<"NOT all ones? 1 && 1 && 1  && 1   && 0 \n"
chkT(1)
}

a = 1
b = 1
c = 1

if ( a && b && c  ) {
<<"all ones? $a && $b && $c\n"
}

b= 0
if ( a && b && c  ) {
<<"all ones? $a && $b && $c\n"
}
b= 1
c= 0
if ( a && b && c  ) {
<<"all ones? $a && $b && $c\n"
chkT(0)
}

a= 0
c=1
if ( a && b && c  ) {
<<"all ones? $a && $b && $c\n"
chkT(0)
}
a =1
if ( a && b && c  ) {
<<"all ones? $a && $b && $c\n"
chkT(1)
}

chkOut()