///
///
///



///  want to select record fields
///  M = R[0:10][3]
/// or T = R[10:20:2][2:4]


// M and T created as new records
// or M and T become vectors or arrays - if typed as such

setDebug(1,@trace,@keep,@filter,0)


IV= vgen(INT_,12,0,1)

<<"$IV\n\n"

IV->redimn(4,3)

<<"$IV\n\n"


 sm = IV[1:3][1:2];

<<"$sm\n"


data_file = GetArgStr()

  if (data_file @= "") {
    data_file = "bike2.tsv"  // open turnpoint file 
   }


<<"using $data_file\n"

  A=ofr(data_file)
  

  if (A == -1) {
    <<" can't find turnpts file \n"
     exit();
  }
  

R=readRecord(A,@type,FLOAT_);

<<"$(typeof(R))  $(Caz(R)) $(Cab(R)) \n"

<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"

sz = Caz(R);
<<"$sz\n"



<<"$R[2][1]\n"
<<"$R[2][2]\n"
<<"$R[2][3]\n"
<<"///\n"
<<"%(5,, ,\n)$R[1:sz-2][1:5:] \n"
<<"///\n"

<<"$(typeof(R))  $(Caz(R)) $(Cab(R)) \n"
<<"$sz\n"

exit()

<<"//////////////\n"

float M[];


M= R[1:20][2];


<<"M $M \n"

<<" R[0:9][2] \n"
<<"$R[0:9][2] \n"

exit()

  for (i=0;i<10;i++) {
    M[i] = R[i][2];
    <<"<$i> $R[i][2] $M[i] \n"
   }

<<"$M \n"

float Q[];

  
    Q = R[0:9][2];

<<"$Q \n"
   






exit()




<<"$(Caz(M)) $(Cab(M))\n"

<<"$M\n"