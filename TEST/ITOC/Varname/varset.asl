//  want to dynamically create variables via "$var" name expansion
setdebug(1)

a = 4

y = a

<<"$a $y \n"

b = 2

vn = "b"

y = $vn

<<"$y \n"

$vn = 7


<<"$b \n"

//b1 = 1
//b2 = 2
//b3 = 3

for (i = 1; i <=3 ; i++) {

  vn = "b$i"
<<"$vn \n"
  $vn = i * 3

  y = $vn

<<"$i $y \n"


}

<<"%V$b1  $b2 $b3 \n"