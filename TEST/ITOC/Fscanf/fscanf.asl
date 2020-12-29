//%*********************************************** 
//*  @script fscanf.asl 
//* 
//*  @comment test fscanf 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Mar 31 12:33:13 2019 
//*  @cdate Sun Mar 31 12:33:13 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



#include "debug.asl"


debugON();

chkIn();
A=ofw("txt.dat")

<<[A]"1 2 3 3.142 -6.123 -123456789 123456789\n"

cf(A);


A= ofr("txt.dat")

char c

int i

short s

float f

double d = 79.65432;

long l;

ulong ul;


fscanf(A,'%d %d %d %f %lf %ld %ld',&c,&i,&s,&f,&d,&l,&ul)

<<"%V$c $i $s $f $d $l $ul\n" 

c->info(1)
i->info(1)
s->info(1)
f->info(1)
d->info(1)
l->info(1)
ul->info(1)


chkN(c,1)

chkN(i,2)

chkN(s,3)


chkR(f,3.142)

chkR(d,-6.123)

chkN(l,-123456789)

chkN(ul,123456789)

chkOut()
