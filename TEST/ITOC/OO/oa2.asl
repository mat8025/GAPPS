//%*********************************************** 
//*  @script oa2.asl 
//* 
//*  @comment test object array 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.49 C-He-In]                              
//*  @date Thu May 21 08:59:16 2020 
//*  @cdate Tue Apr 28 19:55:01 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



<|Use_=
  demo some OO syntax/ops
|>


#include "debug"


if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   

}

allowErrors(-1)

   


chkIn(_dblevel)

int i = 0;



//<<" $(i->info()) \n"  // TBF recurses 

 i->pinfo()

chkN(i,0);

<<"$i \n"

 iv2 = i<-info();

<<"$iv2 \n"

<<" i $i $(IDof(&i)) \n"

IV = vgen(INT_,10,0,1);

 iv2 = IV<-info();

<<"$iv2 \n"

  IV[5] = 47;

 iv2 = IV<-info();

<<"$iv2 \n"

 ivec = IV<-isvector();

 <<"%v $ivec\n"

 

<<"is IV vec?  $(IV->isvector()) \n" // TBF vmf in paramexp print fails!!



vid = i<-varid()

//FIXME <<" $vid $(i->vid())\n"
<<" $vid \n"

float F[10]

chkT(1)

////////////////////////////////////////////////////////////

proc Pset( svar s)
{
<<"proc $_proc   $s \n"  
      s<-info(1)
   <<"$s[1] : $s[2]\n"
      val = s[1]
      <<"%V $val\n"
      val1 = SV[1]
      <<"%V $val1\n"
      return val;
}



///////////////////////////////////////////////////////////
int Act_ocnt = 0;

class Act {

 public:

 int otype;
 int mins; 
 int t;
 int id;
 svar svtype;
 str stype;
 int a_day;
 //===================//
 cmf Set(int k)
 {
     <<"Act_Set INT  $_cobj k $k\n" 
     <<"%V$otype\n"
     otype = k;
     //otype->info(1);
     otype<-pinfo();
     return otype;
 }
 
 cmf Set(svar sa)
 {
     <<"Act Set svar $_cobj \n"
      sa<-pinfo()
      svtype = sa;
   <<"$sa[1] : $sa[2]\n"
      val = sa[1]
      <<"%V $val\n"
      //val1 = SV[1]
      cval1 = SV[1]
      <<"%V $cval1\n"

     <<"stype  $sa $svtype\n"
     return svtype;
 }

 cmf Set(str sr)
 {
     <<"Act Set  str $_cobj \n" 
      stype = sr;
       sr<-pinfo()
     <<"stype  $sr $stype\n"
     return stype;
 }

 cmf Get()
 {
 <<"$_proc  Get %V $otype\n"
     otype<-info(1)

   return otype;
 }
 
 cmf GetWD()
 {
 <<"$_proc  GetWD\n"


   a_day<-info(1)
<<"getting  $a_day\n"
   return a_day;
 }

 cmf Act() 
 {
// FIXME   <<"cons of Act $_cobj $(_cobj->obid())  $(IDof(&_cobj))\n" 
//   co = _cobj->offset()

   id= Act_ocnt++ ;
 
   otype = 1;

   mins = 10;

   t = 0;
   a_day = Act_ocnt;
   a_day<-info(1)
 //<<"Act cons of $_cobj $id $Act_ocnt %V $a_day $mins $otype\n"

 }

}
//================================

Act a;

    a<-info(1)
    a->otype = 2;
<<"%V$a->otype \n"
    a->otype = 3;
<<"%V$a->otype \n"

    at=a->Set(7);

<<"%V $at $a->otype \n"

  chkN(at,7)


   

 int od = 33;

    at=a->Set(od);
    
<<"%V $at $a->otype \n"

  chkN(at,33)


 obid = a->ObjID();

 <<"%V $obid  \n"



 od=a->GetWD()

<<"%V $od\n"




  chkN(od,1)

//chkOut()

chkStage(" Simple Obj reference")

 Act X[7];

 <<"%V $Act_ocnt \n"

 X<-info(1)

od=X[2]->GetWD()

<<"X[2] %V $od\n"
chkN(od,4)



od=X[3]->GetWD()

<<"X[3] %V $od\n"
chkN(od,5)

X<-info(1)



m2 = 2
od = 34;
at = X[m2]->Set(od)

chkN(at,od)

//chkOut()

chkStage(" Array Obj reference")

str S = "hey how are you"

 rstr =  X[m2]->Set(S)

<<"%V $rstr \n"

chkStr(rstr,S);


//chkOut();


//svar SV;

SV = split("estoy bien y tu")

<<"$SV[0] $SV[1] $SV[2] $SV[3] \n"

val = SV[0]
<<"$val\n"

val = SV[1]
<<"$val\n"

val = SV[3]
<<"$val\n"

svar SV2
SV2="estoy bien y tu"

SV2<-split()

<<"$SV2[0]  $SV2[3] \n"

val2 = SV2[0]
<<"$val2\n"

val2 = SV2[1]
<<"$val2\n"

val2 = SV2[3]
<<"$val2\n"

 sv = Pset(SV)

<<"%V $sv \n"

 sv =  a->Set(SV)

<<"%V $sv \n"



 X[m2]->Set(SV)

<<"%V $X[m2]->stype \n"



  obid = X[1]->ObjID(); // TBF fails crashes ?

<<"X[1] $obid \n"


  obid = X[0]->ObjID(); // TBF fails crashes ?

<<"X[0] $obid \n"
 X<-info(1)

chkStage(" Svar Mbr reference")

 Act B;
 Act C;

 <<" B $(IDof(&B)) \n"

  obid = B->ObjID()
 

 vid = B->varid()




// <<"%V$obid $(b->vid\(\))\n"

<<"%V$obid $vid\n"
int bs = 5;

  B->Set(bs)

  br= B->Get()

<<"$br $bs\n"

chkN(br,bs)


B->Set(71)

br= B->Get()

<<"$br \n"

chkN(br,71)


 B->otype = 7

<<"%V$B->otype \n"

 obid = C->ObjID()



<<"%V$obid \n"



 xobid = X[2]->objid();

 <<"%V$xobid \n"

 yrt = X[3]->Set(7)

 yt = X[3]->otype;

<<"type %V$yrt $yt\n"

  X[3]->otype = 66

 yt = X[3]->otype;

 chkN(yt,66);

<<"type %V$yrt $yt\n"


 yrt2 = X[2]->Set(8)
 yt2 = X[2]->otype

<<"type %V$yrt $yt $yrt2 $yt2\n"

chkStage(" Simple Get/Set")


/*
//  cmf to run over subscript of object array !!
 X[0:2]->Set(4)
 yt = X[1]->type
<<"type $yt \n"
*/


<<"\n//////////////// Direct Set-Get /////////////////\n"
 pass = 1

 X[0]->otype = 50
 X[1]->otype = 79
 X[2]->otype = 47
 X[3]->otype = 80;

 
 yt = X[2]->otype

<<"47? type for 2 $yt $(typeof(yt)) \n"

 chkN(yt,47);
  X<-info(1)


 yt = X[3]->otype;

<<"80? type for X[3] $yt \n"

 chkN(yt,80);
  
 yt = X[0]->otype

<<"type for 0 $yt \n"

 chkN(yt,50);


 yt = X[1]->otype
<<"type for 1 $yt = 79 ?\n"

 chkN(yt,79) ;



 yt = X[2]->otype
<<"otype for 2 $yt = 47 ?\n"

 chkN(yt,47) 

 i = 3
 X[i]->otype = 90
 yt = X[i]->otype

<<"otype for $i $yt = 90 ?\n"

 chkN(yt,90)


// numberstring
//  num_type = num-str   - allow with warning?
// val = 50
//!p val


 ival = 50;
 
 i = 2
 X[i]->otype = ival
 yt = X[i]->otype

  chkN(yt,ival)

<<"otype for $i $yt = $val ?\n"

 for (i = 0; i < 4; i++) {
  X[i]->otype = ival
  yt = X[i]->otype

<<"otype for $i $yt = $val ?\n"

  if (yt != ival) {
  pass = 0
  }

  ival++
 }


 <<" $yt $(typeof(yt)) \n"

<<"PASS? $pass \n"

 chkStage(" Array Direct Get/Set")


<<"\n//////////////// cmf Set-Get /////////////////\n"


 pass = 1

 m = 4
 m2 =3
 X<-info(1)

 yst =  X[2]->Set(m)

 <<"%V $yst\n"
 
!i yst

 
 yst =  X[3]->Set(m2)
 
!i yst

 

 yst =  X[m2]->Set(m2)

<<"%V $yst\n"



 i = 2

 yt  =  X[i]->otype

 ygt =  X[i]->Get()

<<"2 otype %V $yst $yt $ygt\n"


  chkN(yst,3)

 j = 66;
 for (i = 0; i < 4; i++) {

   yst =  X[i]->Set(j)
   yt = X[i]->otype
   ygt =  X[i]->Get()
<<"otype for $i $yst $yt $ygt $j\n"
   if (yt != ygt) { 
      pass = 0
   }
   chkN(ygt,j);
   j++;

 }

 j = 7;
 i = 4
 yst =  X[i]->Set(j)
 yt  =  X[i]->otype
 ygt =  X[i]->Get()

 if (yt != 7) {
    pass = 0
 }

<<"3 otype %V$yst $yt $ygt\n"

pass1= chkN(yst,7)


<<"$yst $(typeof(yst)) \n"

<<" PASS? $pass $pass1\n"

i = 3
yst =  X[i]->Set(8)
 yt  =  X[i]->otype
 ygt =  X[i]->Get()

 if (yt != 8) {
    pass = 0
 }

<<"3 type %V$yst $yt $ygt\n"

pass1= chkN(yst,8)


<<"$yst $(typeof(yst)) \n"

<<" PASS? $pass $pass1\n"



for (i = 5; i >= 0; i--) {

   yt = X[i]->otype
   ygt =  X[i]->Get()
<<"type for $i  $yt $ygt \n"

}



 X[0]->otype = 2;

 yt = X[0]->otype;

 <<"%V$yt  $X[0]->otype \n"

  chkN(yt,2)

 X[2]->otype = 28

 yt2 =  X[2]->otype

 <<"%V$yt2  $X[2]->otype \n"

  chkN(yt2,28)

    X[1]->otype = 79

    yt1 =  X[1]->otype

 <<"%V$yt1  $X[1]->otype \n"

  chkN(yt1,79)

  yt = X[0]->otype
 
  <<"%V$yt  $X[0]->otype \n"

   chkN(yt,2)

   yt = X[1]->otype
   <<"%V  $yt  $X[1]->otype \n"
   yt = X[2]->otype
   <<"%V  $yt  $X[2]->otype \n"

   chkN(yt,28)

 for ( i = 0; i < 4; i++) { 
   yt = X[i]->otype
   <<"%V $i $yt  $X[i]->otype \n"
 }

   yt = X[1]->otype
   <<"%V  $yt  $X[1]->otype \n"




//////////////////////   do this in separate test module ////////////


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

 Act A[10] ;
// FIXME each cons of A tacks on anotherstatement ??
//


 //Act A[10];
 cmf Get()
 {
 <<"$_proc  \n"
   w_day<-info(1)
<<"getting w_day $w_day\n"
   return w_day;
 }

 cmf Dil() 
 {
   dil_ocnt++ 
   w_day = dil_ocnt;
  <<"cons of Dil $_cobj $w_day $dil_ocnt\n"
    w_day<-info(1)
}

}
//=========================//




<<" after class def Dil \n"

<<" attempting Dil E \n"


 Dil E 

<<"%V $dil_ocnt \n"
 E<-info(1)

 od =E->Get();
<<"E->w_day $od  $E->w_day\n"
 od<-info(1)

//E->w_day<-info(1);  // broke

chkN(od,1)




Dil H[2];

<<" after class def Dil H[2] \n"
<<"%V $dil_ocnt \n"

H<-info(1)

od = H[1]->Get();

<<"%V $od\n"

 chkN(od,3)



//  FIXME ---- not going to first following statement in E has nested class!!





 x  = 52 * 2000
 y =   2 * 2
<<" %V $y $x\n"




syt = 80 //


//int gyt
<<"nested class setting direct reference %V $syt \n"

   E->B->t = syt;

<<"%V $E->B->t \n"

   tys = E->B->t;

<<"%V $syt  $tys \n"


 chkN(syt,tys);

//chkOut()





 gyt = E->B->t;

<<" $gyt $(typeof(gyt)) \n"


  chkN(gyt,80)

<<"nested class getting direct reference %V $gyt \n"

syt = 60; //

<<"nested class setting direct reference %V $syt \n"

 E->B->t = syt

 gyt = E->B->t

<<"nested class getting direct reference %V $gyt \n"

k = 3;
   chkN(gyt,60)



 E->A[0]->t = 28;


 t1 = E->A[0]->t;

<<"$t1\n"
<<"%V $E->A[0]->t \n"



 E->A[1]->t = 92;

 E->A[k]->t = 72;

 t1 = E->A[k]->t;

<<"%V $k $t1\n"
<<"%V $E->A[0]->t \n"

chkN(t1,72);



 yt0 = E->A[0]->t

<<"%V $yt0 \n"



 yt1 = E->A[1]->t;

<<"%V $yt1 \n"

 yt3 = E->A[3]->t

<<"%V $yt3 \n"

chkN(yt3,72);





 E->A[1]->t = 29;
 E->A[2]->t = 92;
 E->A[3]->t = 75;

 yt0 = E->A[0]->t

<<"%V $E->A[0]->t \n"

<<"%V $yt0 \n"


 chkN(yt0,28);



 yt1 = E->A[1]->t

<<"%V $yt1 \n"

 chkN(yt1,29)

//chkOut()

 yt2 = E->A[2]->t

<<"%V $yt2 \n"

 chkN(yt2,92)




// FIX crash -- xic generation?

 yt3 = E->A[3]->t

<<"%V $yt3 \n"

 chkN(yt3,75)

 //checkProgress()
// exit()

  j = 2

 yt = E->A[j]->t

<<" [${j}] $yt \n"

<<"\n"


 chkN(yt,92)




 for (j = 0; j < 4 ; j++) {

    yt = E->A[j]->t
    <<" [${j}] $yt \n"
 }

<<"\n"


yt = E->A[3]->t;

chkN(yt,75);





 for (j = 0; j < 10 ; j++) {

    E->A[j]->t = 50 + j;

}

<<"\n"




 for (j = 0; j < 10 ; j++) {

    yt = E->A[j]->t;
    <<" [${j}] $yt \n"
 }

 chkN(yt,59)



//iread()

yt2 = E->A[2]->t

<<"%V $yt2 \n"

yt1 = E->A[1]->t

<<"%V $yt1 \n"

j = 3
 yt3 = E->A[j]->t

<<"%V $yt3 \n"

 yt3 = E->A[3]->t

<<"bug? %V $yt3 \n"



 yt4 = E->A[4]->t

<<"?%V $yt4 \n"


 yt8 = E->A[8]->t

<<"%V $yt8 \n"
 chkN(yt8,58)



///  Needs XIC FIX
<<"///////////////G[i]->A[j]->otype////////////////////////////\n"


//////////////////////////////////////////////////////////////////

xov = 20
Dil G[10]

<<"FIRST $(xov--) \n"

 chkN(xov,19)


 G[0]->A[0]->t = 60
 G[1]->A[1]->t = 18
 G[2]->A[2]->t = 33

   yt0 = G[0]->A[0]->t

<<"%V $yt0 \n"

  chkN(yt0,60)



   yt1 = G[1]->A[1]->t

<<"%V$yt1 \n"

   chkN(yt1,18)

   yt2 = G[2]->A[2]->t

<<"%V$yt2 \n"

   chkN(yt2,33)

//chkOut() 
 i = 0 ; j = 1;

  G[i]->A[j]->t = 53

  yt = G[i]->A[j]->t 

<<"%V$yt \n"


  chkN(yt,53)

  k = 7

      yt = G[i]->A[j]->t 
<<"[${i}] [$j ] %V $k $yt \n"
      k++




  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      G[i]->A[j]->t = k

      yt = G[i]->A[j]->t 
<<" [${i}] [${j}] %V $k $yt \n"
      k++

   }

  }

<<"\n"
chkOut()


  k = 7
  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      yt = G[i]->A[j]->t 
      <<" $i $j $yt \n"
       chkN(yt,k)
       k++
   }

  }






ndiy = 10;


Dil Yod[ndiy]



<<"///////////  VMF /////////////////////\n"

 obid = X[0]->obid()

 <<"%V X[0] $obid \n"




 obid = X[1]->obid()
 <<"%V 1 $obid \n"

 obid = X[3]->obid()
 <<"%V 3 $obid \n"

 i = 2

 obid = X[i]->obid()
 <<"%V $i $obid \n"


 yrt = X[0]->Set(7)
<<"otype for 0 $yrt \n"
 yrt = X[2]->Set(4)
<<"otype for 2 $yrt \n"
 yrt = X[3]->Set(5)
<<"otype for 3 $yrt \n"

 yrt = X[1]->Set(6)
<<"otype for 1 $yrt \n"



Dil D[3]

<<" done dec of D \n"

chkOut();

exit()



//////////////////////////  TBD //////////////////////////////////////
/*

						       RDP	XIC
1. Direct Set & Get   - Simple Class                 - OK      OK
2. cmf Set & Get      - Simple Class                 - OK      OK
3. VMF
4. Direct Set & Get   - Object arrays                - OK      OK  
5. cmf Set & Get      - Object arrays                - OK      OK
6. Direct Set & Get   - Nested Class                   OK      OK
7. Direct Set & Get   - Nested Object Arrays	       OK      OK 
8. Set & Get          - MH




FIX  --- nested class  --- each object cons pushes exit statement by one
FIX  --- nested class  







*/
//////////////////////////////////////////////////////////////////////