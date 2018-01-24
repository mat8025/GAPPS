///
///
///


d0 = date(2)

//d1=julday(01,04,2018)
d2=julday(7,01,2018)
//<<"$(typeof(d0))\n"
d1=julday(d0)

<<"$d0   $d2  $(d2-d1)\n"
days = d2-d1;
wks = days/7;

<<"%V$days $wks to go vacaciones\n"

d2=julday(11,08,2018)

days = d2-d1
wks = days/7.0;
<<"%V$days $wks to go till election\n"

d2=julday(04,09,2018)

days = d2-d1
wks = days/7.0;
<<"%V$days $wks to go till birthday\n"

d2=julday(05,22,2018)

days = d2-d1
wks = days/7.0;
<<"%V$days $wks to go till birthday\n"

