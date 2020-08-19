///
///
///

include "debug"

setdebug(1,@pline,@trace)
debugON()
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOW_,"proc_","args_","scope_");


chkIn(0)

proc mooi(int a)
{
<<" $_proc $a \n"

  a->info(1)

}
<<"moo(float) ?\n"

proc moof(float x)
{
<<" $_proc $x \n"

  x->info(1)

}
<<"moo(short,char) ?\n"
proc moos(short s, char c)
{
<<" $_proc $s $c\n"

  s->info(1)
  c->info(1)

}

<<"moo(m , gen) ?\n"
proc moog (m, gen n)
{


}
//===============


int j = 3;
      chkN(j,3)
<<"%V$j\n"
j++

<<"%V$j\n"
++j

<<"%V$j\n"
      chkN(j,5)






<<"call moo int\n"
   mooi(j)


float y = 2.1


<<"call moo float\n"
   moof(y)

short s1;
char c1;


<<"call moo short,char\n"
    moos(s1,c1)

ans = "mark"


chkOut()
  while (1) {

<<"Que pasa $ans ?\n"

   ans= i_read("??");

   if (ans == "quit") {
       break;
   }
   
}