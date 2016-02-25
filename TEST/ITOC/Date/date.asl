
checkin()
setdebug(1,"pline")
td = date(1,'-')
<<"1 $td\n"

dsep = '-'
tsep = ':'

for (i = 1; i <20 ; i++) {
td = date(i,dsep,tsep)
<<"[${i}] $td  $(date(i))\n"
}

td = date(1)

ud = !!"date"

<<"%V$ud\n"
<<"%V$td\n"

udt = split(ud)

<<"%V$udt \n"

<<"$udt[3]\n"
sdt = split(td)
<<"%V$sdt \n"
<<"$sdt[3]\n"

checkStr(sdt[3],udt[3])

checkOut()