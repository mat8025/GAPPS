checkIn()


str C = "mat.vox"

str D = "terry.pcm"


p = regex(C,"vox")

<<"$p \n"

checkNum(p[0],4)

p = regex(D,"pcm")

checkNum(p[0],6)

p = regex(D,'pcm\|vox')

checkNum(p[0],6)

checkOut()