

int do_bops = 0
int do_oo = 0

  i = 1

  while (i < Argc()) {

   wt = _clarg[i]
  
   <<" $i $wt \n"

   wtest = "do_$wt"

   <<"%v $wtest\n"

   $wtest = 1

   <<"%I $wtest $$wtest \n"

   val = $wtest

   <<"%V $val $do_bops $do_oo \n"

   i++

}


<<" %V $do_bops $do_oo $do_xx \n"

STOP!

  nm = "mark"

  nm2 = "nm"


  myn = $nm2


<<"%V $myn $nm $nm2 \n"
  

