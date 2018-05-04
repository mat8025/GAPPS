///
///  alpha_ip
///          takes  fonts file and makes an input for ANN
///  train/test
///


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

  sz = Cab(T)
  <<" $(Caz(T)) $(Cab(T)) \n"

  R=T;

   LOP = OP;
   LOP[wa-1] = 1;

/// train vecs


  LML= cyclecol(T,1)
  LMR= cyclecol(T,-1)
  LMU= cyclerow(T,-1)
  LMD= cyclerow(T,1)

  T->redimn()
  
  LML->redimn();
  LMR->redimn();
  LMU->redimn(); 
  LMD->redimn(); 

  if (wa ==1) {
    TRIV = T;
    TROV = LOP;
  }
  else {
    TRIV=vsplice(TRIV,T)
    TROV=vsplice(TROV,LOP)
  }

    TRIV=vsplice(TRIV,LML);
    TRIV=vsplice(TRIV,LMR);
    TRIV=vsplice(TRIV,LMU);
    TRIV=vsplice(TRIV,LMD);
  for (jj = 0; jj < 4; jj++) {
    TROV=vsplice(TROV,LOP);
  }

// op


   


/// test vecs

  LML= cyclecol(R,1)
  LMR= cyclecol(R,-1)
  LMU= cyclerow(R,-1)
  LMD= cyclerow(R,1)

  LML= cyclerow(LML,1)
  LMR= cyclerow(LMR,-1)
  LMU= cyclecol(LMU,-1)
  LMD= cyclecol(LMD,1) 
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

 cf(A);

}


na = argc()

<<"$na \n"
float T[100];

float TRIV[]
float TROV[]

float TSTIV[]
float TSTOV[]

float OP[26]; // all zeros

  for (i=1 ; i < na ; i++) {

    letter(i);
  
 <<"$i $(Caz(TRIV)) $(Cab(TRIV)) \n"
  }

////////////////////////////////////

  B=ofw("alptrip.dat")
  wdata(B,TRIV);
  cf(B)

  B=ofw("alptrop.dat")
  wdata(B,TROV);
  cf(B)


  B=ofw("alptstip.dat")
  wdata(B,TSTIV);
  cf(B)


  B=ofw("alptstop.dat")
  wdata(B,TSTOV);
  cf(B)

/////////////////////////////////////

  