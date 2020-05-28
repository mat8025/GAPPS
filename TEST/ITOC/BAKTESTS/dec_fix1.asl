

char dv[] = { 'G', 65,66,67, 'O', '0', 0 }


<<"$dv \n"
<<"$dv[0] \n"
<<"$dv[1] \n"

sz = Caz(dv)

<<"%V $sz \n"

<<"%I $dv \n"



 a = 'G'

<<"%I $a \n"

<<"%V $dv[0] $a \n"


;