//%*********************************************** 
//*  @script class_array.asl 
//* 
//*  @comment check array assignment within object 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                             
//*  @date Fri May 22 16:46:03 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
#include "debug"


//debugON()

allowErrors(-1)

chkIn (_dblevel); 

uint SC = 50;
uint OC = 1;  // object counter

MIV= vgen(INT_,30,0,1)


 MIV[7] = 3;

int km = 12;

int km2 = 14;
 MIV[km] = 78;

 MIV[km2] = 79;
<<"$MIV\n"

MIV.pinfo();


chkN(MIV[7],3)
chkN(MIV[km],78)


MIV[0:12] = -16


MIV.pinfo();






class Dil {

public:
 int type;
 int n_actv;
 int IV[30];
 int id;

 void Print(int wa) 
 {
   k = IV[wa]
   <<"$wa $k \n"
 }
 
int Set(int s)
 {
     <<"$_cobj $s\n" 
     <<"%V$type\n"
     type = s;
     type.pinfo();
     return type;
 }
 
 int Get()
 {
 <<"$_proc  Get\n"
//!i type
<<"getting type $type\n"
   return type;
 }


 void Set(int wi, int val)
 {
    <<"%V $wi $val\n"
  // <<"$IV[::] \n"
      IV[wi] = val;
  // <<"$IV[::] \n" 
 }

 void showIV()
  {
//mas = memaddr(&I[0])

 <<"%V$_cobj \n"

// <<"memcpy to %u $mad from $mas #bytes $nbytes\n"
//   memcpy(mad, mas, nbytes)
     IV.pinfo()
//<<"%V $IV[::] \n"

<<"%V $IV[8]\n"
 
  }

 cmf Dil() 
 {
 <<"Starting cons \n"
     id = OC;

     OC++;

    type.pinfo();
n_actv.pinfo()

IV.pinfo()

 IV[0:12] = 1;

IV.pinfo()


<<"%V$I \n"
     <<"cons for $_cobj  $id \n"

   //  IV[23] = SC++ ;

    SC++;

     IV[23] = SC;
  

     k = IV[0];

<<"%V$k \n"

    IV[1] = 28;

 <<"%V$I \n" 

     k = IV[0];

<<"%V$k \n"
 <<"Done cons \n"
 
 }

}
//------------------------------------------------

int agv =8;

agv.pinfo();

Dil E;

E.pinfo()

   E->showIV();

  E->Set(5)



nbytes = 10 * 4

<<"%V$nbytes \n"



<<"%V$OC\n"



char C[1024];

C[0] = 1;
 <<" $C[0:10]\n"







Dil D;

<<" after cons\n"
  D->showIV();



  D->Set(5,32)
  
<<" after set\n"
  D->showIV();

<<" done dec of D\n"



  D->Print(5);

  D->showIV()

  k = D->IV[5];
   
<<" trying %V $k $D->IV[5]  \n"

  E->showIV();
  D->showIV()



   D->IV[5] = 33;

   D->IV[6] = 1634;
   
   k = D->IV[5]

<<" after set D->IV[5] = 33 $k\n"

  D->IV[9] = 78;

<<"%V $D->IV[9]  78? \n"
  D->showIV()


  E->IV[9] = 93;

<<"%V $E->IV[9]  93? \n"

  E->IV[8] = 79

<<"%V $E->IV[8]  79? \n"

  vi = E->IV[8];


<<"%V $vi = 79? \n"
<<"%V $E->IV[9] \n"


 chkN (E->IV[9],93);


  D->Set(8,47)

<<" show D \n"




  D->IV[2] =79;


  D->showIV()

chkN (D->IV[2],79);



  E->showIV()

  D->showIV()

  D->IV[4] =80;

  D->showIV()

  E->IV[2] = 16

  E->showIV()

  D->Set(8,47)

  D->showIV()

  chkN (D->IV[8],47)

  val = D->IV[8]

  D->Set(67)
<<"%V $val\n"
   val = D->Get()



<<"Got $val\n"



Dil X[5];

X[3]->Set(5)

 val = X[3]->Get()

<<"Got $val\n"

  chkN (val,5 )



j= 2
j.pinfo()
k= 44;

 X[j]->Set(k)

 val = X[j]->Get()

<<"Got $val\n"

 chkN (val,44)


 X[j]->Set(89)

 val = X[j]->Get()

<<"Got $val\n"

 chkN (val,89)

sval = 92

X[j]->Set(sval)

val = X[j]->Get()

<<"Got $val\n"

chkN (val,sval


chkOut ()





