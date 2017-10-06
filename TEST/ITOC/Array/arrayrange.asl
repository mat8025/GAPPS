
setdebug(1,"~pline")

//#define ASK ans=iread(); <<"ans was: $ans\n";


#define ASK ;



checkIN()

B=igen(5,0,1)
<<"%V$B\n"

checkNumber(B[0],0)
checkNumber(B[4],4)

D= B
<<"%V$D\n"
<<"%V$B\n"

checkNumber(D[0],0)
checkNumber(D[4],4)




D= B[::]
<<"%V$D\n"
<<"%V$B[0:-1]\n"

checkNumber(D[0],0)
checkNumber(D[4],4)


D= B[0:-1]
<<"%V$D\n"
<<"%V$B[0:-1]\n"

checkNumber(D[0],0)
checkNumber(D[4],4)


D= B[1:-2]
<<"%V$D\n"
<<"%V$B[1:-2]\n"

checkNumber(D[0],1)
checkNumber(D[2],3)

ASK





D= B[-1:0:-1]
<<"reverse opr\n"
<<"%V$D\n"
<<"%V$B[-1:0:-1]\n"

checkNumber(D[0],4)
checkNumber(D[4],0)
ASK

D= B[-2:1:-1]


<<"%V$D\n"
<<"%V$B[-1:0:-1]\n"

checkNumber(D[0],3)
checkNumber(D[2],1)




<<" lets do circular buffer\n"

D= B[-1:2:1]

<<"%V$D\n"
<<"B[-1:2:1] $B[-1:2:1]   \n"

checkNumber(D[0],4)
checkNumber(D[2],1)
checkNumber(D[3],2)

ASK

<<" -2:3:1 \n"
D= B[-2:2:1]
<<"%V$D\n"
<<"%V$B[-2:2:1] \n"

checkNumber(D[0],3)
checkNumber(D[4],2)

ASK

<<" 3:3:1 \n"
D= B[4:3:1]
<<"%V$D\n"
<<"%V$B[3:3:1] \n"
ASK
//checkNumber(D[0],3)
//checkNumber(D[5],3)

<<" 3:3:-1 \n"
D= B[3:3:-1]
<<"%V$D\n"
//<<"%V$B[3:3:-1] \n"

ASK

<<" 3:3:0 \n"
D= B[3:3:0]
<<"%V$D\n"
/{
<<"%V$B[3:3:-1] \n"
/}

//checkNumber(D[0],3)
//checkNumber(D[5],3)

D = B[-3:4:-1]

<<"$D\n"


checkOut() ;
exit()