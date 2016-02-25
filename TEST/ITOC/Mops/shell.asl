


a= 0
b = !a

<<" $a $b \n"




!!" echo mark "


retc = !!" echo terry \\n morning ; echo hey "



;
stop!

sz = Caz(retc)
<<" $sz \n"

<<" $retc[0] \n"

<<" $retc[*] \n"


 fl = retc[0]

<<" %v $fl \n"

lsr = !!" ls -l "

<<" \r $lsr[*] \n"

sz = Caz(lsr)
<<" $sz \n"


<<" $lsr[0] \n"


pfh = !!|" ls -l "


<<" $pfh \n"


nwr = r_words(pfh,Wd)

<<" $Wd[0;nwr-1] \n"


nwr = r_words(pfh,Wd)

<<" $Wd[0;nwr-1] \n"


 



STOP!

retc= !!" echo hi "



<<" $retc \n"

retc= !!" date "

<<" $retc \n"

STOP!
