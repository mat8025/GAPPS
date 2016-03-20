

setDebug(1,"trace")
CheckIn()

//FIXME --- have to have a declare statement afore LIST DECLARE ??

m = 2


ws = getScript()
<<" $ws \n"



L = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" )


<<"$L\n"


 m = Caz(L)

<<"list size is $m \n"

 //CheckNum(m,11)

<<" should be unreversed !\n"

<<"L= $L\n"

 str le = "astring"

<<" $(typeof(le)) $le\n"

 le = L[1]

<<"%V$le \n"
<<"le type is $(typeof(le)) \n"

  li = L[2]
<<"%V$li \n"
<<"li type is $(typeof(li)) \n"
 m = Caz(li)
<<"list size is $m \n"

<<"\n"

lib = L[2:6]
 m = Caz(lib)
<<"list size is $m \n"


<<"%V contains $lib \n"
<<"lib type is $(typeof(lib)) \n"




<<" $L[1] $L[10] \n"


<<"%V$le %V$L[1]\n"

 aw="what"

 tt=CheckStr(aw,"what")

<<"%V$tt\n"

 aw=L[1]

<<" $(typeof(aw)) $aw \n"

 tt=CheckStr(le,"what")

<<"%V$tt\n"
 
 L->reverse()

<<"Reversed: $L \n"
<<" $L[1] $L[10] \n"

 le = L[1]

<<"%V$le \n"


 L->sort()

<<"sort list \n"
<<" $L \n"

 le = L[1]

<<"%V$le \n"


CheckOut()

stop!

