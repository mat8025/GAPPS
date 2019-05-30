//%*********************************************** 
//*  @script forexp.asl
//* 
//*  @comment  for test exp 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%//

include "debug.asl"
debugON()
sdb(1,@pline)

checkIn()

prog = GetScript()

//N = GetArgI()
N = 12
//tt = GetArgI()


k = 1

  if (k <= N) {
<<" $k  <= $N"
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

   CheckNum(k,N+1)
   CheckNum(cnt,N)
<<" DONE %V $k  $N $cnt \n"
<<"//////////////////\n"

//  for ( j = 1; j <= (N-1); j++)

//for ( j = 1; j <= (N-1) ; j++)  // bug does not get RHS exp correct


 

for ( j = 1; j <= N-1 ; j++) { // bug does not get RHS exp correct
   

    cnt = j
    <<"loop val $j <= $(N-1) $cnt\n"

    a= j * tt

    <<"%V$j * $tt = $a \n"


  }

<<" DONE %V $j  $(N-1)  $cnt \n"

  CheckNum(j,N)

<<" $cnt == $(N-1) ?? \n"
   CheckNum(cnt,N-1)


 b = cnt * tt

<<"%i $a ? ==  %i $b \n"


   CheckNum(a, b)


   CheckNum(a, (cnt * tt))


   CheckOut()






///////////////////////////////
