///
///
///

checkin()

setdebug(1,"~pline","~step")


setdebug(1,"~pline","~step")



<<"$ans\n"

td = date(1,'-')
<<"1 $td\n"

dsep = '-'
tsep = ':'

for (i = 1; i <20 ; i++) {
td = date(i,dsep,tsep)
<<"[${i}] $td  $(date(i))\n"
}




str ud;

td = date(1)


<<"$(typeof(td)) %V$td\n"

ud = !!"date"


<<"$(typeof(ud)) %V$ud\n"



udt = split(ud)


<<"%V$udt \n"


<<"$udt[3]\n"

sdt = split(td)

<<"%V$sdt \n"
<<"$sdt[3]\n"

checkStr(sdt[3],udt[3])

checkOut()