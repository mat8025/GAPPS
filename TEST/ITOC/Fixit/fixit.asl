

////
chkIn(_dblevel)


svar S = "get this right"

S->info(1)

<<"$S \n"

<<"$S[0] \n"
S[1] = " looks Ok to me"
S->info(1)
<<"$S[1] \n"
exit()






 int MD[3][4];

MD->info(1)

 MD[2][3] = 77;

<<"$MD \n"


MD->info(1)

ev =  MD[2][3];


chkN(ev,77)



chkOut()





/{/*

VD = vgen (DOUBLE_,10, 0, 1);

<<"%V6.2f $VD \n";


Float = vgen (DOUBLE_,10, 0, 1);

<<"%V6.2f $Float \n";

Real = vgen (DOUBLE_,10, 0, 1);

<<"%V6.2f $Real \n";

exit()



proc array_sub(float rl[])
{

float t1;

<<"In $_proc\n";
//<<"$rl \n";
t1->info(1)
t1 = rl[4]; 

<<"%6.2f%V$t1\n";
t1->info(1)
chkR(t1,4.0);

}



Real1 = vgen(FLOAT_,10,0,1)
<<"%V$Real1\n"

float mt1;

  mt1 = Real1[3];
chkR(mt1,3)
<<"%V $mt1 \n"


val = array_sub(Real1)





chkOut()
exit()

 A=ofr("wex2020.tsv")

 
if (A == -1) {
<<"FILE not found \n"
  exitsi();
}


// check period

int Vec[]

Vec->info(1)

Vec[20] = 67;

Vec->info(1)

Record RX[];

RX->info(1)


RX=readrecord(A,@del,-1)

Nrecs = Caz(RX);

<<"%V $Nrecs RX[0] \n $(Caz(RX))  $(Caz(RX,0)) \n"

exit()


int  a = 1;

<<"%V $a\n"

a->info(1)

int b;

<<"$b \n"

b->info(1)


c = b;

c->info(1)

int Vec[10];


<<"$Vec \n"



exit()

Gevent Ev2;

Ev2->info(1)

 _b = 2;


<<"%V $_b\n"

  c = _b

<<"%V $c\n"


include "gevent"


Ev->info(1)

int _eloop2 = 0;

<<"%V $_eloop\n"

_eloop2 = 4


<<"%V $_eloop2\n"



//======================================//




int AV[10]

AV->info(1)


int BV[]

BV->info(1)




int CV[>10]




CV->info(1)



for (i=0; i< 12; i++) {
  CV[i] = i
}

CV->info(1)
n= 0;


for (i=0; i< 12; i++) {

  n += CV[i]
  <<"<$i> $n\n"

}


Col = vgen(INT_,10,0,1)

<<"$Col \n"

  day = Col[0];


  day2 = Col[2];

<<"%V $day $day2\n"




chkOut()

/}*/