
setdebug(1)

float Freq = 16000.0

y = Freq

<<"%V$Freq $y \n"

z = y * 2

<<"%V $z \n"

t = y/4.0

w  = (z + y) * Sin(t)
<<"%V$w \n"

stop!