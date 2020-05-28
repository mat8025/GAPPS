///
///
///


S=!!"ls -lt"

<<"$S\n"


<<"next\n"

C=!!"pwd"

<<"$C\n"
int k=0
while (1) {
k++
S=!!"ls -lt"

<<"$k\n $S\n"
if (k > 10)
break
}