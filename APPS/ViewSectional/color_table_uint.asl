//%*********************************************** 
//*  @script color-table.asl 
//* 
//*  @comment produce color table from hex values 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.63 C-He-Eu]                               
//*  @date Mon Aug  3 16:03:52 2020 
//*  @cdate Mon Aug  3 16:03:52 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
sdb(1,@~trace)
///
///
///
/{/*
uint m;

u= atol("ff8e8980")
d= atol("371")
m = hex2dec("ff8e8980")

<<"%V $u $m $d\n"
/}*/

A=ofr(_clarg[1])

// read record

MI=ReadTable(A,@type,UINT_,@iptype,HEX_)
//MI=ReadTable(A)

checkMemory(1,1)

sz=Caz(MI)

<<"$sz $(Cab(MI))  $(typeof(MI))\n"

<<"$MI[0]\n"

<<"row 0\n"
<<"$MI[0][0:5]\n"


<<"$MI[1][0:5]\n"
//ans=query()


V= MI[0][::]

V->resize()
sz= Caz(V)

<<"$V\n"


<<"$sz  $(Cab(V)) $V[0]\n"
<<"$V[639]\n"


val = V[200]

index = V->findVal(val,0,1)

<<"$val $index \n"

uint TV[>500];




<<"$val $index \n"

i= 0
k=0
m=0
T=fineTime()

for (j= 0; j < 400; j++) {




for (i=0;i<640;i++) {     // 640
val = MI[j][i]
index = TV->findVal(val,0,m+1)

//<<"$i $val $index \n"

if (index == -1) {

  TV[m] = val
  m++;
  //<<"$i $val $m added\n"
}

k++;


}
dt=FineTimeSince(T,1)
MU=memused()
<<"$j $k $m $(m/(1.0*k))   $dt\n"
<<"$j $m Mem:  $MU\n"
}

/////////////////////////////////////////////////////////////////////




//<<"$TV\n"

sz=Caz(TV)

<<"%V$sz $k $m  $(m/(1.0*k))\n"


