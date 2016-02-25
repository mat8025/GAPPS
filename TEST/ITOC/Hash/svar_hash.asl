
setdebug(1)
Svar S

S->table("HASH",30,2) // if not in use makes Svar a hash type -- could extend table

key = "mark"
val = "strong"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"


key = "chest"
val = "it jolly well hurts"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"

key = "tough"
val = "beatup"
index=S->addkeyval(key,val) // returns index

key = "walk"
val = "long"
index=S->addkeyval(key,val) // returns index

key = "coffee"
val = "dark"
index=S->addkeyval(key,val) // returns index


key = "try again"
val = "much harder"
index=S->addkeyval(key,val) // returns index

key = "terry"
ival = 8015

index=S->addkeyval(key,ival) // returns index



<<"%V$key $ival $index\n"

key = "sunny"
val = "beach"

index=S->addkeyval(key,val) // returns index



i=2
<<"%(2,, ,\n)$S\n"



<<"-----------\n"



for (i = 0 ; i < 60 ; i++) {
k = i * 2
if (!(S[k] @= "")) {
<<"$i  |$S[k]| |$S[k+1]| \n"
}
}



key = "chest"
fval = S->lookup(key)
<<" looking up $key and get \"$fval\" from hash table \n"


/{
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

/}