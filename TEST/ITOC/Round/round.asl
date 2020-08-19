//%*********************************************** 
//*  @script round.asl 
//* 
//*  @comment test Round function 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Thu Jan 17 10:59:36 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug.asl"

debugON();

chkIn()

double f= atan(1.0) * 4.0


i = Round(f);


<<"%V $f $i  $(typeof(i)) \n"

chkN(i,3)
f +=0.5

i = Round(f);


<<"%V $f $i  $(typeof(i)) \n"

chkN(i,4)






int k = 80

sz= Caz(k)

b = Cab(k)
<<"$k $sz b $b \n"

int K[3] = {1,2,3}

sz = Caz(K)

<<"$K $sz\n"

b = Cab(K)

<<"$K $b\n"

int I[3][4]

b = Cab(I)
sz = Caz(I)
<<"b $b \n"
<<" $sz\n"






 f = -1.1

  for (j = 0; j < 30; j++) {
  k = f
  t = trunc(f)
  r = round(f)
  flr = floor(f)
  c = ceil(f)

<<"%V$j $k %4.2f $t $r $flr $c $f\n"
   f += 0.05

  }


F= vgen(FLOAT_,20,0,0.25)

<<"%4.2f $F\n"

R= round(F)

<<"%4.2f $R\n"

chkR(R[1],0)
chkR(R[2],1)
chkR(R[3],1)
chkR(R[6],2)

chkOut();

exit()