
chkIn()

I = vgen(INT_,30,0,1)

<<" $I \n"


 a = 2
 b = 3
 c = a + b
<<"%V $a $b $c\n"

<<"%V $I[2] $I[a] $I[b] $I[c]\n"
//<<"%V $I[c] $I[(a+b)] \n"

cele = I[(a + b)]

<<"%V $cele \n"

chkN(cele,5)

int ci = I[(a+b)]

<<"  ci is element of I \n"

<<"%V $(a+b) $ci \n "



cele = I[(a+b)]

<<"  cele is element of I \n"

<<"%V $(a*b) $cele \n "



S = vgen(SHORT_,30,0,1)
<<" $S \n"
b = 7
s = S[(a+b)]

<<"  s is element of S \n"

<<"%V $(a+b) $s \n "
chkN(s,9)

 chkOut()

stop!