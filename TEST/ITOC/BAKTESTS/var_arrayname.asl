// generates var names programtically
// check works for arrays

setdebug(1)



IV = vgen(INT_,10,0,1)

<<"$IV \n"


FV = vgen(FLOAT_,10,10.5,-1)

<<"$VV \n"


vn = "v_1"
$vn = IV

<<"%V$v_1 \n"

i = 4
vn = "v_$i"
<<"%V$vn\n"
$vn = FV

<<"%V$v_4 \n"


i = 5
vn = "v$i"
<<"%V$vn\n"
$vn = FV

<<"%V$v5 \n"


<<"%V$($vn)\n"

for (i= 0; i < 5; i++) {
vn = "v$i"
<<"%V$vn\n"
$vn = FV
FV += 2
<<"%V$($vn)\n"
}



stop!


$vn = 79

<<"%V$a_4 \n"
vn = "a_8"
$vn = 88
<<"%V$a_8 \n"



i = 7
vn = "a_$i"
<<"%V$vn\n"
$vn = 47

<<"%V$a_7 \n"


<<"%V$(a_$i) \n"

for (i = 0; i < 15; i++) {
  vn = "a_$i"
  $vn = i*2
  <<"$i $$vn \n"
}

<<"%V$a_2 $a_3\n"

stop!

