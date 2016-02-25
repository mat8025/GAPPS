#! /usr/local/GASP/bin/spi

SetDebug(0)
sitoc(2)


  int a =0
 a = 2 ;  b = 3 ;  c = a * b ;

 <<" $c \n"


  if (a == 2) {

<<" a == 2 \n"
  b++ 

  }

  if (b > a) {

<<" $b > $a \n"
  a++ 

  }

  <<" $a $b \n"

  int k =0
  while (1) {

  k++

   <<" $k $a \n"
 <<" $a $b \n"
  if (b > a) {

<<" $b > $a \n"
  a++ 

  }
  else {
  <<" breaking out \n"
   break
  }



  }




STOP!
