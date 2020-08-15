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
include "debug"

<<"%V $_dblevel\n"

if (_dblevel >0) {
   debugON()
}


checkIn(_dblevel)

proc sumarg (ptr v, ptr u)
{
<<"args in %V  $v $u \n"
float z;

 v->info(1)
 u->info(1)

   z = $v + $u;

<<"%V $v + $u = $z\n"

   $v = $v +1;

<<" changing first arg to %V $v\n"


   v->info(1)

   lu = $u
<<"%V $lu \n"   
   $u = (lu * 2)

   //$u = $u * 2;
  // $u *= 2;


<<" changing second arg to %V $u \n"
u->info(1)
<<"args out %V $v $u $z\n"

<<" should return $z\n"

  return z;

}
//=======================//


proc sumarg2 (int v, int u)
{
<<"args in %V  $v $u \n"
float z;
   z = v + u;

<<"%V$v + $u = $z\n"

   v++;
<<" changing first arg to %V$v\n"

   u = u * 2;

<<" changing second arg to %V$u \n"

<<"args out %V$v $u $z\n"

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

p = 0;

<<"IN %V $n $m $p \n"

 p = sumarg(&n,&m)
 
<<"OUT %V $n $m $p \n"

checknum(n,3)
checknum(m,6)


co()
exit()



CheckFNum(w,40.0,6)

CheckFNum(x,14.3,3)

CheckFNum(y,53.4,3)



float x = 13.3;
float y = 26.7;

 w = sumarg(&x,&y)
<<"%V $x $y $w \n"



CheckFNum(w,40.0,6)

CheckFNum(x,14.3,3)

CheckFNum(y,53.4,3)

co ()
exit()


<<"Scalar args \n"
<<"calling %V $n $m \n"

int k = 0;

 k = sumarg(&n,&m);

<<"post %V $n $m $k\n"

<<"%V proc returns $k \n"

  CheckNum(n,3)

  CheckNum(m,6)

<<"%V $k\n"

//  CheckNum(k,5)

   checkNum(5,k);

//

 n = 7;
 m = 14;

  k = sumarg(&n,&m)

<<"%V $n $m $k \n"

  CheckNum(k,21);



  CheckNum(n,8);
  CheckNum(m,28);


 co()
 exit()
 n = 54;
 m = 49;

 k = sumarg(&n,m)

  CheckNum(n,55)
  CheckNum(m,49)
  CheckNum(k,103);
<<"%V $n $m $k \n"



checkOut()


 n = 79;
 m = 47;


k = sumarg2(n,&m)

  CheckNum(n,79)
  CheckNum(m,94)
  CheckNum(k,126);
<<"%V $n $m $k \n"



 n = 20;
 m = 28;

k = sumarg(&n,m)

  CheckNum(n,21)
  CheckNum(m,28)
  CheckNum(k,48);

<<"%V $n $m $k \n"





 CheckOut()



//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument
