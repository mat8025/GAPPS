
setdebug(1)
Svar S

S->table("LUT",30,2) // if not in use makes Svar a hash type -- could extend table

key = "mark"
val = "strong"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"


key = "chest"
val = "hurts"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"

key = "terry"
ival = 8015

index=S->addkeyval(key,ival) // returns index

<<"%V$key $ival $index\n"

i=2
<<"%(2,$i, ,\n)$S\n"
key = "chest"
fval = S->lookup(key)
<<"$fval \n"

k = 3

<<"$i $k $(k+i) \n"
i++
<<"3 $i $k $(k+i) \n"

<<"4 $(i++) $k $(k+i) \n"

<<"4 $i $k $(k++ + i++) \n"

<<"5 $i 4 $k $(k+i) \n"
k= 7
for (j = 0; j < 3; j++) {
<<"$j $(i++) $(k++) \n"
}