//%*********************************************** 
//*  @script fit2tsv.asl 
//* 
//*  @comment convert garmin fit to tsv - location and HB 
//*  @release CARBON 
//*  @vers 1.5 B Boron [asl 6.2.75 C-He-Re]                                  
//*  @date Mon Oct 12 08:53:19 2020 
//*  @cdate 3/1/2017 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
;
///
///  convert fit file --- extract lon,lat, time,speed, pulse
///

//////////////   GLOBALS ///////////////

//#undef DBG

#define CPP 1
//#define DBG



#if CPP
#define ASL 0

#define DBANS
#else
#define ASL 1
#endif


#if ASL
 _DB=2;
#define cout ~!
//#define DBG <<
#define DBG ~!
#define DBANS ~!


#include "debug"

debugOFF()

filterFileDebug(ALLOWALL_,"xxx");
filterFuncDebug(ALLOWALL_,"xxx")

sdb(0,@~pline,@~trace)

#endif






char hsz;
char protover;
short profver;
int fit_hdr = 0;
int datasz;
char C[4];
char CD[4096];
short CRC=0;
int nl;


int normal = 1;
int cmpts = 0;
int defin = 0;
int data = 1;
int devdata = 1;


long lmt = -1;  // all element/range array specs have to long
long where;

//   TBC   (2^31) C?  ASL ?
double scdeg = 180.0/ (2 ^31);  


float deg;


//<<"%V %e $scdeg \n"

float lat;
float lon;

float alt = 0;

float spd = 0;

float dist = 0;
uint bpm = 0;
uint ht;


short wss;
short ws2;
int wi;
int wt;
uint tim;
int pos;
uchar wc;

int svn = 0;
int wvn = 0;
int tvn = 0;
int evn = 0;
int ivn = 0;
int kl = 0;
int dfdt ;

uchar rserv;
uchar arch;
short gmn;
uchar nfields = 0;
uchar nfdd =0;

Mat dfd(UCHAR,85,3);

uchar vec_uc[20];
//int dfd[85][3];
uchar devfd[85][3];


Mat DEFS(UCHAR,256,255);

Vec DEFS_NF(INT,256);

Mat LMTS(INT,256,2);

Vec Vd(UCHAR,255);


int cnt9 =0;
uint cat;
float tot_secs = 0.0;

#if CPP
FILE *A = NULL;
ofstream BOF ("walk.tsv");
#endif


//FILE *BOF = NULL;


///////////////////   PROCS /////////////////



void fit_storeLMT(int almt)
{

static int nlmts = 0;
long k;

   nl = nlmts;

//DBG[_DB]"$_proc %V $nl $almt\n"
//dbp(" nl %d\n",nl);
//DBG dbp("nl %d\n",nl);

int val;

#if CPP 

  for (k = 0; k <= nl; k++) {
//   val = LMTS
    if (LMTS(k,0) == -1) {
    
         LMTS(k,0) = almt;
	 LMTS(k,1) = 1;
	 nlmts++;

//<<[_DB]"added lmt $almt\n"
//	 <<"added lmt $almt\n"
	 break;
     }
     else if (LMTS(k,0) == almt) {
                LMTS(k,1) += 1;
            break;  // already logged
     }
   }

#else


 for (k = 0; k <= nl; k++) {

    if (LMTS[k][0] == -1) {
         LMTS[k][0] = almt;
	          LMTS[k][1] = 1;
	 nlmts++;
	 //<<[_DB]"added lmt $almt\n"
//	 <<"added lmt $almt\n"
	 break;
     }
     else if (LMTS[k][0] == almt) {
                LMTS[k][1] += 1;
            break;  // already logged
     }
   }

#endif

//DBG[_DB]"exit $_proc \n";
}
//===========================//



void fit_rd_hdr()
{

   int k;

#if CPP
   printf("printf rd_hdr  hsz %p protover %p profver %p \n",&hsz,&protover, &profver);
#endif

   k= fscanv(A,0,"C1,C1,S1,I1,C4,S1",&hsz,&protover,&profver,&datasz,&C,&CRC);
   
#if CPP
   printf("printf rd_hdr k %d hsz %d protover %d profver %d datasz %d CRC %d\n",k,hsz,protover, profver, datasz,CRC);
#else
<<[2]"%V $k $hsz  $protover $profver $datasz %s $C  \n"
#endif
   if (feof(A)) {
   cout  << " EOF exit!\n";
   }
   //<<" %s $C\n"
 if (strcmp(C,".FIT")== 0) {
     fit_hdr = 1;
  }

//<<[_DB]"CRC %x $CRC\n"
//DBG[_DB]"exit $_proc \n";
}
//=========================//


void fit_rd_hdb()
{

   int ct;
   int ct40;
   where = ftell(A);

  // dbp("where %d\n",where);

    //k=fscanv(A,0,"C1",&ht)

    fread(&ht,1,1,A);

//DBG[_DB]"rd hdb %V $where $ht $(typeof(ht))\n";

cout << " hdb " << where   << " ht " << ht << endl;

    if (feof(A)) {
    cout <<" EOF exit!\n";
    }



//bc=dec2bin(ht);

   normal = 0;
   data = 0;
   defin = 0;

   cmpts = 0;
//<<[_DB]"<$kl> HDRB "   
   nfdd = 0;

   ct= ht & 0x80;
   ct40= ht & 0x40;
   
   //DBG[_DB]"%V $ht %X  $ht $ct $ct40\n"

cout << "ct " << ct << endl;

    if (ht & 0x80) {
        normal = 0;
	cmpts = 1; // compressed time stamp
   cout	<<"Compressed Time Stamp!! \n";
       //DBG[_DB]"$ht %X $ht  0x80 cmpts  \n"
       
   }
   else {

   normal = 1;
   //DBG[_DB]"%V $normal $ht %X $ht \n"	
   if (ht & 0x40) {
   //DBG[_DB]"40 $ht %x $ht &  0x40\n"
        defin = 1;
	data = 0;
        devdata = 0;
    }
    else {
          data = 1;
    }
    
     if (ht & 0x20) {
        //DBG[_DB]"$ht %x $ht &= 0x20 ?\n"
	devdata = 1;
//<<[_DB]"devdata "		
     }


   }
   

//ct= ht & 0x20
   //<<[_DB]"%V $ht 0x20 %X $ct $ht\n"

   lmt = (ht & 0x0F);  // local message type mt  

   where = ftell(A);

//DBG[_DB]"%V $where $normal   $data    $defin    $cmpts $devdata $lmt \n"


cout <<" where " << where << "  normal " << normal   << " data " << data    << " defin " << defin  << endl ;
cout << " cmpts  " << cmpts << " devdate  " << devdata << " lmt " << lmt << endl ;

//ans= query("%v $defin $data :\n")

  if (defin) {
     fit_storeLMT( lmt);
  }
//DBG[_DB]"exit $_proc $lmt\n";
//DBANS=query("$_proc exit")
}
//=========================//






void fit_rd_dfds()
{

  int n= 3 * nfields;
  int kfs;
  
//DBG[_DB]"$_proc %V $nfields\n"

  if (nfields == 0) {
    cout <<"WARNING no fields \n";
  }


  if (nfields > 0) {

      dfd = 0;  // vec set to zero
    
#if CPP
     kfs=fread(dfd.Memp(),1,n,A);
     DEFS_NF(lmt) = nfields;
#else 
     kfs=fread(dfd,1,n,A);
     DEFS_NF[lmt] = nfields;
#endif
  

    if (feof(A)) {
        return;
    }


  // Vd  = setVec(dfd);  //  mat 2D ==> vec  1D   
    Vd = dfd;
/*
     uchar *vcp = (uchar *) Vd.Memp();
     for (int iv= 0; iv < 30; iv++) {

     printf("i %d val %d\n",iv,vcp[iv]);
     }
*/
cout << " setting row " << lmt << " to vec Vd " <<endl;

#if CPP 
   DEFS(lmt,RALL) = Vd;
#else
   DEFS[lmt][::] = Vd;
#endif


  }
   //DBG[_DB]"exit $_proc \n";
//DBANS=query("$_proc exit")
}
//==============================//
void fit_rd_def()
{

 int kfs= fscanv(A,0,"C1,C1,S1,C1",&rserv,&arch,&gmn,&nfields);
 //ans=query(":?");
    if (feof(A)) {
   cout <<"kfs EOF exit!\n";
      
    }
       //DBG[_DB]"exit $_proc \n";
}
//==============================//

void fit_rd_devfds()
{
 // int ni;   // comma sep list ASL missing TBC 
 int n;
 int i;
 int  kfs = fscanv(A,0,"C1",&nfdd);

cout << " rd_devfds " << nfdd  << " \n";

   if (feof(A)) {
    cout << kfs << "EOF exit!\n";
      
    }



  if (nfdd > 0) {
  
  n= 3 * nfdd;


  int kr=fread(&devfd,1,n,A);

    if (feof(A)) {
       cout << "EOF exit!\n";
       return;
    }



    for (i = 0; i < nfdd ; i++) {

//       dfdt = (int) devfd[i][2];
       dfdt = devfd[i][2];
       cout << i << " dfdt " << dfdt << endl;
//<<"%v $i  $devfd[i][2] $dfdt\n"

    }
  }
  else  {

 cout << "WARNING no dev fields to read " << nfdd << "\n";

  Str fmt = "C16";

//k= fscanv(A,0,fmt,&devfd)

//"%X $devfd \n"

  }

//DBANS=query("$_proc exit")   
}
//==============================//


void fit_rd_data()
{
// what local message ?
   int decode = 1;
#if ASL
T=FineTime();
#endif
    uint i;
   uint nbs;
   int tim = 0;

   int fndpos = 0;

   lat =0.0;

// then what data fields ??
   where = ftell(A);
   
   nfields = DEFS_NF[lmt];

//printf("where %ld lmt %d nfields %d\n",where,lmt,nfields);     

 // if (nfields != DEFS_NF[lmt]) {
////<<"DIFFER? %V$nfields $lmt $DEFS_NF[lmt] \n"
 //   nfields = DEFS_NF[lmt];
//  }

//DBG[_DB]"RD_DATA %v $where $lmt $nfields \n";

cout << " RD_DATA where " << where << " lmt " << lmt  << " nfields " << nfields << endl;
  


  if (nfields ==0) {
     cout << "ERROR no fields!!\n";
  }
  else {

/*
     uchar *mcp = (uchar *) DEFS.Memp();
     for (int iv= 0; iv < 30; iv++) {
     printf("DEFS i %d val %d\n",iv,mcp[iv]);
     }
*/
#if CPP
    Vd = DEFS(lmt,RALL); // get row --> vector  255 CHAR
    dfd = Vd;  //  Mat 85,3    - filled by vec of 255 CHAR
#else
   dfd = DEFS[lmt][::];
   dfd->Redimn(85,3);
#endif
/*
     uchar *vcp = (uchar *) Vd.Memp();
     for (int iv= 0; iv < 30; iv++) {
     printf("i %d Vd val %d\n",iv,vcp[iv]);
     }
*/

//cout  << " Vd  " << Vd << endl;


 
/*
     vcp = (uchar *) dfd.Memp();
     for (int iv= 0; iv < 30; iv++) {
     printf("i %d dfd ucval %d\n",iv,vcp[iv]);
     }
*/

//cout  << " dfd  " << dfd << endl;
//DBG[_DB]"%V $nfields \n";
 for (i = 0; i < nfields ; i++) {

#if CPP
   cat   =  (uint) dfd(i,0);
   nbs   =  (uint) dfd(i,1);
   dfdt  = (int) dfd(i,2);
#else
   cat   =  dfd[i][0];
   nbs   =  dfd[i][1];
   dfdt  = dfd[i][2];
#endif

//DBG[_DB]" $i  %V $cat $nbs $dfdt \n";

cout << " i "  << i << " cat " << cat << " nbs " << nbs << " dfdt " << dfdt << endl;

if (nbs > 0) {

    //   nb = dfd[i][1];
    //    fmt = "C$nbs"
    //kfs= fscanv(A,0,fmt,CD);

    fread(CD,1,nbs,A);
    
    where = ftell(A);


    if (feof(A)) {
       cout <<" EOF exit!\n";
       return;
    }

       switch (dfdt)
       {
         case  0:
	  {
	  // enum
//<<[_DB]"enum %d $CD[0]\n";
    //k= fscanv(A,0,"C1",&wc)

	 
//	    <<"$i <0> $evn enum $CD[0]\n"
	 evn++;
	 }
	 break;
        case   2:
	 {
//<<[_DB]"enum %d $CD[0]\n";
    //k= fscanv(A,0,"C1",&wc)


        if (cat == 3) {
         //  bpm = (uint) CD[0];
	   bpm = CD[0];
        }

	  ////DBG[_DB]"$i <0> $evn enum %u $wc\n"
	 evn++;
	 }
	 break;
        case 7:
	  {
	  // <<"STR <7> %s $CD[0:nbs-1]\n";
	    cout <<"STR    CD[]\n";
	  }
         break;
         case  132:
	  {
	 //wss= (short) *(short *)CD;
	  mscan(CD,0,&wss);
          //wss= CD->mscan(SHORT_,0);

        if (cat == 2) {
             alt = wss * 0.2 -500;
	    // alt = ws * 0.2 ;
        }
        else if (cat == 6) {
           spd = wss * 0.001;
        }
        else {
	alt = wss * 0.2 ;
      //  <<"miss %v$cat $dfdt $ws  $alt\n";
        }

	 svn++;
	 }
	 break;
         case    133:
	{


    //   pos= (int) *(int *)CD;
         mscan(CD,0,&pos);
      // pos= CD->mscan(INT,0);


       //   k= sscan(CD,'%d',&wt)

        deg = pos * scdeg;
        if (cat == 0) {
             lat = deg;
        }
        else if (cat == 1) {
             lon = deg;
        }
       else {
  cout   <<"miss  " << cat << " dfdt  " << dfdt << " pos " << pos << endl ;
        }
	fndpos++;

	  }
        break;  
       case   134:
        {// time created 
////DBG[_DB]"TIME  $CD[0:3] \n";
      //  wt = 0;
      mscan(CD,0,&wt);
        //bscan(CD,0,&wt); // works - sscan does not why?

//wt= (int) *(int *)CD;
// wt=CD->mscan(INT,0);

        if (cat == 253) { // timestamp
           tim = wt;
        }
        else if (cat == 5) {
           dist = wt * 0.01;
        }
	else {
    //    <<"miss %v$cat $dfdt $wt\n";
        }
       //   k= sscan(CD,'%d',&wt)

//	<<"$i <134> <$tvn> time  %u $wt\n"
	  //tvn++;
          }
          break;
 
	case 140:
        // serial
        ////DBG[_DB]"read serial %d $CD[0:nbs-1]\n"

            
#if CPP	  
            wt= (int) *(int *)CD;
#else 
            wt=CD->mscan(INT,0);
#endif
//        <<"$i <140> $ivn serial  %u $wi\n"
	  wvn++;       
        break;
  
         default:
	  {

#if CPP	  
        wss= (short) *(short *)CD;
#else
       wss= CD->mscan(SHORT_,0);
#endif

// <<"default $i  <$dfdt> cat $cat $CD[0] $ws \n";
           }
         break;
        }

     }
 }

//DBG[_DB]"$where $kl $tim $lat $lon $dist $spd $alt $bpm\n";

#if CPP
cout << "RD_DATA OP: " << fndpos << " " << tim << " " << lat << " " << lon << " " << dist << " " << spd << " " << alt << " " << bpm << endl;
#else
if ((kl % 100) == 0) {
   dt= fineTimeSince(T,1)
  secs = dt/1000000.0;
  tot_secs += secs;
  pc_done = where/(file_size*1.0) * 100.0
  <<[2]"%6.2f $pc_done %% $secs $tot_secs %d $kl $where $lat $lon $dist $spd $alt $bpm\r";
  fflush(1)
 }
#endif





   if (fndpos) {
#if CPP 
     BOF << tim << " " << lat << " " << lon << " " << dist << " " << spd << " " << alt << " " << bpm << endl;
#else
//DBG[DB_]"$tim $lat $lon $dist $spd $alt $bpm\n";
<<[B]"$tim $lat $lon $dist $spd $alt $bpm\n";


if (ask_pos) {
<<"$tim $lat $lon $dist $spd $alt $bpm\n";
ans=query("$where $lat :")
if (ans @= "c") {
  ask_pos = 0
}
}
#endif

    }

  if (lmt == 9) {  // what ?
    cnt9++;
    cout     <<   " cnt9  " << cnt9 << endl;

   // 
  }
  
 }
 
//  dt= fineTimeSince(T)
//  secs = dt/1000000.0
 //<<"took  $secs\n"
   //DBG[_DB]"exit $_proc \n";
//DBANS=query("$_proc exit")
}
//===============================//

void fit_rd_devdata()
{
// what local message ?
// then what data fields ??

cout <<"rddevdata ERROR not coded!!\n";
   //DBG[_DB]"exit $_proc \n";
}
//==============================//

// asl has to ignore this line

#if CPP
extern "C" int fit2tsv(Svarg * s)  {
#endif
////////////////////////////////////  MAIN ///////////////////////////
///
///  process s args
///

/// DLLOPEN uac
 Str fname;
 printf("scdeg %f\n",scdeg);
// printf("%s %s\n",__FUNCTION__,fname.cptr());
#if CPP 
  printf("DO CPP ?\n");
  fname = s->getArgStr();
  cout << " fname " << fname << " func " << __FUNCTION__ << endl;
#else 
printf("DO ASL ?\n");
fname = getArgStr();
<<"%V $fname   $_script \n";
#endif
//setDebug(2,"pline,trace");

int ask = 0;
int ask_pos = 0;
Svar S;
Str Ans;

//  set some var names
#if CPP
cout << "setting names" << endl;
dfd.setName("dfd");
Vd.setName("Vd");
DEFS.setName("DEFS");
LMTS.setName("LMTS");
#endif

LMTS = -1;
#if CPP
 printf("%s \n",LMTS.linfo());
#else
LMTS->info(1)
#endif
/// conversion
// semicircles to degrees

// deg = semicirs *  180.0/ (2^31)


     

//<<"%(16,, ,\n)$DEFS_NF\n"

//////////// TBD ////////////////
//  need array of local msg defs
//
//
//
#if CPP
     //A = fopen(fname.cptr(),"r");
      A = ofr(fname);
      if (A == NULL) {
      printf ("could not open %s\n",fname.cptr());
      exit(-1);
     }
#else
      A = ofr(fname);
      file_size= fexist(fname);
    outname = scut(fname,-3);
    outname = scat(outname,"tsv");
<<"in: $fname out: $outname\n"
      B= ofw(outname);      
#endif

if (A == -1) {
//<< " file not found \n";
cout << " file not found " << endl ;
exit(-1);
}
else {
cout << " file open " << fname << endl ;
}

   fit_rd_hdr();   // read the FIT header

   if (!fit_hdr) {
    cout <<" NOT A FIT FILE\n";
   }

  
cout << fname << " OK " << endl;


DEFS_NF = -1;


  kl = 0;
  cout << " start conv of " << fname.cptr() << endl;
  //BOF << " start conv of " << fname.cptr() << endl;
  
//<<"Start while loop \n"

  while (1) {

//DBG[_DB]"loop $kl $_proc %v $defin $data\n";

cout <<" loop " << kl  << endl;
// <<"%V $kl \n"


    fit_rd_hdb();

  //  ans=query("hdb")

    if (feof(A)) {
       break;
    }

   if (defin) {

     fit_rd_def();

     fit_rd_dfds();

     if (devdata) {
         fit_rd_devfds();
     }

   }


    if (data) {

      fit_rd_data();

      if (devdata) {
          fit_rd_devdata();
       }
    }


   kl++;
   if (ask) {
#if CPP   
Ans.getLine("continue?");

  cout << " Ans " << Ans.cptr() << endl;
   if (strncmp(Ans.cptr(),"q",1) == 0) {
        break;
   }

   if (strncmp(Ans.cptr(),"c",1) == 0) {
        ask = 0;
   }
#else
   ans=query("\ncontinue:\n");
    if (ans @="q") {
     break;
   }
    if (ans @="c") {
     ask = 0;
    }
#endif
   }

//<<"loop end $kl\n"
// if (kl > 5000)  break;
   }
#if CPP
}
#endif
//<<" this should be end of processing \n"

#if ASL
<<"Nes $(getNes())\n"
<<"Ndbs $(getNdbs())\n"
<<"Nfastx $(getNfastx())\n"
#endif




//    return 1;







/////////////////////////////////////////
