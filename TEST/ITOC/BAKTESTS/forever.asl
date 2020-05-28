


  for (i = 0; i < 10 ; i++) {

<<"%v $i\n"

  }

  j = 0

  for (i = 0; i < 10 ; j++) {

<<"%V $i $j\n"


  if (j > 20)
      break
  

  }


  j = 0

<<" trying forever \n"
   i = 7
  for ( ; i < 10 ; ) {

<<"%V $i $j\n"
  i++

  if (j > 30)
      break
  
   j++

  }

   j = 0
   i = 8

<<"$i $j trying forever \n"

  for ( ;  ; ) {

<<"%V $i $j\n"
  i++

  if (j > 30)
      break
  
   j++

  }



;