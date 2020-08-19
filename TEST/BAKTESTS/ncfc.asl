///
///
///

setdebug(1,@keep,@trace);

//=======================//
proc zoo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 3) {
  <<" repeat call $znt \n"
  exit();
}
}
//=======================//

do_indirect = 1;
icompile(1)

fr="xx";

<<"%V $(typeof(fr))  $fr\n"
/{
//int gnt = 0;
<<"premer \n"

fr= date()

<<"%V $(typeof(fr))  $fr\n"

<<"segundo \n"

fr= time()

<<"%V $(typeof(fr))  $fr\n"

<<"tercio \n"


fr= urand(0);   // this should convert number to string

<<"%V fr  $(typeof(fr))\n"

<<"proximo \n"


 a = 2 +2;

<<"ultimo $a \n"



b = 3 * 3;

<<"%V $b\n"
if (b > 3) {
<<"%V $b > 3\n"
}
else {
<<"%V $b !> 3\n"
}

date()

b++;

<<"%V $b\n"
/}

zoo(2);


  cbname = "zoo"
<<"indirect call of $cbname\n"
  fr=$cbname(3);  
  <<"%V $(typeof(fr))  $fr\n"

exit()


if (do_indirect) {
/{
 cbname = "time"

<<"indirect call of $cbname\n"
  fr=$cbname();
  <<"%V $(typeof(fr))  $fr\n"
  cbname = "date"
<<"indirect call of $cbname\n"
  fr=$cbname();  
  <<"%V $(typeof(fr))  $fr\n"
  cbname = "urand"
<<"indirect call of $cbname\n"
  fr=$cbname(0);  
  <<"%V $(typeof(fr))  $fr\n"
/}
  cbname = "zoo"
<<"indirect call of $cbname\n"
  fr=$cbname(3);  
  <<"%V $(typeof(fr))  $fr\n"  
  
}


exit()

k = 0;
 while (1) {
  k++;
  cbname = iread("$k what to call?:")

<<"indirect call of $cbname\n"
  fr=$cbname(k);
<<"%V $(typeof(fr))  $fr\n"
if (k > 2) {
   break;
}
   }

<<"salida $b\n"
exit()

