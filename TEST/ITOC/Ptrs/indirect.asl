
//Setdebug(1)

prog= GetScript()

CheckIn()

#{

x=_clarg[0] 

y= _clarg[1]

<<" $x $y \n"

<<" ${_clarg[1]} \n"

<<" ${_clarg[*]} \n"

<<" ${_clarg[4]} \n"

<<" $(argc()) \n"

<<" ${_clarg[argc()-1]} \n"

#}

/{
c = 7

a= "c"

<<"%V$a \n"

b = $a

<<"%V$b \n"

  b++ 

<<"%V$c \n"

  b--

<<"%V$c \n"

 b = c * 3

<<"%v $a \n"

 a= b

<<"%v $a \n"



b = c
d = $b


<<"%v $d \n"
/}



msg0 = "dena"

msg1 = "mark"

msg2 = "pepe"

msg3 = "lauren"

msg4 = "lname"

checkstr(msg0,"dena")


lname = "terry"

terry = "english"

<<" $msg1 \n"

e = "msg1"



f = $e

<<"%v $f \n"

<<"%v $e \n"

<<"%v $($e) \n"

k = 2

e = "msg$k"

<<"%v $($e) \n"
 de = $e;

checkstr(de,"pepe")

for (k = 1 ; k <= 4 ; k++) {

  e = "msg$k"

<<"%V $k $e \n"

//<<" $k $($e) \n"


}


<<" $($$e) \n"  ; 

  mt = $e

checkstr(mt,"lname")

  sn = $$e;
  
checkstr(sn,"terry")

<<"%V $mt \n"

  nat = $$$e

<<"%V $nat \n"

checkstr(nat,"english")


//<<"e %V $($$e) \n"

<<" $msg4  $($msg4) \n"


  svar vn

  vn[0] = "help"
  vn[1] = "me"
  vn[2] = "please"


sz = Caz(vn)
<<"%v$sz\n"

<<"$vn[::] \n"

   for (i = 3 ; i < 10; i++) {
     vn[i] = "ooh$i";
   }

sz = Caz(vn)
<<"%v$sz\n"

<<"$vn[::] \n"






 for (i= 0; i <= 4; i++ ) {
  e = "msg$i" ;
  
  vn[i] = "msg$i" 
  
<<"$i $vn[i] $e\n"
}

sz = Caz(vn)
<<"%v$sz\n"

<<"$vn[::] \n"

 for (i= 0; i <= 4; i++ ) {

  <<"$vn[i] $($vn[i])\n"

}

<<" $($$vn[4])\n"

 for (i= 0; i <= 4; i++ ) {

  <<"$vn[i] $($vn[i])\n"

}

svar vnh

  vnh[0] = "help"
  vnh[1] = "me"
  vnh[2] = "please"


sz = Caz(vnh)
<<"%v$sz\n"

<<"$vnh[::] \n"

   for (i = 3 ; i < 10; i++) {
     vnh[i] = "ooh$i";
   }

sz = Caz(vnh)
<<"%v$sz\n"

<<"$vnh[::] \n"  // TBD FIX XIC prints one less

checkstr(vnh[0],"help")

checkstr(vnh[1],"me")


checkstr(vnh[3],"ooh3")

checkstr(vnh[8],"ooh8")
checkstr(vnh[9],"ooh9")

   for (i = 3 ; i < 10; i++) {
     checkStr(vnh[i], "ooh$i");
   }


checkOut()

STOP!
