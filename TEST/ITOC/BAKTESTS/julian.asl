///
///     Juilian 
///


setDebug(1,@keep,@pline)

  today = date(2);

  jdayn = julian(today)

  today2 = julmdy(jdayn);
  
<<"%V $today $jdayn $today2\n"

  nextwk = julmdy(jdayn+7);

  nextfn = julmdy(jdayn+14);

<<"%V $today $nextwk $nextfn\n"

exit()
   



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

exit()
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


