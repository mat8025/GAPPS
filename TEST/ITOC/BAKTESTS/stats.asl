

F = vgen(FLOAT_,20,1,1)

<<"%6.2f$F\n"

<<" STD DEV \n"
  B=stdev(F)
<<"%6.2f$B\n"

<<" RUNNING STD DEV \n"
  R=runStats(F)
<<"%6.2f$R\n"



  Redimn(F,5,4)

<<"Mat\n "
<<"%6.2f$F\n"

<<"%(4,, ,\n)6.2f$F\n"


   S= Stats(F)

<<"%6.2f$S\n"

   A= Mean(F)

<<"%6.2f$A\n"

<<" STD DEV \n"
  B=stdev(F)

<<"%6.2f$B\n"