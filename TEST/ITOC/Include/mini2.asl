///
///
///
;

float Mini2 = 13;
float amin2 = 5*Mini2;
<<"INCLUDE %V its just me $Mini2 $amin2\n"
amin2++;
int im2;

<<"%V$N switch \n"

if (N > 0) {
<<" $N path followed\n"
 for (im2 = 1; im2 <=N ; im2++) {
    amin2 =  Mini2/ im2;
<<"$im2 $amin2\n"
  }
 }
 else {
<<" zero path followed\n"

 }
<<" now I added more stuff $amin\n"

//  a comment line
///
<<"B4 Mini2 comment \n"; // trailing comment
//  another comment line
<<"Included %V Mini2 \n"

