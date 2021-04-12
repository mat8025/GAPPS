


#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


int F[] = { 1,2,3,4 };

<<"%v $(Caz(F)) \n"
n= Cab(F)
<<"%V $n $(Cab(F)) \n"




<<"%v $F \n"

<<"%v $F[*] \n"

<<"%V $F[0] $F[2] \n"



int G[] = { {1,2,3}, {4,5,6} };

n= Cab(G)

<<"%V $n $(Cab(G)) $(Caz(G)) \n"

<<"%v $G \n"

<<"%v $G[*] \n"

<<"%V $G[0][1] $G[1][1] \n"



svar S[] = { "mark", "nick" , "lauren", "pepe", "dena", "lucky", "scruffy", "jill", "ruby" }

<<"%v $S \n"

<<"%v $S[1] \n"

<<"%v $S[*] \n"


<<"%v $S[0::2] \n"

<<"%v $S[1::2] \n"


svar R[] = { {"mark", "nick" , "lauren",}\
                { "pepe", "dena", "lucky", }\
                {"scruffy", "jill", "ruby" }\
                {"jack", "tinkerbell", "jake" }};


<<"%v $R \n"

<<"%v $R[0][1] \n"

<<"%v $R[1][2] \n"


<<"%v $R[2][2] \n"

<<"%v $R[1][1] \n"

<<"%v $R[3][0] \n"

<<"%v $R[0:3][0] \n"

<<"%v $R[0:3][0:1] \n"

<<"%v $R[0:3][0:2:2] \n"

chkOut()
