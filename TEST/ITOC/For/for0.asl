
//CheckIn()
checkIn()

prog = GetScript()

//N = GetArgI()
N = 24
//tt = GetArgI()


k = 1

  if (k <= N) {
<<" $k  <= $N
  }
  else {

<<" <= op not working!\n"
  }


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

  

  a= k * tt
<<"%V$a  \n"

    <<"%V$N $k\n"

  for ( k = 1; k <= N; k++) 
   {

    <<"loop val $k < $N $cnt\n"

    a= k * tt

    <<"%V$k * $tt = $a \n"

    cnt = k
  }


<<" DONE %V $k  $N  \n"

<<" $cnt == $N ?? \n"

   CheckNum(cnt,N)

 b = cnt * tt

<<"%i $a ? ==  %i $b \n"


   CheckNum(a, b)


   CheckNum(a, (cnt * tt))


   CheckOut()

STOP!




///////////////////////////////
