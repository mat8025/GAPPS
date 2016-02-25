
SetPCW("writepic","writeexe")
Setdebug(1)

//S= ""

svar  S = { "say", "what", "do" ,"I", "do", "now?" , "Well" , "Create!" }

<<"all %v: $S \n"
<<"%v $S[1] \n"
<<"%v $S[*] \n"

sz = Caz(S)

<<" $sz \n"

int I[] = { 1,2,3,4 }

<<"%v = $I \n"
<<"%v =$I[1] \n"
<<"%v =$I[*] \n"


int H[] = { 1,2,3,4 }

<<"%v = $H \n"
<<"%v =$H[1] \n"
<<"%v =$H[*] \n"


int W[] = { 1,2,3,4 }

<<"%v = $W \n"
<<"%v =$W[1] \n"
<<"%v =$W[*] \n"


float F[] = { 1,2,3.5,4, sin(3) }


<<"%v = $F \n"


<<"%v =$F[1] \n"
<<"%v =$F[*] \n"


float F1[] = { 1,2,3.5,4, sin(3) }


<<"%v = $F1 \n"


<<"%v =$F1[1] \n"
<<"%v =$F1[*] \n"




k = 4

<<" %v $k \n"

#{
# TBD make implicit array declaration work

   J[] = { 1,2,3,4 }

<<"%v = $J \n"
<<"%v =$J[1] \n"
<<"%v =$J[*] \n"


   M = { 1,2,3,4 }

<<"%v = $M \n"
<<"%v =$M[1] \n"
<<"%v =$M[*] \n"

#}


 L = ( "say", "what", "do" ,"I", "do", "now", "with", "this", "list" )


<<"L all %v %s $L \n"


<<"L1%v %s $L[1] \n"
<<"%v %s $L[2] \n"
<<"%v %s $L[3] \n"


# TDB make * work --- DONE
<<"all: %v %s $L[*] \n"

# TDB make subscript work  --- DONE
<<"%v %s $L[1:4] \n"

k= 5
<<" %v =$k \n"


<<"%v %s $L[k] \n"



<<" did we see L ? \n"

#{
# TBD make single quote - no expansion work
<<' what do we see here \n'

#}

STOP!
A=!!"ls *.asl"

<<" $A \n"

#{
# TBD make backtick work
B=`"ls *.asl"`
<<" $B \n"
#}




STOP!




 G = { "say", "what", "do" ,"I", "do", "now" }

<<"%v $G \n"
<<"%v $G[1] \n"
<<"%v $G[*] \n"


 K[] = { 1,2,3,4 }

<<"%v = $K \n"
<<"%v =$K[1] \n"
<<"%v =$K[*] \n"


 R[] = { 1.0,2,3,4 }

<<"%v = $R \n"
<<"%v = $R[1] \n"
<<"%v = $R[*] \n"








STOP!

 k = 0
#{
// List L  element e
   e = L->first()
   n = L->size()
  do   
  {
   val = L->currval()
   <<"$k $e->val() \n"
   k++
   e= L->next()
  } until (k > n)

#}

STOP!