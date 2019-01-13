//  diag

CheckIn()

// print out 2D mat easily ?

setdebug(1)
float a = 3.14159
<<"%5.2f \n"
<<" %v4.2f $a\n"
<<"%V4.2f$a \n"
<<"%5.2f g \n"


float e[] = {1.1,2.2,3.3,4.4}

<<"%5.3f <${e}> \n\n"
<<"<%5.3f${e}> \n\n"
<<"%5.3f <${e}> \n\n"
<<"<${e}>\n"
 nd = cnd(e)
<<"e %V $nd\n"

 E = mdiag(e)

 nd = cnd(E)
<<"E %V $nd\n"

<<"Bounds $(Cab(E)) \n"
<<"Size   $(Caz(E)) \n"

<<" %(4,, ,\n)%6.2f$E \n"

<<"\n %V$E[0][0] \n"
<<"\n %V$E[0][1] \n"
<<"\n %V$E[1][1] \n"
<<"\n %V$E[2][2] \n"
<<"\n %V$E[3][3] \n"

   vv = 1.1

   CheckFNum(E[0][0],vv,6)
   CheckFNum(E[0][1],0.0,6)
   CheckFNum(E[1][1],2.2,6)
   CheckFNum(E[2][2],3.3,6)
   CheckFNum(E[3][3],4.4,6)

   CheckOut()

exit()


lw = E[0][::]

<<" $lw \n"

lw = E[1][::]

<<" $lw \n"


lw = E[0:1][::]
<<"sz $(Cab(lw)) $(Caz(lw)) \n"
<<"%V $lw \n"

<<"\n %V ${E[0][::]} \n"

<<"\n %V ${E[1][::]} \n"

<<"\n %V4.1f %(4,\n, ,\n)${E[1:3][::]} \n"

  CheckOut()
;