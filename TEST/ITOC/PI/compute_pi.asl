//%*********************************************** 
//*  @script compute_pi.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat Jan 25 21:20:17 2020 
//*  @cdate Sat Jan 25 21:20:17 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///

//<<" start ap\n"

<<" set a & b \n"

pan a = 2.123456789
pan b ;

a = 2.43;
b = 4.567;

//b = 3

c = a * b;

<<"%V$a  $b \n"
<<"$c \n"

setap(100)

// 


pan pi_c = 6.789

<<"$(typeof(pi_c))\n"
<<"$pi_c \n"

pi_c = atop("4.8793333333334444444444444444455555555555555555")

<<"$(typeof(pi_c))\n"
<<"$pi_c \n"
<<"%p $pi_c \n"


//exit()

pi_str = compute_pi(1000)

<<"$(typeof(pi_str)) $pi_str \n"
<<" convert the string to a PAN then print out (reconverting to string!)\n"

pi_c = atop(pi_str)

<<"$(typeof(pi_c))\n"
<<"%p $pi_c \n"
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
 break;
 
}


//<<"$s1[1] $s2[1]\n"
  