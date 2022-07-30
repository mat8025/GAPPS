///
///
///
A=ofr("denlatlngcalib.txt")

LL=readrecord(A,@type,FLOAT_)

<<"$LL\n"

<<"$(Cab(LL))\n"
bd= Cab(LL)
n= bd[0]
<<"%V $n\n"
float longdiff[]
 k=0;
 for (j= 1; j< n;j++) {
   if ((LL[j-1][1] - LL[j][1]) == 1.0) {
       longdiff[k] = LL[j][2] - LL[j-1][2];
       k++;
   }
 }

<<"$longdiff\n"

LS = msortCol(LL,1)

<<"$LS\n"


float latdiff[]
k=0
  for (j= 1; j< n;j++) {
   if (LS[j-1][1] == LS[j][1]) {
     dlat = abs((LS[j-1][0]- LS[j][0]));
     dnum = abs((LS[j-1][3]- LS[j][3]));
     latdiff[k] = (dnum*1.0)/dlat;
     k++;
   }
   }

<<"%6.0f$latdiff\n"

a=Mean(latdiff)

<<"ave lat $a\n"