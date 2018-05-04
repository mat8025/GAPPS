///
///  alpha_ip
///  takes  fonts file and makes an input for ANN
///  train/test
///

//setdebug(1,"~pline","~trace");

dont_ask = 0;

#define ASK ;

//#define ASK ans=iread("->");

int make_train = 0;
int make_test = !make_train;

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

   LOP = 0.0;
   
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
//==========================
proc make_tar(l,r,t,b)
{

//  how much to shift
//<<"tar vec %6.2f$LOP\n"
<<"%V $l $r $t $b \n"
<<" $(infoof(l))\n"
  int j = 0;
  LOP = 0.0;

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
  <<"memused $(memused()) \n"
}
//======================

proc pos_tar(l,r,t,b)
{

//  how mark start/end rows cols

//<<"tar vec %6.2f$LOP\n"
<<"%V $l $r $t $b \n"
<<" $(infoof(l))\n"

int j = 0;

    LOP = 0.0;
<<"%6.0f%(10,,,\n)$LOP\n"

// ans=iread()

     LOP[l] =1;
  <<"$l \n%6.0f%(10,,,\n)$LOP\n"
     LOP[r] =1;
  <<"$r \n%6.0f%(10,,,\n)$LOP\n"
  
      tpi = t+10;
      LOP[tpi] =1;
      
      //LOP[10+t] =1;
    <<"$t $tpi \n"
    <<" %6.0f%(10,,,\n)$LOP\n"
      bpi = 10+b;
      LOP[bpi] =1;

  <<"$b $bpi \n"
  <<"%6.0f%(10,,,\n)$LOP\n"
  <<"memused $(memused()) \n"
}
//======================

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
<<"$_proc\n"
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
  
  rci = Ncols -rc -1;
  <<"shift right by $rci \n";

   tr = check_trow(W);
  <<"shift up by $tr \n";

   br = check_brow(W);
   bri = Nrows -br -1;
  <<"shift down by $bri \n";

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
  // make_tar(lc,rc,tr,br);
   pos_tar(lc,rc,tr,br);

   ASK
   

}
//==================




float LOP[20];

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
  
    TP = R;
//  different positions

    
    // up
    SP = cyclerow(TP,-1);
    TP = SP
    if (make_train)
    add_pat(SP);

    SP = cyclerow(TP,-1);
    TP = SP
    if (make_test)
    add_pat(SP);



    // left
    SP = cyclecol(TP,-1);
    TP = SP
    if (make_train)
     add_pat(SP);

    SP = cyclecol(TP,-1);
    TP = SP
    if (make_test)
      add_pat(SP);

    
    
    // down
    SP = cyclerow(TP,1);
    TP = SP
    if (make_train)
    add_pat(SP);

    SP = cyclerow(TP,1);
    TP = SP
    if (make_test)
    add_pat(SP);

    SP = cyclerow(TP,1);
    TP = SP
    if (make_train)
    add_pat(SP);
    

// how much to shift  letter dependent!
    
    // right
    SP = cyclecol(TP,1);
    TP = SP
    if (make_train)
    add_pat(SP);

    SP = cyclecol(TP,1);
    TP = SP
    if (make_train)
    add_pat(SP);

    SP = cyclecol(TP,1);
    TP = SP
    if (make_test)
    add_pat(SP);

    SP = cyclecol(TP,1);
    TP = SP
    if (make_test)
    add_pat(SP);


    SP = cyclecol(TP,1);
    TP = SP
    if (make_train)
    add_pat(SP);





    // up

    SP = cyclerow(TP,-1);
    TP = SP
    if (make_train)
    add_pat(SP);

    SP = cyclerow(TP,-1);
    TP = SP
    if (make_test)
    add_pat(SP);


    SP = cyclerow(TP,-1);
    TP = SP
    if (make_train)
    add_pat(SP);

    
// train 9 + start 

// test  6 + start

<<"memused $(memused()) \n"


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

  