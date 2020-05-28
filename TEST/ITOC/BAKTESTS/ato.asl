
setdebug(1,"pline")

checkIn()

str s= "-1"

i=  atoi(s);
checkNum(i,-1)
<<"$s int $i $(typeof(i))\n"

f=  atof(s);
checkNum(f,-1)
<<"$s float $f $(typeof(f))\n"
long L = 47
<<"long $L $(typeof(L))\n"
l=  atol("12");
checkNum(l,12)
<<"long $l $(typeof(l))\n"

l=  atol(s);
checkNum(l,-1)
<<"$s long $l $(typeof(l))\n"



l =  2^32 
<<"$l $(typeof(l))\n"
u=  atou(s);

<<"$u $(typeof(u))\n"

ul = l -1; 


<<"$s ulong $ul $u $(typeof(u))\n"

checkNum(u,ul)

p=  atop(s);

<<"$s $p $(typeof(p))\n"
checkNum(p,-1)
checkOut()

