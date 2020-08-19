
//chkIn()
chkIn()
prog = GetScript()

//N = GetArgI()
N = 24
//tt = GetArgI()

tt = 18

<<"%V $tt $N \n"

#{

 This will calculate a times table

#}


<<" $N $tt times table  test for statement \n"

//int k = 0



int cnt = 0

<<"%i $tt \n"
<<"%i $N \n"

//int b

k = 2

  a= k * tt
<<"%i $a  \n"



//int a
  for ( k = 1; k <= N ; k++) {

//<<" for begin loop val $k < $M \n"

  a= k * tt

 <<" $k * $tt = $a \n"
  cnt = k
 }

<<" DONE %V $k  $N  \n"

<<" $cnt == $N ?? \n"

   chkN(cnt,N)

 b = cnt * tt

<<"%i $a ? ==  %i $b \n"


   chkN(a, b)


   chkN(a, (cnt * tt))


   chkOut()

STOP!




///////////////////////////////
