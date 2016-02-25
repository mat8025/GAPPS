#! /usr/local/GASP/bin/asl



int d = 4
<<"  $d \n"



 d *= 2

<<"  $d \n"


int i
 e = d
  for (i = 0 ; i < 3; i++) {
    d += 2
    e *= 2
  <<" %V $i $d $e \n"
  }

MM= Igen(5,0,1)


ev = MM * 2

<<"%v $MM \n"
 j = 0


 while (1) {
<<"%v $ev \n"

 ev += MM

<<"%v $ev \n"

  ev += MM[1]

<<"%v $ev \n"
<<" %v $j \n"
  if (j++ > 3) 
     break
  

}



<<" DONE \n"

STOP!
