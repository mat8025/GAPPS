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

//<<" TPCLASS\n"

int Tleg_id = 0;
#if ASL

//<<"GT_DB $(GT_DB) \n"

if (GT_DB) {
<<"%V $_include $Tleg_id\n"
}



#endif

class Tleg 
 {

 public:

  
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float tfga;
  float msl;

  Str Tow;
  Str Tplace;

#if ASL
 void Tleg()   //  use cons,destroy   -- have then set to NULL in CPP header
#else
  Tleg()
#endif
 {
 //<<"Starting cons \n"
  dist = 0.0;
  pc = 0.0;
  tfga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"
 }
 Str getPlace ()   
   {
       return Tplace; 
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
  int is_strip;
  int is_mtn;
  int is_mtn_pass;
  
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
     is_mtn_pass =0;     
     
     Place = wval[0]; // wayp 

     Idnt =  wval[1];

    //cout  << "Idnt  "  << Idnt  << endl ;


     Lat = wval[2]; // wayp 

     Lon = wval[3];
     
     Alt = atof(wval[4]);
     
     rway = wval[5];
     
     Radio = wval[6];

     tptype = wval[7];

    if (tptype == "TPA") {
       is_airport = 1;
    }
    if (tptype == "TPM") {
       is_mtn = 1;
    }
    if (tptype == "TPP") {
       is_mtn_pass = 1;
    }
     
     //smat = spat (&tptype, "A",-1,-1,match);

     Ladeg =  coorToDeg(Lat); // wayp
     
     Longdeg = coorToDeg(Lon);

      }
//=========================//

 void TPCUPset (Svar& wval)
 {

//<<"IN $_proc \n"
Str val;

Str val2;

 //  <<"%V $Alt\n";

//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"
 //  pa(wval);
//  aslpinfo(wval);
//<<" $wval \n"

//<<"TP  $wval[0] \n"

     val = wval[0];
     
//<<"%V $val\n"


//cout << "val " << val << endl;
//pa(wval); // crash ??


//      val.aslpinfo();

      val.dewhite(); // TBF ? corrupting vars ?

//<<"%V $AFH\n"

    val.scut(1);
//cout << "val " << val << endl;

//<<"post-scut 1 $val\n"

     val.scut(-1);

//<<"post-scut -1  $val\n"

//cout << "val " << val << endl;
     Place = val; // wayp 

//<<"%V $place \n";



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

    // pa(val);
    // ft or m

//ans=query("?","sele",__LINE__);
    val2 = sele(val,-1,-2);

//<<"%V $val2\n"
    if (val2 == "ft") {

      val.scut(-2); 
//<<"ft  $val\n";
      Alt = atof(val);
   }
    else {
       val.scut(-1);
//<<"m $val\n";       
            Alt = atof(val);
	    Alt *= 3.280839 ;

    }
 //<<"%V$val $val2 $Alt  \n"


//cout  <<"Alt "<< Alt  <<endl ; 
//    pa(val,Alt);

     is_airport =0;
     is_mtn =0;
     is_mtn_pass =0;     
     is_strip = 0;
     rway = wval[6];

//cout << "rway " << rway  << endl;

     if (rway == "5") {
         is_airport =1;
     }

     if (rway == "3") {
         is_strip =1;
     }

     if (rway == "7") {
         is_mtn =1;
     }

     if (rway == "8") {
         is_mtn_pass =1;
     }

     rway = wval[7];

     if (rway != "") {
       //  is_airport =1;
     }



    val = wval[9];


     //Radio = atof(wval[9]);

     Radio = wval[9];

     if (Radio == "") {
          Radio = "    -    ";
     } 


//<<"Radio <|$Radio|> wval[9] $val  \n"
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
      Alt = -1.5;
    //<<"CONS $id $Ntp_id\n"
   }
//=========================//

};
//======================================//



#if ASL
if (GT_DB) <<"%V $_include  DONE\n"
#endif

#endif