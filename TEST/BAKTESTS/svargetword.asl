setdebug(1,"trace")
checkIn()

//
// FIXME --- msg gets to be a STRV -- not svar
//

Svar msg = "we all have to try harder";

//msg = "we all have to try harder";


<<"$msg\n"

<<"$(typeof(msg))\n"

words = Split(msg)

<<"$words[1] \n"
<<"$words[2] \n"
<<"$words[3] \n"

<<"$words \n"

w0 = msg->getWord(0)

<<"%V$w0\n"


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
