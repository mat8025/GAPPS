//%*********************************************** 
//*  @script enum.asl 
//* 
//*  @comment Test enum syntax and ops 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.3.2 C-Li-He]                                
//*  @date Mon Dec 28 14:34:07 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


#define RED 1

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



enum  days { MON = 1, TUE, WED, THU, FRI, SAT, SUN, FUN = 80 };

<<"%V $days \n"

<<"$(typeof(days))\n"
<<"$days[2]\n"
<<"$days[3]\n"
<<"$days[4] \n"
<<"$days[5]\n"

<<"%V $MON \n"

<<"$typeof(MON))\n"

exit()



myday = WED

<<"%V WED $myday \n"

fday = FUN

<<"%V $fday \n"



enum  months { JAN =1, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC } ;

a = APR

<<" my month is $a APR ! \n"





enum DBG_Flags_BMP
  {
    PT_START_SECS = 1,
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

int IV[500]

    IV[PT_START_SECS] = 24
    IV[PT_START_USECS] = 80
    IV[3:8] = vgen(INT_,6,3,1)
<<" $IV[0:9] \n"

<<" PT_START_SECS $IV[PT_START_SECS] \n"
// FIXME second PT_START_SECS is being prepped

<<" PT_START_SECS $DBG_Flags_BMP[0] $DBG_Flags_BMP[1]   PT_START_SECS $IV[PT_START_SECS] \n"


//<<" PT_START_SECS $DBG_Flags_BMP[0] $DBG_Flags_BMP[1]    $IV[atoi(DBG_Flags_BMP[1])] \n"

 val = IV[atoi(DBG_Flags_BMP[1])] 

<<" $val \n"
   k = 0
  for (j =0 ; j < 14 ; j++) {
   val = IV[atoi(DBG_Flags_BMP[k+1])] 
//<<"$j $DBG_Flags_BMP[k] $DBG_Flags_BMP[k+1] $val \n"
//<<"$j $DBG_Flags_BMP[k] $val \n"
// FIXME 
//<<"$j $DBG_Flags_BMP[k] $IV[atoi(DBG_Flags_BMP[k+1])]  \n"
<<"$j $DBG_Flags_BMP[k] $(IV[atoi(DBG_Flags_BMP[k+1])])  \n"
   k += 2  
  }


