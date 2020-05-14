//%*********************************************** 
//*  @script while.asl 
//* 
//*  @comment test While syntax 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.46 C-He-Pd]                             
//*  @date Tue May 12 10:20:19 2020 
//*  @cdate Sat Apr 18 21:48:17 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
//
///



checkIn(_dblevel)



int k = 0
int ok =0
<<"always trying forever \n"


  while (1) {

  if (k++ > 20) {
<<"break $k\n"
   break;
  }
 k++
   <<"forever! $k\n"
  }


 k = 0

  while (1) {  if (k >=9) {  break;  }
  else {
  <<"this while loop $k\n";
  k++; }
  };
  <<"%V$k == ? 9 \n"; checkNum(k,9);

k= 0;
n = 1;

  while (1) {

   if (k >=10) {
      break;
   }
   k++;

  }

<<"%V$k == ? 10 \n"

checkNum(k,10);

k= 0;
n = 1;

  while (1) {

   if (k >=10) {
      break;
   }
   k += n

  }

<<"%V$k == ? 10 \n"

checkNum(k,10);

///
///
///

N = 10

 k = 0

 while ( k < N)  k++;

<<" DONE $k $N \n"

checkNum(k,N);

 k =0;
 int m = 0;
 while ( k++ < N) {
   m++;
   <<" $k $m \n"

 }

<<" DONE $k $N \n"
checkNum(k,N+1);
 m = 0;
 k = 0;
 while ( ++k < N) {
   m++;
   <<" $k $m \n"
 }

checkNum(k,N);
<<" DONE $k $N \n"

checkStage("2")



tt = 13
N = 15

M = 2 *N

<<"%V $tt $N \n"


<<" $tt times table \n"
//tt =3

k = 0
kc = 0;
a = 3

b = 3 ; c = a * b

<<" %v $c \n"

 while ( k < M ) {

   k++

   if ( k > N )
   { 
  <<" attempting continue to end of loop -skipping code lines\n" 
  <<" ! $k > $N \n"
   continue
  <<" should not see this !\n"
   }

//<<" out of if $k \n"

  a= k * tt
  kc++;
 <<" $k * $tt = $a \n"

 }

checkNum(kc,N)

<<" DONE %V $k $kc  $N $M $a\n"

checkStage("continue")

///////////////////////////////


checkOut()