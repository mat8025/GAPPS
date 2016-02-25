#! /usr/local/GASP/bin/spi

SetDebug(0)
//sitoc(2)




 a = 2 ;  b = 3 ;  c = a * b ;
 done = 0

 int k = 0

 c = a * k + b
 stage1: <<" @ stage1 $k %v $c = $a * $k + $b \n"


 while ( ! done)  {

 <<" top of while $k \n"

 k++

 if (k < 5)  {
  <<" $k < 5 \n"
  break
 }




 <<" bottom of while $done\n"
 }

<<" $k $done \n"

STOP!



 while ( ! done)  {

 <<" top of while \n"

 k++

<<" %v $k $done\n"

// if (k > 10)      done = 1
 

// Don't want to see this twice
// if (k > 5) goto exit;


 if (k > 2)  {
  <<" $k > 2 \n"
 }

 c = a * k + b
 stage1: <<" @ stage1 $k %v $c = $a * $k + $b \n"

 d = a * k + b / c
 stage1: <<" @ stage1 $k %v $d = $a * $k + $b / $c \n"

 exit: <<" @ exit $k\n"

 sleep(0.2)

 if (k > 10)  { 
  <<" breaking out %v $k \n";
   break
 }  

 f = k * a

 <<" %v  $f \n"
 <<" bottom of while $k $done ---> back to while ? \n"


 }

 STOP!


///////////////////////////////////
 ooc: <<" hi mark $k \n"
 ac = 0

 na = argc()

 ac = $2
 ccon = 2

 if (! (ac @= "")) {
  ccon = ac
 }

<<" %v $ac $ccon\n"


 a = 2 ;  b = 3 ;  c = a * b ;

 <<" $c \n"



 if (k < 5)  { 

 a = k ;  b = k ;  c = a * b ;

 <<" $c \n"

 }

Y =Fgen(10,0,2)

<<" $Y \n"

 y= Y[3]

<<" $y \n"

STOP!
