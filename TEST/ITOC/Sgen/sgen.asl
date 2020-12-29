//%*********************************************** 
//*  @script sgen.asl 
//* 
//*  @comment test sgen SF 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.1 C-Li-H]                                  
//*  @date Sun Dec 27 22:02:16 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///   sgen
///
/*
V=sgen(TYPE,n,vec,{init_val})
generates a vector n values,of type (FLOAT_,INT_,SHORT_,CHAR_ ...) 
The argument vector is used to successively add values 
to the current value, while cycling through its
'list' of values - 
each new value is put into the next element of the genearated vector. 
e.g.
vec = {2,-1}
V=sgen(INT,10,vec)
would set V to   
2 1 3 2 4 3 5 4 6 5
a two steps forward one step back sequence. 
The default initial value is zero. 
The size of vec does not need to be an exact factor 
of the size of the generated array.
*/



chkIn()

int v[2] = {2,-1}
<<"$v \n"

I = sgen(INT_,10,v)

<<"$I\n"


chkN(I[0],2)
chkN(I[1],1)


int vi[2] = {0,1}

int vs[2] = {1,2}


J = vvgen(INT_,10,vi,vs)

<<"$J\n"

chkN(J[2],1)
chkN(J[3],3)


chkOut()

exit()