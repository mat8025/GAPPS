

A =1
B =2
C =3

<<"$A $B $C\n"


Vec=Igen(10,0,1)

<<"%(2,\s-->,\t,<--\n)$Vec\n"

c="X"
d="Y"
e="Z"
<<"%-10.1s$c %25.1s$d \v %30.1s$e \r$c\n"


<<" $(2+2) \n"

mystr="abcd"

<<" $mystr \n"

ns = scat(mystr,"efgh")
<<"$ns\n"

<<" $(scat(mystr,\"_super\")) \n"

vs = nsc(10,"x")
<<"$vs \n"

<<"nsc $(nsc(10,\"ha\")) \n"
