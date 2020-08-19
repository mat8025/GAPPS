

<<" testing enum \n"

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
    IVPAGE, //10
    BMP_END_FLAGS, // 216 check overwrite - POLL_SVC?
    CTS_FLAG_CHK,


    POLL_SVC = 220,
    RMSGID= 300,
   
  }; // can use upto 375 flags --- 1500 bytes  -- UDP size pkt header of 20



int IV[]

    IV[POLL_RD] = 77

<<" POLL_RD  ${IV[POLL_RD ]}  POLL_RD \n"


stop!


en2 = PT_START_USECS


<<" PT_START_USECS       $en2 \n"




   k = POLL_RD

<<"%V $k = 6 ?\n"





enum  days 
        { 
             MON = 1, 
             TUE,  // should be 2 
             WED, 
             THU, 
             // nearly done


             FRI, 
             SAT,
             SUN, 
             FUN = 80, 
        };  // days of the week


tueday = TUE

<<"%V $tueday \n"

wednesday = WED

<<"%V $wednesday \n"

thuday = THU

<<"%V $thuday \n"

frday = FRI

<<"%V $friday \n"

fday = FUN

<<"%V $fday \n"


enum colors 
            { 
              BLACK, 
              WHITE,
              RED,
              ORANGE,
              YELLOW,
              GREEN,
              BLUE,
              INDIGO,
              VIOLET,
            };


red = RED
violet = VIOLET

<<" RED $red   $violet \n"


stop!