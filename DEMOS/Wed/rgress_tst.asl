
setdebug(1)

float WTVEC[10+] 

int Nobs = 0

A=ofr("wfex.dat")


 while (1) {

    S= readline(A)

    if (feof(A)) {
        break
    }

   col= split(S)

    <<"$col\n"

   if (col[0] @= "WEX") {

   j = 2        

   WTVEC[0] = 1
  
   cycle =  atof(col[j++]) 
  
<<"%V$j $cycle \n"

    Nobs++


   if (Nobs > 10) {
      break
   }

  }
}


exitsi()