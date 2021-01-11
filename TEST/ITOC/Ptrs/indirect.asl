


prog= GetScript()

chkIn()

/*

x=_clarg[0] 

y= _clarg[1]

<<" $x $y \n"

<<" ${_clarg[1]} \n"

<<" ${_clarg[*]} \n"

<<" ${_clarg[4]} \n"

<<" $(argc()) \n"

<<" ${_clarg[argc()-1]} \n"

*/





msg0 = "dena"

msg1 = "mark"

msg2 = "pepe"

msg3 = "lauren"

msg4 = "lname"

chkStr(msg0,"dena")


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

chkStr(de,"pepe")

for (k = 1 ; k <= 4 ; k++) {

  e = "msg$k"

<<"%V $k $e \n"

//<<" $k $($e) \n"


}


<<" $($$e) \n"  ; 

  mt = $e

chkStr(mt,"lname")

  sn = $$e;
  
chkStr(sn,"terry")

<<"%V $mt \n"

  nat = $$$e

<<"%V $nat \n"

chkStr(nat,"english")


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

chkStr(vnh[0],"help")

chkStr(vnh[1],"me")


chkStr(vnh[3],"ooh3")

chkStr(vnh[8],"ooh8")
chkStr(vnh[9],"ooh9")

   for (i = 3 ; i < 10; i++) {
     chkStr(vnh[i], "ooh$i");
   }


chkOut()


