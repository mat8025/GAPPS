//%*********************************************** 
//*  @script lhe.asl 
//* 
//*  @comment test LHS array ele use 
//*  @release CARBON 
//*  @vers 1.38 Sr Strontium                                              
//*  @date Fri Jan 18 20:40:11 2019 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///



chkIn(_dblevel)

// _dblevel == 1 stop - interact on fail else run until exit -- report status on chkOut



Data = vgen(INT_,10,-5,1)


<<"$Data \n"

<<"$Data[1:3] \n"
<<"$Data[1]\n"
<<"$Data[2]\n"
<<"$Data[3]\n"

//query()
Data->info(1)

chkN(Data[1],-4)


H= vgen(INT_,10,0,1)
M= vgen(INT_,10,0,1)

<<"%V $H \n"

Data[3] = 36
<<"$Data \n"
chkN(Data[3],36)

Data->info(1)

 i = 2
 j = 4

Data[i] = 80
<<"$Data \n"


Data->info(1)
chkN(Data[i],80)

H[8] = 76;
H[9] = 77;
<<"%V$H\n"

Data[H[1]] = 47

Data->info(1)

<<"$H[1] $Data[1]\n"
<<"%V$H\n"
<<"%V$Data \n"


<<"H $H\n"

Data[H[2]] = 65
Data[H[3]] = H[9]

Data[H[4]] = H[M[8]]

<<"$Data \n"




Data->info(1)

chkN(Data[1],47)
<<"$Data[1] $Data[2] \n"
d= 47
e= Data[1]
Arglist=testargs(Data[1],e,d)
<<"%(1,,,\n)$Arglist\n"

<<"%(1, ,,\n)$(testargs(Data[1],e,d))\n"

Data->info(1)
<<"%d $Data \n"

chkN(Data[2],65)

chkN(Data[3],77)

chkN(Data[4],76)

Data[H[4]] = H[8]
<<"%V $M[8]\n"

<<"$Data \n"

chkN(Data[4],76)

chkOut()
int k = 0


///////////////////////////////////////////////////////



Data[1] = 47

<<"$Data \n"

<<"$Data[1] \n"

chkN(Data[1],47)

k = 2
Data[k] = 79

<<"$Data[2] $Data[k]\n"

chkN(Data[2],79)
chkN(Data[k],79)









int Vec[10]
int LP[10]

Data[j] = 26;

<<"$Data \n"

<<" %(1,,,,)$Data \n"



chkN(Data[4],26)
     Data[1] = k
     Data[2] = Data[1]
Data->info(1)

<<"$Data \n"

<<"$Data[::] \n"


<<"%V$i $j\n"
     Data[j] = Data[i]
<<"$Data \n"
<<"%V$Data[2]  $k $i\n"

chkN(Data[2],k)


 m = 7

Data[i] = 80
Data[j] = 26

<<"$Data \n\n"

b = 67
     k = 1;
     Data[1] = k;
     Data[2] = Data[1];

<<"%V $Data[1] $Data[2] $k $i\n"
     chkN(Data[1],k)
     chkN(Data[2],k)


  while (1) {

     k++;

<<"%V$k\n"

     Data[1] = k;
     Data[2] = Data[1];

<<"%V $Data[1] $Data[2] $k $i\n"
//ans =iread()
     chkN(Data[1],k)
     chkN(Data[2],k)


<<"$Data \n"
<<"%V$i $j\n"
     Data[j] = Data[i]
<<"$Data \n"


     if (k > 5)
     break

  }


chkOut()
