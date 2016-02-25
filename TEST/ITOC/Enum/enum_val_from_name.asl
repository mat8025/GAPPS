
setdebug(1)
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



<<"$(MON) $days->MON \n"


 wv = days->enumValueFromName("TUE")
 th = days->enumValueFromName("THU")
 wd = days->enumNameFromValue(2)
<<"$wv  $(TUE) $wd $th\n"