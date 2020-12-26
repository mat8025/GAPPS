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
myScript = getScript();


///
/// procrefarg


chkIn(_dblevel)

Str pstrarg (str v, str u)
{
<<"args in %V  $v $u \n"

 m = v;
 v->info(1)
 u->info(1)

 v = "hola"
 u = "que tal?"

  return m;

}
//=======================//


  str s = "hi"
  str t =  "how are you?"

<<"%V $s $t \n"

 w = pstrarg(&s,&t)


<<"%V $s $t $w\n"

 chkStr(s,"hola")


  s = "buenos"
  t = "dias"


<<"%V $s $t \n"

 w = pstrarg(&s,&t)


<<"%V $s $t $w\n"

 chkStr(s,"hola")



  s = "buenas"
  t = "tardes"


<<"%V $s $t \n"

 w = pstrarg(s,t)


<<"%V $s $t $w\n"

 chkStr(s,"buenas")

 chkOut()



//////////// TBD ////////////

