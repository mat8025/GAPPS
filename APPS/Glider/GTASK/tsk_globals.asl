///
///
///



 int TF; // task file FH
 int AFH= -1
 float CSK
 float Cruise_speed

 float TC[20]
 float Dur[20]


  Svar Task;
  int Ntpts = 0;
  float totalD = 0;

  float totalDur = 0.0;

  float TKM[20];
  float AGL[20];
  char  Hey[10] = "hey hey";
  float L1;
  float L2;
  //float lo1,lo2;
  float lo1;
  float lo2;
  double tkm;
  double tkm2;
  float tcd;
  float rmsl;
  float tmsl;
  float msl;
  int nl,li;
  Str ident;
  int n_legs = 0;
  int n_tp = 0;
  int k_tp;

  Str the_start = "Longmont";
  Str try_place = "xxx";
  Str try_start = "xxx";
  Str nxttpt = "Laramie";



  float  km_to_feet = 3281.0
 float   km_to_nm = 3281.0/6080.0 
float   km_to_sm = 3281.0/5280.0
float   nm_to_sm = 6080.0/5280.0
float   nm_to_km = 6080.0/3281.0


///////////////////////////////