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

//MI=ReadTable(A,@type,UINT_,@iptype,HEX_)
MI=ReadTable(A)



sz=Caz(MI)

<<"$sz $(Cab(MI))  $(typeof(MI))\n"

<<"$MI[0]\n"

<<"row 0\n"
<<"$MI[0][0:5]\n"


<<"$MI[1][0:5]\n"
ans=query()
svar S

 S->Table("LUT",2,1)

row=S->addEntry(-1,"ff8e8996")
<<"%V$row \n"

row=S->addEntry(-1,"ff8e8970")
<<"%V$row \n"
row=S->addEntry(-1,"ff8e8949")
<<"%V$row \n"
row=S->addEntry(-1,"ff8e8952")
<<"%V$row \n"

row=S->addEntry(-1,MI[1][7])
<<"%V$row \n"
sz=Caz(S)



<<"Table has : $sz\n"
<<"%V$S[0]\n"


<<"%V$S\n"

val=S->lookup("ff8e8996")

<<"%V$val\n"

val=S->lookup("ff8e8970")

<<"%V$val\n"

val=S->lookup("ff8e8949")

<<"%V$val\n"

val=S->lookup("ff8e8952")

<<"%V$val\n"

<<"$S[::]\n"

<<"%V$S[0]\n"
<<"%V$S[1]\n"
<<"%V$S[2]\n"


val=S->lookup(MI[2][8])

<<"$MI[2][8] $val\n"
hval = MI[2][8]
if (val == -1) {
  row=S->addEntry(-1,MI[2][8])
  <<"add  $row $hval \n"
}




hval = MI[2][9]
val=S->lookup(hval)

<<"$hval $val\n"

if (val == -1) {
  row=S->addEntry(-1,hval)
  <<"add  $row $hval \n"
}

i = 10
hval = MI[2][10]
val=S->lookup(hval)

<<"$hval $val\n"

if (val == -1) {
  row=S->addEntry(-1,hval)
  <<"add $row $hval \n"
}

i++
hval = MI[2][i]
val=S->lookup(hval)

<<"$hval $val\n"

if (val == -1) {
  row=S->addEntry(-1,hval)
  <<"add $row $hval \n"
}

i++

hval = MI[2][i]
val=S->lookup(hval)

<<"$hval $val\n"

if (val == -1) {
  row=S->addEntry(-1,hval)
  <<"add $row $hval \n"
}


hval = MI[2][i]
val=S->lookup(hval)

<<"$hval $val\n"

if (val == -1) {
  row=S->addEntry(-1,hval)
  <<"add $row $hval \n"
}

//while (i < 600) {
k= 0;
m= 0;
for (j = 2; j < 50 ; j++) {

  for (i=0; i < 640; i++) {

  hval = MI[j][i];
  val = S->lookup(hval)



if (val == -1) {
  row=S->addEntry(-1,hval)
//  <<"add $row $hval \n"
  k++;
}
else {
  //<<"$i $hval $val\n"
}
   m++;

}
<<"$j $k $m  $(k/(1.0*m))\n"
}

//<<"$S[::]\n"



exit()





 for (i = 0; i< 4; i++) {

 hval = MI[2][i]
 
 val=S->lookup(hval)

<<"$MI[2][i] $hval $val\n"

if (val == -1) {
  row=S->addEntry(-1,hval)
  <<"add $i $row $hval \n"
}

}

//<<"$S[::]\n"