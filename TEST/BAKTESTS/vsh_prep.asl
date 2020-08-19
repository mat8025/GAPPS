

 t = FLOAT
 i  = INT
 s = SHORT
 d = DOUBLE
 c = CHAR
 p = PAN


<<"%V $t $i $s $d $c $p \n"

 proc foo (j) 
 {
  <<" IN $j \n"

  j++

  <<" OUT $j \n"

 }


 foo(t)


 foo(&s)

<<"%V $t $i $s $d $c $p \n"

;