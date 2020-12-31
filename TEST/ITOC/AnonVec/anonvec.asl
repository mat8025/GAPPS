//%*********************************************** 
//*  @script anonvec.asl 
//* 
//*  @comment  test array vec {1,2,3} assignmnent  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.3.2 C-Li-He]                                
//*  @date Tue Dec 29 09:01:01 2020 
//*  @cdate 1/1/2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///
#include "debug"
debugON()
debugAllowErrors();

chkIn(_dblevel)


int veci[] = {1,2,3}

<<"%V $veci\n"

int vi[2] = {0,0}

<<"$vi \n"
vi->info(1)

int vs[2] = {1,-1}

chkN(vs[0],1)
chkN(vs[1],-1)


<<"$vs \n"
vs->info(1)




veci->info(1)

veci =  {41,52,53,4,5,6,7,8,9}

<<"%V $veci\n"

veci->info(1)


int vec2[] = {86,87,89};

vec2->info(1)

<<"$vec2\n"

vec2 = {90,91,92}

<<"$vec2\n"

  v3 = {35,36,37,38} ;  // should give warning -dynamic

<<"$v3 \n"






Table = vvgen(INT_,20,vi,vs)

<<"%(2,, ,\n)$Table \n"

testArgs(1,vi,vs)

// show list arg arrives as array of values
S=testArgs(1,{1,2,3,4,5,6,7,8,9})

<<"$S\n"


T=testArgs(1,{"hey","hago","haces","hace"})



<<"%(1,,,\n)$T\n"


vi->info(1)

vi = {3,7}

<<"$vi \n"
<<"$vi[0] $vi[1] \n"

vi = {32,45,55}

<<"$vi \n"
<<"$vi[0] $vi[1] $vi[2]\n"

//  v2[] = {1,2,3,4} ;  // crash - should give error

  int v2[] = {1,2,3,4} ;  // should give warning -dynamic

v2->info(1)

<<"$v2 \n"

  v2 = {5,6,7,8} ;  // should give warning -dynamic

<<"$v2 \n"



chkOut()


/*
// allow 
   int v[] = {1,2,3,4} 
// v is dynamic

   int v[4] = {1,2,3,4}
//  v is fixed

// allow following

  v = {5,6,7,8}
//  allow subsequent
//  allow  partial fill

//  allow expansion if dynamic 

  v2 = {1,2,3,4}
// error since v2 not being declared


*/
