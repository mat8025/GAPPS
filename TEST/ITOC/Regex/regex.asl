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

svar S;
S[0] = "DBPR   (";
S[1] = "DBPR  				(";
S[2] = "DBPR(";
S[3] = "DBPR[";



for ( i =0; i< 3; i++) {
p = regex(S[i],"DBPR\s*\t*(")

<<"$p\n"
checkNum(p[0],0)
}

p = regex(S[3],"DBPR\s*\t*(")

<<"$p\n"
checkNum(p[0],-1)



checkOut()