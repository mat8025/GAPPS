


include "debug.asl"; 
  
  
debugON();
  //setdebug(1,@pline,@~trace,@~showresults,1); 
   setdebug (1, @~pline, @~step, @~trace,) ;
   FilterFileDebug(REJECT_,"~storetype_e");
   FilterFuncDebug(REJECT_,"~ArraySpecs",);
   

CheckIn()


Svar W;


W[0] = "hey"


<<"%v $W[0] \n"

 W[1] = "marcos"

<<"%v $W[1] \n"

<<"%v $W[0] \n"

 W[2] = "puedes"

<<" $W \n"

 W[3] = "hacer"


<<"%v $W[0] \n"


 W[4] = "tus"

 W[5] = "metas"

 W[6] = "amigo"


 W[7] = "?"

// W[8] = "?"

<<"W[0::]  $W[0::] \n"



<<"W[2::]  $W[2::]\n"


T= W[2::]

<<"T $T\n"

<<"T[0] $T[0]\n"

<<"T[1] $T[1]\n"

checkStr(T[0],"puedes")
checkStr(T[0],W[2])

checkOut()