///
///  alpha_ip
///  takes  font files and makes an input for ANN
///  train/test
///


// currently input font 
// is a 32x20 matrix
// with 'centered' letter

// use this plus some shifts
// to make up training pats for the letter

// the correct response will be
// OP[26]  with the index element set to one for the training letter alhabet position
// OP[0] is A, OP[1] is B, ...




proc letter(wa)
{

fn = _clarg[wa]);
<<"$wa $fn\n"

 A=ofr(fn);

 if (A == -1) {
  exit();
 }



S=readline(A);
<<"%S\n"
S=readline(A);
<<"%S\n"

 W = split(S,",");

 let = W[0]

<<"letter: $let\n"

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

// 

  T->redimn(Nrow,Ncol);

  <<"%4.0f $T\n"

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

  for (jj = 0; jj < 4; jj++) {
    TSTOV=vsplice(TSTOV,LOP);
  }

 cf(A);

}


na = argc()

<<"$na \n"
// needs to size of letter matrix
// currently 32*20
Nrow = 32;
Ncol = 20;

float T[Nrow*Ncol];

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

exit()

/{
  B=ofw("alptstip.dat")
  wdata(B,TSTIV);
  cf(B)


  B=ofw("alptstop.dat")
  wdata(B,TSTOV);
  cf(B)
/}
/////////////////////////////////////

  