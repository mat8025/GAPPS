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
myScript = getScript();
///
///  convert fit file --- extract lon,lat, time,speed, pulse
///

//////////////   GLOBALS ///////////////
_DB = -1

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

float lat;
float lon;

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
uchar nf;
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



//////////// TBD ////////////////
//  need array of local msg defs
//
//
//



///////////////////   PROCS /////////////////
proc rd_hdr()
{

//<<[_DB]"$_proc\n"

   k= fscanv(A,0,"C1,C1,S1,I1,C4,S1",&hsz,&protover,&profver,&datasz,&C,&CRC)

  //<<[_DB]"%V $k $hsz  $protover $profver $datasz\n"

<<" %s $C\n"
 if (scmp(C,".FIT")) {
     fit_hdr = 1;
 }

//<<[_DB]"CRC %x $CRC\n"
}
//=========================//

proc rd_hdb()
{

//<<[_DB]"$_proc\n"
//   where = ftell(A)
   k= fscanv(A,0,"C1",&ht)
//<<[_DB]"%V $where $k %X $ht\n"
//bc=dec2bin(ht)
//<<[_DB]"$bc \n"
   bc = scut(dec2bin(ht),24);
//<<[_DB]"$bc \n"
   normal = 1;
   defin = 0;
   data = 1;
   cmpts = 0;
//<<[_DB]"<$kl> HDRB "   
   nfdd = 0;

 //  ct= ht & 0x80
   //<<[_DB]"%V $ht %X $ct $ht\n"

    if ((ht & 0x80) == 0x80) {
        normal = 0;
	cmpts = 1;
//<<[_DB]"$ht %X $ht  0x80 cmpts  "	
   }
//   else {
//<<[_DB]"$ht %X $ht normal  "	
//  }


   
   if ((ht & 0x40) == 0x40) {
   //<<[_DB]"$ht %x $ht &  0x40\n"
        defin = 1;
	data = 0;
//<<[_DB]"defin  "		
   }
//   else {
//<<[_DB]"data  "	
//   }

//ct= ht & 0x20
   //<<[_DB]"%V $ht 0x20 %X $ct $ht\n"
   

   if (defin) {
     devdata = 0;
     if ((ht & 0x20) == 0x20) {
        //<<[_DB]"$ht %x $ht &= 0x20 ?\n"
	devdata = 1;
//<<[_DB]"devdata "		
     }
   }
   
   lmt = (ht & 0x0F);

//   where = ftell(A);


//"%V $where $k %X $ht  $bc %d $lmt \n"


  if (defin) {
//     storeLMT( lmt);
  }

//ans=query("%V $where $k $normal  $data $cmpts $devdata %X $ht")

}
//=========================//
proc rd_dfds()
{

  n= 3 * nf;

//<<[_DB]"$_proc %V $nf\n"

  if (nf == 0) {
<<"WARNING no fields $nf \n"
  }



  if (nf > 0) {
  fmt = "C$n"
  //<<[_DB]"%V $fmt \n"
  dfd = 0;


/{/*/ SDBG

  fmt="C3"
  
  where = ftell(A)
  k= fscanv(A,0,fmt,&vec_uc)
<<"@ $where : $vec_uc\n"

where = ftell(A)
  k= fscanv(A,0,fmt,&vec_uc)
<<"@ $where : $vec_uc\n"

where = ftell(A)
  k= fscanv(A,0,fmt,&vec_uc)
<<"@ $where : $vec_uc\n"


ok=query()


/}*///  EDBG

  k= fscanv(A,0,fmt,&dfd)

  //<<[_DB]"dfd %V $(Cab(dfd)) \n"
/{
  for (j=0; j< nf; j++) {
 <<[_DB]"<|$j|> $dfd[j][::]\n"
  }
/}

 //<<[_DB]"%V $lmt \n"
  
   DEFS_NF[lmt] = nf;

   vd = dfd;

   //vd->Redimn(85,3);

  //<<[_DB]"%V $(Cab(vd)) \n"
/{
  for (j=0; j< nf; j++) {
 <<[_DB]"$j $vd[j][::]\n"
  }
/}

   // <<[_DB]"vd $vd\n"
  vd->Redimn();
  //<<[_DB]"/////////////////////// \n"
  //<<[_DB]"%V $(Cab(vd)) \n"
  //<<[_DB]"%V $vd\n"
  //<<[_DB]"/////////////////////// \n"      
//<<[_DB]"DEFS $(Cab(DEFS)) $(typeof(DEFS)) \n"

  DEFS[lmt][::] = vd;
//  DEFS[lmt] = vd;
  
  //<<[_DB]"DEFS %V $lmt $n\n "

//<<[_DB]"DEFS $(Cab(DEFS)) $(typeof(DEFS)) \n"
//  <<[_DB]"%(3,, ,\n)$DEFS[lmt][0:n-1:]\n"
  //<<[_DB]"$DEFS[lmt][0:n-1:]\n"
  //<<[_DB]"/////////////////////// \n"
  }
}
//==============================//

proc rd_devfds()
{
//<<[_DB]"$_proc\n"

k= fscanv(A,0,"C1",&nfdd)

//<<[_DB]"DEVDATA !! @ $kl %V $nfdd\n"

  //ans = iread("devdata $nfdd fields\n"

  if (nfdd == 0) {

<<"WARNING no dev fields to read $nfdd\n"

  fmt = "C16"

//k= fscanv(A,0,fmt,&devfd)

//"%X $devfd \n"

  }


  if (nfdd > 0) {
  
  n= 3 *nfdd;

  fmt = "C$n"

  k= fscanv(A,0,fmt,&devfd)


    for (i = 0; i < nfdd ; i++) {

       dfdt = devfd[i][2];
//<<[_DB]"%v $i  $devfd[i][2] $dfdt\n"
//ans = iread("devdata $i"
    }
  }

}
//==============================//

proc rd_def()
{

 k= fscanv(A,0,"C1,C1,S1,C1",&rserv,&arch,&gmn,&nf)

//<<[_DB]"RD_DEV %V $rserv $arch $gmn $nf \n"
}
//==============================//

int vecd[255];
int cat;


proc rd_data()
{
// what local message ?



// then what data fields ??
  nf = DEFS_NF[lmt];

//ans=query("reading data %V$lmt $nf")

  if (nf <=0) {
<<"ERROR no fields!!\n"
  }
  else {
//<<[_DB]"RD_DATA %V $lmt  $nf \n"
//<<[_DB]"RD_DATA %V $lmt  $DEFS[lmt] $nf \n"

  len = nf*3;

//<<[_DB]"DEFS $(Cab(DEFS)) $(typeof(DEFS)) \n"

  dfd = DEFS[lmt][::];
//<<[_DB]"dfd $(Cab(dfd)) $(typeof(dfd)) \n"

//<<[_DB]"dfd[ $lmt ] \n"

//<<[_DB]"WTF $dfd[1] \n"

//vecd = dfd;
//<<[_DB]"%V $vecd[0:32] \n"

  dfd->Redimn(85,3);

 for (i = 0; i < nf ; i++) {
   cat = dfd[i][0];
   dfdt = dfd[i][2];
   nbs =  dfd[i][1];
//<<[_DB]"%v $i $dfd[i][0] $nbs $dfdt\n"

     if (nbs > 0) {

    //   nb = dfd[i][1];
        fmt = "C$nbs"
        k= fscanv(A,0,fmt,CD);


	//<<[_DB]"READ $nbs data bytes\n";
//	if (nbs > 120) {
         // ans = iread("$nb dbytes too big?");
//	 <<[_DB]"$nbs dbytes too big?\n"
//        }

       if (dfdt == 134) {  // time created
//<<[_DB]"TIME  $CD[0:3] \n";
      //  wt = 0;
        bscan(CD,0,&wt); // works - sscan does not why?

        if (cat == 253) {
           tim = wt;
        }

        if (cat == 5) {
             dist = wt * 0.01;
        }
       //   k= sscan(CD,'%d',&wt)
	 // TV[tvn] = wt;
	//<<[_DB]"$i <134> <$tvn> time  %u $wt\n"
	  tvn++;
       }
       else if (dfdt == 133) {  // time created
//<<[_DB]"TIME  $CD[0:3] \n";
        //pos = 0;
        bscan(CD,0,&pos); // works - sscan does not why?
	 
       //   k= sscan(CD,'%d',&wt)
	 // TV[tvn] = wt;
        deg = pos * scdeg;
        if (cat == 0) {
             lat = deg
        }
        if (cat == 1) {
             lon = deg
        } 	
	//<<[_DB]"$i <133> <$tvn> pos  $pos  $deg\n"
	  tvn++;
       }
        else if (dfdt == 140) {  // serial
    //     <<[_DB]"read serial %d $CD[0:nb]\n"

     //   wi = 0;
        bscan(CD,0,&wi); // works - sscan does not why?
       //  k= sscan(&CD[0],'%d',&wi)
          // IV[ivn] = wi;
        //<<[_DB]"$i <140> $ivn serial  %u $wi\n"
	  wvn++;       
       }
       else if (dfdt == 7) { 
	<<[_DB]"STR <7> %s $CD[0:nbs]\n";
        }

      else if (dfdt == 132) { // manuf/product
//<<[_DB]"manuf/product %d $CD[0:nbs-1]\n";
       // ws = 0;
        bscan(CD,0,&ws); // works - sscan does not why?
	  //      bscan(CD,1,&ws2); // works - sscan does not why?

        if (cat == 2) {
           alt = ws * 0.2 -500;
        }
	
        if (cat == 6) {
           spd = ws * 0.001;
        } 		

        //k= sscan(CD,'%d',&ws)
	 //SV[svn] = ws;
	  //<<[_DB]"$i  <132> svn $svn man/prod %d $ws\n"
	 svn++;
   }
   else if (dfdt == 2) {  // enum
//<<[_DB]"enum %d $CD[0]\n";
    //k= fscanv(A,0,"C1",&wc)
	 // EV[evn] = wc;

        if (cat == 3) {
           bpm = CD[0];
        }

	  //<<[_DB]"$i <0> $evn enum %u $wc\n"
	 evn++;
  }
   else if (dfdt == 0) {  // enum
//<<[_DB]"enum %d $CD[0]\n";
    //k= fscanv(A,0,"C1",&wc)
	 // EV[evn] = wc;
	 
	  //<<[_DB]"$i <0> $evn enum %u $wc\n"
	 evn++;
  }
  else {
    	  //<<[_DB]"$i  <$dfdt> $CD[0:nbs-1] \n";

  }

 }


}


//ans=query("lmt $lmt")

  if (lmt == 9) {
    cnt9++;
    //<<[_DB]"$kl $tim $lat $lon $dist $spd $alt $bpm\n";

    <<[B]"$tim $lat $lon $dist $spd $alt $bpm\n";

  }
  
}
}
//===============================//
proc rd_devdata()
{
// what local message ?

// then what data fields ??

//<<[_DB]"RD_DEVDATA @ read $kl   $nfdd \n"


<<"ERROR not coded!!\n"


}
//==============================//

proc storeLMT( almt)
{
static int nlmts = 0;
int k;

   nl = nlmts;

for (k = 0; k <= nl; k++) {

    if (LMTS[k][0] == -1) {
         LMTS[k][0] = almt;
	          LMTS[k][1] = 1;
	 nlmts++;
	 //<<[_DB]"added lmt $almt\n"
	 break;
     }
     else if (LMTS[k][0] == almt) {
                LMTS[k][1] += 1;
            break;  // already logged
     }
   }

}
//===========================//

fname = "../TRACES/bike.fit";
ask = 0;

fname = _clarg[1];
//ask = atoi(_clarg[2]);



A= ofr(fname);

outname = scut(fname,-3);

outname = scat(outname,"tsv");

<<"$fname $outname\n"

B= ofw(outname);


if (A == -1) {
 <<"bad file $fname --- exit\n"
  exit();
}

rd_hdr();   // read the FIT header

//<<[_DB]"%V $fit_hdr \n"

//ok=query("hdr ok");

 if (!fit_hdr) {
  <<" NOT A FIT FILE\n"
   exit();
 };

//<<[_DB]"hdr is %V$ok\n"


int kl = 0;
int cnt9 =0;

///            MAIN  LOOP ///
goon="y"

while (1) {

// <<"%V $kl \n"


   rd_hdb();



  if (feof(A)) {
       break;
  }


   

   if (defin) {
/{/*
    if (ask) {

      goon= query(" read define?");
<<"%V$goon\n"
     if (goon @= "n") {
         break;
    }

    if (goon @= "c") {
         ask = 0;
     }
 

    }
/}*/    

     rd_def();

     rd_dfds();

      if (devdata) {
         rd_devfds();
     }

   }


    if (data) {
/{/*
    if (ask) {

     goon= iread(" read data?");
<<"%V$goon\n"
      if (goon @= "n") {
        break;
    }

    if (goon @= "c") {
         ask = 0;
    }

    if (goon @= "q") {
         exit()
    }

     ask = 0;
    }
/}*/
       rd_data()

      if (devdata) {
          rd_devdata();
     }

    }

   kl++;
//   if (kl > 10000) {
//       break;
//   }
}
//========================//


   k = 0;
   while (1) {

     if (LMTS[k][0] == -1) {
          break;
     }
    <<" $k $LMTS[k][0] $LMTS[k][1]\n"
    k++;

    }

cf(B)

exit()
//////////////////////////////////////////   DEV //////////////////////////////////////
/{/*


  too slow!

  ? what to move to cpp?













/}*/