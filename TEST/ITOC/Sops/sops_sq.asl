


#include "debug"

if (_dblevel >0) {
   debugON()
}



rpat = "c+"

rpat->info(1)

<<"%V$rpat\n"

rpat = 'abc*'
rpat->info(1)

<<"%V $rpat\n"
exit()
