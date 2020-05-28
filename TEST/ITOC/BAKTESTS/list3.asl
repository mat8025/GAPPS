SetPCW("writepic","writeexe")
Setdebug(1)


  J[] = { 1,2,3,4 }

<<"%v = $J \n"
<<"%v =$J[1] \n"
<<"%id =$J[*] \n"
<<"sz $(Caz(J)) \n"



  J = { 5,6,7,8,9, 10, 11, 67 }

<<"%i=$J sz $(Caz(J)) \n"
STOP!

<<"%v = $J \n"
<<"%v =$J[1] \n"
<<"%id =$J[*] \n"



STOP!