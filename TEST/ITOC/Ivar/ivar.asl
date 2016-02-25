//

setdebug (0) 

CheckIn() 

int do_bops = 0

       do_bops = 3

       <<"%V$do_bops \n"

       wt = "do_bops"

       <<"%V$wt \n"

       $wt = 2

       <<" done indirect assignment \n"

       <<"%V$wt $do_bops \n"

       CheckNum (do_bops, 2)

  silver = 47
  gold = 79
  metal = "silver"
  $wt = $metal

  <<"%V$wt $do_bops \n"

  CheckNum (do_bops, 47)

  metal = "gold"

  $wt = $metal

<<"%V$wt $do_bops \n" 

  CheckNum (do_bops, gold) 





  n = 1;

<<"%i$n \n"

  np = "n" ;

  $np = 3 ;
//    $np = 3

<<"%i$n \n"

<<"%V$np $n \n";

<<"%i$n \n"

  CheckNum (n, 3)

  CheckOut()
<<"  ------------ STOP ---------------- \n"

  stop!

  a = np
  <<"%i$n \n"

  b = $np

  <<"%v$n \n"

<<" %v$b \n" 
<< " %v $a \n" 
<< " %v $b \n" 
<< " %v $np \n" 
<< "%i $n \n"

// double indirection
  ai = "np" c = $$ai << "%v $c\n"

CheckNum (c, 3)

//iread()
d = $ai << "%v $d\n"

CheckStr (d, "n") 

<<"%v $c $d\n" $$ai = 4;

e = $$ai << "%V$e \n"
CheckNum (e, 4)
CheckOut ()
  STOP !
