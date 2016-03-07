//setdebug(1)
checkIn()
Svar msg = "we all have to try harder";


<<"$msg\n"


words = Split(msg)

<<"$words[1] \n"

<<"$words \n"


w1 = msg[0]->getWord(1)

<<"%V$w1\n"

checkStr(w1,"all")

w2 = msg[0]->getWord(2)

<<"%V$w2\n"
checkStr(w2,"have")

w10 = msg[0]->getWord(10)

<<"%V$w10\n"

checkStr(w10,"")

checkOut()
