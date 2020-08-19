
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


food1 = "eggs 1"

food2 = "sausage 2"

food3 = "mushrooms 3"



  fdwords = Split(food1);

<<"$fdwords\n"

   setval(fdwords);

  fdwords = Split(food2);

<<"$fdwords\n"

   setval(fdwords);


  fdwords = Split(food3);

<<"$fdwords\n"

   setval(fdwords);


exit()
   

