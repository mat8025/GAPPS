
// want to make up a bunch of vars - named dynamically


for (i = 0; i < 15; i++) {
  vn = "a_$i"
  $vn = vgen(INT_,5,i,1)
  y = $vn
<<"%V$vn $y\n"
}

//a_0->info(1)
a_1->info(1)



c = a_4

<<"%V$c \n"
b = Cab(a_4)
<<"%V$b \n"

a_4->info(1)
a_3->info(1)
vn = "a_5"

a_3[1] = 77;

<<"a_3 $a_3\n"
e = $vn

<<"%V$e\n"

k = 3

vn = "a_$k"

f = $vn  // BUG should not remove a_3

<<"%V$f \n"

f->info(1)

//<<"a_3 $a_3\n"

a_4->info(1)
//a_3->info(1)


k = 4

vn = "a_$k"


g = $vn[2]

<<"%V$g \n"
