// Scmp 

// first the simple str version
checkIn()

w1= "maybe"

w2 = "maybe"

ok= scmp(w1,w2)

<<"%V$ok\n"

checkNum(ok,1)


diff= strcmp(w1,w2)

<<"%V$diff\n"

checkNum(diff,0)


w3="maybenot"

ok= scmp(w1,w3)

<<"%V$ok\n"

checkNum(ok,0)

diff= strcmp(w1,w3)

<<"%V$diff\n"
if (diff != 0) {
  ok = 1
}

checkNum(ok,1)




ok= scmp(w1,w3,5)

<<"%V$ok\n"

checkNum(ok,1)

w4="Maybe"

ok= scmp(w1,w4)

<<"%V$ok\n"

checkNum(ok,0)


ok= scmp(w1,w4,0,0)

<<"%V$ok\n"

checkNum(ok,1)


s1="Now is the time for all Good men all the time"

<<"$s1\n"

s2=split(s1)

<<"$s2\n"
<<"$s2[5]\n"

rv=s2->findVal("all")

<<"$(typeof(rv)) $(Caz(rv))\n"
<<"$rv \n"

riv=s2->scmp("all")

<<"$(typeof(riv)) $(Caz(riv))\n"
<<"$riv \n"

checkOut()