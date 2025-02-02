
/* 
 *  @script glidetask.asl                                               
 * 
 *  @comment  cpp script                                                
 *  @release Carbon                                                     
 *  @vers 4.9 F Fluorine [asl 6.54 : C Xe]                              
 *  @date 08/16/2024 04:38:22                                           
 *  @cdate 9/17/1997 10:34:08 
 *  @author Mark Terry 
 * 
 */ 

//----------------<v_&_v>-------------------------//                  


char vers[6] ="5.3";

 
#define DB_IT    0
#define GT_DB   0
#define __ASL__ 1
#define __CPP__ 0


#if __ASL__
// this include  when cpp compiling will re-define __ASL__ 0 and __CPP__ 1
#include "debug.asl"
#include "compile.asl"

#endif


#if __CPP__
#include <iostream>
#include <ostream>

using namespace std;
#include "cpp_head.h" 
#include "vargs.h"

#define pxs  cout<<

#define ASL_DB 0
#define CPP_DB 1

#endif

///////////////////////
//uint turnpt::ntp_id = 0;

#if __ASL__

#define CPP_DB 0

#define cout //

int run_asl = runasl();
//<<" running as asl \n";

  //debugon();

 ignoreerrors();
 //checksvpool()
// echolines(0)

#undef  ASL_DB
#define ASL_DB 0


#endif


  // GLOBALS needed for CPP
  // ASL will autodec most of these
  // translater needs to declare them global ? e.g. int ::AFH when seen
  // or place them  above main or in main  block

int tf; // task file fh
int afh= -1;
float csk;
float cruise_speed;

double TC[30];
double Dur[30];


  Svar Task;

  float totalD = 0;

  float totalDur = 0.0;
  
  char  hey[10] = "hey hey";
//  float l1;
  //float l2;
  //float lo1,lo2;
  //float lo1;
  //float lo2;
  double tkm;
  double tkm2;
  float tcd;
  float rmsl;
  float tmsl;
  float msl;
  int nl,li;

  int n_legs = 0;
  int n_tp = 0;
  int k_tp;

  Str the_start = "longmont";
  Str try_place = "xxx";
  Str try_start = "xxx";
  Str nxttpt = "laramie";
  Str ans;
  Str ident;
  float L1;
  float AGL[30];

//<<"%V $nxttpt \n"

//#include "conv.asl"

//ans=ask(" ??",0)

#include "tpclass.asl"


//allowDB("ic_,oo_,spe_,rdp_,pexpnd,array",0)
//allowDB("vmf",1)

Turnpt  GT_Wtp[50];


Tleg  GT_Wleg[20];



//ans=ask("Turnpt ?",0)

#include "ootlib.asl"

/// are all globals in preprocessing stage known here

  int via_keyb = 0;
  int via_file = 0;

  int via_cl = 1;
  int ok_to_compute = 1;
  long where ;
/////////////////////////////////////

 Svar sargs(20);

#if __CPP__

int main( int argc, char *argv[] ) { // main start

   for (int i= 0; i <argc; i++) {
    sargs.cpy(argv[i],i);
   }

   init_cpp(argv[0]); 

#endif

  int na;

#if __ASL__

 na = _clargc;
// _clarg.pinfo() ; // TBF  else  sa = clarg uses clarg offset
 //<<" $_clarg[1] $_clarg[2] \n"
 //sa.clear(0)
 sargs = _clarg;
 //sargs.pinfo()
<<" $sargs\n" 
#endif

  ignoreErrors(); // put in glide.h ??

  allowErrors(-1)

//DBaction((DBSTEP_),ON_)

  int  Main_init = 1;
  float Leg[20];

  CSK = 70.0;


  Cruise_speed = (CSK * nm_to_km);

#if GT_DB
 printf(" Cruise speed %f \n",Cruise_speed);
#endif 

  GT_Wtp[1].Alt = 100.0;

  GT_Wtp[40].Alt = 5300.0;



//  GT_Wtp.pinfo() ;  // should identify Obj


  Str tlon;
  Str tplace;
  Svar CLTPT;
  Svar Wval(20);
  Svar Wval2;  

  Str tpb ="";

  Units= "KM";
  // echolines(0)
//<<" done defines \n"

// dynamic variables no need to declare and set to default
// unless default value used
// the_min = "0"

//  int nerror = 0;

  int use_cup = 1;

  if (use_cup) {

  afh=ofr("CUP/bbrief.cup")  ; // open turnpoint file;

    //printf( "opened CUP/bbrief.cup afh %d \n", afh);

  }

  else {

  afh=ofr("DAT/turnptsA.dat")  ; // open turnpoint file;
  printf("opened  DAT/turnptsA.dat %d \n" , afh );
  }

  if ( afh == -1) {

  printf( " can't find turnpts file \n");
  exit(-1);

  }

//wdb=DBaction((DBSTEP_),ON_)


  int brief = 0;

  int show_dist = 1;

  int show_title = 1;

//main





#if __CPP__
  na = argc;
#else
  na = _clargc;
#endif  

#if GT_DB
printf(" na %d\n",na);
#endif

  int ac = 0;
  float LoD = 35;
  int istpt = 1;

  int cltpt = 0;
  int sz;
  
  Str targ = "xyz"


  //<<" %V $LoD \n";
  // ac 1  is name of asl script or if CPP name of exe
  ac =1;




while (ac < na) {

  istpt = 1;

  targ = sargs.cptr(ac);  // TBF   CPP store?


#if GT_DB
 printf("ac %d targ  %s\n",ac,sargs[ac]);
 targ.pinfo();
#endif


  sz = targ.slen();

//<<"%V $sz\n";

  ac++;

  if (sz > 0) {

  if (targ == "LD") {

//allowDB("spe,rdp",1)



    targ = sargs.cptr(ac);

    LoD= atof(targ);

//<<"parsing %V $LoD \n";
    ac++;

    istpt = 0;

#if GT_DB
     printf("setting LD %f \n",LoD);
#endif

    }

  if (targ == "units") {

      //targ.pinfo();  // print variable status
      // isthere = targ.checkVarInfo("SI_PROC_REF_ARG")  ;  // check variable status for this string

     targ = sargs.cptr(ac);

  if (targ == "KM") {
    Units = "KM";
   }
  else if (targ == "NM") {
    Units = "NM";
  }
   else if (targ == "SM") {
    Units = "SM";
    printf("setting Units to SM %d\n",Units);
  }

    ac++;
    istpt = 0;
    
  }


  if (targ == "CS") {


  targ = sargs.cptr(ac);

  CSK = atof(targ);

  ac++;

  istpt = 0;

  Cruise_speed = (CSK * nm_to_km);

#if GT_DB
  printf("setting CS CSK %f knots Cruise_speed %f kmh \n",CSK,Cruise_speed);
#endif

  }

  if ( targ == "task") {

  via_keyb = 0;

  via_file = 1;

  Str byfile = sargs.cptr(ac);

  ac++;
	//<<" opening taskfile $byfile \n"

  TF = ofr(byfile);

  if (TF == -1 ) {

   printf ("file error");
   exit(-1);


   }

  Task.readFile(TF);


  // cout <<" task" <<  Task.cptr(0) << endl;



  istpt = 0;

  }

  if (targ == ">") {

     break;

  }

  if (targ == "brief") {

     brief = 1;

  }

  if (targ == "tasklist") {

  show_dist = 0;

  show_title = 0;

  istpt = 0;

  }
    //<<" %V $targ $istpt $(typeof(istpt)) \n"
 //<<"%V $ac  $targ $sz $istpt \n"

  if (istpt) {

  via_keyb = 0;

  via_cl = 1;
 // 

#if __ASL__
  //CLTPT[cltpt] = targ;   // TBF 02/24/22

//<<"%V $cltpt $targ  \n"

   CLTPT.cpy(targ,cltpt);

   if (ASL_DB)  {
    <<"%V $targ $sz $cltpt $CLTPT[cltpt] \n"
    <<"CLTPTs  $CLTPT\n"
    }


#else
 CLTPT.cpy(targ,cltpt);
 if (CPP_DB) cout  <<"CPP cltpt "<< cltpt  <<" CLTPT[cltpt] "<< CLTPT[cltpt]  <<endl ; 
#endif

   cltpt++;

   }



 } // arg was valid

}
// look up lat/long



  float N = 0.0;
  int ki;
  int cnttpt = 0;
  int input_lat_long = 0;
  int i = -1;


   if (GT_DB) printf("DONE ARGS  ac %d cltpt %d \n", ac,cltpt);




/////////////////////////////

  i = -1;
 int k;
 int got_start = 0;
 int k_afh = afh;
 cnttpt = 0;

 while ( !got_start) {


#if ASL_DB
 <<" %V $cnttpt $i    $via_keyb $via_cl\n";
#endif

  fseek(afh,0,0);

  if (via_cl) {

  the_start = CLTPT[cnttpt];
  
#if ASL_DB
  <<"$the_start $cnttpt $CLTPT[cnttpt] \n"
#endif

#if CPP_DB
    cout << "the start " << the_start << "  " << cnttpt  << endl;
#endif

  cnttpt++;

  if (cnttpt > cltpt) {

   the_start = "done";

   }


  if (the_start == "done") {
     exit(0);
  }

  if (the_start == "input") {

  input_lat_long = 1;

  i = 0;

  break;

  }

  i=searchFile(afh,the_start,0,1,0,0);

  //printf("afh %d i %d\n",afh,i);

  if (i == -1) {
   printf("the_start  %s not found \n", the_start);

  try_start = nameMangle(the_start);
  
  i=searchFile(afh,try_start,0,1,0,0);
    if (i != -1) {
       the_start = try_start;
    }

  }



  if (i == -1) {

   printf("the_start not found \n");;

  //the_start.pinfo();

//cout  <<" "<< the_start  << "not "  << "found "  <<endl ;
//  printf("the_start  %s not found \n", stoa(the_start));
  ok_to_compute = 0;

  if (!via_keyb) {
		//testargs(1,0,"start not found");
   exit(-1);

   }

  }


  }

  got_start =1;
}  // end while

// -------------------------------
//<<"%V$input_lat_long  $i \n"

  int nwr;
  Str w;

  if (input_lat_long) {
// <<" input place !\n"

  }

  else {

  fseek(afh,i,0);

  if (via_keyb) {

   w=pclFile(afh);

   }

  else {
	  //<<"pcl \n"
	    //w=pcl_file(A,0,1,0)
   }

  ki = seekLine(afh,0);

  //DB//printf("reset to file start %d\n",ki);

  //<<[_DB]" $ki back to beginning of line ?\n";
	  // need to step back a line

  if (use_cup) {
  //  nwr = Wval.readWords(afh,0,44);

    nwr = Wval.readWords(afh,0,',');

//<<" CUP read of  $nwr words \n"

   }
  else {
   nwr = Wval.readWords(afh);
   }

  tplace = Wval[0];

  if (use_cup) {
   tlon = Wval[4];
   }
   else {
    tlon = Wval[3];
   }




  n_tp++;
  if (use_cup) {

     GT_Wtp[0].TPCUPset(Wval);

   }
  else {
     GT_Wtp[n_legs].TPset(Wval);
   }
   
  AGL[n_legs] = GT_Wtp[n_legs].Alt;

 }
 
#if ASL_DB
<<"%V $nwr \n"
<<"$Wval\n"
<<"$Wval[0] $Wval[1] $Wval[2] $Wval[3]\n"	  
<<"start ? %V $n_legs \n";
<<"%V $GT_Wtp[n_legs].Ladeg \n"
#endif



// NEXT TURN POINT
//ans=ask("NEXT TURN POINT ",1)

  int more_legs = 1;

  ok_to_compute = 1;
 // FIX

  float the_leg;
//<<"%V $afh\n";

  while (more_legs == 1) {

 // fseek(afh,0,0);

  if (via_cl) {

  nxttpt = CLTPT[cnttpt];


#if ASL_DB
<<"%V  $nxttpt   $cnttpt $cltpt \n"
#endif


#if __CPP__
  if (GT_DB) cout << " nxttpt " << nxttpt << endl;
#endif

//nxttpt.pinfo();
 
  cnttpt++;



  if (cnttpt > cltpt) {

   //<<[_DB]" done reading turnpts $cnttpt\n ";

   nxttpt = "done";

   }

  }

/*
  else {
  <<" get via a keyboard or file !! \n";
  nxttpt = get_word(nxttpt);
  }
*/

 // if ((nxttpt == "done") || (nxttpt == "finish") || (nxttpt == "quit") ) {  // 6.54 fail
 
if ((nxttpt == "done")  ) {  // 6.54 fail 
     more_legs = 0;

  }

  else {

/*
#if __CPP__
 if (GT_DB) cout <<"looking for " << nxttpt << endl;
#else
 <<"afh $afh looking for $nxttpt \n";
#endif
*/
//<<"%V $afh\n"

  afh = k_afh;



//<<"$afh   $nxttpt \n"

  where = searchFile(afh,nxttpt,0,1,0,0);

//<<"%V $afh $where \n"

//cout <<"Found? " << nxttpt << " @ " << where <<endl;

    if (where  == -1) {

        try_start = nameMangle(nxttpt);

        where = searchFile(afh,try_start,0,1,0,0);
      
       if (afh != k_afh) {
        printf(" ferr afh %d\n",afh);
	}
    }


  if (where  == -1) {

   printf("not found! %s ",nxttpt);

   ok_to_compute = 0;

   if (!via_keyb) {
        printf ("nxttpt not found %s",nxttpt);
     exit(-1);

     }

   }
   else {
//<<"%V $afh\n"
    if (GT_DB) printf ("n_legs %d where %d found %s ",n_legs, where,nxttpt);
    
   }

  }

  if (more_legs) {


  where = fseek(afh,where,0);

  n_legs++;

  if (GT_DB) printf("n_legs %d where %d afh %d\n",n_legs,where , afh);

//cout << " n_legs "<< n_legs <<" @ " << where << endl;

  if (via_keyb) {

      pclFile(afh);

   }

  else {
	      // w=pclFile(afh,0,1,0)

   }
	// fseek(A,w,0)

      where  = seekLine(afh,0);




//cout << n_legs <<" @2 " << where << endl;

//ans=ask("NEXT 2 ",1)
  if (use_cup) {

 //  nwr = Wval.readWords(afh,0,',');
 
   nwr = Wval.readWords(afh,0,44);

//  <<"CUP READ $nwr words \n"


  //  cout <<" next  nwr " << nwr << endl;
#if __CPP__
  if (GT_DB) COUT(Wval);
#endif

#if ASL_DB
<<"%V $nwr \n"
<<"$Wval \n";
<<"%V $afh $n_legs $Wval[0] $Wval[1]  $Wval[4] \n"
#endif



   GT_Wtp[n_legs].TPCUPset(Wval);


//<<"%V $n_legs  $GT_Wtp[n_legs].Place $GT_Wtp[n_legs].Ladeg \n"
 //  Wval.pinfo();

//ans=ask("NEXT TURN 3 ",1)

   AGL[n_legs] = GT_Wtp[n_legs].Alt;
//<<"%V $n_tp $n_legs   $GT_Wtp[n_legs].Alt   $AGL[n_legs] \n"
 //  cout  <<" "<< n_legs  <<" "<< Wval2[0]  <<" "<< Wval2[1]  <<" "<< Wval2[3]  <<" "<< Wval2[4]  <<endl ; 
 //  Wval2.vfree();
   
   }

  else {

   nwr = Wval.readWords(afh);

//<<"read $nwr words \n"
//<<" $Wval[0]  $Wval[1]  $Wval[2]\n"
  //ans=ask(" %V $Wval  ",1)
   GT_Wtp[n_legs].TPset(Wval);
  //ans=ask(" %V $Wval  ",1)

#if __ASL__
     if (afh != k_afh) {
       <<" ferr %V $afh\n"
     }
#endif

   }

 // msz = Wval.Caz();

  }

  L1 = GT_Wtp[nl].Ladeg;
 //printf("n_legs [%d] L1 %f\n",n_legs, L1);
   //<<"$GT_Wtp[n_legs].Place \n";
  //ans=query("??");
}




    //      prompt("%v $more_legs next turn %-> ")
// compute legs
 //<<"compute \n"

//  ild= abs(LoD);

//  <<"%V  $CSK knots $Cruise_speed kmh\n";
  //cout  <<"CSK "<< CSK  << "knots "  <<"Cruise_speed "<< Cruise_speed  << "kmh "  <<endl ;
//  ans=query("show");

  
// get totals
// in main --- no obj on stack?

  float rtime = 0.0;
  float tot_time = 0.0;
  float rtotal = 0.0;
  float nleg,wleg;
  float agl,ght,pc_tot,alt;

 

  if (ok_to_compute) {
   //computeHTD()

    totalD = 0;

  if (show_title) {
  

  printf(" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n");
 printf("Leg TP     ID    RADIO     AMSL            HDG         Dist    FGA          Dur      RunTotD RunTime  PC LAT LONG \n");


  }

 int nl1=0;

// float L1;  // TBF 10/6/24   declare within loop
 float lo1 ;
 
  for (nl = 0; nl < n_legs ; nl++) {
#if ASL_DB
<<"%V $nl   $n_legs  $GT_Wtp[nl].Place  $GT_Wtp[nl+1].Place  $GT_Wtp[nl].Alt $GT_Wtp[nl].Ladeg  \n"
// ans=query("??");
#endif

  L1 = GT_Wtp[nl].Ladeg;  // TBF - no autodec
  ki = nl+1;
  L2 = GT_Wtp[nl+1].Ladeg;  

  lo1 = GT_Wtp[nl].Longdeg;   // TBF - no autodec

  lo2 = GT_Wtp[(nl+1)].Longdeg; 

  tkm = HowFar(lo1 ,L1, lo2, L2);

  tkm2 = HowFar( GT_Wtp[nl].Longdeg , GT_Wtp[nl].Ladeg, GT_Wtp[nl+1].Longdeg, GT_Wtp[nl+1].Ladeg);  // TBF 10/6/24 XIC
  
//cout << "L1 " << L1 << " lo1 " << lo1 << " L2 " << L2 << " lo2 " << lo2 << " tkm " << tkm << endl;

//<<"%V $nl $tkm $tkm2\n"

#if ASL_DB
<<"%V  $GT_Wtp[nl].Place $GT_Wtp[nl].Alt $GT_Wtp[nl].Longdeg $GT_Wtp[nl].Ladeg  $GT_Wtp[nl+1].Place $GT_Wtp[nl+1].Longdeg    $GT_Wtp[nl+1].Ladeg \n";
<<"%V $nl $tkm $tkm2\n"

#endif

  Leg[nl] = tkm;

  GT_Wleg[nl].dist = tkm;
  
  if (Units == "NM") {

  GT_Wleg[nl].dist = tkm * km_to_nm;
  
  }

  else if (Units == "SM") {

  GT_Wleg[nl].dist = tkm * km_to_sm;
  
  } 
//<<"%V $nl $tkm $Leg[nl] $TKM[nl]\n"

  //DBG"%V $GT_Wleg[nl].dist\n";
       //Leg[nl] = ComputeTPD(nl, nl+1)
 nl1 = nl + 1;


  //tcd =  ComputeTC(GT_Wtp,nl, nl1); // this should work
//<<" $nl  $(nl+1) \n"
  tcd =  ComputeTC(GT_Wtp,nl, nl+1); // this should work

//COUT(tcd);
 
  L1 = GT_Wtp[nl].Ladeg;

  L2 = GT_Wtp[nl+1].Ladeg;

  lo1 = GT_Wtp[nl].Longdeg;

  lo2 = GT_Wtp[nl+1].Longdeg;

//<<"%V $L1 $L2 $lo1  $lo2 \n"

//  tc = TrueCourse(L1,lo1,L2,lo2);
 tcd = TrueCourse(lo1,L1,lo2,L2);

//COUT(tcd);


//wdb=DBaction((DBSTEP_),ON_)


  TC[nl] = tcd;

//  Dur[nl+1] = Leg[nl]/ Cruise_speed;
//<<"%V $tkm  $Cruise_speed \n"

    Dur[nl] = tkm / Cruise_speed;
 //<<"%V $Leg[nl] $tkm $Dur[nl+1] \n"

  totalDur += Dur[nl];

  totalD += tkm;

#if ASL_DB
<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"
#endif

  }

  int wk = 0;
  int tplen = tpb.slen();

  Str ws =  nsc((10-tplen)," ");

  int idlen = ident.slen();

  Str wsi= nsc((10-idlen)," ");
  float tct;
  float dct;

  rmsl = 0.0;

  msl = 0.0;

  pc_tot = 0.0;

#if ASL_DB    
   for (k_tp = 0; k_tp < n_legs; k_tp++) {
<<"%V $k_tp   $GT_Wtp[k_tp].Alt  $AGL[k_tp]   $GT_Wtp[1].Alt   $GT_Wtp[0].Alt $GT_Wtp[0].Ladeg  $GT_Wtp[1].Ladeg  $AGL[1]  \n"
   }
#endif

  k_tp = 1;

//<<"%V $k_tp   $GT_Wtp[k_tp].Alt  $AGL[k_tp] \n"

  msl =  GT_Wtp[k_tp].Alt;

  rmsl = AGL[k_tp];


  rtotal = 0;
  
  for (nl = 0; nl <= n_legs ; nl++) {

  if (nl == 0) {

   the_leg = Leg[0];

   pc_tot = 0.0;

   }

  else {

   the_leg = Leg[nl-1];

   pc_tot = 0.0;

   if (totalD > 0) {

     pc_tot = the_leg/totalD * 100.0;

     GT_Wleg[nl].pc = pc_tot;

     }

   }

  nleg = the_leg * km_to_nm;

  alt =  GT_Wtp[nl].Alt;

  msl = alt;

  ght = (Leg[nl] * km_to_feet) / LoD;

  if (nl == n_legs) {

   agl = 1200 + msl;

   }

  else {
   wk = nl +1;
   rmsl =  GT_Wtp[wk].Alt;
   agl = ght + 1200.0 + rmsl;
   //<<"%V $nl $wk $agl = $ght + 1200.0 + $rmsl  $GT_Wtp[nl+1].Alt $GT_Wtp[1].Alt $AGL[nl] $AGL[nl+1]  \n";

   }

  GT_Wtp[nl].fga = agl;

  tpb = GT_Wtp[nl].Place;

//<<"%V  $nl $GT_Wtp[nl].Place   $GT_Wtp[nl].fga\n"
//cout  <<"nl "<< nl  <<"GT_Wtp[nl].Place "<< GT_Wtp[nl].Place  <<"GT_Wtp[nl].fga "<< GT_Wtp[nl].fga  <<endl ;


  ident = GT_Wtp[nl].Idnt;

  li = nl;

  if (Units == "KM") {

   wleg = the_leg ;

   }

  else {

   wleg = nleg ;

   }


  if (li > 0) {

   rtime = Dur[li-1];

   }
//    rtime.info(1)
//<<"%V $li $rtime $Dur[li] \n"

  if (li == 0) {

   wleg = 0.0;

  

   }

   rtotal += GT_Wleg[li].dist;
  
 // <<"$li $GT_Wleg[li]->dist  $GT_Wleg[li]->pc_tot \n"
 //<<"$li ${tpb}${ws}${ident}${wsi} %9.3f${GT_Wtp[li]->Lat} %11.3f${GT_Wtp[li]->Lon}\s%10.0f${GT_Wtp[li]->fga} ${GT_Wtp[li]->Alt} %4.1f$GT_Wleg[li]->pc ";

//<<"%V $tot_time  $li  $Dur[li]  \n"
  //tot_time.pinfo()

   tot_time += Dur[li];

     pc_tot = GT_Wleg[li].dist/totalD * 100.0;

     GT_Wleg[li].pc = pc_tot;
      //checkSVpool()
//ans=ask("SV pool ?",1)
// printf("%d %-5s  \t%s\t%s   %6.0fft   %6.0fft         \n",li,ident,GT_Wtp[li].Lat,GT_Wtp[li].Lon, GT_Wtp[li].fga, GT_Wtp[li].Alt);
  //
#if __ASL__
  printf("%d %-10s %-5s %-8s %6.0fft",li,GT_Wtp[li].Place,ident,GT_Wtp[li].Radio,GT_Wtp[li].Alt);
#else
 //printf("%d %-10s %-5s %-8s",li,GT_Wtp[li].Place.cptr(),ident.cptr(),GT_Wtp[li].Radio.cptr())  ;
 
 //cprintf("%d  %-10S %-5S %-8S ",li,GT_Wtp[li].Place,ident,GT_Wtp[li].Radio)  ;
cprintf("%d  %-10S %-5S %-8S  %6.0fft  ",li,GT_Wtp[li].Place,ident,GT_Wtp[li].Radio,GT_Wtp[li].Alt);

#endif

  
  //printf("%6.0ff  ", GT_Wtp[li].Alt);
  printf("\t%6.0f ",TC[li]);
  printf("\t%5.1f ",GT_Wleg[li].dist);
  printf("%6.0fft ",GT_Wtp[li].fga);


  
//cout  << "%5.1f$GT_Wleg[li]->dist\t$rtotal\t$rtime\t%6.2f${GT_Wtp[li]->Radio} " ; 

  printf("\t%6.2f",Dur[li]);

  printf("\t%6.2f %6.2f ",rtotal,tot_time);
  printf("\t%6.2f%% ",GT_Wleg[li].pc); 
#if __ASL__
  printf("%s %s \n",GT_Wtp[li].Lat,GT_Wtp[li].Lon);

#else
  printf("%s %s \n",GT_Wtp[li].Lat.cptr(),GT_Wtp[li].Lon.cptr());
  //printf("%s %s \n",GT_Wtp[li].Lat,GT_Wtp[li].Lon);
#endif  




  }

  if (show_dist) {
#if __ASL__
  <<"\nTotal distance\t %8.2f $totalD km\t%8.2f $(totalD*km_to_sm) sm\t%6.2f  $(totalD*km_to_nm) nm    LOD %6.1f$LoD CS $CSK knots\n";

  <<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n";
#else
  printf("Total distance\t %8.2f km\t%8.2f sm\t%6.2f  nm  LOD %6.1f  \n", totalD,(totalD*km_to_sm),(totalD*km_to_nm),LoD);
//ans=query("totalD ?");
#endif

     printf("totalD  %6.2f km to fly - %6.2f hrs - bon voyage!\n ", totalD, totalDur);

}

  else {

 // <<"# \n";

  }

  }

//  <<"%6.1f $totalD km to fly -  $totalDur hrs - bon voyage!\n";


#if __CPP__

 exit(0);       // want to report code errors exit status
 }  /// end of C++ main   

////////////////////////////////////////////////////////////////////////////////////////
#endif



/*
  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint
*/

//==============\_(^-^)_/==================//

//LocalWords:  asl
