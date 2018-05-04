///
///  alpha_ip
///  takes  fonts file and makes an input for ANN
///  train/test
///

setdebug(1,"~pline","~step","trace")

//#define ASK ans=iread()
#define ASK ;
proc shift_tar(l,d)
{
//<<"tar vec %6.2f$LOP\n"
   LOP = 0.0;
   if (l > 0) 
     LOP[l-1] =1;
   if (d > 0) 
    LOP[8+d] =1;

<<"tar vec %6.1f$LOP\n"
}

proc make_tar(l,d)
{
//<<"tar vec %6.2f$LOP\n"
   LOP = 0.0;
   if (l > 0) 
     LOP[l-1] =1;
   if (d > 0) 
    LOP[8+d] =1;

<<"tar vec %6.1f$LOP\n"
}


//
proc check_lcol()
{
// which col does letter shape start in?
  cs = Sum(T)
//<<"%V$cs\n"
  lcs = 0;
  int i= 0;
    while (1) {
     lcs = cs[i];
     if (lcs > 0)
        break;
     i++;
    }
 
   return i;
}
//
int make_test=0;
float LOP[12];

proc letter(wa)
{

fn = _clarg[wa]);
<<"$wa $fn\n"

A=ofr(fn);

if (A == -1) {
 exit();
}

lmu =memused()

S=readline(A);
S=readline(A);

 W = split(S,",");

let = W[0]

<<"%V$let\n"

S=readline(A);  W = split(S,",");


int k = 0;


  while (1) {

  wl=readline(A)

  if (feof(A)) {
  <<"EOF $k line\n"
   break;
  }

 W = split(wl,,",");

  
  
 if (k > 100)
   break;
   



 T[k] = atof(W[4]);


<<"[${k}] $W[0] $W[4] \n"
k++;
}



  T->redimn(10,10);

  <<"%6.1f $T\n"

  lc = check_lcol()
  <<"shift left by $lc \n";
  
  sz = Cab(T)
  <<" $(Caz(T)) $(Cab(T)) \n"

   R=T;

   shift_tar(lc,1)
   
/// train vecs
<<"%6.0f$LOP \n"

mu =memused()
<<"memused $mu $lmu $(mu-lmu)\n"

lmu = mu

ASK


<<"$T \n"
//ans=iread("T");

  LML= cyclecol(T,1)
//<<"$LML \n"
//ans=iread("LML");

  LML2= cyclecol(T,2)
<<"$LML2 \n"
//ans=iread("LML");
  LML2U= cyclerow(LML2,-1)  

  LMR= cyclecol(T,-1)
<<"$LMR \n"

//ans=iread("LMR");

  LMR2= cyclecol(T,-2)
  LMR2D= cyclerow(LMR2,1)  

  LMU= cyclerow(T,-1)
//<<"$LMU \n"
//ans=iread("LMU");

  LMD= cyclerow(T,1)
//<<"$LMD \n"
//ans=iread("LMD");


  T->redimn()
  
  LML->redimn();
  LML2->redimn();
  LML2U->redimn();
  LMR->redimn();
  LMR2->redimn();
  LMR2D->redimn();

  ASK
    


  if (wa ==1) {
    TRIV = T;
    
    TROV = LOP;
  }
  else {
    TRIV= vsplice(TRIV,T)
    TROV= vsplice(TROV,LOP)
  }

<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"
ASK
// how much to shift left letter dependent!
    TRIV=vsplice(TRIV,LML);
    shift_tar(lc-1,1);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK
    TRIV=vsplice(TRIV,LMR);
    shift_tar((lc+1),1);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK
    TRIV=vsplice(TRIV,LMR2);
    shift_tar((lc+2),1);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK	
    TRIV=vsplice(TRIV,LMR2D);
    shift_tar(lc+2,0);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK

    TRIV=vsplice(TRIV,LML2);
     shift_tar(lc-2,1);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK    
    TRIV=vsplice(TRIV,LML2U);	
     shift_tar(lc-2,2);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK
    TRIV=vsplice(TRIV,LMU);
     shift_tar(lc,2);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK
    TRIV=vsplice(TRIV,LMD);
     shift_tar(lc,0);
    TROV=vsplice(TROV,LOP);
<<"$(Caz(TRIV)) $(Caz(TROV)) $(memused())\n"    
ASK

/// op
/// test vecs

 cf(A);
ASK
}


na = argc()

<<"$na \n"
float T[100];

float TRIV[]
float TROV[]

float TSTIV[]
float TSTOV[]

  for (i=1 ; i < na ; i++) {

    letter(i);
  
 <<"$i $(Caz(TRIV)) $(Cab(TRIV)) \n"
  }

////////////////////////////////////

if (make_test) {
<<"writing TST IPOP \n"
  B=ofw("shifttstip.dat")
  wdata(B,TRIV);
  cf(B)

  B=ofw("shifttstop.dat")
  wdata(B,TROV);
  cf(B)
 }
 else {
 <<"writing TR IPOP \n"
  B=ofw("shifttrip.dat")
  wdata(B,TSTIV);
  cf(B)


  B=ofw("shifttrop.dat")
  wdata(B,TSTOV);
  cf(B)
}
/////////////////////////////////////
<<"DONE\n"
  