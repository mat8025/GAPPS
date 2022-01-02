///
///
///
;

Mini = 7;
int amin = 5*Mini;
<<"INCLUDE %V its just me $Mini $amin\n"
amin++;
int im;

<<"%V$N switch \n"

if (N > 0) {
<<" $N path followed\n"
 for (im = 1; im <=N ; im++) {
    amin = im * Mini;
<<"$im $amin\n"
  }
 }
 else {
<<" zero path followed\n"

 }
<<" now I added more stuff $amin\n"

//  a comment line
///
<<"B4 Mini comment \n"; // trailing comment
//  another comment line
<<"Included Mini \n"

