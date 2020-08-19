///
///
///





ln=readline(0)
<<"$ln\n"

while (1) {

ln=readline(0)
if (feof(0)) {
break
}
S=Split(ln," ")
len = slen(S[0])
pad = nsc(24-len," ")

<<"$S[0]${pad}$S[1]\t$S[2:-1:]\n"


}