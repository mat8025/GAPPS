/* 
   *  @script tpclass.asl
   *
  *  @comment turnpt class cpp version
  *  @release CARBON
  *  @vers 1.5 B Boron [asl 6.3.66 C-Li-Dy]
  *  @date 12/12/2021 15:59:42
  *  @cdate 1/1/2001
  *  @author Mark Terry
  *  @Copyright © RootMeanSquare  2010,2021 →
  *
 */ 

  ;//-----------------<v_&_v>--------------------------//;

cout << "including tpclass.asl " << endl;



  int Tleg_id = 0;

  class Tleg {

  public:

  int tpA;

  int tpB;

  float dist;

  float pc;

  float fga;

  float msl;

  Str Tow;

  Str Place;

  Tleg()
   {
  printf("Starting cons \n");

  dist = 0.0;
  pc = 0.0;
  fga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"

   };

};




int Ntp_id = 0;

  class Turnpt {

  public:

  Str Lat;

  Str Lon;

  Str Place;

  Str Idnt;

  Str rway;

  Str tptype;

  Str Cltpt;

  Str Radio;

  float Alt;

  float fga;  // final glide msl to next TP?;

  float Ladeg;

  float Longdeg;

  int is_airport;

  int id;

  void TPset (Svar wval)
  {
//<<"TPset $_proc $wval \n"
//      wval->info(1)
//<<": $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"

  Place = wval[0]; // wayp;

  <<"%V$Place\n";

  Idnt =  wval[1];

  <<"%V$Idnt  \n";
//Idnt->info(1)

  Lat = wval[2]; // wayp;
    // <<"%V$Lat  \n"
     //   DBG"%V$wval[3]\n"	 

  Lon = wval[3];
    //<<"%V$Lon  \n" 

  Alt = atof(wval[4]);

  rway = wval[5];
//<<"radio $wval[6] \n"

  Radio = wval[6];

  tptype = wval[7];

  spat (tptype,"A",-1,-1,&is_airport);

  Ladeg =  coorToDeg(Lat); // wayp;

  Longdeg = coorToDeg(Lon);
     //"%V $Ladeg $Longdeg \n"

  }
//=========================//

  void TPCUPset (Svar wval)
  {

  Str val;
//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

  val = dewhite(wval[0]);

  val = scut(val,1);

  val = scut(val,-1);

  Place = val; // wayp;
//   <<"%V$Place\n"

  val =  wval[1];

  val = scut(val,1);

  val = scut(val,-1);

  Idnt = val;
//  <<"%V$Idnt\n"
//Idnt->info(1)

  Lat = wval[3]; // wayp;

  Lon = wval[4];
//  <<"%V$Lon  \n"

  val = wval[5];
//  <<"%V$val  \n"

  val = scut(wval[5],-2);
//     <<"%V$val  \n"

  Alt = atof(val);
//     <<"%V$Alt  \n"

  is_airport =0;

  rway = wval[6];
  //  <<"%V$rway  \n"

  if (rway == "5") {

  is_airport =1;

  }

  rway = wval[7];

  if (rway != "") {

  is_airport =1;

  }
//     val = wval[9];
//  <<"Radio ?? $val  \n"
     //Radio = atof(wval[9]);

  Radio = wval[9];
//     <<"%V$Radio  \n"

  tptype = wval[10];
    // spat (tptype,"A",-1,-1,&is_airport);

  Ladeg =  coorToDeg(Lat,2);

  Longdeg = coorToDeg(Lon,2);

  }
//=========================//

  void SetPlace (Str val)
  {
  Place = val;
  };
//=========================//

  Str GetPlace ()
  {
  return Place;
  };
//=========================//

  void Print ()
  {
    //<<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"

  cout << "Place " << Place << endl;

  }
//=========================//

  int GetTA()
  {
  int amat =0;

  spat (tptype,"A",-1,-1,&amat);  // need a c++ spat(Str,...);
//DBG"Turnpt  $amat\n"
//DBG"%V $amat $(typeof(amat)) \n"

  return amat;

  }
//=========================//

  Turnpt()
  {
//id = Ntp_id++;

  Ntp_id++;

  id = Ntp_id;

  Place=" ";

  Ladeg = 0.0;

  Longdeg = 0.0;
    //<<"CONS $id $Ntp_id\n"

  }
//=========================//

  }
//======================================//

//==============\_(^-^)_/==================//
