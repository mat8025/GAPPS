


dt=date(2);

jd = julian(dt)

dt2 =julmdy(jd+14)

<<"%V $dt $jd $dt2 \n"

dt3= julmdy(julian(date(2))+14))

<<"next fortnight $dt3\n"

jd = julian("08/15/1582")

wd = julday(jd)

<<"Greg cal $jd $wd \n"


jd = julian("01/01/1066")

<<"first $jd \n"

jd = julian("01/01/100")

<<"first $jd \n"

jd = julian("01/01/01")

wd = julday(jd)

<<"first $jd $wd \n"


bcjd = jd-5;

mdy = julmdy(bcjd)

<<"five days before A.D $mdy\n"

bcjdy = jd - (3*365);

mdy = julmdy(bcjdy)

<<"one year before A.D $mdy\n"