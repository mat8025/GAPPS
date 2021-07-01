

#include "debug.asl";


if (_dblevel >0) {
   debugON()
}



str le;

Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;

<<"$(typeof(Mol)) size $(caz(Mol))  \n"

<<"List is $Mol \n"

sz = caz(Mol)

<<"%V$sz\n";

chkN(sz,12)


<<"first month $Mol[0]\n"

<<"second month $Mol[1]\n"

<<"twelveth month $Mol[11]\n"

Mol->info(1)


 le12 = Mol[11];

<<"$(typeof(le12)) %V$le12\n"
