//%*********************************************** 
//*  @script bubblesort.asl 
//* 
//*  @comment test bubblesort vmf 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%

<|Use_=
BubbleSort

bubblesort(Vec)
performs bubble sort on a vector returns the sorted vector.
Should work on all types.
can be used as Vec->BubbleSort() returns 1 if sorted.
|>

#include "debug"

if (_dblevel >0) {
   debugON()
      <<"$Use_ \n"       
}

chkIn(_dblevel)

I = vgen(INT_,30,0,1)

<<"$I \n"

I.pinfo()

//chkOut()


chkN(I[1],1)
chkN(I[29],29)

I.reverse()

<<"$I \n"
chkN(I[1],28)
chkN(I[29],0)

I.pinfo()


I.bubbleSort()

<<"$I \n"

chkN(I[1],1)
chkN(I[29],29)

rs= scat("Now ", " Shuffle ");
<<"$rs\n"


I.shuffle(20)

<<"$I \n"

I.bubbleSort()

<<"$I \n"

chkN(I[1],1)
chkN(I[29],29)

//chkStage("bubblesort")


chkOut()
