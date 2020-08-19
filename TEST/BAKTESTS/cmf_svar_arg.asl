
setDebug(1,"step");

<<"first line - hey\n"


//CMF setval(fdw)

proc setval(fdw)
    {
    
    int nsa = 1;

<<"%V$fdw  $fdw[0]\n"

       int kw = 0;
       descr = fdw[kw++];
       amt = atof(fdw[kw++]);
<<"%V $descr $amt\n"
      return nsa;
    }



include "foodclass"


int n_f = 10;

Food Fd[n_f];

food1 = "eggs 1"

food2 = "sausage 2"

food3 = "mushrooms 3"

food4 = "tomatoes 1"




bad xxxx


  fdwords = Split(food2);

<<"$fdwords\n"

   setval(fdwords);


  fdwords = Split(food1);

<<"$fdwords\n"

   setval(fdwords);

  fdwords = Split(food2);

<<"$fdwords\n"

   setval(fdwords);


  fdwords = Split(food3);

<<"$fdwords\n"

   setval(fdwords);

jf = 0;

err= Fd[jf]->setval(fdwords);

  fdwords = Split(food2);

<<"$fdwords\n"

jf++;
err= Fd[jf]->setval(fdwords);


  fdwords = Split(food1);

<<"$fdwords\n"

jf++;
err= Fd[jf]->setval(fdwords);

  fdwords = Split(food4);

jf++;
err= Fd[jf]->setval(fdwords);

//<<" hey  ;

//err =< "hey ++ h;

///int iv[] = {a, ,,,' ;

exit()
   

