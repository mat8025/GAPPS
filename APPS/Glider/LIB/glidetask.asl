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


///////////////////////
//uint Turnpt::Ntp_id = 0;

int Ntp_id = 0; // ids for turnpt objs
int TF; // task file FH
int AFH= -1;
float CSK;
float Cruise_speed;

Svar Task;

#include "conv.asl"

#include "tpclass.asl"

Turnpt  Wtp[50];

Tleg  Wleg[20];

#include "ootlib.asl"



  int via_keyb = 0;

  int via_file = 0;

  int via_cl = 1;
  int ok_to_compute = 1;
  long where ;
  
void
Uac::glideTask(Svarg * sarg)  
{

 Str a0  = sarg->getArgStr(0) ;

a0.pinfo();
 Svar sa;

 sa.findWords(a0.cptr());

cout << " gliderTask paras are:  "  << sa << endl;

cout << " para[1] is:  "  << sa.cptr(1) << endl;


 // ignoreErrors(); // put in uac.h ??

  chkIn(1);  //  _dblevel ?
  
//setMaxICerrors(-1) // ignore - overruns etc

int  Main_init = 1;


//<<"%V $totalD\n"

  float Leg[20];

  float CSK = 70.0;

  float Cruise_speed = (CSK * nm_to_km);

  cout <<" Cruise_speed "  << Cruise_speed << endl;




  Wtp[1].Alt = 100.0;

  Wtp[40].Alt = 5300.0;

//  <<"$Wtp[1].Alt\n";

//  Wtp.pinfo() ;  // should identify Obj

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

  int nerror = 0;

  int use_cup = 1;

  if (use_cup) {

  AFH=ofr("CUP/bbrief.cup")  ; // open turnpoint file;

  }

  else {

  AFH=ofr("DAT/turnptsA.dat")  ; // open turnpoint file;

  }

  if (AFH == -1) {

  printf( " can't find turnpts file \n");
  exit(-1);

  }

  int brief = 0;

  int show_dist = 1;

  int show_title = 1;

//main

//  int na = getargc();

  int na = sa.getNarg();

//  DBG"%v $na\n";

  printf(" na %d\n",na);


  int ac = 0;

  float LoD = 35;

  int istpt = 1;

  int cltpt = 0;
  int sz;
  
  Str targ;

  //<<" %V $LoD \n";

  while (ac < na) {

  istpt = 1;

  targ = sa.cptr(ac);

cout <<"ac "<< ac <<" " << targ << endl;

//  DBG"%V $ac $targ\n";

  sz = targ.slen();

  ac++;

  if (sz > 0) {

  if (targ == "LD") {

  LoD= atof(sa.cptr(ac));

  ac++;

  istpt = 0;

  cout <<"setting LD " << LoD << endl;

  }

  if (targ == "CS") {

  CSK = atof(sa.cptr(ac));

  ac++;

  istpt = 0;

  Cruise_speed = (CSK * nm_to_km);

    printf("setting CS CSK %f knots Cruise_speed %f kmh \n",CSK,Cruise_speed);

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


   cout <<" task" <<  Task.cptr(0) << endl;



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
 //   <<"%V $ac  $targ $sz $istpt \n"

  if (istpt) {

  via_keyb = 0;

  via_cl = 1;

 // CLTPT[cltpt] = targ;   // TBF 02/24/22
  CLTPT.cpy(targ,cltpt); 


//	<<"%V$targ $sz $cltpt $CLTPT[cltpt] \n"
cout  <<"cltpt "<< cltpt  <<" CLTPT[cltpt] "<< CLTPT[cltpt]  <<endl ; 

  cltpt++;

  }
    //    <<"%V $ac  $targ $sz \n"
   } // arg was valid
  }
// look up lat/long

  Str the_start= "Longmont";

  Str nxttpt = "Laramie";

  float N = 0.0;

  int ki;

  int cnttpt = 0;
// enter start

  int input_lat_long = 0;

  int i = -1;


 cout << "DONE ARGS  ac "<<ac << endl;




////   do this to check routine    
    //<<"Start  $the_start \n"
// first parse code bug on reading svar fields?


  int k;
  
  for (k= 0; k < cltpt; k++) {

//  <<"$k  $CLTPT[k] \n";
cout  <<" "<< k  <<" "<< CLTPT[k]  <<endl ; 
  }
/////////////////////////////

  i = -1;
 int got_start = 0;
  while ( !got_start) {

 // <<[_DB]" iw %V $cnttpt $i %v $via_keyb $via_cl\n";

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
      //<<"searching file for $the_start\n";
      // <<"         \n";
      //<<" \n";

  i=searchFile(AFH,the_start,0,1,0);

//  <<[_DB]"$i\n";
      //<<"index found was $i \n"

  if (i == -1) {

  the_start = nameMangle(the_start);
  i=searchFile(AFH,the_start,0,1,0);
  }



  if (i == -1) {

//  <<"$the_start not found \n";
cout  <<" "<< the_start  << "not "  << "found "  <<endl ; 
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

  //<<[_DB]" $ki back to beginning of line ?\n";
	  // need to step back a line

  if (use_cup) {

   nwr = Wval.readWords(AFH,0,',');


   cout <<" cup nwr " << nwr << endl;

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

  tplace = Wval[0];

  if (use_cup) {

   tlon = Wval[4];

   }

  else {

   tlon = Wval[3];

   }
//<<"%V$tplace $tlon \n"
//<<"$Wval[::]\n"	  

  if (use_cup) {
   Wtp[n_legs].TPCUPset(Wval);
   }
  else {
     Wtp[n_legs].TPset(Wval);
   }

 }

   
  cout << "Next TP " << endl;
  
//<<"next \n"
// NEXT TURN

  int more_legs = 1;

  int ok_to_compute = 1;
 // FIX

  float the_leg;

  while (more_legs == 1) {

  fseek(AFH,0,0);

  if (via_cl) {

  nxttpt = CLTPT[cnttpt];

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

 cout << endl;

  more_legs = 0;

  }

  else {

 // cout <<"looking for " << nxttpt << endl;


  where =searchFile(AFH,nxttpt,0,1,0);

//  cout <<"Found? " << nxttpt << " @ " << where <<endl;


  if (where  == -1) {

   cout <<"not found! " << nxttpt << endl;

   ok_to_compute = 0;

   if (!via_keyb) {
        printf ("nxttpt not found %s",nxttpt);
     exit(-1);

     }

   }

  }

  if (more_legs) {

  where = fseek(AFH,where,0);

  n_legs++;

cout << " n_legs "<< n_legs <<" @ " << where << endl;

  if (via_keyb) {

      pclFile(AFH);

   }

  else {
	      // w=pclFile(AFH,0,1,0)

   }
	// fseek(A,w,0)

  where  = seekLine(AFH,0);

cout << n_legs <<" @2 " << where << endl;

  if (use_cup) {

 //  nwr = Wval.readWords(AFH,0,',');
 
   nwr = Wval.readWords(AFH,0,',');
   
    cout <<" next  nwr " << nwr << endl;


// <<"$n_legs $Wval[0] $Wval[1] $Wval[3] $Wval[4] \n"

   Wtp[n_legs].TPCUPset(Wval);

 //  cout  <<" "<< n_legs  <<" "<< Wval2[0]  <<" "<< Wval2[1]  <<" "<< Wval2[3]  <<" "<< Wval2[4]  <<endl ; 
 //  Wval2.vfree();
   
   }

  else {

   nwr = Wval.readWords(AFH);

   Wtp[n_legs].TPset(Wval);

   }

 // msz = Wval.Caz();

  }

  }
    //      prompt("%v $more_legs next turn %-> ")
// compute legs
 //<<"compute \n"

//  ild= abs(LoD);

//  <<"%V  $CSK knots $Cruise_speed kmh\n";
  cout  <<"CSK "<< CSK  << "knots "  <<"Cruise_speed "<< Cruise_speed  << "kmh "  <<endl ;
  
  if (show_title) {
cout  << "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "  <<endl ; 

//  <<"Leg   TP      ID   LAT      LONGI      FGA     MSL   PC    $Units   RTOT   RTIM    Radio    TC \n";
cout  << "Leg   TP      ID   LAT      LONGI      FGA    "  << "MSL   PC    " << Units   << " RTOT   RTIM  Radio  TC "  <<endl ; 
  }
  
// get totals

  float rtime = 0.0;

  float rtotal = 0.0;
// in main --- no obj on stack?
  float nleg,wleg;
  float agl,ght,pc_tot,alt;
  if (ok_to_compute) {
   //computeHTD()

  totalD = 0;
//totalD->info(1)

  float TKM[20];
  float L1,L2,lo1,lo2;
  double tkm;
  float tcd,rmsl,msl;
  int nl,li;
  Str ident;
  for (nl = 0; nl < n_legs ; nl++) {

  L1 = Wtp[nl].Ladeg;

  L2 = Wtp[nl+1].Ladeg;
       //DBG"%V $L1 $L2 \n"

  lo1 = Wtp[nl].Longdeg;

  lo2 = Wtp[nl+1].Longdeg;
       //DBG"%V $lo1 $lo2 \n"
      // tkm = ComputeTPD(nl, nl+1);

  tkm = HowFar(lo1 ,L1, lo2, L2);
//cout << "L1 " << L1 << " lo1 " << lo1 << " L2 " << L2 << " lo2 " << lo2 << " tkm " << tkm << endl;      // DBG"%V $nl $tkm \n"

  TKM[nl] = tkm;

  Leg[nl] = tkm;

  Wleg[nl+1].dist = tkm;
//<<"%V $nl $tkm $Leg[nl] $TKM[nl]\n"

  //DBG"%V $Wleg[nl].dist\n";
       //Leg[nl] = ComputeTPD(nl, nl+1)

  tcd =  ComputeTC(nl, nl+1);

  TC[nl] = tcd;

  Dur[nl] = Leg[nl]/ Cruise_speed;
//<<"%V $Leg[nl] $tkm \n"

  totalDur += Dur[nl];

  totalD += tkm;
//<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"

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

     Wleg[nl-1].pc = pc_tot;
	     //<<"%V $nl $the_leg $pc_tot\n"

     }

   }

  nleg = the_leg * km_to_nm;

  alt =  Wtp[nl].Alt;

  msl = alt;
    //    <<" %I $msl $Wtp[nl].Alt \n"
    //    <<" %I $nl $msl \n"
    //    <<" %I $rmsl $Wtp[nl+1].Alt \n"
    //<<" %I $LoD \n"

  ght = (Leg[nl] * km_to_feet) / LoD;
    //<<" $ght = ${Leg[nl]} * $km_to_feet / $LoD \n"
    // <<"    $agl = $ght + 1200.0 + $rmsl \n"

  if (nl == n_legs) {

   agl = 1200 + msl;

   }

  else {

   rmsl =  Wtp[nl+1].Alt;

   agl = ght + 1200.0 + rmsl;

   }

  Wtp[nl].fga = agl;

  tpb = Wtp[nl].Place;

//<<"%V  $nl $Wtp[nl].Place   $Wtp[nl].fga\n"
//cout  <<"nl "<< nl  <<"Wtp[nl].Place "<< Wtp[nl].Place  <<"Wtp[nl].fga "<< Wtp[nl].fga  <<endl ;


  ident = Wtp[nl].Idnt;

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

  Str ws =  nsc((15-tplen)," ");

  int idlen = ident.slen();

  Str wsi= nsc((15-idlen)," ");
 // <<"$li $Wleg[li]->dist  $Wleg[li]->pc_tot \n"

 // <<"$li ${tpb}${ws}${ident}${wsi} %9.3f${Wtp[li]->Lat} %11.3f${Wtp[li]->Lon}\s%11.0f${Wtp[li]->fga} ${Wtp[li]->Alt} %4.1f$Wleg[li]->pc_tot\t";
 printf("%d %s  \t%s\t%s   %6.0fft   %6.0fft         ",li,ident.cptr(),Wtp[li].Lat.cptr(),Wtp[li].Lon.cptr(), Wtp[li].fga, Wtp[li].Alt);
 // <<"%5.1f$Wleg[li]->dist\t$rtotal\t$rtime\t%6.2f${Wtp[li]->Radio}";
  printf("%5.1f ",Wleg[li].dist);
  
//cout  << "%5.1f$Wleg[li]->dist\t$rtotal\t$rtime\t%6.2f${Wtp[li]->Radio} " ; 
  printf("\t%6.0f hdg",TC[li]);

   printf("\t%6.2f %",Wleg[li].pc);
  //<<"\t%6.2f$Dur[li]\n";
  printf("\t%6.2f hrs",Dur[li]);

  printf("\t%s\n",Wtp[li].Radio.cptr())  ; 

  }

  if (show_dist) {

  //<<"Total distance\t %8.2f$totalD km\t%8.2f$(totalD*km_to_sm) sm\t%6.2f$(totalD*km_to_nm) nm    LOD %6.1f$LoD \n";

  //<<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n";

  }

  else {

 // <<"# \n";

  }

  }

//  <<"%6.1f $totalD km to fly -  $totalDur hrs - bon voyage!\n";
 cout   << totalD  << "km to fly - " << totalDur  << "hrs "  << "- bon voyage! "  <<endl ; 

}


////////////////////////////////////////////////////////////////////////////////////////



extern "C" int glider_task(Svarg * sarg)  {

 Str a0 = sarg->getArgStr(0) ;

 a0.pinfo();

Str Use_ ="compute task distance\n  e.g  asl anytask.asl   gross laramie mtevans boulder  LD 40";


 cout << " glideTask app " << Use_   << endl;
 cout << " paras are: "  << " a0 " <<  a0 << endl;

    Uac *o_uac = new Uac;



    o_uac->glideTask(sarg);

  }





//exit(0,"%6.1f$totalD km to fly -  $totalDur hrs")
/*
  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint
*/

//==============\_(^-^)_/==================//
