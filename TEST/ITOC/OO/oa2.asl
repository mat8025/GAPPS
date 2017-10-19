///
/// oa2
///


setDebug(1,"~trace","pline","~step")

//#define  ASK ans=iread();
#define  ASK ;

CheckIn(0)

int i = 0

<<" i $i $(IDof(&i)) \n"

vid = i->vid()

//FIXME <<" $vid $(i->vid())\n"
<<" $vid \n"

float F[10]

vid = F->vid()

<<" $vid \n"

vid = F[2]->vid()

<<" $vid \n"

int act_ocnt = 0

class Act {

 public:

 int type;
 int mins; 
 int t;

 CMF Set(s)
 {
     obid = _cobj->obid()
//     <<"Act Set  $_cobj  $obid $(offsetof(&_cobj)) $(IDof(&_cobj))\n" 
     <<"Act Set  $_cobj \n" 
      type = s
     <<"type  $s $type\n"
     return type
 }

 CMF Get()
 {
   return type;
 }

 CMF Act() 
 {
// FIXME   <<"cons of Act $_cobj $(_cobj->obid())  $(IDof(&_cobj))\n" 
//   co = _cobj->offset()
//   <<"cons of Act $_cobj   $(IDof(&_cobj)) $(offsetof(&_cobj)) co $co\n" 
   //<<"Act cons of $_cobj $act_ocnt\n"
   act_ocnt++

   type = 1

   mins = 10;

   t = 0;
 }

};
//================================

Act a;

    a->type = 2
<<"%V$a->type \n"
    a->type = 3
<<"%V$a->type \n"
    a->Set(5)
<<"%V$a->type \n"


 vid = a->vid()
<<"%V$vid \n"

  <<"%V$a->type \n"

// FIXME <<" a $(IDof(&a)) $(a->obid())\n"


 obid = a->obid()

 <<" a $(IDof(&a)) obid $obid \n"

ASK

 Act b;
 Act c;

 <<" b $(IDof(&b)) \n"

 obid = b->obid()
 vid = b->vid()

// <<"%V$obid $(b->vid\(\))\n"

<<"%V$obid $vid\n"
 b->Set(5)

 b->type = 7

<<"%V$b->type \n"

 obid = c->obid()

 vid = c->vid()

<<"%V$obid $vid\n"

 Act X[4];

 xobid = X[2]->obid();

 <<"%V$xobid \n"

 yrt = X[3]->Set(7)

 yt = X[3]->type

<<"type %V$yrt $yt\n"

  X[3]->type = 66

 yt = X[3]->type

<<"type %V$yrt $yt\n"


 yrt2 = X[2]->Set(8)
 yt2 = X[2]->type

<<"type %V$yrt $yt $yrt2 $yt2\n"




/{
//  cmf to run over subscript of object array !!
 X[0:2]->Set(4)
 yt = X[1]->type
<<"type $yt \n"
/}


<<"\n//////////////// Direct Set-Get /////////////////\n"
 pass = 1

 X[0]->type = 50
 X[1]->type = 79
 X[2]->type = 47
 X[3]->type = 80


 yt = X[2]->type

<<"type for 2 $yt $(typeof(yt)) \n"


 CheckNum(yt,47)
 

 yt = X[3]->type
<<"type for 3 $yt \n"

 CheckNum(yt,80)
  

 yt = X[0]->type

<<"type for 0 $yt \n"

 CheckNum(yt,50)


 yt = X[1]->type
<<"type for 1 $yt = 79 ?\n"

 CheckNum(yt,79) 



 yt = X[2]->type
<<"type for 2 $yt = 47 ?\n"

 CheckNum(yt,47) 

 i = 3
 X[i]->type = 90
 yt = X[i]->type

<<"type for $i $yt = 90 ?\n"

  if (yt != 90) {
     pass = 0
  }

ASK

 val = 50
 i = 2
 X[i]->type = val
 yt = X[i]->type
  if (yt != val) {
  pass = 0
  }

<<"type for $i $yt = $val ?\n"

 for (i = 0; i < 4; i++) {
  X[i]->type = val
  yt = X[i]->type

<<"type for $i $yt = $val ?\n"

  if (yt != val) {
  pass = 0
  }

  val++
 }


 <<" $yt $(typeof(yt)) \n"

<<"PASS? $pass \n"

ASK

<<"\n//////////////// CMF Set-Get /////////////////\n"


 pass = 1

 yst =  X[2]->Set(4)
 yst =  X[3]->Set(5)

 i = 2
 yt  =  X[i]->type

 ygt =  X[i]->Get()

<<"2 type %V $yst $yt $ygt\n"


  CheckNum(yst,5)


 for (i = 0; i < 4; i++) {

   yst =  X[i]->Set(66)
   yt = X[i]->type
   ygt =  X[i]->Get()
<<"type for $i $yst $yt $ygt\n"
   if (yt != ygt) { 
      pass = 0
   }

 }


 yst =  X[3]->Set(7)
 yt  =  X[3]->type
 ygt =  X[3]->Get()

 if (yt != 7) {
    pass = 0
 }

<<"3 type %V$yst $yt $ygt\n"

 CheckNum(yst,7)


<<"$yst $(typeof(yst)) \n"

<<" PASS? $pass \n"



 X[0]->type = 2

 yt = X[0]->type

 <<"%V$yt  $X[0]->type \n"

  CheckNum(yt,2)

 X[2]->type = 28

 yt2 =  X[2]->type

 <<"%V$yt2  $X[2]->type \n"

  CheckNum(yt2,28)

    X[1]->type = 79

    yt1 =  X[1]->type

 <<"%V$yt1  $X[1]->type \n"

  CheckNum(yt1,79)

  yt = X[0]->type
 
  <<"%V$yt  $X[0]->type \n"

   CheckNum(yt,2)

   yt = X[1]->type
   <<"%V  $yt  $X[1]->type \n"
   yt = X[2]->type
   <<"%V  $yt  $X[2]->type \n"

   CheckNum(yt,28)

 for ( i = 0; i < 4; i++) { 
   yt = X[i]->type
   <<"%V $i $yt  $X[i]->type \n"
 }

   yt = X[1]->type
   <<"%V  $yt  $X[1]->type \n"


ASK

<<"/////////////////// Nested Class /////////////\n"

int dil_ocnt = 0

class Dil {

 public:
 int w_day;

// Act A[3] ;
// FIXME each cons of A tacks on anotherstatement ??
//

 Act B;
 Act A[10];

 CMF Dil() 
 {
   w_day = 1
  // <<"cons of Dil $_cobj $w_day $dil_ocnt\n"
   dil_ocnt++ 
 }

}

xov = 20

<<" after class def \n"


Dil H[2]


<<"FIRST H[2] $(xov--) \n"
 CheckNum(xov,19)
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<" after H[2] \n"




<<" attempting Dil E \n"
xov = 20

Dil E

<<"FIRST E $(xov--) \n"

 CheckNum(xov,19)
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"

//  FIXME ---- not going to first following statement in E has nested class!!

 x  = 52 * 2000
 y =   2 * 2
<<" %V $y $x\n"




syt = 80 //


//int gyt
<<"nested class setting direct reference %V $syt \n"

   E->B->t = syt;

<<"%V $E->B->t \n"

 gyt = E->B->t;

<<" $gyt $(typeof(gyt)) \n"


  CheckNum(gyt,80)

<<"nested class getting direct reference %V $gyt \n"

syt = 60; //

<<"nested class setting direct reference %V $syt \n"

 E->B->t = syt

 gyt = E->B->t

<<"nested class getting direct reference %V $gyt \n"

k = 3
   CheckNum(gyt,60)

 E->A[0]->t = 28;

ASK

 t1 = E->A[0]->t;

<<"$t1\n"

ASK


 E->A[1]->t = 92;

 E->A[k]->t = 72;

 t1 = E->A[k]->t;

<<"$t1\n"

ASK

 yt0 = E->A[0]->t

<<"%V $yt0 \n"



 yt1 = E->A[1]->t;

<<"%V $yt1 \n"

 yt3 = E->A[3]->t

<<"%V $yt3 \n"

ASK

 E->A[1]->t = 29;
 E->A[2]->t = 92;
 E->A[3]->t = 75;

 yt0 = E->A[0]->t

<<"%V $yt0 \n"

ASK

 CheckNum(yt0,28)

 yt1 = E->A[1]->t

<<"%V $yt1 \n"

 CheckNum(yt1,29)

ASK

 yt2 = E->A[2]->t

<<"%V $yt2 \n"

 CheckNum(yt2,92)

ASK

// FIX crash -- xic generation?

 yt3 = E->A[3]->t

<<"%V $yt3 \n"

 CheckNum(yt3,75)

ASK

  j = 2

 yt = E->A[j]->t

<<" [${j}] $yt \n"

<<"\n"

 for (j = 0; j < 4 ; j++) {

    yt = E->A[j]->t
    <<" [${j}] $yt \n"
 }

<<"\n"

 for (j = 0; j < 4 ; j++) {

    E->A[j]->t = 50 + j;
 }

<<"\n"

 E->A[8]->t = 47;

 for (j = 0; j < 4 ; j++) {

    yt = E->A[j]->t;
    <<" [${j}] $yt \n"
 }

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

//iread()

 yt4 = E->A[4]->t

<<"?%V $yt4 \n"


 yt8 = E->A[8]->t

<<"%V $yt8 \n"





<<"///////////////G[i]->A[j]->type////////////////////////////\n"

xov = 20
Dil G[10]

<<"FIRST $(xov--) \n"

 CheckNum(xov,19)


 G[0]->A[0]->t = 60
 G[1]->A[1]->t = 18
 G[2]->A[2]->t = 33

   yt0 = G[0]->A[0]->t

<<"%V $yt0 \n"

  CheckNum(yt0,60)

   yt1 = G[1]->A[1]->t

<<"%V$yt1 \n"

   CheckNum(yt1,18)

   yt2 = G[2]->A[2]->t

<<"%V$yt2 \n"

   CheckNum(yt2,33)


 i = 0 ; j = 1;

  G[i]->A[j]->t = 53

  yt = G[i]->A[j]->t 

<<"%V$yt \n"


  CheckNum(yt,53)

  k = 7




  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      G[i]->A[j]->t = k

      yt = G[i]->A[j]->t 
<<"%V$k $yt \n"
      k++
   }

  }

<<"\n"

  k = 7
  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      yt = G[i]->A[j]->t 
      <<" $i $j $yt \n"
       CheckNum(yt,k)
       k++
   }

  }



ndiy = 365




Dil Yod[ndiy]



<<"///////////  VMF /////////////////////\n"

 obid = X[0]->obid()

 <<"%V 0 $obid \n"

 obid = X[1]->obid()
 <<"%V 1 $obid \n"

 obid = X[3]->obid()
 <<"%V 3 $obid \n"

 i = 2

 obid = X[i]->obid()
 <<"%V $i $obid \n"


 yrt = X[0]->Set(7)
<<"type for 0 $yrt \n"
 yrt = X[2]->Set(4)
<<"type for 2 $yrt \n"
 yrt = X[3]->Set(5)
<<"type for 3 $yrt \n"

 yrt = X[1]->Set(6)
<<"type for 1 $yrt \n"



Dil D[3]

<<" done dec of D \n"

CheckOut();

exit()



//////////////////////////  TBD //////////////////////////////////////
#{

						       RDP	XIC
1. Direct Set & Get   - Simple Class                 - OK      OK
2. CMF Set & Get      - Simple Class                 - OK      OK
3. VMF
4. Direct Set & Get   - Object arrays                - OK      OK  
5. CMF Set & Get      - Object arrays                - OK      OK
6. Direct Set & Get   - Nested Class                   OK      OK
7. Direct Set & Get   - Nested Object Arrays	       OK      OK 
8. Set & Get          - MH




FIX  --- nested class  --- each object cons pushes exit statement by one
FIX  --- nested class  







#}
//////////////////////////////////////////////////////////////////////