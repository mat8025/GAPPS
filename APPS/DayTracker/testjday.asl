
ds = date(2);

<<"$ds\n"

//jd = julday("04/09/2017")

jd = julday(ds)

<<"%V$jd\n"


dstr = juldayofweek(jd)


<<"$dstr\n"


dstr = julmdy(jd)

dow = !!"date +\%u"

<<"$dow $dstr\n"

dn= atoi(dow)

daystr = juldayofweek(jd)
wday = sele(daystr,0,3)
dn--;
for (wd = jd-dn; wd < (jd+(7-dn)) ; wd++) {
daystr = juldayofweek(wd)
dstr = julmdy(wd)
dt = Split(dstr,"/");
//<<"$jd $daystr $dstr $dt[1]\n"
//<<"$wd $(sele(daystr,0,3)) $dt[1]\n"

<<"$(sele(daystr,0,3)) $dt[1]\n"

}