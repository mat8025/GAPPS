// generates var names programtically
// 
setdebug(0)

int a_3 = 66

vn = "a_3"

k = $vn

$vn = 77

<<"%V$vn $k $a_3 \n"






//a_0 = 700
//a_1 = 4



//a_4 = 20
<<"%V$a_1 \n"



vn = "a_3"
$vn = 80

<<"%V$a_3 \n"

i = 4
vn = "a_$i"
<<"%V$vn\n"
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
  y = $vn
  <<"$i $vn $y $($vn)\n"
}

<<"%V$a_2 $a_3 $a_10 $a_11\n"

stop!

