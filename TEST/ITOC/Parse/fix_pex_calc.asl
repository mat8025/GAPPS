


#include "debug.asl"


  debugON()

  db_ask =0
  
  chkIn()

  y1 =2.0
  x1 = 4.0

  r = x1 -y1


  chkN(r,2.0)
k=1
  <<"%V    $y1 - $x1   \n"
ans = ask("OK $k",db_ask) ; k++
  <<"%V    $(2+2)   \n"

ans = ask("OK $k",db_ask) ; k++

  <<"%V   $(x1-y1) \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

<<"%V   $(x1+y1)  \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

<<"%V   $(x1+y1/2.0)  \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

  <<" x1+y1 =  $(x1+y1)  \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

  <<"  =  $(x1+y1)  \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

  <<"  =  $(x1+y1) $r \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

  <<"   $(x1+y1) $r \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++


  <<" $x1  $(x1+y1)  \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

  <<" $x1 $y1  $(x1+y1) $(x1-y1)  \n" // TBF pex calc fail?

ans = ask("OK $k",db_ask) ; k++

ans=ask("%V    $y1 - $x1   $(y1-x1) ",db_ask) // TBF pex calc fails

ans = ask("OK $k",db_ask) ; k++
  chkOut();
  