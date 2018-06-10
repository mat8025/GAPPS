///
///
///


ws = getScript()

<<"%V $ws\n"

//  setdebug(1."trace","keep")  /// TBF 1." crashes

setdebug(1,@trace,@keep);

filterDebug(1,"Vdeclare")



CrashList = ( "",  )  // empty list

<<"%V$CrashList \n"




CrashList->LiDelete(0)

 FailedList = ( "",  )  // empty list --- bug first item null? 

 FailedList->LiDelete(0)
 
<<" $ws \n"
<<"%V$CrashList \n"


<<"%V$FailedList \n"


CheckIn()

int J[] = { 1,2,3,4 }

m = Caz(J)

<<"%V$m \n"

<<"$J\n"


<<" $(CheckNum(m,4))\n"

checkOut()
exit()

//PassFail(CheckNum(m,4))


// FIXED !!  ---FIXME --- declare of list is tramping on ptrs

  L1 = ( "a", "small" , "list" , "1", "2", "3", "4", "5" ,"6" ,"yellow", "green", "blue" ,"indigo", "violet")

<<"$L1 \n"

exit()

 str fw = L1[0]

<<"%V$fw $(typeof(fw))\n"

checkStr(fw,"a")

l1sz = Caz(L1)
<<"%V$l1sz\n"

fw = L1[l1sz-1]

<<"%V$fw $(typeof(fw))\n"

checkStr(fw,"violet")


 L2 = ( "The", "colors", "of" ,"the", "rainbow", "are", "red", "orange", "yellow", "green", "blue" ,"indigo", "violet" )

<<"L2 = $L2 \n"

 L1 = L2

<<"L1 = $L1 \n"

 fw = L1[0]

<<"%V$fw $(typeof(fw))\n"

checkStr(fw,"The")


//  PassFail(checkStr(fw,"The"))

// FIXED!! -- FIXME not overwriting

<<"L2->L1 = $L1 \n"

//ans=iread()

 L1->reverse()

<<"%(,= , ,)vs${L1} \n"

     fw = L1[0]

checkStr(fw,"violet")

  //PassFail(checkStr(fw,"violet"))


 L3 = L1

<<"L3 = $L3 \n"



 L = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" )


<<"L = %s$L \n"

  fw = L[0]

<<"%V$fw $(typeof(fw))\n"

//  PassFail(checkStr(fw,"say"))

checkStr(fw,"say")


 L->reverse()

fw = L[0]

   //PassFail(checkStr(fw,"list"))

checkStr(fw,"list")

<<"L = $L \n"



//iread(";>")


//<<"%v$L[1:4] \n"
//<<"%v$L[1:-2] \n"
<<"%v\s$L[1:-3] \n"
//iread(";>")
<<"%V$L \n"

 L3 = L[1:7]

<<" $(typeof(L3)) \n"
<<"%V$L3 \n"

     fw = L3[0]
<<"fw $fw\n"
checkStr(fw,"lovely")




 litem = "focus"
 n= L->Insert(litem)

<<"insert %V$L    $n\n"

 sz= caz(L)

<<"%v $sz \n"


 litem = "on-working"
 n= L->Insert(litem,-1)

<<"insert %V$L    $n\n"


 sz= caz(L)

<<"%v $sz \n"

 litem = "first"

 n= L->Insert(litem,0)

<<"insert %V$L    $n\n"


 sz= caz(L)

<<"%v $sz \n"

 fw = L[0]

 checkStr(fw,"first")

 CheckOut()

stop!


 L3 = L[1:-2]

<<"1:-2 %V$L3 \n"

// L3 = L[6:1:]


 L3 = L[6:1]

<<"6->1%V$L3 \n"


 L3 = L[-3:2:-1]

<<"-3->2%V$L3 \n"

<<" %V$L3[1:7:2] \n"


// FIXME <<" %V$L3[-3:1:-1] \n"
// FIMXME
//<<"%v\s$L3[-1:0:] \n"
//iread(";>")





 m = Caz(L)

<<" %v$m \n"

 PassFail(CheckNum(m,11))

 n=L->Sort()


<<"%v$L \n"


<<"L is a $(typeof(L)) \n"

//iread(";>")


 L2 = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" )

<<"%v $L2 \n"

<<"%v $L2 \n"


 L2->Reverse()

<<"$L2 \n"




 CheckOut()


stop!

<<"%vs$L[1] \n"
<<"%vs$L[2] \n"
<<"%vs$L[3] \n"

<<"last element ? %vs $L[-1] \n"

//iread(";>")

# TDB make subscript work  --- DONE

<<"%vs$L[1:4] \n"

<<"%v$L \n"

//svar sl = L[3]


sl = L[3]

<<"%V$sl \n"

//iread(";>")

k= 5

<<" %v$k \n"
<<"%vs$L[k] \n"


 L->Reverse()

<<"reversed %V$L[0:3] \n"

<<"reversed %vs$L[0:-2] \n"

<<"reversed %vs$L[1:-3] \n"

//iread(";>")

 L->Reverse()

<<"reversed %V$L \n"

//iread(";>")

 L->Shuffle(20)

<<"shuffle %V$L  \n"

//iread(";>")

 L->Sort()

<<"sorted %V$L  \n"

//iread(";>")

 L->Reverse()

<<"reversed %vs$L \n"

// int ns=L->Sort()
 int ns

   ns=L->Sort()

<<"$(typeof(ns)) $ns \n"

<<"sorted %V$L   swaps $ns\n"

//iread(";>")

 L->Reverse()

<<"reversed %vs$L \n"

 ns=L->Sort()

<<"sorted %v$L   swaps $ns\n"

<<"$(typeof(ns)) $ns \n"


 n=L->Shuffle(20)
<<"shuffle %V$L  \n"


 n=L->Sort()
<<"sorted %V$L   swaps $n\n"

 n=L->Shuffle(100)
<<"shuffle %V$L  \n"


 n=L->Sort()
<<"sorted %V$L   swaps $n\n"

//iread(";>")

 litem = "focus"
 n= L->Insert(litem)

<<"insert %V$L    $n\n"

 CheckOut()

stop!


//////////////////// TBD //////////////////////
//  FIX XIC is doing a copypush_siv and push_siv - should just be copypush_siv
