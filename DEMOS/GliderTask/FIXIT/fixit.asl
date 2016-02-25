
setdebug(1)

proc foo( wval)
{

    sz = wval->Caz()
<<"%V$sz \n"
       //<<"$(typeof(wval))\n"
    place = wval[0]
<<"%V$place\n"

    nickn = wval[1]
<<"%V$nickn\n"
    idnt =  wval[2]
<<"%V$idnt\n"



}


class turnpt 
 {

 public:
 str place;
 str nickn;
 str idnt;

 cmf foo( wval)
 {
<<"CMF \n"
    sz = wval->Caz()
<<"%V$sz \n"
       <<"$(typeof(wval))\n"
    place = wval[0]
<<"%V$place\n"

    nickn = wval[1]
<<"%V$nickn\n"
    idnt =  wval[2]
<<"%V$idnt\n"

 }

}


svar m_wval

     Wval = Split("once upon a time")
   


<<"%V$sz \n"
       //<<"$(typeof(wval))\n"
    Place = Wval[0]
<<"%V$Place   $(typeof(Place))\n"

    Nickn = Wval[1]
<<"%V$Nickn\n"
    Idnt =  Wval[2]
<<"%V$Idnt\n"


     foo(Wval)

turnpt T


 T->foo(Wval)



stop!