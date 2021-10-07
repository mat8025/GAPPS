
//%*********************************************** 
//*  @script procrefarg.asl 
//* 
//*  @comment test proc args
//*  @release CARBON 
//*  @vers 1.37 Rb Rubidium                                               
//*  @date Mon Jan 21 06:40:50 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

<|Use_=
  Demo  ref arg
|>


#include "debug"




if (_dblevel >0) {
   debugON()
       <<"$Use_\n"   
}

allowErrors(-1)

chkIn(_dblevel);


int sumarg (int v, int  u)
{
<<"args in %V  $v $u \n"

   z = v + u

<<"%V  $v + $u = $z\n"

  v = v +1;
 // v++;
   
<<" changing first arg  %V $u \n"
   u = u * 2
<<" changing second arg  %V $u \n"
<<"args out %V  $v $u \n"
  return z

}


int n = 2
int m = 3

 pre_m = m
 pre_n = n


<<"Scalar args \n"
<<"calling %V $n $m \n"

  k = sumarg(n,m)

<<"post %V $n $m \n"

<<"%V proc returns $k \n"

  chkN(n,2)
  chkN(m,3)

  chkN(k,5)

<<"%V $n $m \n"

  k = sumarg(&n,&m)

<<"%V $n $m \n"

  chkN(n,3)
  chkN(m,6)

  chkN(k,5)

chkout()

exit()


 n = 7
 m = 14


k = sumarg(n,&m)


<<"%V $n $m $k \n"



float x = 13.3
float y = 26.7

 w = sumarg(&x,y)
<<"%V $x $y $w \n"

 chkR(w,40.0,6)

 n = 79
 m = 47

k = sumarg(&n,m)

<<"%V $n $m $k \n"



 n = 20
 m = 28

k = sumarg(&n,m)

<<"%V $n $m $k \n"

 chkOut()


//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument