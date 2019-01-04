
A=ofr("cal2019")

S=readfile(A)

sz=Caz(S);
char Ln[80]

int Week3[21];
str val="";
char num[3]
for (i = 4; i < 10;i++) {
len = slen(S[i]);
scpy(Ln,S[i]);
Ln[66]=0;
//<<"${i}:$len %s <|$Ln|>"

//scpy(&num,&Ln[2],2)

num[0] = Ln[0];
num[1] = Ln[1];
val1 = Atoi(num)

num[0] = Ln[3];
num[1] = Ln[4];
val2 = Atoi(num)


//<<"${Ln[0]}$Ln[1] %s ${Ln[0]}$Ln[1]\n"

//<<" %s ${Ln[0]}$Ln[1] ${Ln[3]}$Ln[4] %d $val1 $val2\n"
 j= 0;
 for (k = 1; k <=21; k++) {
  num[0] = Ln[j++];
  num[1] = Ln[j++];
           j++;
	  if ((k % 7) == 0) {
            j+= 2;
          }

          ival = Atoi(num)
          Week3[k-1] = ival;

 }
<<"$i $Week3[0:6] $Week3[7:13] $Week3[14:20] \n"
}
