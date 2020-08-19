
uint p
 while (1) {
 
  p = iread(":>")
  b = (p & ~0X0005)
  c = (p & 0X0005)
  d = (p ^ 0XFFF5)

<<"%V %x $p $b %x $b $c  $d\n"

<<"%V %o $p $b  $b $c  $d\n"

 sb = decbin(p)

<<"%V $sb \n"

 if ( (p & ~0X5) == 0X5 ) {

<<" $p div by 5 \n"

 }

<<" $p %x $p \n"
}
;