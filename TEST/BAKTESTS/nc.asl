///
///
///

setdebug(1,@keep);

//=======================//

do_indirect = 1;
icompile(1)
//int gnt = 0;
<<"premer \n"

<<"segundo \n"


<<"tercio \n"

<<"proximo \n"

proc goo()
{
static int gnt = 0;
gnt++;
<<"IN $_proc $gnt\n"

<<"check $gnt\n"
if (gnt > 10) {
  <<" repeat call $gnt \n"
  exit();
}


}
//=================//

proc poo()
{
static int nt = 0;
nt++;
<<"IN $_proc $nt\n"

<<"never seen\n"
if (nt > 100) {
  <<" repeat call $nt \n"
  exit();
}
}
//=======================//


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

goo()

b++;

goo()

<<"%V $b\n"

b++;

<<"%V $b\n"

goo()



b++;

<<"%V $b\n"
goo()


if (do_indirect) {
cbname = "goo"
<<"indirect call of $cbname\n"
  $cbname();


cbname = "poo"

<<"indirect call of $cbname\n"
  $cbname();


cbname = "goo"

<<"indirect call of $cbname\n"
  $cbname();
}

<<"salida $b\n"
exit()


k = 0;

while (1) {
k++;
<<"loop $k\n";

goo()

poo()

if (do_indirect) {
cbname = "poo"

<<"indirect call of $cbname\n"

$cbname();


cbname = "goo"

<<"indirect call of $cbname\n"
$cbname();

}

if (k > 20) {
   break;
}
}
<<"salida $b\n"

exit()
