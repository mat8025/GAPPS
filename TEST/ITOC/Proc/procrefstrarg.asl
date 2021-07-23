//%*********************************************** 
//*  @script proc_refstrarg.asl 
//* 
//*  @comment ref arg as str/svar 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.45 C-He-Rh]                               
//*  @date Sat May  9 16:19:04 2020 
//*  @cdate Sat May  9 16:19:04 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug"


///
/// procrefarg
if (_dblevel >0) {
  debugON()
}


chkIn(_dblevel)

Str pstrarg (str v, str u)
{
<<"args in %V  $v $u \n"


 v->info(1)
 u->info(1)
m = scat(v,"-x-",u);


m->info(1);

// ans= query("args are correct?");
 v = "hola"
 v->info(1)
 s->info(1)
!p m


u = "que tal?"

  return m;

}
//=======================//


  str s = "hi"
  str t =  "Comment allez-vous?"

<<"%V $s $t \n"

  chkStr(s,"hi")
  chkStr(t,"Comment allez-vous?");

  s->info(1)
  t->info(1)

 w = pstrarg(s,t)

 w->info(1)
<<"%V $s $t $w\n"
 chkStr(w,"hi-x-Comment allez-vous?")
  s->info(1)
 chkStr(s,"hola")



  s = "buenos"
  t = "dias"

  s->info(1)
  t->info(1)

<<"%V $s $t \n"

 w = pstrarg(&s,&t)


<<"%V $s $t $w\n"

 chkStr(s,"hola")


  s = "buenas"
  t = "tardes"

  s->info(1)
  t->info(1)
  

<<"%V $s $t \n"

 w = pstrarg(s,t)


<<"%V $s $t $w\n"
 s->info(1)
 chkStr(s,"hola")

 chkOut()



//////////// TBD ////////////

