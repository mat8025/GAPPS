///
///  alpha_ip
///  takes  fonts file and makes an input for ANN
///  train/test
///

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

float LOP[12];

proc letter(wa)
{

fn = _clarg[wa]);
<<"$wa $fn\n"

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

  lc = check_lcol()
  <<"shift left by $lc \n";
  


  sz = Cab(T)
  <<" $(Caz(T)) $(Cab(T)) \n"

   R=T;

   shift_tar(lc,1)
   
/// train vecs
<<"$LOP \n"

ans=iread();


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
    


  if (wa ==1) {
    TRIV = T;
    
    TROV = LOP;
  }
  else {
    TRIV=vsplice(TRIV,T)
    TROV=vsplice(TROV,LOP)
  }

// how much to shift left letter dependent!
    TRIV=vsplice(TRIV,LML);
    shift_tar(lc-1,1);
    TROV=vsplice(TROV,LOP);



    TRIV=vsplice(TRIV,LMR);
    shift_tar((lc+1),1);
    TROV=vsplice(TROV,LOP);

    TRIV=vsplice(TRIV,LMR2);
    shift_tar((lc+2),1);
    TROV=vsplice(TROV,LOP);
	
    TRIV=vsplice(TRIV,LMR2D);
    shift_tar(lc+2,0);
    TROV=vsplice(TROV,LOP);


    TRIV=vsplice(TRIV,LML2);
     shift_tar(lc-2,1);
    TROV=vsplice(TROV,LOP);
    
    TRIV=vsplice(TRIV,LML2U);	
     shift_tar(lc-2,2);
    TROV=vsplice(TROV,LOP);

    TRIV=vsplice(TRIV,LMU);
     shift_tar(lc,2);
    TROV=vsplice(TROV,LOP);

    TRIV=vsplice(TRIV,LMD);
     shift_tar(lc,0);

    TROV=vsplice(TROV,LOP);


/// op
/// test vecs
/{
  LML= cyclecol(R,1)
  LMR= cyclecol(R,-1)
  LMU= cyclerow(R,-1)
  LMD= cyclerow(R,1)

  LML= cyclerow(LML,1)
  LMR= cyclerow(LMR,-1)
  LMU= cyclecol(LMU,-1)
  LMD= cyclecol(LMD,1)

  LOP=  submat(R,2,2,9,7)

  LOP->redimn()
  if (wa ==1) {
    TSTIV = R;
    TSTOV=LOP;    
  }
  else {
    TSTIV=vsplice(TSTIV,R);
    TSTOV=vsplice(TSTOV,LOP);
  }
  
    TSTIV=vsplice(TSTIV,LML);
    TSTIV=vsplice(TSTIV,LMR);
    TSTIV=vsplice(TSTIV,LMU);
    TSTIV=vsplice(TSTIV,LMD);    

  for (jj = 0; jj < 4; jj++) {
    TSTOV=vsplice(TSTOV,LOP);
  }
/}
 cf(A);

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

  B=ofw("shifttstip.dat")
  wdata(B,TRIV);
  cf(B)

  B=ofw("shifttstop.dat")
  wdata(B,TROV);
  cf(B)

/{
  B=ofw("shifttstip.dat")
  wdata(B,TSTIV);
  cf(B)


  B=ofw("shifttstop.dat")
  wdata(B,TSTOV);
  cf(B)
/}
/////////////////////////////////////

  