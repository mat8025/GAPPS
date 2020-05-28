

Setdebug(1)



// list H = (1,2,3);

H = (1,2,3);

 ///H = ("1","2","3");

<<"%V $H\n";

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