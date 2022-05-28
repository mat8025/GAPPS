/* 
 *  @script glidetask.asl 
 * 
 *  @comment task-planner cpp script 
 *  @release  
 *  @vers 4.7 N 6.3.83 C-Li-Bi 
 *  @date 02/14/2022 11:20:58          
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;



#define ASL 1
#define ASL_DB 0
#define GT_DB   0


#define CPP 0

#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "/home/mark/gasp-CARBON/include/compile.h"
#endif





#if CPP
#include <iostream>
#include <ostream>

using namespace std;

#endif

///////////////////////
//uint Turnpt::Ntp_id = 0;

#if ASL
#define COUT //
int run_asl = runASL();
<<" running as ASL \n";
#include "debug"
ignoreErrors(-1);
#endif



int TF; // task file FH
int AFH= -1;
float CSK;
float Cruise_speed;

float TC[20];
float Dur[20];

Svar Task;

  float totalD = 0;

  float totalDur = 0.0;

  float TKM[20];
  float L1;
  float L2;
  float lo1,lo2;
  double tkm;
  float tcd,rmsl,msl;
  int nl,li;
  Str ident;

//#include "conv.asl"

#include "tpclass.asl"

Turnpt  GT_Wtp[50];

Tleg  GT_Wleg[20];

#include "ootlib.asl"

  int via_keyb = 0;

  int via_file = 0;

  int via_cl = 1;
  int ok_to_compute = 1;
  long where ;

#if CPP

void
Uac::glideTask(Svarg * sarg)  
{

int run_asl = runASL();
 cout <<"CPP  ASL?  " << run_asl << endl;

 Str a0  = sarg->getArgStr(0) ;

//a0.pinfo();
 Svar sa;

cout << " paras are:  "  << a0.cptr(0) << endl;
 sa.findWords(a0.cptr());

cout << " The glider Task turnpts and  parameters are:  "  << sa << endl;

cout << " para[0] is:  "  << sa.cptr(0) << endl;

cout << " para[1] is:  "  << sa.cptr(1) << endl;

//cout << " para[2] is:  "  << sa.cptr(2) << endl;
#endif

  int na;

#if ASL


 Svar sa;

// <<" na $_clargc \n"
 na = _clargc;
// <<" na $_clarg[1]  $_clarg[2] \n"
 

 sa = _clarg;

<<"args are $sa \n"

<<"0 $sa[0] \n"

<<"1 $sa[1] \n"

<<"2 $sa[2] \n"

!a


#endif

//cout << " ??? \n"  ;


//cout << " para[3] is:  "  << sa.cptr(3) << endl;


  ignoreErrors(); // put in uac.h ??

//  chkIn(1);  //  _dblevel ?
  
//setMaxICerrors(-1) // ignore - overruns etc

int  Main_init = 1;

//cout << " ??? & \n";
//<<"%V $totalD\n"

  float Leg[20];

  CSK = 70.0;

  Cruise_speed = (CSK * nm_to_km);

//  printf(" Cruise_speed %f ",Cruise_speed);

  GT_Wtp[1].Alt = 100.0;

  GT_Wtp[40].Alt = 5300.0;

//  <<"$GT_Wtp[1].Alt\n";

//  GT_Wtp.pinfo() ;  // should identify Obj

  Str tlon;
  Str tplace;

  Svar CLTPT;
  Svar Wval;
  Svar Wval2;  

  Str tpb ="";

  Units="KM";
  
//<<" done defines \n"

// dynamic variables no need to declare and set to default
// unless default value used
// the_min = "0"

//  int nerror = 0;

  int use_cup = 1;

  if (use_cup) {

  AFH=ofr("CUP/bbrief.cup")  ; // open turnpoint file;
   //printf( "opened CUP/bbrief.cup %d \n",AFH);
  }

  else {

  AFH=ofr("DAT/turnptsA.dat")  ; // open turnpoint file;
  //printf("opened  DAT/turnptsA.dat %d \n" ,AFH );
  }

  if (AFH == -1) {

  printf( " can't find turnpts file \n");
  exit(-1);

  }

  int brief = 0;

  int show_dist = 1;

  int show_title = 1;

//main


#if CPP
  na = sa.getNarg();
#else
  na = _clargc;
#endif  

  if (GT_DB) printf(" na %d\n",na);


  int ac = 0;

  float LoD = 35;

  int istpt = 1;

  int cltpt = 0;
  int sz;
  
  Str targ;
  Str ans;

  //<<" %V $LoD \n";
#if ASL
ac =1;
#endif

while (ac < na) {

  istpt = 1;

#if CPP
  targ = sa.cptr(ac);
#else
  //targ = _clarg[ac];

  targ = sa.cptr(ac);

<<"%V $ac $sa[ac] $targ\n"

#endif

#if GT_DB
 printf("ac %d targ %s\n",ac,targ);
#endif
//cout <<"ac "<< ac <<" " << targ << endl;

//  DBG"%V $ac $targ\n";

  sz = targ.slen();

//<<"%V $sz\n";

  ac++;

  if (sz > 0) {

  if (targ == "LD") {


  targ = sa.cptr(ac);




   // LoD= atof(sa.cptr(ac));
    LoD= atof(targ);

//<<"parsing %V $LoD !n";
    ac++;

    istpt = 0;
//LoD.pinfo();
    if (GT_DB) printf("setting LD %f ",LoD);

  }

  if (targ == "CS") {


  targ = sa.cptr(ac);



  CSK = atof(targ);

  ac++;

  istpt = 0;

  Cruise_speed = (CSK * nm_to_km);

  if (GT_DB) printf("setting CS CSK %f knots Cruise_speed %f kmh \n",CSK,Cruise_speed);

  }

  if ( targ == "task") {

  via_keyb = 0;

  via_file = 1;

  Str byfile = sa.cptr(ac);

  ac++;
	//     <<" opening taskfile $byfile \n"

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



#if ASL
 CLTPT[cltpt] = targ;   // TBF 02/24/22
  if (GT_DB) <<"%V $targ $sz $cltpt $CLTPT[cltpt] \n"
#else
CLTPT.cpy(targ,cltpt);
 if (GT_DB) cout  <<"cltpt "<< cltpt  <<" CLTPT[cltpt] "<< CLTPT[cltpt]  <<endl ; 
#endif
//cout  <<"cltpt "<< cltpt  <<" CLTPT[cltpt] "<< CLTPT[cltpt]  <<endl ; 

  cltpt++;

  }

// <<"%V $ac  $targ $sz \n"

} // arg was valid

}
// look up lat/long

  Str the_start= "Longmont";
  Str try_place = "xxx";
  Str try_start = "xxx";
  Str nxttpt = "Laramie";

  float N = 0.0;

  int ki;

  int cnttpt = 0;
// enter start

  int input_lat_long = 0;

  int i = -1;


   if (GT_DB) printf("DONE ARGS  ac %d cltpt %d \n", ac,cltpt);




////   do this to check routine    
    //<<"Start  $the_start \n"
// first parse code bug on reading svar fields?

//  TBF asl does not handle nested #if 's
 int k;
#if GT_DB
  for (k= 0; k < cltpt; k++) {
//#if ASL
//<<"$k  $CLTPT[k] \n";
//#else
//  printf("k  %d    %d\n",k,CLTPT[k]); ; 
//#endif
}
#endif


/////////////////////////////

  i = -1;
 int got_start = 0;
 int K_AFH = AFH;
 
  while ( !got_start) {

   // <<" %V $cnttpt $i    $via_keyb $via_cl\n";

  fseek(AFH,0,0);

  if (via_cl) {

  the_start = CLTPT[cnttpt];

//<<"$the_start $cnttpt \n"

  cnttpt++;

  if (cnttpt > cltpt) {

   the_start = "done";

   }

//  else {
//
//  the_start = get_word(the_start);
//
//  }
      // <<"Start  $the_start \n"
	//    	prompt(" ? ")

  if (the_start == "done") {

     exit(0);

  }

  if (the_start == "input") {

  input_lat_long = 1;

  i = 0;

  break;

  }
     // <<"searching file for $the_start\n";
      //the_start.pinfo();
      // <<"         \n";
      //<<" \n";

  i=searchFile(AFH,the_start,0,1,0);

//  <<[_DB]"$i\n";

//<<"index found was $i \n"

  if (i == -1) {
 // printf("the_start  %s not found \n", stoa(the_start));

  //printf("the_start  %s not found \n", the_start);

  try_start = nameMangle(the_start);
  
  i=searchFile(AFH,try_start,0,1,0);
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
}

//  DBG"inputs  $the_start\n";
// -------------------------------
//<<"%V$input_lat_long  $i \n"

  int nwr;
  Str w;
  if (input_lat_long) {
// <<" input place !\n"

  }

  else {

  fseek(AFH,i,0);

  if (via_keyb) {

   w=pclFile(AFH);

   }

  else {
	  //<<"pcl \n"
	    //w=pcl_file(A,0,1,0)

   }

  ki = seekLine(AFH,0);

  //DB//printf("reset to file start %d\n",ki);

  //<<[_DB]" $ki back to beginning of line ?\n";
	  // need to step back a line

  if (use_cup) {

   nwr = Wval.readWords(AFH,0,',');


   //cout <<" cup nwr " << nwr << endl;

//<<"$Wval[0] $Wval[1] $Wval[3] $Wval[4] \n"	 

   }

  else {

   nwr = Wval.readWords(AFH);

   }
      //    <<" %i $Wval \n"

//  DBG"$nwr $Wval[0] $Wval[1] $Wval[2] $Wval[3] \n";
	  //    msz = Wval.Caz()
	// <<"%V$msz \n"
	// <<"%V$n_legs \n"

COUT(Wval)
  tplace = Wval[0];

COUT(Wval[4])
  if (use_cup) {

   tlon = Wval[4];

   }

  else {

   tlon = Wval[3];

   }

COUT(tlon)
//<<"%V$tplace $tlon \n"

#if ASL_DB
<<"$Wval[::]\n"	  
<<" start ? $n_legs \n";
#endif



  if (use_cup) {
   GT_Wtp[n_legs].TPCUPset(Wval);

   }
  else {
     GT_Wtp[n_legs].TPset(Wval);
   }

 }

   
//  cout << "Next TP " << endl;
  
//<<"next   $cnttpt \n"
// NEXT TURN

  int more_legs = 1;

  ok_to_compute = 1;
 // FIX

  float the_leg;
//<<"%V $AFH\n";

  while (more_legs == 1) {

 // fseek(AFH,0,0);

  if (via_cl) {

  nxttpt = CLTPT[cnttpt];

//<<"%V  $nxttpt   $cnttpt $cltpt \n"

#if CPP
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
  if ((nxttpt == "done") || (nxttpt == "finish") || (nxttpt == "quit") ) {

 //cout << endl;
  if (GT_DB) printf("done %s\n",nxttpt);
  more_legs = 0;

  }

  else {

#if CPP
 if (GT_DB) cout <<"looking for " << nxttpt << endl;
#else
 //<<"AFH $AFH looking for $nxttpt \n";
#endif

//<<"%V $AFH\n"

  AFH = K_AFH;



//<<"%V $AFH   $nxttpt \n"

  where = searchFile(AFH,nxttpt,0,1,0);

//<<"%V $AFH\n"

//cout <<"Found? " << nxttpt << " @ " << where <<endl;

    if (where  == -1) {

        try_start = nameMangle(nxttpt);

      where = searchFile(AFH,try_start,0,1,0);
      
       if (AFH != K_AFH) {
        printf("ERROR AFH %d\n",AFH);
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
//<<"%V $AFH\n"
    if (GT_DB) printf ("n_legs %d where %d found %s ",n_legs, where,nxttpt);
    
   }

  }

  if (more_legs) {


  where = fseek(AFH,where,0);

  n_legs++;

  if (GT_DB) printf("n_legs %d where %d AFH %d\n",n_legs,where , AFH);

//cout << " n_legs "<< n_legs <<" @ " << where << endl;

  if (via_keyb) {

      pclFile(AFH);

   }

  else {
	      // w=pclFile(AFH,0,1,0)

   }
	// fseek(A,w,0)

      where  = seekLine(AFH,0);




//cout << n_legs <<" @2 " << where << endl;


  if (use_cup) {

 //  nwr = Wval.readWords(AFH,0,',');
 
   nwr = Wval.readWords(AFH,0,',');




  //  cout <<" next  nwr " << nwr << endl;
#if CPP
  if (GT_DB) COUT(Wval);
#endif

#if ASL_DB
<<"%V $nwr \n"
<<"$Wval \n";
<<"%V $AFH $n_legs $Wval[0] $Wval[1]  $Wval[4] \n"
#endif



   GT_Wtp[n_legs].TPCUPset(Wval);



 //  cout  <<" "<< n_legs  <<" "<< Wval2[0]  <<" "<< Wval2[1]  <<" "<< Wval2[3]  <<" "<< Wval2[4]  <<endl ; 
 //  Wval2.vfree();
   
   }

  else {

   nwr = Wval.readWords(AFH);

   GT_Wtp[n_legs].TPset(Wval);

#if ASL
     if (AFH != K_AFH) {
       <<"ERROR %V $AFH\n"
     }
#endif

   }

 // msz = Wval.Caz();

  }

  L1 = GT_Wtp[nl].Ladeg;
 // printf("n_legs [%d] L1 %f\n",n_legs, L1);
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
  if (show_title) {
    printf("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n");

//  <<"Leg   TP      ID   LAT      LONGI      FGA     MSL   PC    $Units   RTOT   RTIM    Radio    TC \n";
    printf("Leg   TP      ID   LAT      LONG      FGA    MSL   PC   Dist  Hdg   Dur RTOT   RTIM  Radio   \n") ; 
  }
  
// get totals


  float rtime = 0.0;
  float tot_time = 0.0;
  float rtotal = 0.0;
// in main --- no obj on stack?
  float nleg,wleg;
  float agl,ght,pc_tot,alt;
  if (ok_to_compute) {
   //computeHTD()

  totalD = 0;


  
  
  for (nl = 0; nl < n_legs ; nl++) {
#if ASL_DB
<<"$nl   $n_legs  $GT_Wtp[nl].Place  $GT_Wtp[nl+1].Place  $GT_Wtp[nl].Ladeg  \n"
// ans=query("??");
#endif
  L1 = GT_Wtp[nl].Ladeg;

  L2 = GT_Wtp[nl+1].Ladeg;
       //DBG"%V $L1 $L2 \n"

  lo1 = GT_Wtp[nl].Longdeg;

  lo2 = GT_Wtp[nl+1].Longdeg;
       //DBG"%V $lo1 $lo2 \n"
      // tkm = ComputeTPD(nl, nl+1);

  tkm = HowFar(lo1 ,L1, lo2, L2);
//cout << "L1 " << L1 << " lo1 " << lo1 << " L2 " << L2 << " lo2 " << lo2 << " tkm " << tkm << endl;      // DBG"%V $nl $tkm \n"

  TKM[nl] = tkm;

  Leg[nl] = tkm;

  GT_Wleg[nl+1].dist = tkm;

//<<"%V $nl $tkm $Leg[nl] $TKM[nl]\n"

  //DBG"%V $GT_Wleg[nl].dist\n";
       //Leg[nl] = ComputeTPD(nl, nl+1)

  tcd =  ComputeTC(GT_Wtp,nl, nl+1);
COUT(tcd);
 
  L1 = GT_Wtp[nl].Ladeg;

  L2 = GT_Wtp[nl+1].Ladeg;

  lo1 = GT_Wtp[nl].Longdeg;

  lo2 = GT_Wtp[nl+1].Longdeg;

//  tc = TrueCourse(L1,lo1,L2,lo2);
 tcd = TrueCourse(lo1,L1,lo2,L2);

COUT(tcd);


  TC[nl+1] = tcd;

//  Dur[nl+1] = Leg[nl]/ Cruise_speed;

    Dur[nl+1] = tkm / Cruise_speed;
 //<<"%V $Leg[nl] $tkm $Dur[nl+1] \n"

  totalDur += Dur[nl+1];

  totalD += tkm;

#if ASL_DB
<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"
#endif
  }
    //  <<" $total \n"

  rmsl = 0.0;

  msl = 0.0;

  pc_tot = 0.0;

  for (nl = 0; nl <= n_legs ; nl++) {

  if (nl == 0) {

   the_leg =0;

   pc_tot = 0.0;

   }

  else {

   the_leg = Leg[nl-1];

   pc_tot = 0.0;

   if (totalD > 0) {

     pc_tot = the_leg/totalD * 100.0;

     GT_Wleg[nl].pc = pc_tot;
#if ASL_DB     
//<<"%V $nl $the_leg $totalD $pc_tot  $GT_Wleg[nl-1].pc  \n"
#endif
     }

   }

  nleg = the_leg * km_to_nm;

  alt =  GT_Wtp[nl].Alt;

  msl = alt;
    //    <<" %I $msl $GT_Wtp[nl].Alt \n"
    //    <<" %I $nl $msl \n"
    //    <<" %I $rmsl $GT_Wtp[nl+1].Alt \n"
    //<<" %I $LoD \n"

  ght = (Leg[nl] * km_to_feet) / LoD;
    //<<" $ght = ${Leg[nl]} * $km_to_feet / $LoD \n"
    // <<"    $agl = $ght + 1200.0 + $rmsl \n"

  if (nl == n_legs) {

   agl = 1200 + msl;

   }

  else {

   rmsl =  GT_Wtp[nl+1].Alt;

   agl = ght + 1200.0 + rmsl;

   }

  GT_Wtp[nl].fga = agl;

  tpb = GT_Wtp[nl].Place;

//<<"%V  $nl $GT_Wtp[nl].Place   $GT_Wtp[nl].fga\n"
//cout  <<"nl "<< nl  <<"GT_Wtp[nl].Place "<< GT_Wtp[nl].Place  <<"GT_Wtp[nl].fga "<< GT_Wtp[nl].fga  <<endl ;


  ident = GT_Wtp[nl].Idnt;

//<<"%V $tpb $ident \n"

//cout  <<"tpb "<< tpb  <<" ident "<< ident  <<endl ; 




  li = nl;
  

  rtotal += the_leg;

  if (Units == "KM") {

   wleg = the_leg ;

   }

  else {

   wleg = nleg ;

   }
 //   kiss = "^$tpb"
 //   ki=Fsearch(A,kiss,0,1,0,0,1)
 //   tpb = nameMangle(tpb);
 // <<"namemangle returns $tpb \n"

  if (li > 0) {

   rtime = Dur[li-1];

   }
//    rtime.info(1)
//<<"%V $li $rtime $Dur[li] \n"

  if (li == 0) {

   wleg = 0.0;

   rtotal = 0;

   }

  int tplen = tpb.slen();

  Str ws =  nsc((12-tplen)," ");

  int idlen = ident.slen();

  Str wsi= nsc((10-idlen)," ");
  float tct;
  float dct;
  
 // <<"$li $GT_Wleg[li]->dist  $GT_Wleg[li]->pc_tot \n"
 //<<"$li ${tpb}${ws}${ident}${wsi} %9.3f${GT_Wtp[li]->Lat} %11.3f${GT_Wtp[li]->Lon}\s%10.0f${GT_Wtp[li]->fga} ${GT_Wtp[li]->Alt} %4.1f$GT_Wleg[li]->pc ";

   tot_time += Dur[li];


#if ASL
// <<"$li ${tpb}${ws}${ident}${wsi} ${GT_Wtp[li]->Lat} ${GT_Wtp[li]->Lon}\s%11.0f${GT_Wtp[li]->fga} ${GT_Wtp[li]->Alt} %4.1f$GT_Wleg[li]->pc_tot ";
tct = TC[li];
dct = Dur[li];
<<"$li ${tpb}${ws}${ident}${wsi} ${GT_Wtp[li]->Lat} ${GT_Wtp[li]->Lon}\s%11.0f${GT_Wtp[li]->fga} ${GT_Wtp[li]->Alt} %4.1f$GT_Wleg[li]->pc_tot ";
<<"%6.2f $GT_Wleg[li]->dist\t $TC[li]\t $Dur[li]\t $rtotal\t$tot_time ${GT_Wtp[li]->Radio}\n";


//<<"$GT_Wleg[li]->dist\t$tct\t$dct\t$rtotal\t%6.2f${GT_Wtp[li]->Radio}\n";

//  ans=query("??");
#else
// printf("%d %s  \t%s\t%s   %6.0fft   %6.0fft         \n",li,ident,GT_Wtp[li].Lat,GT_Wtp[li].Lon, GT_Wtp[li].fga, GT_Wtp[li].Alt);
printf("%d %s%s%s%s%s %s  %6.0fft  %6.0fft ",li,GT_Wtp[li].Place.cptr(),ws.cptr(),ident.cptr(),wsi.cptr(),GT_Wtp[li].Lat.cptr(),GT_Wtp[li].Lon.cptr(), GT_Wtp[li].fga, GT_Wtp[li].Alt);

   printf("\t%6.2f%%",GT_Wleg[li].pc); 
    printf("\t%5.1f ",GT_Wleg[li].dist);
  
//cout  << "%5.1f$GT_Wleg[li]->dist\t$rtotal\t$rtime\t%6.2f${GT_Wtp[li]->Radio} " ; 
  printf("\t%6.0f ",TC[li]);

  printf("\t%6.2f %6.2f %6.2f ",Dur[li],rtotal,tot_time);

  printf("\t%s\n",GT_Wtp[li].Radio.cptr())  ; 
#endif

  }

  if (show_dist) {
#if ASL
  <<"Total distance\t %8.2f $totalD km\t%8.2f $(totalD*km_to_sm) sm\t%6.2f  $(totalD*km_to_nm) nm    LOD %6.1f$LoD CS $CSK knots\n";

  <<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n";
#else
  printf("Total distance\t %8.2f km\t%8.2f sm\t%6.2f  nm  LOD %6.1f  \n", totalD,(totalD*km_to_sm),(totalD*km_to_nm),LoD);
//ans=query("totalD ?");
#endif

//printf("totalD %f   totalDur %f\n",totalD,totalDur);

//     cout << "total D "  << endl;
  //   cout << ::totalD    <<endl ; 

     printf("totalD  %6.2f km to fly - %6.2f hrs - bon voyage!\n ", totalD, totalDur);

     //cout.flush();

//ans=query("totalD ?");
}

  else {

 // <<"# \n";

  }

  }

//  <<"%6.1f $totalD km to fly -  $totalDur hrs - bon voyage!\n";


#if CPP
}
////////////////////////////////////////////////////////////////////////////////////////
extern "C" int glider_task(Svarg * sarg)  {

 Str a0 = sarg->getArgStr(0) ;
 Str ans;
 a0.pinfo();

Str Use_ ="compute task distance\n  e.g  asl anytask.asl   gross laramie mtevans boulder  LD 40";


 printf(" glideTask app %s ",Use_.cptr() );
 //cout << " paras are: "  << " a0 " <<  a0 << endl;

    Uac *o_uac = new Uac;



    o_uac->glideTask(sarg);

   //cout << "total D " << ::totalD    <<endl ;

  }

#endif



//exit(0,"%6.1f$totalD km to fly -  $totalDur hrs")
/*
  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint
*/

//==============\_(^-^)_/==================//
