proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }

}


#define  ASK ask();
//#define  ASK ;



setdebug(1,"~pline","trace","~stderr")



checkIn()

int i = 5;
float f = 3.1;
uchar uc = 79;
char c = 127;

long l = 1234;


int i2 ;
float f2 ;
uchar uc2 ;
char c2;
long l2;


<<"%V$i $f $uc $c $l \n"


uchar UCV[]
uchar UCV2[];



UCV[0] = 7;

<<"$UCV\n"
int IV[10];
int FV[10];

checkIn()
int nc;
i = 0;
f = 0.0;

while (1) {

nc = packb (UCV,"I",i)

<<"$nc  :: $UCV\n"

nc = unpackb (UCV,"I1",IV)

checkNum(i,IV[0]);

nc = packb (UCV,"F",f)

<<"$nc  :: $UCV\n"
nc = unpackb (UCV,"F1",FV)

checkNum(f,FV[0]);

packb (UCV,"I,F,U,C,L",i,f,uc,c,l)


unpackb (UCV,"I,F,C,C,L",&i2,&f2,&uc2,&c2,&l2)


checkNum(i,i2)
checkNum(f,f2)
checkNum(c,c2)
checkNum(uc,uc2)
checkNum(l,l2)


ASK
i++;
f++;

IV = vgen(INT_,5,0,1)
<<"%V $IV\n"

packb (UCV,"I4",IV)

if (i >= 5) {
  break;
}

}

checkOut()

exit();