setdebug(0)
int TS[]

 TS[0:10]->Set(1,2)

<<"$TS \n"

 nf = TS[1]
<<"%V $nf \n"
 if (TS[1] > 0) {

<<" TS ele > 0\n"

 }

 S = "this is painful" 

<<" $S \n"

col = Split(S)

<<" %V$col $col[0] $col[1]\n"

 if (col[1] @= "is") {

<<" what does is mean \n"

 }



 if (col[2] @= "painful") {

<<" painful $col[2] \n"

 }


stop!