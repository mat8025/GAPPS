///
///  alpha_ip
///  takes  fonts file and makes an input for ANN
///  train/test
///

setdebug(1,"~pline");

float T[100];

float TRIV[]
float TROV[]

float TSTIV[]
float TSTOV[];


proc add_pat(MP)
{
<<"adding pat\n"
    check_shift(MP);
  //  MP->redimn();
  redimn(MP);
    TRIV=vsplice(TRIV,MP);
    TROV=vsplice(TROV,LOP);
}
//=================
proc shift_tar(l,r,t,b)
{


;
   LOP[0:23] = 0.0;
   
   if (l > 0) 
     LOP[l-1] =1;
   if (t > 0) 
    LOP[8+t] =1;
   if (r > 0) 
     LOP[11+r] =1;
   if (b > 0) 
     LOP[20+b] =1;  
<<"%6.0f%(12,,,\n)$LOP\n"
}

proc make_tar(l,r,t,b)
{
//  how much to shift
//<<"tar vec %6.2f$LOP\n"

  // LOP = 0.0;
      LOP[0:23] = 0.0;
 <<"tar vec %6.0f$LOP\n"
// ans=iread()
   if (l > 0)  {
     j =l ;  j->limit(0,7);
     <<"0 : $(j-1) \n"
     LOP[0:j-1] =1;
   }

<<"$l %6.0f%(12,,,\n)$LOP\n"

   if (t > 0) {
        j =t;  j->limit(0,5);
	<<"7 : $(7+j-1) \n"
      LOP[7:7+j-1] =1;
   }

<<"$t %6.0f%(12,,,\n)$LOP\n"

   if (r > 0) {
     j =r;  j->limit(0,7);
     <<"12 : $(12+j-1) \n"
     LOP[12:12+j-1] =1;
    }

<<"$r %6.0f%(12,,,\n)$LOP\n"

   if (b > 0) {
     j =b;  j->limit(0,5);
     <<"19 : $(19+j-1) \n"
     LOP[19:19+j-1] =1;
    // LOP[19:19+j] =1;
     //LOP[19:19] =1;
    // LOP[19:19] =1;
     
  }

<<"$b %6.0f%(12,,,\n)$LOP\n"

<<"%6.0f%(12,,,\n)$LOP\n"
}


//
proc check_lcol(M)
{
// which col does letter shape start in?
  cs = Sum(M)
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

proc check_rcol(M)
{
// which col does letter shape end in?
  cs = Sum(M)
//<<"%V$cs\n"
  lcs = 0;
  int i= Ncols-1;
    while (1) {
     lcs = cs[i];
     if (lcs > 0)
        break;
     i--;
    }
   return i;
}
//

proc check_trow(M)
{
// which row does letter shape start in?
  rs = 0;
  int i= 0;
    while (1) {
     rs = Sum(getRow(M,i))
     if (rs > 0)
        break;
     i++;
    }
   return i;
}
//

proc check_brow(M)
{
// which row does letter shape end in?
  rs = 0;
  int i= Nrows -1;
    while (1) {
     rs = Sum(getRow(M,i))
     if (rs > 0)
        break;
     i--;
    }
   return i;
}
//

proc check_shift(W, lname)
{

  lc = check_lcol(W);
  <<"shift left by $lc \n";
  rc = check_rcol(W);
  rc = Ncols -rc -1;
  <<"shift right by $rc \n";

   tr = check_trow(W);
  <<"shift up by $tr \n";

   br = check_brow(W);
   br = Nrows -br -1;
  <<"shift down by $br \n";

  sz = Cab(W)
  <<" $(Caz(W)) $(Cab(W)) \n"


   lcs = -1;
   rcs = -1;
   trs = -1;
   brs = -1;
<<"%V $lc $rc $tr $br $lcs $rcs $trs $brs \n"

   if (fabs(lc-rc) < 1) {
     lcs = 0;
     rcs = 0;
   }
   else {
     if (lc > rc) {
      lcs = (lc-rc)/2;
      rcs = 0;
     }
     else {
      rcs = (rc-lc)/2;
      lcs = 0;
     }
   }

   if (fabs(tr-br) < 1) {
     trs = 0;
     brs = 0;
   }
    else {
     if (tr > br) {
      trs = (tr-br)/2;
      brs = 0;
     }
     else {
      brs = (br-tr)/2;
      if (br ==2) {
         brs = 1;
      }
      trs = 0;
     }
   }

<<"$Lname %V $lc $rc $tr $br $lcs $rcs $trs $brs \n"

   //shift_tar(lcs,rcs,trs,brs);
   make_tar(lc,rc,tr,br);
   
//ans=iread("->");
}

float LOP[24];

int Ncols = 10;
int Nrows = 10;

Lname = "";

proc letter(wa)
{

fn = _clarg[wa]);
<<"$wa $fn\n"
Lname = fn;

A=ofr(fn);

if (A == -1) {
 exit();
}



S=readline(A);
S=readline(A);

 W = split(S,",");

let = W[0]

<<"%V$let\n"

S=readline(A);  W = split(S,",");


int k = 0;


  while (1) {

  W = split(readline(A),",");

  if (feof(A)) {
   break;
  }
  
  
//<<"[${k}] $W[0] $W[4]\n"
 T[k] = atof(W[4]);
 k++;
 }

  T->redimn(10,10);

  <<"%6.1f $T\n"

   R=T;



/// train vecs
<<"$LOP \n"

<<"$T \n"
//ans=iread("T");


  LML= cyclecol(T,1);

  LML2= cyclecol(T,2)
<<"$LML2 \n"

//ans=iread("LML");
  LML2U= cyclerow(LML2,-1)
  LML2D= cyclerow(LML2,1)  

  LMR= cyclecol(T,-1)
<<"$LMR \n"

  LMR2= cyclecol(T,-2)

  LMR2D= cyclerow(LMR2,1)

  LMR2U= cyclerow(LMR2,-1)  

  LMU= cyclerow(T,-1)

  LMD= cyclerow(T,1)

  check_shift(T);


  T->redimn()
  if (wa ==1) {

    TRIV = T;
    
    TROV = LOP;
  }
  else {
    TRIV=vsplice(TRIV,T)
    TROV=vsplice(TROV,LOP)
  }

   add_pat(LML);
  
  //check_shift(LML);
  //LML->redimn();
  //TRIV=vsplice(TRIV,LML);
  //TROV=vsplice(TROV,LOP);

    add_pat(LML2);

    add_pat(LML2U);
    add_pat(LML2D);
 
    add_pat(LMR);

    add_pat(LMR2);

    add_pat(LMR2D);
    add_pat(LMR2U);

    add_pat(LMU);

    add_pat(LMD);

// how much to shift left letter dependent!
   






/// op
/// test vecs

 cf(A);

}


na = argc()

<<"$na \n"

//ans=iread()



  for (i=1 ; i < na ; i++) {

    letter(i);
  
 <<"$i $(Caz(TRIV)) $(Cab(TRIV)) \n"
  }

////////////////////////////////////

int make_test = 1;
 if (make_test) {
  B=ofw("shifttstip.dat")
  wdata(B,TRIV);
  cf(B)


  B=ofw("shifttstop.dat")
  wdata(B,TROV);
  cf(B)
}
else {
  B=ofw("shifttrip.dat")
  wdata(B,TRIV);
  cf(B)

  B=ofw("shifttrop.dat")
  wdata(B,TROV);
  cf(B)

}

/////////////////////////////////////

  