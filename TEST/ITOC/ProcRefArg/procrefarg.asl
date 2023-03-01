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


Str Use_ = "How to use ref args" ;



/*
// in C++  function prototype  designates the args as ref
// at the moment asl allows to call as value or ref via swap(a,b) or swap(&a,&b)
// but now we want to compile into C++ 
// so have to be to declare function 
// as C++ i.e. swap(int &i, int &j) 
//

void swapnum(int& i, int& j) {
  int temp = i;
  i = j;
  j = temp;
}

int main(void) {
  int a = 10;
  int b = 20;

  swapnum(a, b);
  printf("A is %d and B is %d\n", a, b);
  return 0;
}
*/


///
/// procrefarg
#include "debug"

   allowErrors(-1) ; // keep going;

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn(_dblevel);


int a = 5;
int b = 4;


  aslpinfo(a);
  

 chkN(a,5);

 chkN(b,4);

  chkN(a,(b+1));



   int sumarg (int v, int u)
   {

     <<"$_proc int args int v  $v  u $u \n";

     v.aslpinfo();

     u.aslpinfo();


     int z;

     z = v + u;

     z.aslpinfo();

     v.aslpinfo();

     u.aslpinfo();

     <<"%V$v + $u = $z\n";

//   v++;

     v = v +1;



     v.aslpinfo();

     u = u * 2;

     <<" changing second arg to %V$u \n";

     u.aslpinfo();

     <<"args out %V$v $u $z\n";


     return z;

     }
//=======================//



   float sumarg (float v, float u)
   {

     <<"$_proc float args  v  $v u  $u \n";

     v.aslpinfo();

     u.aslpinfo();


     float z;


     z = v + u;

     z.aslpinfo();

     v.aslpinfo();

     u.aslpinfo();

     <<" $v + $u = $z\n";

//   v++;

     v = v +1;



     v.aslpinfo();

     u = u * 2;

//     <<" changing second arg to %V$u \n";

     u.aslpinfo();

     <<"args out %V $v $u $z\n";


     return z;

     }
//=======================//


   int swapnum (int& v, int& u)
   {

     <<"$_proc args int %V  $v $u \n";

     v.aslpinfo();

     u.aslpinfo();


     int z = -1;
     z.aslpinfo();
  
     z = v;  // this should get the value of what v refers to
     z.aslpinfo();

     v =u;

     v.aslpinfo();
     
     u= z;
     
<<"%V $z $v $u \n"

     return z;

     }
//=======================//

   float swapnum (float& v, float& u)
   {

     <<"$_proc args float v  $v u $u \n";

     v.aslpinfo();

     u.aslpinfo();


     float z = -1;

  
     z = v;
     z.aslpinfo();

     v =u;
     u= z;
     
<<"%V $z $v $u \n"

     return z;

     }
//=======================//







b = 4;

int c = a;

<<"%V $a $b \n"

  c=  sumarg (a,b);
<<"returns  $c\n";

 c.aslpinfo();
 <<"%V $a $b \n"
 chkN(c,9);


  a++;
  b++;

  c=  sumarg (a,b);
<<"returns  $c\n";

 chkN(c,11);

  

float x =5.2;
float y =4.2;
float z = -9;


  z= sumarg(x,y);

 chkN(z,9.4);

  z= sumarg(y,x);

 chkN(z,9.4);


  z= sumarg(y,a);

 chkN(z,10.2);





  z=  sumarg (x,y);

<<"returns z $z\n";

 chkN(z,9.4);

  x = 24.2;
  y = 12.2;

  z=  sumarg (x,y);

<<"returns z $z\n";

 chkN(z,36.4,3);



<<" should choose float version sumarg(a,y) \n"

 
  z= sumarg(a,y); 



 chkN(z,18.2);


   c= a;
<<"%V $a $b $c \n"

  swapnum (a,b);

<<"%V $a $b $c \n"

   chkN(b,c);

<<"%V $x $y  \n"

  swapnum (x,y);

<<"%V $x $y  \n"

   chkN(x,12.2);
  //swapptrs (&a,&b);


   chkOut();

///////////////// TBD //////////////////
// should work? if call as Hoo(x,y) or Hoo(&x,&y)
// difference is &x makes it a ref argument so it can be modified inside of proc
// else modification does not carry to calling scope
//
// xic version fails - fix
//
//

   
/*
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
*/

/*
   int sumarg (int v, int u)
   {

     <<"args int %V  $v $u \n";

     v.aslinfo();

     u.aslinfo();


     int z;

     z.aslinfo();

     z = v + u;

     z.aslinfo();

     v.aslinfo();

     u.aslinfo();

     <<"%V$v + $u = $z\n";
!z
//   v++;

     v = v +1;

     <<" changing first arg to %V$v\n";

     v.aslinfo();

     u = u * 2;

     <<" changing second arg to %V$u \n";

     u.aslinfo();

     <<"args out %V$v $u $z\n";
!z

     return z;

     }
//=======================//
*/


//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument

//===***===//
