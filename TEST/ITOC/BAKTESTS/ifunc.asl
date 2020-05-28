///
///
///

setdebug(1,@keep);

proc goo()
{
static int nt = 0;
nt++;
<<"IN $_proc $nt\n"

if (nt > 10) {
  <<" repeat call $nt \n"
  exit();
}
}
//================//
proc poo()
{
static int nt = 0;
nt++;
<<"IN $_proc $nt\n"

<<"never seen\n"
if (nt > 10) {
  <<" repeat call $nt \n"
  exit();
}
}
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


icompile(0)

<<"premer \n"

<<"segundo \n"


<<"tercio \n"

<<"proximo \n"



  //goo()

 // poo()


<<"ultimo \n"

<<"salida \n"


exit()

  cbname = "goo"

/{
<<"indirect call of $cbname\n"
  $cbname();
<<" exito - segamos adelante!\n"

  cbname = "poo"
<<"indirect call of $cbname\n"
  $cbname();

  cbname = "zoo"
<<"indirect call of $cbname\n"
  $cbname();


/}
 // icompile(0);
 int k = 0;
   while (1) {
k++;
cbname = iread("what to call?:")

<<"indirect call of $cbname\n"
 //  icompile(0);
  $cbname(k);
   //zoo()
   <<" exito - segamos adelante!\n"

  // icompile(1)
   
   <<"next up!\n"
}









   while (1) {

  cbname = iread("what to call?:")

<<"indirect call of $cbname\n"
  icompile(0);
  
  //$cbname();
  goo()
  poo()
  zoo()
   <<" exito - segamos adelante!\n"
   icompile(1)   
   }


exit()
