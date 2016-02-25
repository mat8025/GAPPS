

 S = "hey how are you?"
<<"$S\n"
      col= split(S)

<<"$col \n"

<<"$col[0] \n"

  fwrd = col[1]

<<"first wrd was $fwrd \n"

   if (fwrd @= "how") {

     <<" fine\n"

   }


<<"$col[1] \n"

<<"$col[1:3] \n"



   if (col[1] @= "how") {

     <<" fine\n"

   }
   else {

     <<" not so good\n"

   }
  


