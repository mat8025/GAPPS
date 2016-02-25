CheckIn()

// test array indexing

N = 10

float RS[12]

  RS = 77

<<"%6.2f$RS \n"

 CheckNum(RS[1],77.0)

float xr0


 xr0 = RS[1]
 yr0 = RS[2]


<<"%V$xr0 $yr0 \n"

 CheckNum(xr0,77)

 CheckNum(yr0,RS[2])


 CheckOut()

STOP!







 YV = Igen(N,0,1)
<<" $YV \n"

 vi = 5

 val = YV[2]
<<" $val \n"

 val = YV[3]
<<" $val \n"

int nloop = 0

while ( nloop < N) {

   val = YV[nloop]

  <<"$nloop  $val \n"

 nloop++
}

<<" $YV \n"

YV[2]=96

<<" $YV \n"


STOP!
