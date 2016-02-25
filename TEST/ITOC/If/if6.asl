
CheckIn()

 do_all = 1

 do_bops = 1

<<"%V $do_all $do_bops \n"

  if ((do_all == 6)) {

     <<"is %v $do_all == 6 TRUE? is TRUE\n"

  }
  else {

    <<" ELSE %v $do_all != 6 TRUE? is TRUE\n"
       CheckNum(1,do_all)
  }

  do_all = 6

  if ((do_all == 6)) {

     <<"is %v $do_all == 6 TRUE? is TRUE\n"
       CheckNum(6,do_all)
  }
  else {

    <<" ELSE %v $do_all != 6 TRUE? is TRUE\n"

  }







  if (do_all) {

     <<"is %v $do_all value TRUE is correct?\n"
       CheckNum(6,do_all)
  }
  else {

     <<" ELSE %v $do_all is FALSE is correct?\n"

  }

  if (do_bops) {

     <<"is %v $do_bops value TRUE is correct?\n"
       CheckNum(1,do_bops)
  }
  else {

     <<" ELSE %v $do_bops is FALSE is correct?\n"

  }





  if ((do_all == 4)) {

     <<"is %v $do_all == 4 TRUE? is TRUE\n"

  }
  else {

   <<" ELSE %v $do_all != 4 TRUE? is TRUE\n"
       CheckNum(6,do_all)
  }




  if ( do_bops == 2 ) {

     <<"%v $do_bops == 2 TRUE? is TRUE\n"
  }
  else {

     <<"%v $do_bops == 2 TRUE? is FALSE\n"

  }


  if (do_bops || do_all) {

     <<"%V $do_bops ||  $do_all TRUE? is TRUE\n"
  }
  else {

     <<"%V $do_bops ||  $do_all FALSE? is TRUE\n"

  }


  do_bops = 0

<<"%v $do_bops   FALSE \n"



  if ( do_bops || do_all) {

     <<"%V $do_bops ||  $do_all TRUE? is TRUE\n"
       CheckNum(0,do_bops)
  }
  else {

     <<"%V $do_bops ||  $do_all FALSE? is TRUE\n"

  }


  do_bops = 2

  if (do_bops && do_all) {

     <<"%V $do_bops &&  $do_all \n"
       CheckNum(2,do_bops)
  }
  else {

  <<"%V $do_bops &&  $do_all is FALSE\n"

  }


CheckOut()


STOP!



