/{/*
#94 09/29/17 5.90 4 PENDING
descr:
 vector print adds unwanted new line 
fix: 
 
tbd:
/}*/

setdebug(1)

T=vgen(INT_,10,0,1)

<<"$T"

<<"<-here\n"

te=T[2];
<<"<|%V${te}|>\n"


<<"%(2,->, ,<-\n)$T\n"

exit()

<<"/////////////\n"



n=2;
p="-->";
r="<--\n";
<<"%($n,$p, ,$r)$T\n"
<<"/////////////\n"


<<" $(n) \n"
<<" $(n+1) \n"

<<" $(n++) \n"
<<" $(n) \n"

<<" $(++n) \n"
<<" $(n) \n"


//<<"%($(n+1),$p, ,$r)$T\n"
<<"/////////////\n"
