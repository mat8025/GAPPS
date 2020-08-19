//%*********************************************** 
//*  @script procrefarg.asl 
//* 
//*  @comment test proc ref & arg 
//*  @release CARBON 
//*  @vers 2.37 Rb Rubidium                                               
//*  @date Wed Jan  9 21:40:10 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


///
/// procrefarg

setdebug(1,@pline,@~step,@~trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc",);
filterFileDebug(ALLOWALL_,"ic_",);


chkIn(0)

proc sumarg (v, u)
{
<<"args in %V  $v $u \n"
float z;
 v->info(1)
 u->info(1)

   z = v + u;

<<"%V$v + $u = $z\n"

   v++;

<<" changing first arg to %V $v\n"
v->info(1)   
   u = u * 2;

<<" changing second arg to %V $u \n"
u->info(1)
<<"args out %V $v $u $z\n"
z->info()
<<" should return $z\n"

  return z;

}
//=======================//





int n = 2;
int m = 3;

 pre_m = m;
 pre_n = n;

<<"%V$n \n"

    n++;

<<"%V$n \n"

    n--;

<<"%V$n \n"


float x = 13.3;
float y = 26.7;

 w = sumarg(&x,&y)
<<"%V $x $y $w \n"

chkR(w,40.0,6)

chkR(x,14.3,3)

chkR(y,53.4,3)


<<"Scalar args \n"
<<"calling %V $n $m \n"

int k = 0;

 k = sumarg(&n,&m);

<<"post %V $n $m $k\n"

<<"%V proc returns $k \n"

  chkN(n,3)

  chkN(m,6)

<<"%V $k\n"

   chkN(5,k);

//

 n = 7;
 m = 14;

  k = sumarg(&n,&m)

<<"%V $n $m $k \n"

  chkN(k,21);


chkOut()
