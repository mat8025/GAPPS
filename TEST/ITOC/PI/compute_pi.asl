
<<" start ap\n"

<<" set a & b \n"

pan a = 2.123456789
pan b 

a = 2.43
b = 4.567

//b = 3

c = a * b

<<"%V$a  $b \n"
<<"$c \n"

setap(100)

// 
pi_str = compute_pi(1000)

<<"$pi_str \n"
<<" convert the string to a PAN then print out (reconverting to string!)\n"
pi_c = pi_str
<<"$pi_c \n"

A=ofr("pi.txt")

piw = readline(A)

<<"$piw\n"

ret =scmp(piw,pi_str,10)
<<" same ? $ret \n"

str s1
str s2
index = 0

while (1) {

s1 = sele(piw,index,10)
s2 = sele(pi_str,index,10)


ret =scmp(s1,s2)
if (ret != 1) {
<<"diff @ $index\n"
<<"$s1 $s2 $ret\n"
  break
}

index += 10
if (index > 1000)
 break
}



//<<"$s1[1] $s2[1]\n"
  