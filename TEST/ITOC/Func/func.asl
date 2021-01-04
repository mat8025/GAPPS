//%*********************************************** 
//*  @script func.asl 
//* 
//*  @comment test CL args 
//*  @release CARBON 
//*  @vers 1.38 Sr Strontium                                               
//*  @date Tue Apr 21 16:16:17 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

#include "debug";



if (_dblevel >0) {
   debugON()
}

///
///
///


chkIn(_dblevel)


double goo(double a)
{
 float tmp

 tmp = a/2.0

 return tmp

}
//=====================

gen N = "a1"
gen M = "a2"
if (argc() > 1) {
N = _clarg[1]
}

if (argc() > 2) {
M = _clarg[2]
}
<<"$N $M\n"
<<" $_clarg[0:-1] \n"

 sa=testargs(N,M)

<<" $sa $N $M\n"



 int k = 0

 kt = typeof(k)

 <<"%V $k $kt \n"

 ut = utime()

 <<"%V $ut \n"

 y = 1.0 

 m = 2

  d = 45.0

  r = deg2rad(d)

<<"%V $r \n"

  x= Sin(r)

  <<"Sin $r = $x   \n"

  x= Sin(deg2rad(d))

  <<"Sin $d degs = $x   \n"


  y= Cos(deg2rad(d))

  <<"Cos $d degs = $y   \n"


  z = Sin(deg2rad(d)) * Cos(deg2rad(d))

  <<" Sin $d * Cos $d  = $z\n"

  float w = x * y

  <<" $x * $y = $w \n"

  //     chkN(w,z)

  z = Cos(Sin(deg2rad(d))) * Sin(Cos(deg2rad(d)))

<<" $z \n"

  w = Cos(x) * Sin(y)

<<" $w \n"

  chkR(w,z,4)

// FIXME

  z = Sin(Cos(Sin(deg2rad(d)))) * Cos(Sin(Cos(deg2rad(d))))

<<" $z \n"



  w = Sin(Cos(x)) * Cos(Sin(y))

<<" $w \n"

  chkR(w,z,3)


  t = goo(x)

<<"$x $t \n"



 t = goo(Cos(x))
 <<"$x $t \n"



  k = 0

 while (k <= 10) {

  x= Sin(deg2rad(k))

 <<"$k  $x\n"

  k++

 }



prog= GetScript()




 y=Sin(1.0)

 <<" $y \n"

 y=Cos(0)

 <<"cos $y \n"

  chkN(y,1.0)



 pi = 4.0 * atan(1.0)

<<"%v $pi \n"

y = Sin(pi/2.0)

<<" sin pi/2 $y \n"

  chkN(Fround(y,2),1.0)



  pir =Fround(pi,5)  

 if ( Fround(pi,5) == 3.14159) {
<<" $pir == 3.14159 \n"
 }
 else {
<<" $pir != 3.14159 \n"

  }

   chkN(Fround(pir,5),3.14159)

/////////////////////////////////////////

//%*********************************************** 
//*  @script func1.asl 
//* 
//*  @comment test func call 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Fri Feb  8 20:08:15 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

// foota returns arg values into double array
// dv = testargs(1,2)

<<"func test depends on testargs - which may change!\n"

jal = 0

j = 4

fva= testargs(1,2*3,4+1,j*2)

<<"%(1,,,\n)$fva \n"

jal = 6
fvs = fva[jal]

<<"%V $fvs\n"

Checkstr(fvs,"6")


jal++

jal += (2 * 10)


int A[]

  A=igen(5,0,1)

jal += 9

dv= testargs(A,1,2,3)

//<<"%(1,,\s,\n)$dv \n" // TBF

 F = vgen(FLOAT_,6,0,1)

<<"$F\n"

fva2= testargs(F)

fva2->info(1)
//<<"%(1,,,\n)$fva2 \n"   // TBF

jal = 2
fvs = fva2[jal]
col = split(fvs)


<<"%V$jal \n"
<<"$fvs\n"
<<"$col\n"

   checkstr(col[1],"0.000000")

jal = 3
fvs = fva2[jal]
col = split(fvs)
<<"%V $col \n"
chkStr(col[1],"1.000000")



///////////////////////////////
//%*********************************************** 
//*  @script funcargs.asl 
//* 
//*  @comment test func args 
//*  @release CARBON 
//*  @vers 1.13 Al Aluminium                                              
//*  @date Tue Jan 29 11:50:29 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


void Noo(int x,int y,int z)
{
<<"%V $x $y $z\n"
int m =x;
int n =y;
int p =z;
int i;
 i->info(1)
 ans ="c"
 for (i=0; i< 4; i++) {

 SV2=testargs(-1,m,n,p,1,2,3)
// <<"%V$SV2 \n"

   <<"%V $m $n $p\n"
    m++;
    n++;

  <<"%V $i $m $n $p\n";

//ans=query("proc");
 // if (ans @="q")    break;
//  p++;
    //if (m >20)
   // m = 20;
  
  }

}


//======================//



 int A2[5];

 A2= igen(5,0,1)

 B = A2 * 2

 a = 1;

a->info(1)
//ans=query("a?")

 chkR (a,1)




 int b = 79;
 int c = 47;
 
<<"%V $a $b $c \n"

SV=testargs(1,a,b,c)

<<"%V$SV[0] $SV[1] $SV[2]\n"

SV=testargs(1,&a,&b,&c)
<<"%V$SV\n"


//SV=testargs(1,c,a,b)
//<<"%V$SV\n"



<<"%V $a $b $c \n"

a->info(1)
//ans=query("a?")





//Noo(1,2,3);

a->info(1)
b->info(1)
c->info(1)

Noo(a,b,c);




/*




 testargs(1,@head,"big",@tail,"tiny",1,2,3,A)
 SV=testargs(-1,@head,"big",@tail,"tiny",1,2,3,A)

//iread();
<<"whats in SV\n"
<<"%V$SV[0] $SV[1] $SV[2]\n"
<<"%(12,,\,,\n)$SV[0:10]\n"

<<"%(1,,,\n)$SV\n"

<<"%V$SV[3] $SV[8] $SV[18]\n"

*/

SV=testargs(1,c,a,b)
<<"%V$SV\n"
////////////////////////////
chkStage("funcargs")

 pan pnum = 123456789.98765432100;

<<"%V$pnum \n"

  testArgs(pnum,  123456789)

  testArgs(pnum,  123.456)

  testArgs(pnum,  123456789.98765432100)

  chkR (pnum,  123456789.98765432100, 5)


chkStage("pan")


chkOut ()




