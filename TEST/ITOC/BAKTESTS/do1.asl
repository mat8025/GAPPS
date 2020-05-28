
checkIn(0)


int k = 0

N = GetArgI(1)

 <<" arg was $N \n"
 <<" k  < $N  b4 loop\n"

  i= 0
  j = 0

  DO {

       i++
       k++
      <<" in do_while loop $i $k < $N \n"

    }         WHILE ( k < N); 

<<" out of loop $i $k $N \n"

 CheckNum(i,N) ;
 CheckNum(k,N) ;





  i= 0
  j = 0
  k = 0
  DO {
 <<" in do_while outer top of loop %V$i $k < $N \n"

       i++
       k++
      
        DO {
    <<" top of nest %v$j \n"
          j++
          <<" bottom nest do loop %V$i $k $j < $N \n"
        } 
         WHILE (j < N);
     
 <<" in do_while outer bottom loop %V$i $k < $N \n"

    } 
      WHILE ( k < N);
 



<<" after do loop \n"
 //     <<"xx\n" 
<<" out of loop $i $k $j $N \n"



CheckNum(k,N) ; CheckNum(j,(2*N-1)) ;
      

 i = 0
 k = 0

  DO {
       i++
       k++
      <<" in do_until loop %V$i $k >= $N \n"
    } 
       UNTIL ( k >= N); 


<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   CheckNum(k,N)

   CheckOut()




///////////////////////////////
