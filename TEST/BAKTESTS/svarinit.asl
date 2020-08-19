#! /usr/local/GASP/bin/asl

proc spit( str) 
{

  sz = Caz(str)

  <<" %v $str \n"

  for (i = 0 ; i < sz ; i++) {

  <<" $i $str[i] \n"
 
  }


}


// svar S[] = { "once", "upon" , "a" , "time" }

 S  = "once upon a time" 


<<" $S \n"

 T= Split(S)

<<" $T \n"

 spit(T)

STOP!
