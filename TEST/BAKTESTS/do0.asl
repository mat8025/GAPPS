
checkIn()


int k = 0 ;
int j = 4;  <<" %I $k $j \n"

CheckNum(k,0) ;
CheckNum(j,4)

N = GetArgI()

 <<" arg was $N \n"
 <<" k++  < $N  b4 loop\n"

  i= 0

  do {

       i++
       k++
      <<" in do_while loop %V $i $k < $N \n"
    }  while ( k < N) 

<<" after do loop \n"

<<"out of loop %V$i $k $N \n"

 CheckNum(i,N) ; CheckNum(k,N) ;

 i = N
 k = 0

  do {
       i--
       k++
      <<" in do_until loop %V $i $k >= $N \n"
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   CheckNum(k,N) ; CheckNum(i,0) 

  i = 0
<<"  do - do loop at least once \n"
  do {
       i++
       k++
      <<" in do_until loop %V $i $k >= $N \n"
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   CheckNum(k,N+1); 
   CheckNum(i,1) 
   CheckOut()




///////////////////////////////
