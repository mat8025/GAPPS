

<<" \% \$ \\ \b \a \c a \rA BAC\rK\n"


<<" \% \$ \\ \b \a \c a"
nanosleep(1,5000)
<<" \rA BAC\rK\n"


 for (i = 0; i < 10 ; i++) {

<<"%c$(i+65)"
nanosleep(0,50000000)
fflush(1)

 }

<<"mark j\bterry\n"

char name[] = {"mark j\bterry"}

sz =caz(name)



 for (i = 0; i < sz ; i++) {

<<"%c$name[i]"
nanosleep(0,50000000)
fflush(1)

 }
<<"\n"

str s = "mark j\bterry drinks coffee \n all day long!\n"
<<"my str is \n"
<<"$s\n"
sz = slen(s)
 for (i = 0; i < sz ; i++) {
<<"$(sele(s,i,1))"
nanosleep(90000000)
fflush(1)
 }

 s = "All work and no s\bplay makes Jack a dull boy!\n"
 t = "All wark and no s\bplay makes Jock a dull buy!\n"
<<"$s\n"
sz = slen(s)
 k = 0
 for (j = 0; j < 50 ; j++) {
 for (i = 0; i < sz ; i++) {
<<"$(sele(s,i,1))"
nanosleep(90000000)
fflush(1)
 }

 if (k == 4) {
 s=ssub(s,"a","o",0)
 }

 if (k == 6) {
 s=ssub(s,"o","i",0)
 }

 if (k == 8) {
 s=ssub(s,"i","a",0)
 }

 if (k == 10) {
 s=ssub(s,"a","u",0)
 }

 if (k == 14) {
 s=ssub(s,"u","e",0)
 k = 0
 }

 if (k == 16) {
  s=ssub(s,"e","a",0)
  s= t
  k = 0
 }

 if (k == 18) {
  s= t
  k = 0
 }

 k++
}
