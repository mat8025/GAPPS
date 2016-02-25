#! /usr/local/GASP/bin/asl


A= popen("ls ","r")


 while (1) {

  nwr = r_words(A,Wd)
//<<" $nwr \n"

 if (nwr > 0) {
  <<" ${Wd[0]} \n"
 fn = Wd[0]
!!" mv $fn ${fn}.asl"
 }
 else
 break



 } 
<<"DONE \n"
STOP!
