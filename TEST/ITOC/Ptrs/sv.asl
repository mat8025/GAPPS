

svar vn;

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