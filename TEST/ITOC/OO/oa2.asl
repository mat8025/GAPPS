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




checkIn(_dblevel)

int i = 0;

//<<" $(i->info()) \n"  // TBF recurses 

 iv = info(&i);

<<"$iv \n"

 iv2 = i->info();

<<"$iv2 \n"

<<" i $i $(IDof(&i)) \n"

IV = vgen(INT_,10,0,1);

 iv2 = IV->info();

<<"$iv2 \n"

  IV[5] = 47;

 iv2 = IV->info();

<<"$iv2 \n"

 vec = IV->isvector();

 <<"%v $vec\n"

 //<<" $(IV->isvector()) \n"

// <<" $IV->isvector() \n" // TBF vmf in paramexp print fails!!



vid = i->varid()

//FIXME <<" $vid $(i->vid())\n"
<<" $vid \n"

float F[10]

vid = F->varid()

<<" $vid \n"

vid = F[2]->varid()

<<" $vid \n"

int Act_ocnt = 0;

class Act {

 public:

 int type;
 int mins; 
 int t;
 int id;
 
 cmf Set(int s)
 {
     //obid = _cobj->obid()
//     <<"Act Set  $_cobj  $obid $(offsetof(&_cobj)) $(IDof(&_cobj))\n" 
     <<"Act Set  $_cobj \n" 
      type = s;
     <<"type  $s $type\n"
     return type;
 }

 cmf Get()
 {
   return type;
 }

 cmf Act() 
 {
// FIXME   <<"cons of Act $_cobj $(_cobj->obid())  $(IDof(&_cobj))\n" 
//   co = _cobj->offset()

   id= Act_ocnt++ ;
  <<"Act cons of $_cobj $id $Act_ocnt\n"
   type = 1;

   mins = 10;

   t = 0;
 }

};
//================================

Act a;

    a->type = 2;
<<"%V$a->type \n"
    a->type = 3;
<<"%V$a->type \n"
    a->Set(5);
<<"%V$a->type \n"


a->info(1)


  <<"%V$a->type \n"

// FIXME <<" a $(IDof(&a)) $(a->obid())\n"


 obid = a->objid();
<<"%V $obid  $vid \n"
 a_info = a->info();


<<"$a_info \n"
 <<" a $(IDof(&a))  \n"
<<" $a->info() \n"
<<" %V $obid \n"




 Act X[4];


  obid = X[1]->objid(); // TBF fails crashes ?

<<"X[1] $obid \n"


  obid = X[0]->objid(); // TBF fails crashes ?

<<"X[0] $obid \n"


 Act b;
 Act c;

 <<" b $(IDof(&b)) \n"

  obid = b->objid()
 

  vid = b->varid()




// <<"%V$obid $(b->vid\(\))\n"

<<"%V$obid $vid\n"
 b->Set(5)

 b->type = 7

<<"%V$b->type \n"

 obid = c->objid()

 vid = c->varid()

<<"%V$obid $vid\n"



 xobid = X[2]->objid();

 <<"%V$xobid \n"

 yrt = X[3]->Set(7)

 yt = X[3]->type;

<<"type %V$yrt $yt\n"

  X[3]->type = 66

 yt = X[3]->type;

 checkNum(yt,66);

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
 X[3]->type = 80;

 
 yt = X[2]->type

<<"47? type for 2 $yt $(typeof(yt)) \n"

 checkNum(yt,47);
 

 yt = X[3]->type;

<<"80? type for X[3] $yt \n"

 checkNum(yt,80);
  
 yt = X[0]->type

<<"type for 0 $yt \n"

 checkNum(yt,50);


 yt = X[1]->type
<<"type for 1 $yt = 79 ?\n"

 checkNum(yt,79) ;



 yt = X[2]->type
<<"type for 2 $yt = 47 ?\n"

 checkNum(yt,47) 

 i = 3
 X[i]->type = 90
 yt = X[i]->type

<<"type for $i $yt = 90 ?\n"

  if (yt != 90) {
     pass = 0
  }



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

 


<<"\n//////////////// cmf Set-Get /////////////////\n"


 pass = 1

 yst =  X[2]->Set(4)
 yst =  X[3]->Set(5)

 i = 2

 yt  =  X[i]->type

 ygt =  X[i]->Get()

<<"2 type %V $yst $yt $ygt\n"


  checkNum(yst,5)


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

 checkNum(yst,7)


<<"$yst $(typeof(yst)) \n"

<<" PASS? $pass \n"



 X[0]->type = 2;

 yt = X[0]->type;

 <<"%V$yt  $X[0]->type \n"

  checkNum(yt,2)

 X[2]->type = 28

 yt2 =  X[2]->type

 <<"%V$yt2  $X[2]->type \n"

  checkNum(yt2,28)

    X[1]->type = 79

    yt1 =  X[1]->type

 <<"%V$yt1  $X[1]->type \n"

  checkNum(yt1,79)

  yt = X[0]->type
 
  <<"%V$yt  $X[0]->type \n"

   checkNum(yt,2)

   yt = X[1]->type
   <<"%V  $yt  $X[1]->type \n"
   yt = X[2]->type
   <<"%V  $yt  $X[2]->type \n"

   checkNum(yt,28)

 for ( i = 0; i < 4; i++) { 
   yt = X[i]->type
   <<"%V $i $yt  $X[i]->type \n"
 }

   yt = X[1]->type
   <<"%V  $yt  $X[1]->type \n"




<<"/////////////////// Nested Class /////////////\n"

int dil_ocnt = 0;

class Dil {

 public:
 int w_day;

// Act A[3] ;
// FIXME each cons of A tacks on anotherstatement ??
//

 Act B;
 Act A[10];

 cmf Dil() 
 {
   w_day = 1
  // <<"cons of Dil $_cobj $w_day $dil_ocnt\n"
   dil_ocnt++ 
 }

}
//=========================//


xov = 20;

<<" after class def Dil \n"


Dil H[2];

<<" after class def Dil H \n"




<<"FIRST H[2] $(xov--) \n"

checkNum(xov,19)


<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"


<<" after H[2] \n"


<<" attempting Dil E \n"
xov = 20

 Dil E 

<<"FIRST E $(xov--) \n"

 checkNum(xov,19)




<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"

//  FIXME ---- not going to first following statement in E has nested class!!


checkOut();








exit()



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


 checkNum(syt,tys);

//checkOut()

 



 gyt = E->B->t;

<<" $gyt $(typeof(gyt)) \n"


  checkNum(gyt,80)

<<"nested class getting direct reference %V $gyt \n"

syt = 60; //

<<"nested class setting direct reference %V $syt \n"

 E->B->t = syt

 gyt = E->B->t

<<"nested class getting direct reference %V $gyt \n"

k = 3;
   checkNum(gyt,60)

 E->A[0]->t = 28;


 t1 = E->A[0]->t;

<<"$t1\n"
<<"%V $E->A[0]->t \n"



 E->A[1]->t = 92;

 E->A[k]->t = 72;

 t1 = E->A[k]->t;

<<"%V $k $t1\n"
<<"%V $E->A[0]->t \n"
 checkNum(t1,72);

checkOut()
exit()

 yt0 = E->A[0]->t

<<"%V $yt0 \n"



 yt1 = E->A[1]->t;

<<"%V $yt1 \n"

 yt3 = E->A[3]->t

<<"%V $yt3 \n"



 E->A[1]->t = 29;
 E->A[2]->t = 92;
 E->A[3]->t = 75;

 yt0 = E->A[0]->t

<<"%V $E->A[0]->t \n"

<<"%V $yt0 \n"


 checkNum(yt0,28);



 yt1 = E->A[1]->t

<<"%V $yt1 \n"

 checkNum(yt1,29)



 yt2 = E->A[2]->t

<<"%V $yt2 \n"

 checkNum(yt2,92)




// FIX crash -- xic generation?

 yt3 = E->A[3]->t

<<"%V $yt3 \n"

 checkNum(yt3,75)

 //checkProgress()
// exit()

  j = 2

 yt = E->A[j]->t

<<" [${j}] $yt \n"

<<"\n"


 checkNum(yt,92)




 for (j = 0; j < 4 ; j++) {

    yt = E->A[j]->t
    <<" [${j}] $yt \n"
 }

<<"\n"


yt = E->A[3]->t;

checkNum(yt,75);





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

 checkNum(xov,19)


 G[0]->A[0]->t = 60
 G[1]->A[1]->t = 18
 G[2]->A[2]->t = 33

   yt0 = G[0]->A[0]->t

<<"%V $yt0 \n"

  checkNum(yt0,60)

   yt1 = G[1]->A[1]->t

<<"%V$yt1 \n"

   checkNum(yt1,18)

   yt2 = G[2]->A[2]->t

<<"%V$yt2 \n"

   checkNum(yt2,33)


 i = 0 ; j = 1;

  G[i]->A[j]->t = 53

  yt = G[i]->A[j]->t 

<<"%V$yt \n"


  checkNum(yt,53)

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
       checkNum(yt,k)
       k++
   }

  }



ndiy = 10;




Dil Yod[ndiy]



<<"///////////  VMF /////////////////////\n"

 obid = X[0]->obid()

 <<"%V X[0] $obid \n"


 exit()

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

checkOut();

exit()



//////////////////////////  TBD //////////////////////////////////////
#{

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







#}
//////////////////////////////////////////////////////////////////////