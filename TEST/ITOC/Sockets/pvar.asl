
SetDebug(1,"step","pline")



proc  foo ()
{

  hwo = 3
  C = hwo
}



proc moo ()
{

  nwo = 4

<<"%v $nwo \n"


}


A= 1
B = 0
C = 0

foo()


<<" %v $C \n"
hwo =3

ac = hwo
ac++

foota(ac,hwo)


foota({++ac,--hwo})


<<" %V $ac $hwo \n"




STOP!

B = hwo

<<" %v $B \n"

moo()


A= nwo

<<" %v $ A\n"

<<"%v $nwo \n"

STOP!