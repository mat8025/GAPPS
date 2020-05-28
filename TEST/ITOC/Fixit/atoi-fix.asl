
checkIn(_dblevel)

str sa= "-1"

i=  atoi(sa);
checkNum(i,-1)
<<"$sa int $i $(typeof(i))\n"

f=  atof(sa);
checkNum(f,-1)
<<"$sa float $f $(typeof(f))\n"
long L = 47
<<"long $L $(typeof(L))\n"
l=  atol("12");
checkNum(l,12)
<<"long $l $(typeof(l))\n"

l=  atol(sa);
checkNum(l,-1)
<<"$sa long $l $(typeof(l))\n"



l =  2^32 
<<"$l $(typeof(l))\n"
u=  atou(sa);

<<"$u $(typeof(u))\n"

ul = l -1; 


<<"$sa ulong $ul $u $(typeof(u))\n"

checkNum(u,ul)

p=  atop(2.345);

<<"$sa $p $(typeof(p))\n"
checkFnum(p,2.345,5)
checkStage("atoi")





CheckOut()

