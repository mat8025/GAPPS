///
////
///

chdir("/home/mark/gapps")
!!"pwd"

S=!!"ls -ld *"


sz= Csz(S)
for (i=0;i <sz ;i++) {
C= split(S[i])
if (scmp(C[i],"drwx",4)) {
<<"<$i> $C[8]\n"
}
}

