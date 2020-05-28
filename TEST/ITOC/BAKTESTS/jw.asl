
setdebug(0)
N = 5
  i=0
  k = 0

 WHILE ( k++ < N) {
   i++
 <<"%V $i $k < $N \n"
 }
 k = 0
 <<" ++k  < $N  b4 loop\n"


 WHILE ( ++k < N) {
   i++
 <<"%V $i $k < $N \n"
 }


STOP!