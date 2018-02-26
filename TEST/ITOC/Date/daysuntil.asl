///
///
///

proc days2go(mn,dom,phr1)
{

d2=julian(mn,dom,yr)

days = d2-d1;
wks = days/7;
if (days < 0) {
d2=julian(mn,dom,yr+1)
days = d2-d1;
wks = days/7;
}

<<" $days\tdays\t$wks\tweeks to go until $phr1\n"

}
///



d0 = date(2);

d1 = julian(d0)
yrs = spat(d0,"/",'>','<')
yr = atoi(yrs)

<<" today is $d0    $yrs  $yr\n"



days2go(03,14,"Iris's Birthday")

days2go(02,10,"Lauren's Birthday")

days2go(04,09,"Mark's Birthday")

days2go(05,22,"Dena's Birthday")

days2go(12,03,"Nicks's Birthday")

days2go(3,20,"vernal equinox") // til 2025

if ((yr/4) == (yr/4.0)) {
days2go(07,21,"summer solstice") //  07/20 in leap years 
}
else {
days2go(07,20,"summer solstice") //  07/20 in leap years 
}

days2go(7,01,"nuestras vacaciones")

days2go(11,08, "the election")




