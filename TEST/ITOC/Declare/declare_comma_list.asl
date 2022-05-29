


Str Use_="Demo  of declare e.g. double yr0 = -1.5";


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

// ignoreErrors();
 chkIn(_dblevel)

 int i = 2;
 <<"%V $i \n";

 chkN(i,2);
 
 int j,k, m = 3;

 <<"%V $j $k $m \n";

 chkN(j,3);

 chkN(k,3);

  chkN(m,3);

 int e = m;

 <<"%V $e \n";

 chkN(e,3);

  float x,y,z = 123.5;

<<"%V $x $y $z\n"

 chkR(x,123.50,2);

  double d,g,h = 12345.6789;

<<"%V $d $g $h\n"



 float sawo = 0.5;

<<"%V $sawo \n"

 float sawo2= Cos(0.5);

<<"%V $sawo2 \n"

 float sawo3= Cos(0.5,0.3);

<<"%V $sawo3 \n"

 chkOut()
