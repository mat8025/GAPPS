# test ASL function bscan
CheckIn()

uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE }

<<" $C \n"
<<"%x $C \n"

D = C


<<" $D \n"
<<"%x $D \n"


   recast(D,"int")

d0 = 0xcafebabe
<<" $d0 \n"



   //D->recast("int")

<<" $D \n"
<<"%x $D \n"

<<" $(typeof(D)) \n"

 x= D[0]
 swab(D)


<<" $D \n"
<<"%x $D \n"

   if (d0 == D[0]) {

<<" recast to INT worked \n"

   }