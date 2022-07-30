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

debugOFF()
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

AF=ofr(_clarg[1])

// read record -ascii

//MI=ReadTable(A,@type,UINT_,@iptype,HEX_)
//MI=ReadTable(A)

uint PH[3];

nir=vread(AF,PH,3,UINT_);
int npix = PH[0];

<<"$PH\n";
//uint MI[>10]

// should size MI to required



uint val = hex2dec("ffffffff");
int wd = PH[1];
int ht = PH[2];

nrows = 5000;

uint MI[PH[0]];

nir=vread(AF,MI,wd*ht,UINT_);



sz=Caz(MI)

<<"$sz $(Cab(MI))  $(typeof(MI))\n"

<<"%.8X $MI[0] $MI[2048]  $MI[13867]\n"


uint A[]
k = 0;
/*
for (i=0;i<nrows;i += 20) {


vvcopy(A,MI,wd,ALWAYS_,0,1,1,0,k)

S=Stats(A)
<<"$i $S[5] $S[1] $S[6] %.8x$A[10]\n"
k += wd;
}




<<"row 0\n"
//<<"$MI[0][0:5]\n"
<<"$MI[1][0:5]\n"
*/

//ans=query()
/*
 V = vgen(INT_,20,0,1)

<<"$V\n"


V[17] = 4
V[15] = 3

<<"$V\n"

 TV= vunique(V)


 vsz= Caz(TV)


<<"$vsz \n"
*/


 T=fineTime();

 TV= vunique(MI);

 tsz= Caz(TV);
 nu = tsz/2;
 dt=FineTimeSince(T,1);


<<"$tsz $(dt/1000000.0)\n"
 reType(TV,UINT_);
 
<<"$TV[0:10]\n";

 pc = (tsz/2)/(sz*1.0) * 100;

<<"%V $sz $tsz $pc\n"

B=ofw("cmap")

RV=msortCol(TV,1)


for (i=0;i<nu;i++) {
printf('%d %d 0x%.8x %d\n',i,RV[i][0],RV[i][0],RV[i][1]);
<<[B]"$i  $RV[i][0] %.8x 0x$RV[i][0] %d $RV[i][1]\n"
}


V=colsum(RV);

<<"$V \n"


exit()