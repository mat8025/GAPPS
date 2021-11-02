//%*********************************************** 
//*  @script fitconv.asl 
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
///  
///

<|Use_= 
 Convert fit file --- extract lon,lat, time,speed, pulse 
/////////////////////// 
|>

#include "debug"

if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)

allowErrors(-1) ; // keep going


//filterFileDebug(ALLOWALL_,"xxx");
//filterFuncDebug(ALLOWALL_,"xxx")

//sdb(1,@~pline)


//////////////   GLOBALS ///////////////

int tot_br =0;

normal = 1;
cmpts = 0;
defin = 0;
data = 1;
devdata = 1;

int lmt = -1;

int LMTS[256][2];

LMTS = -1;

//<<"$LMTS\n"
long where;


/// conversion
// semicircles to degrees

// deg = semicirs *  180.0/ (2^31)

double scdeg = 180.0/ (2 ^31);

//<<"%V %e $scdeg \n"
double deg;
double lat;
double  lon;

float alt = 0;

float spd = 0;;

float dist = 0;
uchar bpm = 0;
uint ht;
char hsz;
char protover;
short profver;

short ws;
short ws2;
int wi;
int wt;
uint tim;
int pos;
uchar wc;

short SV[4096];
char EV[4096];

int IV[4096];
int TV[4096];

int svn = 0;
int wvn = 0;
int tvn = 0;
int evn = 0;
int ivn = 0;

uint dfdt ;

int datasz;

char C[4];
char CD[4096];

short CRC;

uchar rserv;
uchar arch;
short gmn;
uchar nfields;
uchar nfdd =0;

uchar dfd[85][3];

uchar vec_uc[20];
//int dfd[85][3];
uchar devfd[85][3];


uchar DEFS[256][255];

int DEFS_NF[256];

DEFS_NF = -1;

//<<"%(16,, ,\n)$DEFS_NF\n"

fit_hdr = 0;

int A;
int B;

int kfs;
//////////// TBD ////////////////
//  need array of local msg defs
//
//
//

/*
#define DBANS ~!
#define DBG ~!
_DB=-1
*/


_DB= 1;

//#define DBG <<

#define DBG ~! 

//#define DBANS ~!
///////////////////   PROCS /////////////////

<<" reading procs\n"


void rd_hdr()
{

//<<[_DB]"$_proc\n"
   int k;
   k= fscanv(A,0,"C1,C1,S1,I1,C4,S1",&hsz,&protover,&profver,&datasz,&C,&CRC)
   tot_br += k;


//  DBG[_DB]"%V $k $hsz  $protover $profver $datasz %s $C  \n"



if (feof(A)) {
<<" EOF exit!\n"
}

//<<" %s $C\n"
 if (scmp(C,".FIT")) {
     fit_hdr = 1;
 }

//<<[_DB]"CRC %x $CRC\n"
/*
DBANS=query("$_proc out ? ")

if (DBANS == "q") {
   exit()
}
*/

}
//=========================//

void rd_hdb()
{

//[_DB]"$_proc\n"
   where = ftell(A)

    //k=fscanv(A,0,"C1",&ht)
    fread(&ht,1,1,A);
    tot_br +=1 ;
   // <<"fread rd_hdb 1 $tot_br\n"
    if (feof(A)) {
    <<" EOF  so break put\n"
    }
    else {
    // fread(&ht,1,1,A)
//<<[_DB]"%V $where  %X $ht\n"
//bc=dec2bin(ht)
//   DBG[_DB]"rd hdb %V $where $ht $(typeof(ht))\n";
   
   normal = 0;
   data = 0;
   defin = 0;

   cmpts = 0;
//<<[_DB]"<$kl> HDRB "   
   nfdd = 0;

   ct= ht & 0x80
   
//   DBG[_DB]"%V $ht %X  $ht $ct\n"


    if (ht & 0x80) {
        normal = 0;
	cmpts = 1; // compressed time stamp
      // DBG[_DB]"Compressed Time Stamp!! \n"
      // DBG[_DB]"$ht %X $ht  0x80 cmpts  \n"	
   }
   else {
   
   //DBG[_DB]"normal $ht %X $ht \n"	

   normal = 1;
   if (ht & 0x40) {
   
   //DBG[_DB]"0x40 $ht %x $ht &  0x40\n"

        defin = 1;
	data = 0;
        devdata = 0;
    }
    else {
          data = 1;
    }
    
     if (ht & 0x20) {
     
        //DBG[_DB]"0x20 $ht %x $ht &= 0x20 ?\n"

      devdata = 1;
//<<[_DB]"devdata "		
     }


   }
   

//ct= ht & 0x20
   //<<[_DB]"%V $ht 0x20 %X $ct $ht\n"

   lmt = (ht & 0x0F);  // local message type mt  

   where = ftell(A);

 //DBG[_DB]"%V $where $normal   $data    $defin    $cmpts $devdata $lmt \n"



  if (defin) {
     storeLMT( lmt);
  }
 }
 
/*
DBANS=query("$_proc out ? ")
if (DBANS == "q") {
   exit()
}
*/

}
//=========================//

void rd_dfds()
{

  n = 3 * nfields;

//  DBG[_DB]"$_proc %V $nfields\n"

  if (nfields == 0) {
<<"WARNING no fields $nfields \n"
  }


  if (nfields > 0) {

//  fmt = "C$n"
  //<<[_DB]"%V $fmt \n"
  dfd = 0;



 // kfs=fscanv(A,0,fmt,&dfd)

    kfs=fread(dfd,1,n,A)
    
    tot_br +=kfs ;

//<<"fread rd_dfds $kfs $tot_br\n"

    if (feof(A)) {
       DBG"$_proc $kfs EOF exit!\n"
       break;
    }
    
 // DBG[_DB]"dfd %V $(Cab(dfd)) \n"

/*
  for (j=0; j< nfields; j++) {
 <<[_DB]"<|$j|> $dfd[j][::]\n"
  }
*/

   //DBG[_DB]"%V $lmt $nfields \n"
  
   DEFS_NF[lmt] = nfields;

//<<"$DEFS_NF\n"



/*
DBANS=query("lmt $lmt ? ")
if (DBANS == "q") {
   exit()
}
*/




   vd = dfd;

   //vd<-Redimn(85,3);

  //<<[_DB]"%V $(Cab(vd)) \n"

//  for (j=0; j< nfields; j++) {
// <<[_DB]"$j $vd[j][::]\n"
//  }


   // <<[_DB]"vd $vd\n"
  vd<-Redimn();
  
  //<<[_DB]"/////////////////////// \n"
  //<<[_DB]"%V $(Cab(vd)) \n"
  //<<[_DB]"%V $vd\n"
  //<<[_DB]"/////////////////////// \n"      
//<<[_DB]"DEFS $(Cab(DEFS)) $(typeof(DEFS)) \n"

  DEFS[lmt][::] = vd;
  
//  DEFS[lmt] = vd;
    
  //DBG[_DB]"DEFS %V $lmt $n\n "

  //DBG[_DB]"DEFS $(Cab(DEFS)) $(typeof(DEFS)) \n"

//  <<[_DB]"%(3,, ,\n)$DEFS[lmt][0:n-1:]\n"
  //<<[_DB]"$DEFS[lmt][0:n-1:]\n"
  //<<[_DB]"/////////////////////// \n"
  }


//<<"Out of $_proc \n";

}

//==============================//

void rd_devfds()
{
    //DBG[_DB]"$_proc\n"


    kfs = fscanv(A,0,"C1",&nfdd)
    tot_br += kfs;

//<<"rd_devfds $kfs  $tot_br\n"

    if (feof(A)) {
    <<"$_proc $kfs EOF exit!\n"
     
    }


//<<[_DB]"DEVDATA !! @ $kl %V $nfdd\n"

  //ans = iread("devdata $nfdd fields\n"

 

  if (nfdd > 0) {
  
  n= 3 * nfdd;

  //fmt = "C$n"

  
  //ksf= fscanv(A,0,fmt,&devfd)

  kr=fread(&devfd,1,n,A);

  tot_br += kr ;

//<<"fread rd_devfds $kr $tot_br\n"

  if (feof(A)) {
    DBG"$_proc $kfs EOF exit!\n"
   }
  else {


    for (i = 0; i < nfdd ; i++) {

       dfdt = devfd[i][2];
//<<"%v $i  $devfd[i][2] $dfdt\n"

    }
  }
  else  {

<<"WARNING no dev fields to read $nfdd\n"

  fmt = "C16"

//k= fscanv(A,0,fmt,&devfd)

//"%X $devfd \n"

  }
  }
/*
DBANS=query("$_proc out ? ")
if (DBANS == "q") {
   exit()
}
*/
}
//==============================//

void rd_def()
{

 kfs= fscanv(A,0,"C1,C1,S1,C1",&rserv,&arch,&gmn,&nfields);
 
 tot_br += kfs;

  if (feof(A)) {
    <<"$_proc $kfs EOF break!\n"
       break;
    }

//DBG[_DB]"rd_dev $tot_br %V $rserv $arch $gmn $nfields \n"

}
//==============================//

int vecd[255];
int cat;
float tot_secs = 0.0;


void rd_data()
{

// what local message ?

  decode = 1;
  
   T=FineTime()

   tim = 0
   lat =0;
   fndpos = 0;
   
// then what data fields ??


 if (nfields != DEFS_NF[lmt]) {
//<<"DIFFER? %V$nfields $lmt $DEFS_NF[lmt] \n"
    nfields = DEFS_NF[lmt];
  }


   where = ftell(A)

   nfields = DEFS_NF[lmt];

//DBG[_DB]"$_proc @ posn $where reading data %V$lmt $nfields\n"

  if (nfields <=0) {
<<"ERROR no fields!!\n"
  }
  else {
//<<[_DB]"RD_DATA %V $lmt  $nfields \n"
//<<[_DB]"RD_DATA %V $lmt  $DEFS[lmt] $nfields \n"

  //len = nfields*3;

//<<[_DB]"DEFS $(Cab(DEFS)) $(typeof(DEFS)) \n"

  dfd = DEFS[lmt][::];

 // <<"%V $dfd[0:len-1] \n"
//<<[_DB]"dfd $(Cab(dfd)) $(typeof(dfd)) \n"

//<<[_DB]"dfd[ $lmt ] \n"

//<<[_DB]"WTF $dfd[1] \n"

//vecd = dfd;
//<<[_DB]"%V $vecd[0:32] \n"

  dfd<-Redimn(85,3);


//<<"$dfd[0:9:1][::] \n"

//DBG[_DB]"%V $nfields\n"


 for (i = 0; i < nfields ; i++) {

   cat = dfd[i][0];
   nbs =  dfd[i][1];
   dfdt = dfd[i][2];

     if (nbs > 0) {



    //   nb = dfd[i][1];
    //    fmt = "C$nbs"

    //kfs= fscanv(A,0,fmt,CD);

   kfs = fread(CD,1,nbs,A);
   tot_br += kfs ;

//<<"fread rd_data CD $kfs $tot_br\n" 

//DBG[_DB]"%v $i $kfs $cat $nbs $dfdt\n"

   // where = ftell(A);

    if (feof(A)) {
    <<"$_proc EOF exit!\n"
    }
    else {
	//<<[_DB]"READ $nbs data bytes\n";
//	if (nbs > 120) {
         // ans = iread("$nb dbytes too big?");
//	 <<[_DB]"$nbs dbytes too big?\n"
//        }





       switch (dfdt)
       {
         case  0:
	  {
	  // enum
//<<[_DB]"enum %d $CD[0]\n";
    //k= fscanv(A,0,"C1",&wc)
	 // EV[evn] = wc;
	 
//	    <<"$i <0> $evn enum $CD[0]\n"
	 evn++;
	 }
	 break;
        case   2:
	 {
//<<[_DB]"enum %d $CD[0]\n";
    //k= fscanv(A,0,"C1",&wc)
	 // EV[evn] = wc;

        if (cat == 3) {
           bpm = CD[0];
        }

	  //DBG[_DB]"$i <0> $evn enum %u $wc\n"
	 evn++;
	 }
	 break;
        case 7:
	  {
	    <<"STR <7> %s $CD[0:nbs-1]\n";
	  }
         break;
         case  132:
	  {
//<<"%V $CD[0:10]\n"
            ws= CD<-mscan(SHORT_,0);

        if (cat == 2) {
             alt = ws * 0.2 -500;
	    // alt = ws * 0.2 ;
        }
        else if (cat == 6) {
           spd = ws * 0.001;
        }
        else {
	alt = ws * 0.2 ;
      //  <<"miss %v$cat $dfdt $ws  $alt\n";
        }
//	<<"spd ? $where $dfdt $cat $CD[0] $CD[1] $ws $spd\n";
        //k= sscan(CD,'%d',&ws)
	 //SV[svn] = ws;
	  //<<[_DB]"$i  <132> svn $svn man/prod %d $ws\n"
	 svn++;
	 }
	 break;
         case    133:
	{
	// time created
//<<[_DB]"TIME  $CD[0:3] \n";
        //pos = 0;

//<<" got data 133 \n"
       
	pos=CD<-mscan(INT_,0);
       //   k= sscan(CD,'%d',&wt)
	 // TV[tvn] = wt;
        deg = pos * scdeg;
        if (cat == 0) {
             lat = deg;
        }
        else if (cat == 1) {
             lon = deg;
        }
       else {
        DBG[DB_]"miss %v$cat $dfdt $pos\n";
        }


	fndpos++;

        //DBG[_DB]"$i <133>  pos_deg   $deg\n"
	//	<<"$i <133>  $cat pos_deg   $deg\n"
	  //tvn++;
	  }
        break;  
       case   134:
        {// time created 
//DBG[_DB]"TIME  $CD[0:3] \n";
      //  wt = 0;
      
        //bscan(CD,0,&wt); // works - sscan does not why?

        wt=CD<-mscan(INT_,0);

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
	 // TV[tvn] = wt;
//	<<"$i <134> <$tvn> time  %u $wt\n"
	  //tvn++;
          }
          break;
 
	case 140:
              // serial
        //DBG[_DB]"read serial %d $CD[0:nbs-1]\n"

     //   wi = 0;
//        bscan(CD,0,&wi); // works - sscan does not why?
       //  k= sscan(&CD[0],'%d',&wi)
          // IV[ivn] = wi;
               wt=CD<-mscan(INT_,0);

//        <<"$i <140> $ivn serial  %u $wi\n"
	  wvn++;       
        break;
  
         default:
	  {
	  ws= CD<-mscan(SHORT_,0);
    	 // <<"default $i  <$dfdt> cat $cat $CD[0] $ws \n";
           }
         break;
        }
       }
     }
 }

//DBG[_DB]"%V $lmt\n"

//ans=query("lmt $lmt")


   // <<"$where $kl $tim $lat $lon $dist $spd $alt $bpm\n";
 if ((kl % 100) == 0) {
   dt= fineTimeSince(TL,1)
  secs = dt/1000000.0;
  tot_secs += secs;
  pc_done = where/(file_size*1.0) * 100.0
  <<[2]"$where %6.2f $pc_done %% $secs $tot_secs %d $kl $where $lat $lon $dist $spd $alt $bpm\r";
  fflush(1)
 }

//<<"$tim $lat $lon $dist $spd $alt $bpm\n";


 if (fndpos) {
 
<<[B]"$tim $lat $lon $dist $spd $alt $bpm\n";

//<<"$tim $lat $lon $dist $spd $alt $bpm\n";


  if (do_ask) {
    ans=query("$where $lat $lon :")
    if (ans @="q") {
       wloop = 0;
   }
    if (ans @="c") {
     do_ask = 0;
    }
   }
  
}

  if (lmt == 9) {  // what ?
    cnt9++;
    <<[_DB]" $cnt9  \n";

   // <<[B]"$tim $lat $lon $dist $spd $alt $bpm\n";

  }
  
 }
 
  dt= fineTimeSince(T);

  secs = dt/1000000.0;

<<"took  $secs\n"

//  <<"end of $_proc \n"

}
//===============================//
void rd_devdata()
{
// what local message ?

// then what data fields ??

<<[_DB]"RD_DEVDATA @ read $kl   $nfdd \n"


<<"ERROR not coded!!\n"

}
//==============================//

void storeLMT(int almt)
{
//DBG[_DB]"$_proc \n"
static int nlmts = 0;
int k;

   nl = nlmts;

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

/*
DBANS=query("$_proc out ? ")
if (DBANS == "q") {
   exit()
}
*/
}
//===========================//

fname = "bike.fit";
ask = 0;

fname = _clarg[1];
//ask = atoi(_clarg[2]);

//file_size= fstat(fname,"size")
file_size= fexist(fname)

<<"%V$file_size \n";

   TL=FineTime()
A= ofr(fname);

outname = scut(fname,-3);

outname = scat(outname,"tsv");

<<"$fname $outname\n"

B= ofw(outname);

<<" %V $B\n"

if (A == -1) {
 <<"bad file $fname --- exit\n"
  exit();
}

rd_hdr();   // read the FIT header

//<<[_DB]"%V $fit_hdr \n"

//ok=query("hdr ok?");

 if (!fit_hdr) {
  <<" NOT A FIT FILE\n"
   exit();
 };

//<<[_DB]"hdr is %V$ok\n"


int kl = 0;
int cnt9 =0;

///            MAIN  LOOP ///

   do_ask = 0;
   wloop = 1;
   
while (wloop) {

//<<"%V $kl \n"


   rd_hdb();

//ans=query("hdb")

    if (feof(A)) {
       break;
    }

   if (defin) {

     rd_def();
//ans=query("rd_def");



     rd_dfds();



//ans=query("rd_dfds");

      if (devdata) {
      
         rd_devfds();
	 
     }

   }


    if (data) {
    
       rd_data()


      if (devdata) {
      
          rd_devdata();
	  
       }

    }

   kl++;

/*
   if (do_ask) {
     ans=query("continue:\n");
    if (ans @="q") {
     break;
   }
    if (ans @="c") {
     do_ask = 0;
    }
  }
*/

    //if (kl > 50)       break;
//<<"wloop $kl\n"

}
//========================//


   k = 0;
   while (1) {

     if (LMTS[k][0] == -1) {
          break;
     }
   // <<" $k $LMTS[k][0] $LMTS[k][1]\n"

    k++;

    }
<<" at end $k\n";

cf(B)

exit()
//////////////////////////////////////////   DEV //////////////////////////////////////
/*
  too slow!

  ? what to move to cpp?



*/