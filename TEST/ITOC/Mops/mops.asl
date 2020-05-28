//%*********************************************** 
//*  @script mops.asl 
//* 
//*  @comment test some math SF  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sun Apr 12 13:35:08 2020 
//*  @cdate Sun Apr 12 13:35:08 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///    Mops -- test some SF mops



CheckIn()

short xyv[12]
//int xyv[12]

<<"%v $(Caz(xyv)) \n"

<<" $(typeof(xyv)) \n"

<<"%v $(Caz(xyv)) \n"

 xyv[2] = 99

testargs(" TRY HARDER $xyv[2] ")

 as = xyv[2]

<<"%v  $as \n"


   CheckNum(xyv[2],99)

   CheckNum(xyv[2],as)


//FIX CheckNum(Caz(xyv),8)

 sz = Caz(xyv)

  CheckNum(sz,12)


  CheckNum(Caz(xyv),12)
// FIX runs twice ?


//   CheckOut()
//STOP!

short zx[4]

 zx[0] = 1
 zx[1] = 2
 zx[2] = 3
 zx[3] = 4



 zxs = 50

   pi = 0
   xyv[pi++] = 700
   xyv[pi++] = zx[3]*zxs
   xyv[pi++] = 699
   xyv[pi++] = zx[2]*zxs
   xyv[pi++] = 698
   xyv[pi++] = zx[1]*zxs
   xyv[pi++] = 697
   xyv[pi++] = zx[0]*zxs

<<" %v $pi \n"




<<" $xyv[0] \n"

<<" $xyv \n"

<<" $xyv[::] \n"

<<"%V $xyv[::] \n"

<<"%v $(Caz(xyv)) \n"


   xyv[0,2,4,6] = 77


<<"%v $xyv[::] \n"

   CheckNum(xyv[2],77)


   CheckNum(xyv[6],77)

<<"%v $xyv[::] \n"

   xyv[0,2,4,6] = Igen(4,69,1)

<<"%v $xyv[::] \n"


   CheckNum(xyv[2],70)


//<<"%v $xyv[6] \n"

   CheckNum(xyv[6],72)

<<" $xyv \n"
   zx[0] =23

<<" %v $zx \n"
<<"%v $xyv[*] \n"

   xyv[1,3,5,7] =  zx

<<"%v $xyv[::] \n"



<<" $xyv[0] \n"
<<"%V :: $xyv[0] \n"

    zx[3] = 66

<<"%v $zx \n"

 for (j = 1; j < 4 ; j++) {

    zx =  zx * 2
    
<<"%v $zx \n"
//   xyv[1,3,5,7] =  zx * zxs * j

   xyv[1,3,5,7] =  zx 


<<"%V $j :: $xyv[0] \n"

<<"%V $j :: $xyv \n"

 }

<<"%v $(Caz(xyv)) \n"

checkStage("xyassign")
N = 27

a = cbrt(N)

<<"cube root of $N  is $a\n"
checkFNum(a,3.0)
N = 729

a = cbrt(N)

<<"cube root of $N  is $a\n"
checkFNum(a,9.0)

checkStage("cbrt")


//============= Atof ===========//
p = _PI

  i = 47;
    <<"%I $i    \n"



  f= 1.2;
  sz = Caz(&f);
  <<"%V $f  $sz  \n"


  f = atof("3.141593")

  sz = Caz(&f);
  <<"%V $f  $sz  \n"

 checkNum(sz,0)



A= Split("$_PI 1634 8208 9473")

<<"%V $A \n"

F=Atof(A)
 sz = Caz(F);
 bd = Cab(F);
 <<"%V $F  $sz $bd\n"
checkNum(sz,4)

G = Atof(A[1])
 sz = Caz(&G);
 bd = Cab(&G);
<<"%V $G $sz $bd \n"
checkNum(sz,0)

I = Atoi(A[2])
 sz = Caz(&I);
 bd = Cab(&I);
<<"%V $I $sz $bd \n"

checkNum(sz,0)

checkStage("atof")

hs = dec2hex(47806)
<<"$hs\n"
checkStr(hs,"BABE")

i= hex2dec("babe")


checkNum(i,47806)


checkStage("dec2hex")

CheckOut()
