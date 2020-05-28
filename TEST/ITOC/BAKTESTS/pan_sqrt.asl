// test some functions at high precision

setAP(20)

n = argc()


pan E
pan p 
pan T
pan c
 if (n >=2) {

   c = atop(_argv[1])
 }
 else {

   c = atop(iread("input number :> "))

 }

<<" squaring\n $c \n to use as input \n"

p = c * c

<<"find sqrt of $p  \n"


  E = sqrt(p)

<<"sqrt is %p$E  \n"
<<"sqrt is $E  \n"

  R = fround(E,0)
<<"Round to nearest int \n"
<<"$R \n"

  T = E * E
<<" compute square \n"
<<" $T \n which should be \n $p \n"


 if (T == p) {
<<"Validated sqrt \n"
<<" $E \nis sqrt of \n $p \n"
 }
 else {

<<" $T  neq to \n"
<<" $p \n"

    T = R * R
  if (T == p) {
<<" rounded root is correct \n"
<<" $R \nis sqrt of \n $p \n"
  }
  else {
<<" sqrt failed \n"
 }

 }
