
//  Object Arrays Nested Class

setDebug(1)

chkIn()


int i = 0

<<" i $(IDof(&i)) \n"

vid = i->vid()
//FIXME <<" $vid $(i->vid())\n"


<<" $vid \n"


float F[10]
vid = F->vid()

<<" $vid \n"

vid = F[2]->vid()

<<" $vid \n"

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

   return type

 }

 CMF Act() 
 {
//FIXME   <<"cons of Act $_cobj $(_cobj->obid())  $(IDof(&_cobj))\n" 
//   co = _cobj->offset()
//   <<"cons of Act $_cobj   $(IDof(&_cobj)) $(offsetof(&_cobj)) co $co\n" 
   <<" cons of $_cobj \n"
   type = 1
   mins = 10;
   t = 0;
 }

}


Act a

    a->type = 2
<<"%V $a->type \n"
    a->type = 3
<<"%V $a->type \n"
    a->Set(5)
<<"%V $a->type \n"


// vid = a->vid()
// <<"%V 2 $vid \n"

<<"%V is $a->type\n"

// FIXME <<" a $(IDof(&a)) $(a->obid())\n"


 obid = a->obid()

 <<" a $(IDof(&a)) obid $obid \n"


 Act b

 <<" b $(IDof(&b)) \n"

 obid = b->obid()

 <<"%V b $obid \n"

 b->Set(5)


 Act X[4]

 xobid = X[2]->obid()
 <<"%V 2 $xobid \n"




 yrt = X[3]->Set(7)

 yt = X[3]->type
<<"type %V $yrt $yt \n"





#{
//  cmf to run over subscript of object array !!
 X[0:2]->Set(4)
 yt = X[1]->type
<<"type $yt \n"

#}


<<"\n//////////////// Direct Set-Get /////////////////\n"
 pass = 1

 X[0]->type = 50
 X[1]->type = 79
 X[2]->type = 47
 X[3]->type = 80


 yt = X[2]->type
<<"type for 2 $yt \n"

 yt = X[3]->type
<<"type for 3 $yt \n"

 yt = X[0]->type
<<"type for 0 $yt \n"




 yt = X[1]->type
<<"type for 1 $yt = 79 ?\n"
  if (yt != 79) {
  pass = 0
  }



 yt = X[2]->type
<<"type for 2 $yt = 47 ?\n"
  if (yt != 47) {
  pass = 0
  }

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

<<" PASS ? $pass \n"


<<"\n//////////////// CMF Set-Get /////////////////\n"


 pass = 1

 yst =  X[2]->Set(4)
 yt  =  X[2]->type
 ygt =  X[2]->Get()

<<"2 type %V $yst $yt $ygt\n"
 if (yt != 4) {
    pass = 0
 }

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

<<"3 type %V $yst $yt $ygt\n"



<<" PASS ? $pass \n"




 X[0]->type = 2
 X[2]->type = 28
 X[1]->type = 79


   yt = X[0]->type
   <<"%V  $yt  $X[0]->type \n"
   yt = X[1]->type
   <<"%V  $yt  $X[1]->type \n"
   yt = X[2]->type
   <<"%V  $yt  $X[2]->type \n"


 for ( i = 0; i < 4; i++) { 
   yt = X[i]->type
   <<"%V $i $yt  $X[i]->type \n"
 }

   yt = X[1]->type
   <<"%V  $yt  $X[1]->type \n"

<<" DONE \n"

<<"/////////////////// Nested Class /////////////\n"


class Dil {

 public:
 int w_day;
// Act A[3] ;
// FIXME each cons of A tacks on anotherstatement ??
//
 Act A[4]
 Act B;

 CMF Dil() 
 {
   w_day = 1
   <<"cons of Dil $_cobj $w_day\n" 
 }

}

<<" after class def \n"

Dil E

//  FIXME ---- not going to first following statement in E has nested class!!
<<"1 done dec of E \n"
<<"2 done dec of E \n"
<<"3 done dec of E \n"
<<"4 done dec of E \n"
<<"5 done dec of E \n"

 x  = 52 * 2000
 y =   2 * 2
<<" %V $y $x\n"

syt = 80 //

<<"nested class setting direct reference %V $syt \n"

 E->B->t = syt

 gyt = E->B->t

<<"nested class getting direct reference %V $gyt \n"


syt = 60 //

<<"nested class setting direct reference %V $syt \n"

 E->B->t = syt

 gyt = E->B->t

<<"nested class getting direct reference %V $gyt \n"


int yt0
int yt1
int yt2

 E->A[0]->t = 28
 E->A[1]->t = 29
 E->A[2]->t = 92
 E->A[3]->t = 75

// FIXME --- 
// type of yt0 should be INT
 yt0 = E->A[0]->t

<<"%V $yt0 \n"

 yt1 = E->A[1]->t

<<"%V $yt1 \n"

 yt2 = E->A[2]->t

<<"%V $yt2 \n"

 yt3 = E->A[3]->t

<<"%V $yt3 \n"



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

    E->A[j]->t = 50 + j
 }

<<"\n"


 for (j = 0; j < 4 ; j++) {

    yt = E->A[j]->t
    <<" [${j}] $yt \n"
 }


<<"///////////////G[i]->A[j]->type////////////////////////////\n"

Dil G[3]

<<"1 done dec of G \n"
<<"2 done dec of G \n"
<<"3 done dec of G \n"
<<"4 done dec of G \n"
<<"5 done dec of G \n"
<<"6 done dec of G \n"
<<"7 done dec of G \n"
<<"8 done dec of G \n"
<<"9 done dec of G \n"
<<"10 done dec of G \n"



 G[0]->A[0]->t = 60
 G[1]->A[1]->t = 18
 G[2]->A[2]->t = 33

   yt0 = G[0]->A[0]->t

<<"%V $yt0 $(typeof(yt0))\n"

  chkN(yt0,60)

   yt1 = G[1]->A[1]->t

<<"%V $yt1 \n"

  chkN(yt1,18)

   yt2 = G[2]->A[2]->t

<<"%V $yt2 \n"

  chkN(yt2,33)

 i = 0 ; j = 1;

   G[i]->A[j]->t = 53

  yt = G[i]->A[j]->t 

<<"%V $yt \n"

  chkN(yt,53)

  k = 7

  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      G[i]->A[j]->t = k
      k++
   }

  }

<<"\n"


  for (i = 0; i < 3 ; i++) {

   for (j = 0; j < 4 ; j++) {

      yt = G[i]->A[j]->t 
      <<" $i $j $yt \n"
   }

  }


chkOut()
<<" DONE \n" ; stop!



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


stop!



Dil D[3]


<<" done dec of D \n"


stop!


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