//%*********************************************** 
//*  @script procrefarg.asl 
//* 
//*  @comment test proc ref & arg 
//*  @release CARBON 
//*  @vers 2.37 Rb Rubidium                                               
//*  @date Wed Jan  9 21:40:10 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


///
/// procrefarg

setdebug(1,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc",);
filterFileDebug(ALLOWALL_,"ic_",);


CheckIn(0)

proc pstrarg (v, u)
{
<<"args in %V  $v $u \n"

 m = v;
 v->info(1)
 u->info(1)

 v = "hola"
 u = "que tal?"

  return m

}
//=======================//

  checkin();


  str s = "hi"
  str t =  "how are you?"

<<"%V $s $t \n"

 w = pstrarg(&s,&t)


<<"%V $s $t $w\n"

 checkStr(s,"hola")


  s = "buenos"
  t = "dias"


<<"%V $s $t \n"

 w = pstrarg(&s,&t)


<<"%V $s $t $w\n"

 checkStr(s,"hola")



  s = "buenas"
  t = "tardes"


<<"%V $s $t \n"

 w = pstrarg(s,t)


<<"%V $s $t $w\n"

 checkStr(s,"buenas")
  



 CheckOut()



//////////// TBD ////////////

