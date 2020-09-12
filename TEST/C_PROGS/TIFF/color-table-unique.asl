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



sz=Caz(MI)

<<"$sz $(Cab(MI))  $(typeof(MI))\n"

<<"$MI[0]\n"

<<"row 0\n"
<<"$MI[0][0:5]\n"


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

