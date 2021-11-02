
///
/*

 this script will use the compiled (cpp) script  fit2tsv.asl  to convert fit file
 fit2tsv.asl  is in the uac directory and is compiled by adding

#include "fit2tsv.asl"
 to uac_table.cpp
 and adding line
 "fit2tsv"
 into 
 si_uact_init (int *cnt)

 and then making the uac library 

 fit2tsv is then becomes a script function which will the process its supplied args

 in this case the supplied fit file name e.g bike.fit
 out put will be to file bike.tsv
 which contains tab separated values of gps postion and heart rate

*/

opendll("uac");

fname = getArgStr(1)

<<"arg1 is $fname\n"

dbout = getArgI()


fit2tsv(fname, dbout) ;


exit()