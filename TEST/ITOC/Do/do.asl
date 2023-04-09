//%*********************************************** 
//*  @script do.asl 
//* 
//*  @comment test Do .. while Do .. until syntax 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.97 C-He-Bk]                             
//*  @date Mon Dec 21 14:28:28 2020
//*  @cdate Sun Apr 19 11:56:14 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


int k = 0 ;
int j = 4;

<<" %I $k $j \n"

chkN(k,0) ;


chkN(j,4)

  N = 6;
   <<" default $N \n"


 ac = argc()
 <<"%V $ac\n"

  if (argc() > 1) {
     N = getArgI(1) ; //  gets first after script name
     <<" arg was $N \n"
  }
  else {

  N = 5;
   <<" else  $N \n"
  }


 <<" k++  < $N  b4 loop\n"

 i = N
 k = 0

  do {
       i--
       k++
      <<" in do_until loop %V $i $k >= $N \n";
      
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"


  i= 0;
  k = 0;

  do {

       i++
       k++
      <<" in do_while loop %V $i $k < $N \n"
    }
    while ( k < N) 

<<" after do loop $k $N \n"

<<"out of loop %V $i $k $N \n"

 chkN(i,N) ;
 chkN(k,N) ;

 i = N
 k = 0

  do {
       i--
       k++
      <<" in do_until loop %V $i $k >= $N \n"
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   chkN(k,N) ;
   chkN(i,0) 

  i = 0
<<"  do - do loop at least once \n"
  do {
       i++
       k++
      <<" in do_until loop %V $i $k >= $N \n"
    } until ( k >= N) 

<<" after do until loop \n"

<<"out of loop %V$i $k $N \n"

   chkN(k,N+1); 
   chkN(i,1) 


k = 0



  i= 0
  j = 0

  do {

       i++
       k++
      <<" in do_while loop $i $k < $N \n"

    }  while ( k < N); 

<<" out of loop $i $k $N \n"

 chkN(i,N) ;
 chkN(k,N) ;





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



chkN(k,N) ;
chkN(j,(2*N-1)) ;
      

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

   chkN(k,N)

   chkOut()


