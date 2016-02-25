

CheckIn()

 m = 7 % 3

CheckNum(m,1)


 m = 9 % 3

CheckNum(m,0)


 k = -2
 float d = 6.0

 x = k / d

 yf = floor(x)


int ir

 yr = k -  d * floor(k/ d);

 ir = yr

<<"%V $k $d $x $yf $yr $ir\n"

CheckNum(ir,4)


  f= fmod(5.0,3)

<<"%V $f \n"

  CheckFNum(f,2,6)

CheckOut()

stop!


for (mr = 1 ; mr < 16 ; mr++) {

<<" $mr \n"
  cnt = 0
  ncnt = 0

for (i = 1; i <= 32 ; i++) {
  n = i / mr
  j = i % mr

<<"$i \% $mr =  $j  $n \n"

  if (j) {
   cnt++
  }
  else {
   ncnt++
  }

}

<<"%V $mr $cnt $ncnt \n"
}

<<"%V $mr $cnt $ncnt \n"
;


CheckOut()
