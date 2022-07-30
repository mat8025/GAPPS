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

include "debug"

//debugOFF()
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

AF=ofile(_clarg[1],"r+")

// read record -ascii

//MI=ReadTable(A,@type,UINT_,@iptype,HEX_)
//MI=ReadTable(A)


uint val = hex2dec("ffffffff")


nrows = 100
nvals = 20


uint MI[]

sz=Caz(MI)

<<"$(Caz(MI)) $(Cab(MI))  $(typeof(MI))\n"



nir=vread(AF,MI,nvals,UINT_)




sz=Caz(MI)

<<"$sz $(Cab(MI))  $(typeof(MI))\n"
for (i= 0; i< nvals; i++) {
<<"$i $MI[i] %.8x$MI[i]\n"
}
exit()


int wd = PH[1]
int ht = PH[2]

<<"%.8X $MI[0] $MI[2048]  $MI[13867]\n"





uint A[]
k = 0;

for (i=0;i<nrows;i++) {


vvcopy(A,MI,wd,ALWAYS_,0,1,1,0,k)

S=Stats(A)
<<"$i $S[5] $S[6] %.8x$MI[k+10]\n"
k += wd;
}

exit()


<<"row 0\n"
//<<"$MI[0][0:5]\n"


<<"$MI[1][0:5]\n"
//ans=query()
/{
 V = vgen(INT_,20,0,1)

<<"$V\n"


V[17] = 4
V[15] = 3

<<"$V\n"




 TV= vunique(V)


 vsz= Caz(TV)


<<"$vsz \n"
/}


 T=fineTime()

 TV= vunique(MI)

 tsz= Caz(TV)

 dt=FineTimeSince(T,1)


<<"$tsz $(dt/1000000.0)\n"
 reType(TV,UINT_)
 
<<"$TV[0:10]\n"

 pc = tsz/(sz*1.0)

<<"%V $sz $tsz $pc\n"

B=ofw("cmap")

for (i=0;i<tsz;i++) {
printf('%d %.8x\n',i,TV[i]);
<<[B]"$i %.8x $TV[i]\n"
}

