





//A string variable can be used to 'point' to another variable by using $ symbol as
//a derefence operator.
// e.g.  use $ as variable pointer operator

int a_3 = 66

vn = "a_3"

k = $vn

$vn = 77

<<"%V$vn $k $a_3 \n"

// output is :- vn a_3 k 66 a_3 77 

//The string variable, 'vn' contains the name of the integer variable 'a_3'.
//The action is that $vn is substituted as a_3. 
//Since variables can be dynamically created the ability to create names
//via variable expansion
//can be used together with the $ operator create a set of variables. e.g

for (i = 0; i < 15; i++) {
  vn = "a_$i"
  $vn = i*2
  y = $vn
<<"%V$vn $y\n"
}

y->info(1)

a_5->info(1)

vn ="a_6"

<<"ptr_var vn $vn\n"
 vn->info(1)

<<"deref ptr_var $vn\n"
 $vn->info(1);


 ptr p = &vn

<<"%V $(typeof(p)) $p\n"

 p->info(1)

 ptr q = &$vn

<<"%V $(typeof(q)) $q \n" 
exit()