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

#ifndef TPCLASS_

#define TPCLASS_ 1


int Tleg_id = 0;
#if ASL
<<"%V $_include $Tleg_id\n"
#endif

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



int Ntp_id = 0; // ids for turnpt objs


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
  int is_mtn;
  int id;
  //int match[2];
  int match;
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
     is_airport =0;
     is_mtn =0;
     
     Place = wval[0]; // wayp 

     Idnt =  wval[1];

    //cout  << "Idnt  "  << Idnt  << endl ;


     Lat = wval[2]; // wayp 

     Lon = wval[3];
     
     Alt = atof(wval[4]);
     
     rway = wval[5];
     
     Radio = wval[6];

     tptype = wval[7];

    if (tptype == "TA") {
       is_airport = 1;
    }
    if (tptype == "TM") {
       is_mtn = 1;
    }
     
     //smat = spat (&tptype, "A",-1,-1,match);

     Ladeg =  coorToDeg(Lat); // wayp
     
     Longdeg = coorToDeg(Lon);

      }
//=========================//

 void TPCUPset (Svar& wval)
 {

Str val;
Str val2;

//<<"$_proc  $AFH \n";

//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"
//<<"$wval \n"

     val = wval[0];

//      val.pinfo();

      val.dewhite(); // TBF ? corrupting vars ?


//cout << "val " << val << endl;


//<<"%V $AFH\n"

    val.scut(1);
//cout << "val " << val << endl;

//<<"post-scut 1 %V $AFH\n"

     val.scut(-1);

//<<"post-scut -1 %V $AFH\n"

//cout << "val " << val << endl;
     Place = val; // wayp 
    
//cout << "Place " << Place << endl;

     val =  wval[1];

    val.scut(1);
     
     val.scut(-1);

     Idnt = val;
//<<"%V $AFH\n"

//  <<"%V$Idnt\n"
//Idnt->info(1)

     Lat = wval[3]; // wayp
     
//cout << "Lat " << Lat <<endl;
//<<"%V $Lat \n"
     ccoor(Lat);
//<<"%V $Lat \n"     
 
     Lon = wval[4];

     ccoor(Lon);

 //<<"%V$Lon  \n"
  
     val = wval[5];

//  <<"%V$val  \n"

     val.scut(-2); 

// <<"%V$val  \n"


     Alt = atof(val);
//cout  <<"Alt "<< Alt  <<endl ; 
// <<"%V$Alt  \n"

     is_airport =0;
     is_mtn =0;

     rway = wval[6];

//cout << "rway " << rway  << endl;

     if (rway == "5") {
         is_airport =1;
     }

     if (rway == "8") {
         is_mtn =1;
     }

     rway = wval[7];

     if (rway != "") {
       //  is_airport =1;
     }



    val = wval[9];


     //Radio = atof(wval[9]);

     Radio = wval[9];

//<<"Radio wval[9] $val  \n"
//ans=query("??");


//     
 //cout  <<"Radio "<< Radio  <<endl ; 

     tptype = wval[10];
     
    // spat (tptype,"A",-1,-1,&is_airport);

//<<"%V $lat \n";

     Ladeg =  coorToDeg(Lat,2); 
 
 
//<<"%V $Lat $Ladeg \n";

 //cout  <<"Lat " << Lat <<" Ladeg "<< Ladeg  <<endl ; 

     Longdeg = coorToDeg(Lon,2);

//cout  <<"Lon " << Lon <<" Longdeg "<< Longdeg  <<endl ; 
#if ASL
//<<"%V $Lon $Longdeg \n";
//<<"%V $Place $is_airport \n"
#endif



      }
//=========================//

void SetPlace (Str val)   
   {
       Place = val;
   }
//=========================//

  Str GetPlace ()   
   {
       return Place; 
   }
//=========================//
   void Print ()    
   {
     //<<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"
#if ASL
<<" $Place  $Lat $Lon $Radio\n"

#else
cout << " " << Place <<" " << Idnt <<" " << Lat <<" " << Lon <<" " << Alt <<" " << rway <<" "
<< Radio <<" " << Ladeg <<" " << Longdeg << endl;
#endif
   }
//=========================//


 int GetTA()   
   {
      int amat[2];
      spat (tptype.cptr(),"A",-1,-1,amat);
    //  pa("amat ",amat);
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



#if ASL
<<"%V $_include  DONE\n"
#endif

#endif