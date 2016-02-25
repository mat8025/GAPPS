
checkIn()
setdebug(1)

int ok =0
int k = 0

<<"%I $k \n"

N = GetArgI(1)

 <<" arg was $N \n"
 <<" k++  < $N  b4 loop\n"

  i= 0

 WHILE ( k++ <N){
    i++
   <<"%V$i $k < $N \n"
 }

<<"%V$k \n"
<<"%V out of loop $i $k $N \n"

   CheckNum(k,(N+1))




  i=0
  k = 0
 <<" ++k  < $N  b4 loop\n"

<<"%I $k \n"



 WHILE ( ++k < N) {
   i++
 <<"%V $i $k < $N \n"
 }


<<"out of loop %V$i $k $N \n"

CheckNum(k,N)

CheckOut()
stop()

 k = 0
 WHILE ( k < N) {

 <<"$i $k < $N \n"
   i++
   k++
   if (k > (N/2)) {
    <<" $k > $N /2  skip rest \n"
     continue
   }

 <<" $k < $(N / 2) \n"

 }

<<" %V $k $N \n"


   CheckNum(k,N)




  k = 0
 j = 0


 WHILE ( k++ < N) {

    <<" $k  < $N \n"
   j++
   if (k == j) {
      ok++
   }


   if (k > (2 *N)) {
      bad++
      break
    }


   if (j > N) {
<<" %v $j > $N   $k \n")
    bad++
    break
   }
 }

<<" %V $k $N \n"

   CheckNum(k,(N+1))



more_legs = 1
   j = 0

   WHILE (more_legs == 1) {

       j++

    <<"%V $j $more_legs \n"

       if (j > 3) {
              more_legs = 0
       }

       if (j > 5) {
           break
       }
   }


   CheckNum(j,4)

   CheckOut()


STOP!


///////////////////////////////
