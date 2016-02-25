//

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
<<"%V $j :: $xyv[0] \n"

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

     CheckOut()

STOP!