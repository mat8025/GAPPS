
setdebug(1)

A=4
<<"%V$A \n"

if  (A == -1) {
<<" $A  is == -1 \n"
}

<<"%V$A \n"




if  (A==5) {
<<" $A  is 5 \n"
}
else {
<<" $A  is not 5 \n"
}

<<"%V$A \n"

if  (A==4) {
<<"%V $A  is 4 \n"
}

<<"%V$A \n"

C = -1

if  (A != -1) {
<<" $A  is != -1 \n"
}

<<"%V$A \n"

A =5
<<"%V$A \n"
if  (A != C) {
<<" $A  is != $C \n"
}

<<"%V$A $C\n"





A=ofr("wfex.dat")
<<"%V$A \n"


 B = A
<<"%V$A $B\n"
if (B==-1) {
<<"FILE not found \n"
  exitsi();
}

<<"%V$A $B\n"

exitsi()