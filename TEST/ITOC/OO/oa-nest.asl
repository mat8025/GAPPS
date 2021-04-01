//%*********************************************** 
//*  @script oa-nest.asl 
//* 
//*  @comment test object array nested 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.49 C-He-In]                              
//*  @date Thu May 21 08:59:16 2020 
//*  @cdate Tue Apr 28 19:55:01 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug"


if (_dblevel >0) {
   debugON()
}


   


chkIn(_dblevel)

///////////////////////////////////////////////////////////
int Act_ocnt = 0;



class Act {

 public:

 int type;
 int mins; 
 int t;
 int id;
 svar svtype;
 str stype;
 int a_day;
 //===================//
 cmf Set(int k)
 {
     <<"Act_Set INT  $_cobj $k\n" 
     <<"%V$type\n"
    type = k;


     type->info(1);
     return type;
 }
 
 cmf Set(svar sa)
 {
     <<"Act Set svar $_cobj \n"
      sa->info(1)
      svtype = sa;
   <<"$sa[1] : $sa[2]\n"
      val = sa[1]
      <<"%V $val\n"
      cval1 = SV[1]
      <<"%V $cval1\n"

     <<"stype  $sa $svtype\n"
     return svtype;
 }

 cmf Set(str sr)
 {
     <<"Act Set  str $_cobj \n" 
      stype = sr;
       sr->info(1)
     <<"stype  $sr $stype\n"
     return stype;
 }

 cmf Get()
 {
 <<"$_proc  Get %V $type\n"
     type->info(1)

   return type;
 }
 
 cmf GetWD()
 {
 <<"$_proc  GetWD\n"


   a_day->info(1)
<<"getting  $a_day\n"
   return a_day;
 }

 cmf Act() 
 {
   id= Act_ocnt++ ;
 
   type = 1;

   mins = 10;

   t = 0;
   a_day = Act_ocnt;
   a_day->info(1)
 <<"Act cons of $_cobj $id $Act_ocnt %V $a_day $mins $type\n"

 }

}
//================================

Act a;

//!a after Act a
a->info(1)
 <<"%V $Act_ocnt\n"

<<"/////////////////// Nested Class /////////////\n"

int dil_ocnt = 0;

<<"%V $dil_ocnt \n"

class Dil {

 public:
 

 int w_min;
 int w_sec;
 int w_day; 

 Act B;
 /// now an array 

 Act A[2] ;
// FIXME each cons of A tacks on anotherstatement ??
//

 cmf Get()
 {
 <<"$_proc  \n"
   w_day->info(1)
<<"getting w_day $w_day\n"
   return w_day;
 }

 cmf Dil() 
 {
   dil_ocnt++ 
   w_day = dil_ocnt;
  <<"cons of Dil $_cobj $w_day $dil_ocnt\n"
    w_day->info(1);
    B->info(1)
}

}
//=========================//


<<" after class def Dil \n"

<<" attempting Dil E \n"


 Dil E 

<<"%V $dil_ocnt \n"
  E->info(1);

 od =E->Get();
<<"E->w_day $od  $E->w_day\n"
 od->info(1)

//E->w_day->info(1);  // broke

chkN(od,1)


///  Needs XIC FIX
<<"///////////////G[i]->A[j]->type////////////////////////////\n"


//////////////////////////////////////////////////////////////////

xov = 20
Dil G[1]

<<"after Dil G[1]\n"
<<"%V $dil_ocnt \n"
 <<"%V $Act_ocnt\n"


<<"FIRST $(xov--) \n"

 chkN(xov,19)
!a

G[0]->B->t = 60

<<"after G[0]->B->t = 60\n"

!a

ytB = G[0]->B->t

<<"%V$ytB \n"
!a
 chkN(ytB,60)

<<"G[0]->A[0]->t = 44 \n"

G[0]->A[0]->t = 44

!a

yt0 = G[0]->A[0]->t

<<"%V$yt0  \n"

chkN(yt0,44)

chkOut()



<<"%V $yt0 \n"
!a

 G[1]->A[1]->t = 18






 G[2]->A[2]->t = 33
!a

   yt0 = G[0]->A[0]->t

<<"%V $yt0 \n"



   yt1 = G[1]->A[1]->t

<<"%V$yt1 \n"
!a
   chkN(yt1,18)

   yt2 = G[2]->A[2]->t

<<"%V$yt2 \n"

   chkN(yt2,33)

//chkOut() 
 i = 0 ; j = 1;

  G[i]->A[j]->t = 53

  yt = G[i]->A[j]->t 

<<"%V$yt \n"

!a
  chkN(yt,53)

  k = 7

      yt = G[i]->A[j]->t 
<<"[${i}] [$j ] %V $k $yt \n"
      k++
!a

chkOut()

  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      G[i]->A[j]->t = k

      yt = G[i]->A[j]->t 
<<" [${i}] [${j}] %V $k $yt \n"
      k++
!a      
   }

  }

<<"\n"



  k = 7
  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      yt = G[i]->A[j]->t 
      <<" $i $j $yt \n"
       chkN(yt,k)
       k++
   }

  }


chkOut()
//=============================//