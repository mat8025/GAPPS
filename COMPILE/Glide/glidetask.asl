/* 
 *  @script glidetask.asl                                               
 * 
 *  @comment task-planner cpp script                                    
 *  @release Beryllium                                                  
 *  @vers 4.8 O Oxygen [asl 6.4.76 C-Be-Os]                             
 *  @date 02/07/2023 10:34:08                                           
 *  @cdate 9/17/1997                                                    
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 
//----------------<v_&_v>-------------------------//                  







//#include "debug.asl"

 
#define DB_IT    0
#define GT_DB   0
#define __ASL__ 1
#define __CPP__ 0


#if __ASL__
// this include  when cpp compiling will re-define __ASL__ 0 and __CPP__ 1
//#include "compile.asl"

#endif


#if __CPP__
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#undef GT_DB
#define GT_DB 0 

#define CPP_DB 1

#endif

///////////////////////


#if __ASL__

#define CPP_DB 0

#define COUT //

    run_asl = runASL();
//<<" running as ASL \n";

  //debugON();

 ignoreErrors();
 //echolines(0)

#endif





int TF; // task file FH
 
int AFH= -1;
 
float CSK;
float Cruise_speed;

float TC[20];
float Dur[20];


  Svar Task;

  totalD = 0.0;

  totalDur = 0.0;

  float TKM[20];
  float AGL[20];
  char  Hey[10] = "hey hey";
  float L1;
  float L2;
  //float lo1,lo2;
  float lo1;
  float lo2;
  double tkm;
  double tkm2;
  float tcd;
  float rmsl;
  float tmsl;
  float msl;
  int nl,li;
  Str ident;
  
  n_legs = 0;
  n_tp = 0;
  k_tp= 0;
 
  the_start = "Longmont";
  try_place = "xxx";
  ry_start = "xxx";
  nxttpt = "Laramie";

  Str ans;

//<<"%V $nxttpt \n"

//#include "conv.asl"

//ans=ask(" ??",0)

///#include "tpclass.asl"

///////////////////////////////////////////////////////////////


class Tleg 
 {

 public:

  
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float tfga;
  //  msl is part of class should not clash with global msl
  float msl;

  Str Tow;
  Str Tplace;

//  use cmf for cons,destruct
//  preprocess to asc will remove cmf
 cmf Tleg()   
 {
 //<<"Starting cons \n"
  dist = 0.0;
  pc = 0.0;
  tfga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"
 }
 
 Str getPlace ()   
   {
       return Tplace; 
   }

 cmf ~Tleg()   
 {
    //<<"destructing Tleg \n";
 }
};   



int Ntp_id = 0; // ids for turnpt objs


class Turnpt 
 {

 public:
 //static uint Ntp_id;
  Str Lat;
  Str Lon;
  Str Place;
  
  Str Idnt;
  Str rway;
  Str tptype;
  
  Str Cltpt;
  Str Radio;
  float Alt;
  float fga;  // final glide msl to next TP?
  float Ladeg;
  float Longdeg;
  int is_airport;
  int is_strip;
  int is_mtn;
  int is_mtn_pass;
  
  int id;
  //int match[2];
  int match;
  Str smat; ;
  
//  int amat;

//  method list

// for cpp  either use reference or ptr
// else copy constructor - memory corruption  - it makes a copy of the svar then
// there will double resf to mem pointers
//  either Svar* ot Svar& MUST be used


  void TPset (Svar& wval)
   {

//<<"TPset $_proc $wval \n"

//   wval.pinfo()


//<<": $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"
 //ans=ask(" wval $wval  ",1)

     is_airport =0;
     is_mtn =0;
     is_mtn_pass =0;     
     
     Place = wval[0]; // wayp 

     Idnt =  wval[1];

    //cout  << "Idnt  "  << Idnt  << endl ;


     Lat = wval[2]; // wayp 

     Lon = wval[3];
     
     Alt = atof(wval[4]);
     
     rway = wval[5];
     
     Radio = wval[6];

     tptype = wval[7];

    if (tptype == "TPA") {
       is_airport = 1;
    }
    if (tptype == "TPM") {
       is_mtn = 1;
    }
    if (tptype == "TPP") {
       is_mtn_pass = 1;
    }
     
     //smat = spat (&tptype, "A",-1,-1,match);

     Ladeg =  coorToDeg(Lat); // wayp
     
     Longdeg = coorToDeg(Lon);

      }
//=========================//



//void TPCUPset (Svar& wval)
void TPCUPset (Svar& wval)
 {

//<<"IN $_proc \n"
Str val;

Str val2;
//    wval.pinfo();
 //<<"%V $Alt\n";
int lastc = -1;
//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

//<<"%V $wval\n"
     val = wval[0];
     
//<<"%V $val\n"


//cout << "val " << val << endl;
//pa(wval); // crash ??


//      val.aslpinfo();

      val.dewhite(); // TBF ? corrupting vars ?
  //    <<"%V $val\n"
//<<"%V $AFH\n"
//DBaction((DBSTEP_),ON_)
//allowDB("ic_,oo_,spe_,rdp_,pexpnd,tok,array")

     val.scut(1);

  //    <<"%V $val\n"


     //val.scut(-1);
     val.scut(lastc);

  //    <<"%V $val\n"

     Place = val; // wayp 

//<<"%V $place \n";

     val =  wval[1];

     val.scut(lastc);
     
     val.scut(1);

     Idnt = val;
//<<"%V $AFH\n"

//  <<"%V$Idnt\n"
//Idnt->info(1)

     Lat = wval[3]; // wayp
     


     ccoor(Lat);
//<<"%V $Lat \n"     
 
     Lon = wval[4];

     ccoor(Lon);

// <<"%V$Lon  \n"
  
     val = wval[5];

//<<" %V $val \n";

    // pa(val);
    // ft or m

//ans=query("?","sele",__LINE__);

    val2 = sele(val,-1,-2);

//<<"%V $val2\n"
    if (val2 == "ft") {

      val.scut(-2); 
//<<"ft  $val\n";
      Alt = atof(val);
   }
    else {
       val.scut(-1);
//<<"m $val\n";       
            Alt = atof(val);
	    Alt *= 3.280839 ;

    }
 //<<"%V$val $val2 $Alt  \n"


//cout  <<"Alt "<< Alt  <<endl ; 
//    pa(val,Alt);

     is_airport =0;
     is_mtn =0;
     is_mtn_pass =0;     
     is_strip = 0;
     rway = wval[6];

//cout << "rway " << rway  << endl;

     if (rway == "5") {
         is_airport =1;
     }

     if (rway == "3") {
         is_strip =1;
     }

     if (rway == "7") {
         is_mtn =1;
     }

     if (rway == "8") {
         is_mtn_pass =1;
     }

     rway = wval[7];

     if (rway != "") {
       //  is_airport =1;
     }



    val = wval[9];


     //Radio = atof(wval[9]);

     Radio = wval[9];

     if (Radio == "") {
          Radio = "    -    ";
     } 


//<<"Radio <|$Radio|> wval[9] $val  \n"
//ans=query("??");
//ans=ask("%V $Radio ",1)


//     
 //cout  <<"Radio "<< Radio  <<endl ; 

     tptype = wval[10];
     
// spat (tptype,"A",-1,-1,&is_airport);
//<<"%V $Lat \n";
//allowDB("ic,spe_,rdp")

     Ladeg =  coorToDeg(Lat,2); 
 
 
//<<"%V $Lat $Ladeg \n";
//ans=ask("¿Es eso correcto?  [y,n,q]",1);

 //cout  <<"Lat " << Lat <<" Ladeg "<< Ladeg  <<endl ; 

     Longdeg = coorToDeg(Lon,2);

//cout  <<"Lon " << Lon <<" Longdeg "<< Longdeg  <<endl ; 

//<<"%V $Lon $Longdeg \n";
//<<"%V $Place $is_airport \n"


 }


//=========================//

void SetPlace (Str val)   
   {
       Place = val;
   }
//=========================//

  Str GetPlace ()   
   {
       return Place; 
   }
//=========================//
   void Print ()    
   {
     //<<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"

     <<" $Place  $Lat $Lon $Radio\n"

   }
//=========================//


 int GetTA()   
   {
      int amat[4]; // TBF 6/21/24 should not get translated to Vec<int>
     // spat (tptype.cptr(),"A",-1,-1,amat);
      spat (tptype,"A",-1,-1,amat);
    //  pa("amat ",amat);
      return amat[0];
   }
//=========================//

cmf Turnpt()
 {
            Ntp_id++;
	    id = Ntp_id;
      Place = " ";
      Ladeg = 0.0;
      Longdeg = 0.0;
      Alt = -1.5;
    //<<"CONS $id $Ntp_id\n"
   }
//=========================//

};
//======================================//

//float ComputeTC(Turnpt& wtp,int j, int k)
// need to get Turnpt wtp[]  to work?
//  TBF float ComputeTC(Turnpt wtp[],int j, int k)  - bad translate to
//  Vec<not_known_dtype> ComputeTC ()  ;  - which is wrong


   float ComputeTC(Turnpt wtp[],int j, int k)
   {

        <<"$_proc %V $j $k\n";   // TBF 6/20/24  wtp[] syntax does not get j or k
  //wtp.pinfo();

 float L1,L2,lo1,lo2,km,tc;   // TMP fix

        km = 0.0;  // TBF 6/21/24 should sac to double does not -- in PROC ??

        tc = 0.0;


        L1 = wtp[j].Ladeg;  // TBF 6/21/24  does not look up Turnpt mbr Ladeg

        L2 = wtp[k].Ladeg;
//<<"%V $L1 $L2 \n";

        lo1 = wtp[j].Longdeg;

        lo2 = wtp[k].Longdeg;
//<<"%V $lo1 $lo2 \n";
//  tc = TrueCourse(L1,lo1,L2,lo2);

        tc = TrueCourse(lo1,L1,lo2,L2);  // TBF 6/21/24  does not look up TrueCourse
  //printargs(j, k ,L1 ,lo2 ,"tc=", tc);

       <<" Leg $k $tc \n" 

        return tc;

   }

//===========================//
/////////////////////////////////////////////////////////




///////////////////////////////////////////////////
// should not translate the include if it is a asc file!

#include "ootlib.asl"


  Turnpt  GT_Wtp[50];

  Tleg  GT_Wleg[20];

// ans=ask("do inc ootlib.asl",1)



/// are all globals in preprocessing stage known here

  int via_keyb = 0;
  int via_file = 0;

  int via_cl = 1;
  int ok_to_compute = 1;
  long where ;
/////////////////////////////////////

 Svar sargs;

#if __CPP__
int main( int argc, char *argv[] ) { // main start
   RunCPP = 1;
   for (int i= 0; i <argc; i++) {
     sargs.cpy(argv[i],i);
   }
#endif

  int na;



#if __ASL__

  na = _clargc;
  sargs = _clarg;

#endif

  ignoreErrors(); // put in glide.h ??

  allowErrors(-1)

//DBaction((DBSTEP_),ON_)

  

  int  Main_init = 1;
  float Leg[20];
  Str try_start = "";
 
  CSK = 70.0;


  Cruise_speed = (CSK * nm_to_km);

  //printf(" Cruise speed %f \n",Cruise_speed);
  <<" %V $Cruise_speed  \n";

  GT_Wtp[1].Alt = 100.0;

  GT_Wtp[40].Alt = 5300.0;

//  <<"$GT_Wtp[1].Alt\n";

//  GT_Wtp.pinfo() ;  // should identify Obj

//ans =query("??");

  Str tlon;
  Str tplace;
  Svar CLTPT;
  Svar Wval;
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
#if __ASL__
  allowDB("ic_,oo_,spe_,rdp_,pexpnd,array",1)
#endif

  if (use_cup) {

  AFH=ofr("CUP/bbrief.cup")  ; // open turnpoint file;

  printf( "opened CUP/bbrief.cup AFH %d \n",AFH);

  }

  else {

  AFH=ofr("DAT/turnptsA.dat")  ; // open turnpoint file;
  printf("opened  DAT/turnptsA.dat %d \n" ,AFH );
  }

  if (AFH == -1) {

  printf( " can't find turnpts file \n");
  exit(-1);

  }

  int brief = 0;

  int show_dist = 1;

  int show_title = 1;

//main


    //na = sargs.getNarg(); // TBC no asl version??


#if __CPP__
  na = argc;
#endif

#if __ASL__
  na = _clargc;
#endif  




  printf(" na %d\n",na);


  int ac = 0;

  float LoD = 35;

  int istpt = 1;

  int cltpt = 0;
  int sz;
  
  Str targ;


  //<<" %V $LoD \n";
#if __ASL__
  ac =1;
#endif



while (ac < na) {

  istpt = 1;

#if __ASL__
  targ = _argv[ac];
#endif

#if __CPP__
  targ = argv[ac];
#endif




#if GT_DB
 printf("ac %d targ %s\n",ac,targ);
 targ.pinfo();
 ans=ask("%V $ac $targ\n",0)
#endif
 


/*
 targ.pinfo();
  ok= targ.aslcheckinfo("GLOBAL");
 <<" $ok   targ is a GLOBAL \n";
*/

  sz = targ.slen();

<<"%V <|$targ|> $sz\n";

  ac++;

  if (sz > 0) {

<<"%V <|$targ|> $sz  $ac \n";
  targ.pinfo()
  
  if (targ == "LD") {

    targ = sargs.cptr(ac);  // for CPP copy argv to svar sa


    LoD= atof(targ);

//<<"parsing %V $LoD \n";
    ac++;

    istpt = 0;

#if GT_DB
     printf("setting LD %f ",LoD);
     LoD.pinfo();
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

      // targ = sargs[ac]  ; // should work index Svar array? TBC 6/17/24 
      targ = sargs.cptr(ac);
      

  CSK = atof(targ);

  ac++;

  istpt = 0;

  Cruise_speed = (CSK * nm_to_km);

  if (GT_DB) printf("setting CS CSK %f knots Cruise_speed %f kmh \n",CSK,Cruise_speed);

  }

  if ( targ == "task") {

  via_keyb = 0;

  via_file = 1;

  Str byfile = sargs.cptr(ac);  
//     byfile = sargs.cptr(ac); // TBF 6/19/24 sjould sac to Str byfile

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

//<<"%V $targ $cltpt \n"

   CLTPT.cpy(targ,cltpt);

   if (GT_DB)  {
    <<"%V $targ $sz $cltpt $CLTPT[cltpt] \n"
    <<"CLTPTs  $CLTPT\n"
    }
    
#else
 CLTPT.cpy(targ,cltpt);
 if (CPP_DB) cout  <<"cltpt "<< cltpt  <<" CLTPT[cltpt] "<< CLTPT[cltpt]  <<endl ; 
#endif


   cltpt++;

   }

   <<"%V $ac  $targ $sz \n"

 } // arg was valid

}
// look up lat/long



  float N = 0.0;
  int ki;
  int cnttpt = 0;  // TBF 1 for cpp? -clargv copy
  int input_lat_long = 0;
  int i = -1;


   if (GT_DB) printf("DONE ARGS  ac %d cltpt %d \n", ac,cltpt);




/////////////////////////////

  i = -1;
 int k;
 int got_start = 0;
 int K_AFH = AFH;
 
 cnttpt = 0;
// if CPP cnttpt should be 1 ?
#if __CPP__
   cnttpt = 1;
#endif

 while ( !got_start) {


#if GT_DB
 <<" %V $cnttpt $i    $via_keyb $via_cl\n";
#endif

  fseek(AFH,0,0);

  if (via_cl) {

  the_start = CLTPT[cnttpt];
  
#if GT_DB
  <<"$the_start $cnttpt $CLTPT[cnttpt] \n"
#endif

#if CPP_DB

    cout << the_start << "  " << cnttpt  << endl;

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

  i=searchFile(AFH,the_start,0,1,0,0);

  //printf("AFH %d i %d\n",AFH,i);

  if (i == -1) {
   printf("the_start  %s not found \n", the_start);

  try_start = nameMangle(the_start);
  
  i=searchFile(AFH,try_start,0,1,0,0);
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


// pa("start ", the_start);
// -------------------------------
//<<"%V$input_lat_long  $i \n"

  nwr =0;  // TBF 6/21/24  sac to int nwr = 0;
  w = "xyz" ; // TBF 6/21/24  sac to Str = 0;

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

   <<" CUP read of  $nwr words \n"

   }
  else {
   nwr = Wval.readWords(AFH);
   }

  tplace = Wval[0];

  if (use_cup) {
   tlon = Wval[4];
   }
   else {
    tlon = Wval[3];
   }

#if GT_DB
<<"%V $nwr \n"
<<"$Wval\n"
<<"$Wval[0] $Wval[1] $Wval[2] $Wval[3]\n"	  
<<"start ? %V $n_legs \n";
#endif


  n_tp++;
  if (use_cup) {

//<<"start %V $n_legs  $Wval \n"

     GT_Wtp[0].TPCUPset(Wval);

//<<"%V $GT_Wtp[n_legs].Ladeg \n"

   }
  else {
     GT_Wtp[n_legs].TPset(Wval);
   }
   
  AGL[n_legs] = GT_Wtp[n_legs].Alt;

 }


// NEXT TURN POINT
//ans=ask("NEXT TURN POINT ",1)

  int more_legs = 1;

  ok_to_compute = 1;
 // FIX

  float the_leg;
//<<"%V $AFH\n";

  while (more_legs == 1) {

 // fseek(AFH,0,0);

  if (via_cl) {

  nxttpt = CLTPT[cnttpt];


#if GT_DB
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

  if ((nxttpt == "done") || (nxttpt == "finish") || (nxttpt == "quit") ) {

     more_legs = 0;

  }

  else {

#if __CPP__
 if (GT_DB) cout <<"looking for " << nxttpt << endl;
#else
 //<<"AFH $AFH looking for $nxttpt \n";
#endif

//<<"%V $AFH\n"

  AFH = K_AFH;



//<<"$AFH  $K_AFH  <|$nxttpt|> \n"

  where = searchFile(AFH,nxttpt,0,1,0,0);

//<<"%V $AFH $where \n"

//cout <<"Found? " << nxttpt << " @ " << where <<endl;

    if (where  == -1) {

        try_start = nameMangle(nxttpt);

      where = searchFile(AFH,try_start,0,1,0,0);
      
       if (AFH != K_AFH) {
        printf(" ferr AFH %d\n",AFH);
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

//ans=ask("NEXT 2 ",1)
  if (use_cup) {

 //  nwr = Wval.readWords(AFH,0,',');
 
   nwr = Wval.readWords(AFH,0,44);

//  <<"CUP READ $nwr words \n"





  //  cout <<" next  nwr " << nwr << endl;
#if __CPP__
  if (GT_DB) COUT(Wval);
#endif

#if GT_DB
<<"%V $nwr \n"
<<"$Wval \n";
<<"%V $AFH $n_legs $Wval[0] $Wval[1]  $Wval[4] \n"
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

   nwr = Wval.readWords(AFH);

//<<"read $nwr words \n"
//<<" $Wval[0]  $Wval[1]  $Wval[2]\n"
  //ans=ask(" %V $Wval  ",1)
   GT_Wtp[n_legs].TPset(Wval);
  //ans=ask(" %V $Wval  ",1)

#if __ASL__
     if (AFH != K_AFH) {
       <<" ferr %V $AFH\n"
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
  
  for (nl = 0; nl < n_legs ; nl++) {
#if GT_DB
<<"%V $nl   $n_legs  $GT_Wtp[nl].Place  $GT_Wtp[nl+1].Place  $GT_Wtp[nl].Alt $GT_Wtp[nl].Ladeg  \n"
// ans=query("??");
#endif

  L1 = GT_Wtp[nl].Ladeg;
  ki = nl+1;
  L2 = GT_Wtp[nl+1].Ladeg;  //  TBF icode
  //L2 = GT_Wtp[ki].Ladeg;  //  TBF icode
       //DBG"%V $L1 $L2 \n"

  lo1 = GT_Wtp[nl].Longdeg;

  lo2 = GT_Wtp[(nl+1)].Longdeg; // TBF

 // lo2 = GT_Wtp[ki].Longdeg; 
  
       //DBG"%V $lo1 $lo2 \n"
      // tkm = ComputeTPD(nl, nl+1);

  tkm = HowFar(lo1 ,L1, lo2, L2);

 // tkm2 = HowFar( GT_Wtp[nl].Longdeg , GT_Wtp[nl].Ladeg, GT_Wtp[ki].Longdeg, GT_Wtp[ki].Ladeg);
  tkm2 = HowFar( GT_Wtp[nl].Longdeg , GT_Wtp[nl].Ladeg, GT_Wtp[nl+1].Longdeg, GT_Wtp[nl+1].Ladeg);
  
//cout << "L1 " << L1 << " lo1 " << lo1 << " L2 " << L2 << " lo2 " << lo2 << " tkm " << tkm << endl;

#if GT_DB
<<"%V  $GT_Wtp[nl].Place $GT_Wtp[nl].Alt $GT_Wtp[nl].Longdeg $GT_Wtp[nl].Ladeg  $GT_Wtp[nl+1].Place $GT_Wtp[nl+1].Longdeg    $GT_Wtp[nl+1].Ladeg \n";

<<"%V $nl $tkm $tkm2\n"

#endif
  TKM[nl] = tkm;

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


  TC[nl] = tcd;

//  Dur[nl+1] = Leg[nl]/ Cruise_speed;

    Dur[nl] = tkm / Cruise_speed;
 //<<"%V $Leg[nl] $tkm $Dur[nl+1] \n"

  totalDur += Dur[nl];

  totalD += tkm;

#if GT_DB
<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"
#endif

  }

//  int wk = 0;
    wk = 0    // TBF 6/21/24 sac to int wk = 0;
  //int tplen = tpb.slen();  
   tplen  =tpb.slen();
   
  Str ws =  nsc((10-tplen)," ");

  int idlen = ident.slen();

  Str wsi= nsc((10-idlen)," ");

  //float tct;
    tct = 0.0;
  //float dct;
    dct = 0.0;
    
  rmsl = 0.0;

  msl = 0.0;

  pc_tot = 0.0;

#if GT_DB    
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

   tot_time += Dur[li];

     pc_tot = GT_Wleg[li].dist/totalD * 100.0;

     GT_Wleg[li].pc = pc_tot;
     

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
  exit(-1);
}
////////////////////////////////////////////////////////////////////////////////////////


#endif



/*
  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint
*/

//==============\_(^-^)_/==================//

//LocalWords:  asl
