SetPCW("writepic","writeexe")
Setdebug(1)
prog= GetScript()


#{

x=_clarg[0] 

y= _clarg[1]

<<" $x $y \n"

<<" ${_clarg[1]} \n"

<<" ${_clarg[*]} \n"

<<" ${_clarg[4]} \n"

<<" $(argc()) \n"

<<" ${_clarg[argc()-1]} \n"

#}

/{
c = 7

a= "c"

<<"%V$a \n"

b = $a

<<"%V$b \n"

  b++ 

<<"%V$c \n"

  b--

<<"%V$c \n"

 b = c * 3

<<"%v $a \n"

 a= b

<<"%v $a \n"



b = c
d = $b


<<"%v $d \n"
/}

msg1 = "mark"

msg2 = "pepe"

msg3 = "lauren"


<<" $msg1 \n"

e = "msg1"

f = $e

<<"%v $f \n"

<<"%v $e \n"

<<"%v $($e) \n"

k = 2

e = "msg$k"

<<"%v $($e) \n"

for (k = 1 ; k < 4 ; k++) {

e = $"msg$k"

<<"%V $k $($e) \n"

<<" $k $($e) \n"


}



STOP!
