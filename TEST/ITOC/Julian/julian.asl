//%*********************************************** 
//*  @script julian.asl 
//* 
//*  @comment test SF julian calendar 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                                
//*  @date Wed Dec 23 11:22:40 2020 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


/*
julian()

/////
jday=julian(month,day-of-month,year)
given month(1-12),day(1-31), year xxxx
returns the julian day using Julian calander,
remember first year AD is year 1 (not zero)
-1 first year (BC)
and
date_mdy= julmdy(jday)
would return the date m/d/yr   for a julian day.


juldayofweek(julianday)
*/

  today = date(2);

<<"$today %i $today\n"

  jdayn = julian(today)

<<"%i $jdayn\n"


  today2 = julmdy(jdayn);
  
<<"%I $today2\n"

  nextwk = julmdy(jdayn+7);

  nextfn = julmdy(jdayn+14);

<<"%V $today $nextwk $nextfn\n"


   



<<"4/9/2018\n"

  jdayn = julian("4/9/2018")
<<"%V $jdayn \n"


  wday = juldayofweek(jdayn)
  wday2 = juldayofweek("4/9/2018")

<<" $jdayn  $wday $wday2\n"

<<" $wday \n"

  wday = juldayofweek("3/24/2008")


<<" $wday \n"

  dt = "4/9/2019"
  day = julday(dt)
  wday = juldayofweek("4/9/2019")


<<"$dt $day $wday \n"


  wday = juldayofweek("4:9:2008")


<<" $wday \n"

  dt = "4-9-2019"
  day = julday(dt)
  wday = juldayofweek(dt)

<<"$dt $day $wday \n"

  dt = "4-9-1949"
  day = julday(dt)
  wday = juldayofweek(dt)


<<"$dt $day $wday \n"


  dt = "4-9-2017"
  day = julday(dt)
  wday = juldayofweek(dt)

  rdt = julmdy(day)

<<"Mark $dt $day $wday $rdt \n"


  dt = "5-22-1959"
  day = julday(dt)
  wday = juldayofweek(dt)

  rdt = julmdy(day)

<<"Dena $dt $day $wday $rdt \n"

  dt = "12-3-1991"
  day = julday(dt)
  wday = juldayofweek(dt)

  rdt = julmdy(day)

<<"Nick $dt $day $wday $rdt \n"

  dt = "2-10-1990"
  day = julday(dt)
  wday = juldayofweek(dt)

  rdt = julmdy(day)

<<"Lauren $dt $day $wday $rdt \n"


exit()