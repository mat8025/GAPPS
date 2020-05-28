///

setdebug(1,"trace")

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

<<"$vnh[::] \n"

msg4 = "lname"


lname = "terry"

terry = "english"

k = 4;

e = "msg$k"

<<"%v $($e) \n"

<<" $($$e) \n"  ; // FIXME ---- corrupts var space

  nat = $$$e

<<"%V $nat \n"

<<" $($$$e) \n"  ; // FIXME ---- corrupts var space


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