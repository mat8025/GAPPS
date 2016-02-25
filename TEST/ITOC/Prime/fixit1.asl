
setdebug(0)

uint p = 777 

n = argc()

<<"$n args ---  $_argv \n"

 if (n >=2) {
<<" first arg is $_argv[1] \n"
   p = _argv[1]
<<" first arg is $p $_argv[1] \n"
 }
 else {

   <<" no args \n"

 }

<<"%V $p $(typeof(p)) \n"


;
