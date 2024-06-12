//%*********************************************** 
//*  @script cast.asl 
//* 
//*  @comment test cast function 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sun Mar 10 08:42:29 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


#include "debug.asl";

if (_dblevel >0) {
   debugON()
}



chkIn()



int IV[] = {47,79,80};

<<"%V $IV\n"

chkN(IV[1],79);

FV = vgen(FLOAT_,3,0,1)

<<"%V $FV\n"


//sdb(1,@step,@pline)


uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE };


<<" $C[0]  $C[1]\n"
<<" $(typeof(C)) \n"
<<" $C \n"
<<"%x $C \n"


<<"%x $C \n"



// just copy
<<" just assign/copy to new vector \n"
D = C
<<"D $D\n"
// convert

   C->Convert(INT_);
   
   chkN(202,C[0]);
   

//////////////////////////

   CI= C

<<" $(typeof(C)) $(sizeof(C))\n"
<<" $C \n"
<<"%x $C \n"

    C->Convert(FLOAT_)

<<" $(typeof(C)) $(sizeof(C))\n"
<<" $C \n"
<<"%x $C \n"
<<"$C[0] $C[1] \n"



   chkN(202.0,C[0])
   chkN(254.0,C[1])

<<" $(typeof(D)) \n"
<<" $D \n"
<<"%x $D \n"
// FIX
//int E[] = D
int E[]  ;
E = D


<<"E $(typeof(E)) \n"
<<" $E \n"
<<"%x $E \n"
<<" swab E\n"
swab(E)

<<"%x $E \n"



// retype vector to int
<<"now retype D CHAR vec to an INT vec\n"

   retype(D,INT_)

<<" $(typeof(D)) \n"
<<"D[] \%d $D \n"
<<"D[] \%X %x $D \n"



d0 = 0xcafebabe



<<"%V %x $d0 \n"

<<"%V %d $d0 \n"

d0 = 0xca

<<"%V %x $d0 \n"
<<"%V  $d0 \n"

 x= D[0]
 swab(D)
<<"%x $D[0] \n"
<<"swabbed $D \n"
<<"%x $D \n"




   chkN(d0,CI[0])


<<"retype CHAR $(CHAR_) --> FLOAT $(FLOAT_) \n"

   E->retype(FLOAT_)

<<" $(typeof(E)) \n"
<<" $E \n"
<<"%x $E \n"

<<"Types values %V $(INT_) $(FLOAT_) $(CHAR_) $(DOUBLE_)\n"





//<<"now retype D INT vec to a FLOAT \n"

//   retype(D,FLOAT_)

<<" $(Sizeof(D)) \n"
<<" $(typeof(D)) \n"

<<"D[] \%f $D \n"

<<"D[] \%X %x $D \n"


// F= cast(D,FLOAT_)
float F[]

 F = D;
 
<<" D $(typeof(D))\n"
<<" F $(typeof(F))\n"

<<"float vec $F[::]\n"

<<"float vec $F[0:-1]\n"

 G= cast(FLOAT_,D)

<<"float G[] $G[0:-1]\n"

 IV = cast(INT_,G)

<<"int IV[] $IV\n"

 LV = cast(LONG_,G)

<<"long LV[] $LV\n"

chkOut()

exit()
