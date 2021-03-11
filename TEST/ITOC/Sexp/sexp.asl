/* 
 *  @script sexp.asl 
 * 
 *  @comment test simple expression 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.30 C-Li-Zn]                                
 *  @date 03/11/2021 09:31:21 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

#include "debug";



if (_dblevel >0) {
   debugON()
}
  

<<"Running $_script\n"
chkIn(_dblevel)


  zz = 75 * 40 ;

<<"%V $zz\n"

chkN(zz,3000)


chkOut()

  zz = 75 * 40 * 4;

 if ( zz != 12000) {

<<" FAILED MISERABLY!! $zz != 12000\n"

 }
 else {
<<" a simple SUCCESS! $zz\n"
 }

   chkN(zz,12000)

zz = 75 + 40 * 4

 if ( zz != 235) {

<<" FAILED MISERABLY!! $zz != 235\n"

 }
 else {
<<" a simple SUCCESS!\n"

 }



prog = GetScript()

<<" %v is  $prog \n"


//double N = GetArgD()

 N = GetArgD()

<<"%v $N \n"

 if (N == 0.0) {

<<" enter parameter value != 0.0  on command line -> e.g. \n ./sexp 10 \n"
<<" use  10\n"
    N = 10;
  }



double z
double r
double ry
double y

<<" you entered a value of $N \n"

  z = Fround(N,10)

<<" set of $z to $N \n"
   k = 10

   while (k-- > 3) {

    z = Fround(N,k)

<<" round to $k  decimal places  $z \n"

   }


x = 3.0


 y = 4.0 * N

<<" $y = 4.0 * $N\n"

 y = 10.0 * N  / x

<<" $y = 10.0 * $N  / x\n"


 y = 10.0 * N  / x

<<" $y = 10 * $N  / x \n"

 y = 10.0 * N  / x   * 40.0

<<"  $y = 10 * $N  / $x   * 40 \n"


  ry = y /400.0  * x

<<"%V $ry \n"

  ry = Fround(ry,7)

<<"%V $ry \n"

   chkR(ry,N,6)

   if (ry < N) {
<<" $ry < $N \n"
   }



   if (ry <= N) {
<<" $ry <= $N \n"
   }
   else {
<<" $ry <= $N \n"
   }


   if (ry > N) {
<<" $ry > $N \n"
   }

   if (ry >= N) {
<<" $ry >= $N \n"
     chkN(1,1)
   }


   if (ry != N) {
<<" $ry != $N \n"
   }



<<"%V $ry $y $N  \n"

   y = 3.0

  z = y * y

  r = y/3.0

  k = 2




  while (1) {

   nr = 0.5 * (z + k)


//ttyin()


   mr = (z + k)

<<"%V $mr $(typeof(mr)) \n"

   mr *= 0.5

<<"%V $mr $(typeof(mr)) \n"

<<"[${k}]   $nr = 0.5 * ( $z + $k ) $mr \n"

   if (k > 6)
       break

    k++

   chkN(nr,mr)




  }

   chkOut()




///////////////////////////////
