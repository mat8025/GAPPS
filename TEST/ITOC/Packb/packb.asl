/* 
 *  @script packb.asl 
 * 
 *  @comment test packb SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.3 C-Li-Li]                                 
 *  @date Thu Dec 31 08:43:37 2020 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

/*
packb
packb (UCV,[swapbytes],"I,F,C,C,L",i,f,uc,c,l)
will take a uchar vec and format string "I,F,U,C,L"
and following args/constants convert according to the format specifier
and then pack them into the uchar vector according to sizeof of the format specifier
if optional second argument is 1, then pairs of bytes are swapped
*/


proc ask()
{
   ok=chkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }
  ans=iread();
}


//#define  ASK ask();
#define  ASK ;



//setdebug(1,"pline","trace","~stderr")



chkIn()

int i = 5
float f = 3.1
uchar uc = 79
char c = 127

long l = 1234;


int i2 
float f2 
uchar uc2 
char c2
long l2


<<"%V$i $f $uc $c $l \n"


//uchar UCV[20]
//uchar UCV2[20];

uchar UCV[]
uchar UCV2[];



UCV[0] = 7;

<<"$UCV\n"



int nc;

nc = packb (UCV,"I",i)

<<"$nc  :: $UCV\n"




nc = packb (UCV,"F",f)

<<"$nc  :: $UCV\n"

nc = packb (UCV,"L",l)

<<"$nc  :: $UCV\n"


packb (UCV,"I,F,U,C,L",i,f,uc,c,l)


<<"$UCV\n"


unpackb (UCV,"I,F,C,C,L",&i2,&f2,&uc2,&c2,&l2)


chkN(i,i2)

chkN(f,f2)
<<" $c $c2 \n"
chkN(c,c2)
<<" $uc $uc2 \n"

chkN(uc,uc2)


chkN(l,l2)


ASK

<<"$UCV\n"

<<"%V$i2 $f2 $uc2 $c2 $l2 \n"

<<" now vec \n"

 I = vgen(INT_,5,0,1)

ASK

packb (UCV,"I3",I)

<<"$UCV\n"




int T[5];

<<"$(Caz(T)) %V$T \n"

ASK
unpackb (UCV,"I4",T)

<<"$(Caz(T)) %V$T \n"

ASK

float F2[20];

F= vgen(FLOAT_,4,-4,1)
 
packb (UCV2,"F3",F)

unpackb (UCV2,"F3",F2)

<<"%V F2  $(Caz(F2))\n"

ASK
<<"///////////\n"

<<"$I\n"


<<"T: $T\n"

<<"F2: $F2\n"

double D[];

  <<"$i2 $f2 $l2\n"

  //packv(D,i2,f2,l2)

<<"$D \n"

ASK

chkOut()
