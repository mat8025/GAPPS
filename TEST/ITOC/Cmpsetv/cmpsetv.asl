//*********************************************** 
//*  @script cmpsetv.asl 
//* 
//*  @comment test cmpsetv func 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Tue Apr  2 07:47:16 2019 
//*  @cdate Tue Apr  2 07:34:04 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************



/*
cmpsetv
cmpsetv(vec, op,cmp_value, set_value)
sets elements of a vector to set_value if compare operator (">,>=,<,<=,==") 
on an element with the cmp_value is true.
cmpsetv(vec,">",1,1)
will limit vector values to 1
 Another operation may done sequentially e.g
cmpsetv(vec,">",10,10,"<",-10,-10)  
would limit vector between range -10,10.
*/

#include "debug.asl"
debugON()

filterFileDebug(REJECT_,"array","args","exp")

void limit_vec()
{
   cmpsetv(I,">",1,10)
}


chkIn(_dblevel)

I = vgen(INT_,20,0,1)

<<"$I \n"

 for (k =0 ; k < 10; k++) 
 {
  I += 5;
  <<"[${k}] $I \n"
  cmpsetv(I,">",50,10)
  <<"$I \n"

//ans=iread()
}

<<"%V$I[0] \n"
<<"$I \n"
 I.pinfo()

m= I[0]

n = I[1]

r = I[19]



<<"$m $n $r $I[0] $I[1] $I[19] \n"

chkN(m,50)

chkN(I[0],50)

chkN(n,10)

chkN(I[1],10)


////


for (i = 0; i < 5; i++) {

  I[0:7] = 25 + i

  <<"$I \n"

  limit_vec()

  <<"$I \n"

}

chkN(I[0],10)

chkOut()