/* 
 *  @script stats.asl 
 * 
 *  @comment test runStats stdev SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]                                  
 *  @date Tue Jan 12 20:32:06 2021 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


F = vgen(FLOAT_,100,1,1)

<<"%6.2f$F\n"

<<" STD DEV \n"
  B=stdev(F)
<<"%6.2f$B\n"

<<" RUNNING STD DEV \n"
  R=runStats(F)
<<"%6.2f$R\n"

  Redimn(F,10,10)

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

exit()