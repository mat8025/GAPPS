//%*********************************************** 
//*  @script do.asl 
//* 
//*  @comment test Do .. while Do .. until syntax 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.46 C-He-Pd]                              
//*  @date Tue May 12 09:48:00 2020 
//*  @cdate Sun Apr 19 11:56:14 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

checkIn(_dblevel)


int k = 0 ;
int j = 4;  <<" %I $k $j \n"

checkNum(k,0) ;
checkNum(j,4)
if (argc() > 1) {
  N = getArgI(1) ; //  gets first ater script name
 <<" arg was $N \n"
}
else {
  N = 5;
   <<" default $N \n"
}


 <<" k++  < $N  b4 loop\n"

  i= 0

  do {

       i++
       k++
      <<" in do_while loop %V $i $k < $N \n"
    }  while ( k < N) 

<<" after do loop \n"

<<"out of loop %V $i $k $N \n"

 checkNum(i,N) ; checkNum(k,N) ;

 i = N
 k = 0

  do {
       i--
       k++
      <<" in do_until loop %V $i $k >= $N \n"
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   checkNum(k,N) ;
   checkNum(i,0) 

  i = 0
<<"  do - do loop at least once \n"
  do {
       i++
       k++
      <<" in do_until loop %V $i $k >= $N \n"
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   checkNum(k,N+1); 
   checkNum(i,1) 


k = 0



  i= 0
  j = 0

  do {

       i++
       k++
      <<" in do_while loop $i $k < $N \n"

    }  while ( k < N); 

<<" out of loop $i $k $N \n"

 checkNum(i,N) ;
 checkNum(k,N) ;





  i= 0
  j = 0
  k = 0;
  
  do {
 <<" in do_while outer top of loop %V$i $k < $N \n"

       i++
       k++
      
        do {
    <<" top of nest %v$j \n"
          j++
          <<" bottom nest do loop %V$i $k $j < $N \n"
        } 
         while (j < N);
     
 <<" in do_while outer bottom loop %V$i $k < $N \n"

    } 
      while ( k < N);
 



<<" after do loop \n"
 //     <<"xx\n" 
<<" out of loop $i $k $j $N \n"



checkNum(k,N) ;
checkNum(j,(2*N-1)) ;
      

 i = 0
 k = 0

  do {
       i++
       k++
      <<" in do_until loop %V$i $k >= $N \n"
    } 
    until ( k >= N); 


<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   checkNum(k,N)

   checkOut()




///////////////////////////////


  checkOut()




///////////////////////////////
