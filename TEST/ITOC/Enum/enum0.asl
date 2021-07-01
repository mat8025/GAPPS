
////
///
///
#include "debug"



#define RED 1

<<" $RED\n"


#define GREEN (RED + RED +1)

#define BLUE  (RED + GREEN)

g = GREEN
r = RED
b = BLUE



<<"%V $r \n"

<<"%v $g \n"
<<"%v $b \n"



<<"Red $(RED) \n"

// FIXME
<<"%V $r  $(RED) \n"

<<"%v $r  $(RED) \n"

///
///
///

enum  days { MON = 1, TUE, WED, THU, FRI, SAT, SUN, FUN = 80 };

<<"%V $days \n"

<<"$(typeof(days))\n"
<<"$days[2]\n"
<<"$days[3]\n"
<<"$days[4] \n"
<<"$days[5]\n"

<<"%V $(MON) \n"

<<"$(typeof(days))\n"


myday = WED

<<"%V WED $myday \n"

fday = FUN

<<"%V $fday \n"



enum  months { JAN =1, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC } ;

a = APR

<<" my month is $a APR ! \n"

enum DBG_Flags_BMP { /
    PT_START_SECS = 1, /
    PT_START_USECS,
    PT_DUR_USECS,
    PT_PER_USECS,
    POLL_WC,    
    POLL_RD,
    POLL_WD,
    POLL_IVC,
    IVCMD,
    IVPAGE, 
    BMP_END_FLAGS,
    CTS_FLAG_CHK,

    POLL_SVC = 220,
    RMSGID= 300,
   
  }; // can use upto 375 flags --- 1500 bytes  -- UDP size pkt header of 20


<<"\n%(2,, ,\n)$DBG_Flags_BMP \n"

   k = POLL_RD

<<"%V $k = 6 ?\n"



exit()
