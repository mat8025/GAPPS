

dt80 = 1.0/80.0

dt100 = 1.0 /100.0


<<"%V $dt80 $dt100 \n"

 X = Fgen(32,0,dt80)

<<"%8\nr $X \n"

 Y = trunc(X/dt100)

<<"%8\nr $Y \n"

 Y *= dt100

<<"%8\nr $Y \n"

STOP!