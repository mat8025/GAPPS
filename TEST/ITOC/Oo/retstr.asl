


class food {

 public:
   str desc;
   str amt;
   str taste;


 CMF  setTaste( howisit)
  {
<<" $_proc   $howisit \n"

    taste = howisit;

  }


 CMF  getTaste( )
  {
 <<" $desc is $taste\n"

    return taste 

  }

  CMF setDesc ( whatisit)
  {

     desc = whatisit
<<"creating  $desc \n"
  }


  //CMF food ( whatisit)
  CMF food ()
  {


//<<"$_proc creating  a food $desc\n"
<<"$_proc creating  a food \n"

    //desc = whatisit

  }

}



// food  Raspberry("raspberry")
 food  Raspberry
//FIX no parameter constructor!! food  Brocolli("Broc")
food  Brocolli

 Raspberry->setTaste("nice")
 Brocolli->setTaste("vile")


 t = Raspberry->getTaste()

 <<"got via return $t \n"


 t = Brocolli->setDesc("brocolli")

 t = Brocolli->getTaste()

 <<"got via return $t \n"


stop!

;