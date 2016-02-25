
Opendll("math")

p = 4.0 * atan(1.0)

<<" $p \n"

x= sin(p)
y = cos(p)

<<" $x $y \n"
ans=""

k= 0

while (k < 5) {
k++

 p= atof(ans)

x= sin(p)
y = cos(p)

<<" $x $y \n"
<<"%v $k \n"


}

STOP!