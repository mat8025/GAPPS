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

int Rn = 0;
chkIn(_dblevel)

Str pstrarg (str v, str u)
{
<<"args in %V  $v $u \n"
 Rn++;

 v.pinfo()
 u.pinfo()


 r=  sele(v,1)
 <<"$r $v\n"

//m = scat(v,u);
m = scat(v,"-x-",u);
 


m.pinfo();

// ans= query("args are correct?");
 v = "hola"
 v.pinfo()
 s.pinfo()
!p m


u = "que tal?"
!z
  return m;

}
//=======================//


  str s = "hi"
  str t =  "Comment allez-vous?"


  z = scat(s,t)
  zs = sele(z,3)
  
<<"%V $s $t $z $zs\n"

  chkStr(s,"hi")
  chkStr(t,"Comment allez-vous?");

  s.pinfo()
  t.pinfo()

 w = pstrarg(s,"Comment allez-vous?");
<<"%V$Rn\n"
 w.pinfo()
<<"%V $s $t $w\n"

 chkStr(w,"hi-x-Comment allez-vous?")
  s.pinfo()
  <<"$s\n"
  
 chkStr(s,"hola")

chkOut()

  s = "buenos"
  t = "dias"

  s.pinfo()
  t.pinfo()

<<"%V $s $t \n"
  Rn= 0;
 w = pstrarg(&s,&t)
<<"%V$Rn\n"

<<"%V $s $t $w\n"

 chkStr(s,"hola")
!?

  s = "buenas"
  t = "tardes"

  s.pinfo()
  t.pinfo()
  

<<"%V $s $t \n"
Rn= 0;
 w = pstrarg(s,t)
<<"%V$Rn\n"

<<"%V $s $t $w\n"
 s.pinfo()
 chkStr(s,"hola")

 chkOut()



//////////// TBD ////////////

