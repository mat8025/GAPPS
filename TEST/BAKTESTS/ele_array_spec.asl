///
///
///



checkIn()
int bounds[5];
int nb = 3;

bounds[0] =3;
bounds[1] =5;

bounds[2] =4;


V=vgen(INT_,60,0,1)

A3D= V

A3D->redimn(3,5,4)

<<"$A3D \n"


ele = 36; // r*c  - n'th ele is what array spec
// 25 should be [1][1][1]
// 36 should be [1][4][0]
int spec[15][3];

proc ele2spec( ele , row)
{
ev= ele;
for (i= 0; i < nb; i++) {
 ib = 1;
 for (j = (i+1) ; j < nb; j++) {
   ib *= bounds[j];
 }
 val = ev / ib;
 <<"%V $ev $val $ele $ib \n"
 spec[row][i] = val; 
 ev = ev - (ib * val);
}

<<"$ele  $spec[row][::]\n"
}


k = 0;
ele2spec(0,k++)

ele2spec(1,k++)

ele2spec(2,k++)

ele2spec(3,k++)

ele2spec(4,k++)

ele2spec(5,k++)

ele2spec(36,k++)

ele2spec(37,k++)

ele2spec(49,k++)

ele2spec(53,k++)

ele2spec(47,k++)

ele2spec(59,k++)


<<"$spec\n"




M=eletoarrayspec(V,3,3,5,4)

<<"$M\n"


int V2[8];

V2[0] = 13
V2[1] = 37
V2[2] = 47
V2[3] = 51
V2[4] = 54
V2[5] = 59
V2[6] = 60
V2[7] = -1

M2=eletoarrayspec(V2,3,3,5,4)

<<"\n$M2\n"

checkNum(M2[5][0],2)
checkNum(M2[5][1],4)
checkNum(M2[5][2],3)
checkNum(M2[6][0],-1)
checkNum(M2[7][0],-1)


checkOut()
