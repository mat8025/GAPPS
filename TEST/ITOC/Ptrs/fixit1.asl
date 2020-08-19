///
///   int c[];  //dynamic expansion
/// 

proc foo( C[] ,n)
{

for (i= 0; i< n ; i++) {
  c[i] = i;
   sz = Caz(c);
 <<"$i %V $sz   $c\n"
}

}
//=============

chkIn()


int c[];  //dynamic expansion

 sz = Caz(c);

/{
 c[0] = 47;

<<"%V $sz   $c\n"

 c[3] = 56;


chkN(c[0],47)
/}

 sz = Caz(c);
 <<"%V $sz   $c\n"

m = 12;


  foo(c,m)

exit()








n= 10;




for (i= 0; i< n ; i++) {
  c[i] = i;
   sz = Caz(c);
 <<"$i %V $sz   $c\n"
}

chkOut()