
 ns = 8

 int Twf[ns][2]


  for (i = 0; i < ns; i++) {

      Twf[i][0] = -1

  }


  for (i = 0; i < ns; i+=2) {

      Twf[i][0] = i+1
      Twf[i][1] = (i+3) 

  }


<<"$Twf \n"

    for (i = 0; i < ns; i++) {
  
     if (Twf[i][0] > -1) { 
      <<"$Twf[i][0] $Twf[i][1] \n"
     }
  }


 int Twk[ns]
 int TwN[ns]


  for (i = 0; i < ns; i++) {

      TwN[i] = -1

  }


  for (i = 0; i < ns; i+=2) {

      Twk[i] = i+1
      TwN[i] = (i+3) 

  }


<<"$Twf \n"

    for (i = 0; i < ns; i++) {
  
     if ((TwN[i]) > -1) { 
      <<"kn $Twk[i] $TwN[i] \n"
     }
  }


