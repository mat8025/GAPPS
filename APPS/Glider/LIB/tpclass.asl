/* 
 *  @script tpclass.asl 
 * 
 *  @comment turnpt class for showtask 
 *  @release CARBON 
 *  @vers 1.5 B 6.3.83 C-Li-Bi 
 *  @date 02/15/2022 17:26:49          
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                                                 



int Tleg_id = 0;

//<<"%V $_include $Tleg_id\n"

class Tleg 
 {

 public:

  
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float fga;
  float msl;

  Str Tow;
  Str Place;

#if ASL
 void Tleg()   //  use cons,destroy   -- have then set to NULL in CPP header
#else
Tleg()
#endif
 {
 //<<"Starting cons \n"
  dist = 0.0;
  pc = 0.0;
  fga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"
 }
 
};   // need ;



//int Ntp_id = 0;


class Turnpt 
 {

 public:
 //static uint Ntp_id;
  Str Lat;
  Str Lon;
  Str Place;
  
  Str Idnt;
  Str rway;
  Str tptype;
  
  Str Cltpt;
  Str Radio;
  float Alt;
  float fga;  // final glide msl to next TP?
  float Ladeg;
  float Longdeg;
  int is_airport;
  int id;
  int match[2];
  Str smat; ;
  
//  int amat;

//  method list

// for cpp  either use reference or ptr
// else copy constructor - memory corruption??

  void TPset (Svar& wval)
   {

//<<"TPset $_proc $wval \n"

//      wval->info(1)
//<<": $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"

     Place = wval[0]; // wayp 

     Idnt =  wval[1];

   cout  << "Idnt  "  << Idnt  << endl ;


     Lat = wval[2]; // wayp 

     Lon = wval[3];
     
     Alt = atof(wval[4]);
     
     rway = wval[5];
     
     Radio = wval[6];

     tptype = wval[7];
     
     smat = spat (&tptype, "A",-1,-1,match);

     Ladeg =  coorToDeg(Lat); // wayp
     
     Longdeg = coorToDeg(Lon);

      }
//=========================//

 void TPCUPset (Svar& wval)
 {

Str val;
Str val2;

<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"
<<"$wval \n"
     val = wval[0];

<<"%V $val\n"

     val.dewhite();

//cout << "val " << val << endl;

    // val.pinfo();

     val.scut(1);
//cout << "val " << val << endl;     
     val.scut(-1);
//cout << "val " << val << endl;
     Place = val; // wayp 
    
//cout << "Place " << Place << endl;

     val =  wval[1];
     val.scut(1);
     val.scut(-1);

     Idnt = val;

//  <<"%V$Idnt\n"
//Idnt->info(1)

     Lat = wval[3]; // wayp
     
//cout << "Lat " << Lat <<endl;

     ccoor(Lat);
     
     Lon = wval[4];

     ccoor(Lon);

//  <<"%V$Lon  \n"
  
     val = wval[5];

//  <<"%V$val  \n"

     val.scut(-2); 

//     <<"%V$val  \n"


     Alt = atof(val);
//cout  <<"Alt "<< Alt  <<endl ; 
//     <<"%V$Alt  \n"

     is_airport =0;

     rway = wval[6];

//cout << "rway " << rway  << endl;

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

//     
 //cout  <<"Radio "<< Radio  <<endl ; 

     tptype = wval[10];
     
    // spat (tptype,"A",-1,-1,&is_airport);

     Ladeg =  coorToDeg(Lat); 

//cout  <<"Lat " << Lat <<" Ladeg "<< Ladeg  <<endl ; 

     Longdeg = coorToDeg(Lon);

//cout  <<"Lon " << Lon <<" Longdeg "<< Longdeg  <<endl ; 

      }
//=========================//

void SetPlace (Str val)   
   {
       Place = val;
   }
//=========================//

  void GetPlace ()   
   {
       return Place; 
   }
//=========================//
   void Print ()    
   {
     //<<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"

cout << " " << Place <<" " << Idnt <<" " << Lat <<" " << Lon <<" " << Alt <<" " << rway <<" "
<< Radio <<" " << Ladeg <<" " << Longdeg << endl;
   }
//=========================//


 int GetTA()   
   {
      int amat[2];
      spat (&tptype,"A",-1,-1,amat);
//DBG"Turnpt  $amat\n"
//DBG"%V $amat $(typeof(amat)) \n"
      return amat[0];
   }
//=========================//
#if ASL
void Turnpt()
#else
 Turnpt()
#endif
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

};
//======================================//




//<<"%V $_include $Ntp_id\n"


