//
//
//

//  A=ofr("gki.tsv")
//<<"$A\n"
//  D=readfile(A)

   D= readfile("gki.tsv",1)
  <<"$D\n"
    sz= Caz(D)
    <<"$sz\n"
    sz.pinfo()
    str grs
    gki = 0.0
   for (i=0;i< sz; i++) {
    // C=D[i]
     E=split(D[i])
     grs= E[0]
     gr = atof(E[0])
     kr = atof(E[1])
     if (kr > 0) 
     gki = gr/18.0/kr
    // <<"[$i] <|$E[0]|> $E[1] \n"
     if (grs != "#"  && gr > 0) {
    
     <<"[$i] %6.2f $gr $kr $gki\n"
     }
   }


/*
 TBF   E[0] != "#"
 first line read
 skip comment #

*/