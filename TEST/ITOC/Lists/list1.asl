
chkIn()

ws = getScript()
<<" $ws \n"
//chkIn()



int J[] = { 1,2,3,4 }


m = Caz(J)

<<" %v $m \n"

// chkN(m,4)

 L = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" )

//<<"%vs $L \n"

<<"%v $L \n"


 m = Caz(L)

<<" %v $m \n"

// chkN(m,11)


 n=L->Sort()


<<"%v $L \n"


<<"L is a $(typeof(L)) \n"


stop!
 L2 = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" )

<<"%v $L2 \n"

//chkOut()


stop!


<<"%vs $L \n"

fw = L[0]

<<" %V $fw \n"


stop!


lw = L[-1]

<<" %V $fw $lw\n"



<<"%vs $L[1] \n"
<<"%vs $L[2] \n"
<<"%vs $L[3] \n"

<<"last element ? %vs $L[-1] \n"


# TDB make subscript work  --- DONE

<<"%vs $L[1:4] \n"

<<"%v $L \n"

k= 5

<<" %v =$k \n"
<<"%vs $L[k] \n"


 L->Reverse()

<<"reversed %vs $L[0:3] \n"

<<"reversed %vs $L[0:-2] \n"

<<"reversed %vs $L[1:-3] \n"

 L->Reverse()

<<"reversed %vs $L \n"


 L->Shuffle(20)
<<"shuffle %vs $L  \n"




 L->Sort()
<<"sorted %vs $L  \n"



 L->Reverse()

<<"reversed %vs $L \n"

 n=L->Sort()

<<"sorted %vs $L   swaps $n\n"

 L->Reverse()

<<"reversed %vs $L \n"


 n=L->Sort()
<<"sorted %v $L   swaps $n\n"

 n=L->Shuffle(20)
<<"shuffle %vs $L  \n"


 n=L->Sort()
<<"sorted %vs $L   swaps $n\n"

 n=L->Shuffle(100)
<<"shuffle %vs $L  \n"


 n=L->Sort()
<<"sorted %vs $L   swaps $n\n"


 chkOut()

stop!

