
setdebug(1,"keep")

filterDEbug(1,"split","~findtokens")

Record DF[5];

S = Split("s2d,ASR,5,0,22/1/18,xx,31/1/18,",',');

DF[0] = S;


<<"$DF[0][::]\n"

for (i=0; i< 6;i++) {
<<"$DF[0][i]\n"
}

DF[1] = Split("s2d,ASR,6,10,22/1/18,xx,31/1/18,x,",',');

<<"$DF[1][::]\n"



DF[2] = Split("s2d,ASR,'(6,57,79)',10,22/1/18,xx,31/1/18,x,",',');

<<"$DF[2][::]\n"


DF[3] = Split("s2d,ASR,'(6:57:79)',10,22/1/18,xx,31/1/18,x,",',');

<<"$DF[2][::]\n"


T = Split("s2d,ASR,'(6,57,79)',10,22/1/18,xx,31/1/18,x,",',');

<<"$T\n"

<<"$T[2]\n"

