//%*********************************************** 
//*  @script arrayrange.asl 
//* 
//*  @comment test vecotr range spec - forward,backward 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Tue Jun 25 18:48:42 2019 
//*  @cdate Tue Jun 25 18:48:42 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%



chkIn(_dblevel)

B=vgen(INT_,10,0,1)
<<"%V$B\n"

chkN (B[0],0)
chkN (B[4],4)

D= B
<<"%V$D\n"
<<"%V$B\n"

chkN (D[0],0)
chkN (D[4],4)

C= B[1:3];

<<"%V$C\n"

chkN (C[0],1)

D= B[::]
<<"%V$D\n"
<<"%V$B[0:-1]\n"

chkN (D[0],0)
chkN (D[4],4)


D= B[0:-1]
<<"%V$D\n"
<<"%V$B[0:-1]\n"

chkN (D[0],0)
chkN (D[5],5)


D= B[1:-2]
<<"%V$D\n"
<<"%V$B[1:-2]\n"

chkN (D[0],1)
chkN (D[2],3)







D= B[-1:0:-1]
<<"reverse opr\n"
<<"%V$D\n"
<<"%V$B[-1:0:-1]\n"

chkN (D[0],9)
chkN (D[4],5)


D= B[-2:1:-1]


<<"%V$D\n"
<<"%V$B[-1:0:-1]\n"

chkN (D[0],8)
chkN (D[2],6)




<<" lets do circular buffer\n"

D= B[-1:8:1]

<<"%V$D\n"
<<"B[-1:2:1] $B[-1:2:1]   \n"

chkN (D[0],9)
chkN (D[1],0)
chkN (D[2],1)
chkN (D[3],2)



<<" -2:3:1 \n"
D= B[-2:2:1]
<<"%V$D\n"
<<"%V$B[-2:2:1] \n"

chkN (D[0],8)
chkN (D[4],2)



<<" 3:3:1 \n"
D= B[4:3:1]
<<"%V$D\n"
<<"%V$B[3:3:1] \n"

//chkN (D[0],3)
//chkN (D[5],3)

<<" 3:3:-1 \n"
D= B[3:3:-1]
<<"%V$D\n"
//<<"%V$B[3:3:-1] \n"



<<" 3:3:0 \n"
D= B[3:3:0]
<<"%V$D\n"
/{
<<"%V$B[3:3:-1] \n"
/}

//chkN (D[0],3)
//chkN (D[5],3)

D = B[-3:4:-1]

<<"$D\n"

e = B[9]
<<"%V $e $B[9]\n"


f=  B[-1]

<<"%V $f $B[-1]\n"

chkN (f,9)

f=  B[-2]
<<"%V $f $B[-2]\n"
chkN (f,8)


chkOut () ;
