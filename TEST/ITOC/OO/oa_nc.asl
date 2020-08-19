

setDebug(1,"trace","~pline","~step")

#define  ASK ans=iread();

chkIn(0);

int act_ocnt=0;

class Act {

 public:

 int type;
 int mins; 
 int t;

 CMF Set(s)
 {
     obid = _cobj->obid()
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
   act_ocnt++
<<"cons of  Act $act_ocnt\n";
   type = 1;
   mins = 10;
   t = 0;
 }

};
//================================

Act a1;

//setDebug(1,"~trace","pline","step");

Act b[3];




<<"/////////////////// Nested Class /////////////\n"

int dil_ocnt = 0;

class Dil {

 public:
 int w_day;


 
 Act A[5]; // BUG this does not construct each A objele!! 

 Act B;

////////////////
 CMF Dil() 
 {
   w_day = 1
  <<"cons of Dil $_cobj $w_day $dil_ocnt\n"
   dil_ocnt++ 
 }
};


/////////////////////////////


Dil E;


exit()

setDebug(1,"~trace","pline","step")

int k = 0;
  E->A[0]->t = 28;



t1 = E->A[0]->t;




  E->A[1]->t = 92;

  E->A[k]->t = 72;

  t1 = E->A[k]->t;

<<"$t1\n"



 E->A[1]->t = 29;
 E->A[2]->t = 92;
 E->A[3]->t = 75;
 E->A[4]->t = 79;

 yt0 = E->A[0]->t

<<"%V $yt0 \n"

 chkN(yt0,28)

 yt1 = E->A[0]->t

<<"%V $yt1 \n"
k = 0;
 yt1 = E->A[k]->t
<<"%V $yt1 \n"
 k++;
 
 yt1 = E->A[k]->t
<<"%V $yt1 \n"


chkOut()

exit()