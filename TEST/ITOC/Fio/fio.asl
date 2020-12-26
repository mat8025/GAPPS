//%*********************************************** 
//*  @script fio.asl 
//* 
//*  @comment test file IO 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Thu Dec 24 09:53:49 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


chkIn(_dblevel)

int ok = 0
int ntest = 0
int bad = 0


a = 1
b = 2
c = 3

B=ofw("junk")
C=ofw("junk2")

int M[] = {0,1,2,3,4}

M->info(1)

<<"%i $M\n";
<<"%V $M\n"


 for (i= 0; i < 5; i++) {
   a++; b++; c++;
 <<[B]"$i %V $a $b $c  \n"

 <<"$i %V $a $b $c  \n"
 <<[C]"$i $M  \n"
 <<"$i $M  \n"
   M =  M * 2

 }

cf(C)
cf(B)

B=ofr("junk")

W=readfile(B)



<<"$W\n"
C=ofr("junk2")
T=readfile(C)

<<"$T\n"
// now read back and check

<<"$W[0]\n"

<<"$T[0]\n"

L=Split(T[0])

<<"$L[0] $L[1] $L[2]\n"

chkStr(L[2],"1")

L=Split(W[0])

chkStr(L[1],"a")

chkOut()
