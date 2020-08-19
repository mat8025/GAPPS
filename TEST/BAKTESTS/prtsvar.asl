
setDebug(1)

//svar S[] = Split("one at a time and not all at once")

svar S = Split("one at a time and not all at once")

<<"$S[0] \n"

<<"$S[3] \n"

<<"$S\n"

sz= Caz(S)

<<"%V$sz\n"


<<"%(3,-->, ,<--\n)$S\n"


<<"%(3,-->,\,,<--\n)$S\n"