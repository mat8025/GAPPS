
A=ofr("foodtable2019.csv")

i=0;
 while (1) {

   S=readline(A)
   if (feof(A)) {
       break
   }
 //  <<"$S\n"
   i++;
   D=split(S,",")
   E=split(D[0])
    n=Caz(E);
    fcat = E[n-1]

  if (scmp(fcat,"<",1)) {
//<<" cat is <|$fcat|>\n"
     //fcat= sele(fcat,-2)
//<<" cat is <|$fcat|>\n"     
     //fcat = sele(fcat,1)
     <<"$fcat "
  //<<"%(1, , ,)$E[0::-1]"
     
     if (n >2) {
       m = n-1
       F= E[0::m] /// BUG
       p=Caz(F);
       //<<"F = %(1, ,,)$F\n"
       //<<"%V $n $m $p\n"
         for (i=0; i <m; i++) {
           <<" $E[i]"
         }
       //<<"%(1, ,,)$E[0::m]"  // BUG
       //<<"%(1, ,,)$F[0::]"
     }
     else {
<<" $E[0]"
     }
  }
  else {
   <<"%(1, , ,)$E[0::]"
  }
   <<"%(1,\,,,)$D[1::]\n"
 }