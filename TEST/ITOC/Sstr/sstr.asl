checkIn()

str A = "keep going until world tour"
str B = "unti"


i = sstr(A,B,1)

<<"$i\n"

checkNum(i,11)

i = sstr(A,"XX",1)

<<"$i\n"

checkNum(i,-1)

i = sstr(A,"ou",1)

<<"$i\n"

checkNum(i,24)

i = sstr(A,"OU")

<<"$i\n"

i = sstr(A,"OU",1)

<<"$i\n"

checkNum(i,24)

p = regex(A,"ou")

<<"$p \n"

str C = "mat.vox"
str D = "terry.pcm"


p = regex(C,"vox")

<<"$p \n"

checkNum(p[0],4)

p = regex(D,"pcm")


<<"$p \n"

checkNum(p[0],6)

p = regex(C,'vox\|pcm')

<<"$p \n"


p = regex(D,'vox\|pcm'  )

<<"$p \n"


checkOut()