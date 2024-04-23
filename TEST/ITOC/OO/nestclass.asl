/* 
 *  @script nestclass.asl                                               
 * 
 *  @comment test Obj nested within Obj                                 
 *  @release Carbon                                                     
 *  @vers 1.5 B Boron [asl 6.5 : C B]                                   
 *  @date 04/23/2024 15:12:03                                           
 *  @cdate Tue Apr 28 19:55:01 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


//-----------------<v_&_v>--------------------------//                       
///
///
///

#include "debug"

if (_dblevel >0) {
   debugON()
}



allowErrors(-1)
int db_ask = 0; // set to zero for no ask
int db_step = 0; // set to zero for no step
int db_allow = 0; // set to zero for internal debug print

#include "act.asl"


  chkIn(_dblevel); 

allowDB("spe,oo",0)

Act MA;

<<"%V $MA.t \n"

ans=ask("Act $MA.t set ?",0)

  <<" /////////////////// Nested Class /////////////\n";

  int Dil_ocnt = 0;

  <<"%V $Dil_ocnt \n";




  class Dil {

  public:

  int w_min;

  int w_sec;

  int w_day;

  int nt;
  
  Act B;
  
 /// now an array 

  Act A[10] ;
  
// FIXME each cons of A tacks on anotherstatement ??
//
//Act A[10];

  int Get()
  {

  <<"$_proc  \n";

  w_day.pinfo();

  <<"getting w_day $w_day\n";
  return w_day;
  }

  void Dil()
  {

  Dil_ocnt++;
  w_day = Dil_ocnt;

  nt = B.t;
  
  <<"cons of Dil $_cobj $w_day $nt $Dil_ocnt\n";

//  w_day.pinfo();


  }

  }
//=========================//

  <<" after class def Dil \n";

  <<" attempting Dil E \n";

  Dil E;


  E.pinfo()

  <<"$_scope\n";

  <<"scope $(showscope())\n";

  <<"stack $(showstack())\n";

 <<"%V $Dil_ocnt \n";

  <<"%V $Act_ocnt \n";


//  find E then class mbr B  then its member t which 2*id

  mnt = E.B.t

<<"%V $mnt \n"

   chkN(mnt,2)

  <<"%V $E.B.t \n";

ans= ask(" OK ??",0);


  
  od =E.Get();

  <<"E.w_day $od  $E.w_day\n";

  od.pinfo();

  <<"%V $E.B.t \n";

//E.w_day.pinfo();  // broke

  chkN(od,1);




  Dil H[2];

  <<" after class def Dil H[2] \n";

  <<"%V $Dil_ocnt \n";

  H.pinfo();

  od = H[1].Get();

  <<"%V $od\n";

  chkN(od,3);
//  FIXME ---- not going to first following statement in E has nested class!!

  x  = 52 * 2000;

  y =   2 * 2;

  <<" %V $y $x\n";

  syt = 80 ; //;
//int gyt

  <<"nested class setting direct reference %V $syt \n";

  E.B.t = syt;



  tys = E.B.t;

  <<"%V $syt  $tys \n";

  chkN(syt,tys);


  gyt = E.B.t;

  <<" $gyt $(typeof(gyt)) \n";

  chkN(gyt,80);

  <<"nested class getting direct reference %V $gyt \n";

  syt = 60; //;

  <<"nested class setting direct reference %V $syt \n";

  E.B.t = syt;

  gyt = E.B.t;

  <<"nested class getting direct reference %V $gyt \n";

  k = 3;

  chkN(gyt,60);
// dot ref should work for nested class

  E.A[0].t = 28;

  t1 = E.A[0].t;

  <<"$t1\n";

  <<"%V $E.A[0].t \n";

  E.A[1].t = 92;

  E.A[k].t = 72;

  t1 = E.A[k].t;

  <<"%V $k $t1\n";

  <<"%V $E.A[0].t \n";

  chkN(t1,72);

  yt0 = E.A[0].t;

  <<"%V $yt0 \n";

  yt1 = E.A[1].t;

  <<"%V $yt1 \n";

  yt3 = E.A[3].t;

  <<"%V $yt3 \n";

  chkN(yt3,72);

  E.A[1].t = 29;

  E.A[2].t = 92;

  E.A[3].t = 75;

  yt0 = E.A[0].t;

  <<"%V $E.A[0].t \n";

  <<"%V $yt0 \n";

  chkN(yt0,28);

  yt1 = E.A[1].t;

  <<"%V $yt1 \n";

  chkN(yt1,29);


  yt2 = E.A[2].t;

  <<"%V $yt2 \n";

  chkN(yt2,92);
// FIX crash -- xic generation?

  yt3 = E.A[3].t;

  <<"%V $yt3 \n";

  chkN(yt3,75);
 checkProgress()


  j = 2;

  yt = E.A[j].t;

  <<" [${j}] $yt \n";

  <<"\n";

  chkN(yt,92);

  for (j = 0; j < 4 ; j++) {

  yt = E.A[j].t;

  <<" [${j}] $yt \n";

  }

  <<"\n";

  yt = E.A[3].t;

  chkN(yt,75);

  for (j = 0; j < 10 ; j++) {

  E.A[j].t = 50 + j;

  }

  <<"\n";

  for (j = 0; j < 10 ; j++) {

  yt = E.A[j].t;

  <<" [${j}] $yt \n";

  }

  chkN(yt,59);
//iread()

  yt2 = E.A[2].t;

  <<"%V $yt2 \n";

  yt1 = E.A[1].t;

  <<"%V $yt1 \n";

  j = 3;

  yt3 = E.A[j].t;

  <<"%V $yt3 \n";

  yt3 = E.A[3].t;

  <<"bug? %V $yt3 \n";

  yt4 = E.A[4].t;

  <<"?%V $yt4 \n";

  yt8 = E.A[8].t;

  <<"%V $yt8 \n";

  chkN(yt8,58);
///  Needs XIC FIX

  chkStage("E.A[n].t ")

 

  <<"; ///////////////G[i].A[j].otype////////////////////////////\n";
//////////////////////////////////////////////////////////////////

  xov = 20;

  Dil G[10];

  <<"FIRST $(xov--) \n";

  chkN(xov,19);

  G[0].A[0].t = 60;

  G[1].A[1].t = 18;

  G[2].A[2].t = 33;

  yt0 = G[0].A[0].t;

  <<"%V $yt0 \n";

  chkN(yt0,60);

  yt1 = G[1].A[1].t;

  <<"%V$yt1 \n";

  chkN(yt1,18);

  yt2 = G[2].A[2].t;

  <<"%V$yt2 \n";

  chkN(yt2,33);
//chkOut() 

  i = 0 ; j = 1;

  G[i].A[j].t = 53;

  yt = G[i].A[j].t;

  <<"%V$yt \n";

  chkN(yt,53);

  k = 7;

  yt = G[i].A[j].t;

  <<"[${i}] [$j ] %V $k $yt \n";

  k++;

  for (i = 0; i < 3 ; i++) {

  for (j = 0; j < 4 ; j++) {

  G[i].A[j].t = k;

  yt = G[i].A[j].t;

  <<" [${i}] [${j}] %V $k $yt \n";

  k++;

  }

  }

  <<"\n";

  

  k = 7;

  for (i = 0; i < 3 ; i++) {

  for (j = 0; j < 4 ; j++) {

  yt = G[i].A[j].t;

  <<" $i $j $yt \n";

  chkN(yt,k);

  k++;

  }

  }

 chkOut(1)

  ndiy = 10;

  Dil Yod[ndiy];

  <<"; ///////////  VMF /////////////////////\n";

  obid = X[0].obid();

  <<"%V X[0] $obid \n";

  obid = X[1].obid();

  <<"%V 1 $obid \n";

  obid = X[3].obid();

  <<"%V 3 $obid \n";

  i = 2;

  obid = X[i].obid();

  <<"%V $i $obid \n";

  yrt = X[0].Set(7);

  <<"otype for 0 $yrt \n";

  yrt = X[2].Set(4);

  <<"otype for 2 $yrt \n";

  yrt = X[3].Set(5);

  <<"otype for 3 $yrt \n";

  yrt = X[1].Set(6);

  <<"otype for 1 $yrt \n";

  Dil D[3];

  <<" done dec of D \n";

  chkOut(1);




