
  today = date(2);

  jdayn = julian(today)

  yesterday = julmdy(jdayn-1);

<<"%V $today $jdayn $yesterday\n"

  epoch = "06/09/1996"
  
  jdayn = julian(epoch)

  edate = julmdy(jdayn);

  dow = juldayofweek(jdayn)
<<"%V $epoch $jdayn $edate $dow\n"