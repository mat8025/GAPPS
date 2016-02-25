
// want to make up a bunch of vars - named dynamically


for (i = 0; i < 15; i++) {
  vn = "a_$i"
  $vn = vgen(INT_,5,i,1)
  y = $vn
<<"%V$vn $y\n"
}



c = a_4

<<"%V$c \n"
b = Cab(a_4)
<<"%V$b \n"


vn = "a_5"


e = $vn


<<"%V$e\n"

k = 3

vn = "a_$k"

f = $vn

<<"%V$f \n"

//f = $("a_$k")

//<<"%V$f \n"


stop!