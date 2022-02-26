/* 
 *  @script tpclass.asl 
 * 
 *  @comment turnpt class for showtask 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.46 C-Li-Pd] 
 *  @date 08/09/2021 09:57:07 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//-----------------------//                                                                           






int Tleg_id = 0;

//<<"%V $_include $Tleg_id\n"
/*
str ccoor (str dm)
  {
  <<"$_proc  $dm\n";
    Svar sv;
    Str deg;
    Str min;
    Str dms;
    sv = Split(dm,'.');
    deg = scut(sv[0],-2);
    min = prune(sv[0],2);
    sec= scut(sv[1],-1);
    dir = prune(sv[1],1)
    <<" $deg,${min}.$sec \n"
    dms = "$deg,${min}.${sec},$dir"
    <<"$dms\n"

     return dms;
  }
*/


class Tleg 
 {

 public:

  
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float fga;
  float msl;

  str Tow;
  str Place;


 void Tleg() 
 {
 //<<"Starting cons \n"
  dist = 0.0
  pc = 0.0;
  fga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"
 }
 
}



int Ntp_id = 0;




class Turnpt 
 {

 public:

  str Lat;
  str Lon;
  str Place;
  
  str Idnt;
  str rway;
  str tptype;
  
  str Cltpt;
  str Radio;
  float Alt;
  float fga;  // final glide msl to next TP?
  float Ladeg;
  float Longdeg;
  int is_airport;
  int id;
//  int amat;

//  method list

  void TPset (svar wval) 
   {

//<<"TPset $_proc $wval \n"

//      wval->info(1)
//<<": $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"

     Place = wval[0]; // wayp 
    
//     <<"%V$Place\n"


     Idnt =  wval[1];

//    <<"%V$Idnt  \n"

//Idnt->info(1)

     Lat = wval[2]; // wayp 

   <<"%V$Lat  \n"

     //   DBG"%V$wval[3]\n"	 
     Lon = wval[3];

    //<<"%V$Lon  \n" 
     
     Alt = atof(wval[4]);
     
     rway = wval[5];

//<<"radio $wval[6] \n"
     
     Radio = wval[6];

     tptype = wval[7];
     
     spat (tptype,"A",-1,-1,&is_airport);

     Ladeg =  coorToDeg(Lat); // wayp
     Longdeg = coorToDeg(Lon);
     
     DBG"%V $Ladeg $Longdeg \n"


      }
//=========================//




  void TPCUPset (svar wval) 
   {
//wval.pinfo()
//<<"%V $wval[::]\n"
//<<"0 <|$wval[0]|>\n"
//<<"1 <|$wval[1]|>\n"
//<<"2 <|$wval[2]|>\n"
Str val;
Str Lon2;
Str Lat2;
//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

     val = dewhite(wval[0]);
//val->info(1)
//<<"%V$val  \n"


     val=scut(val,1);
     val=scut(val,-1);

     Place = val; // wayp 
    
//   <<"%V$Place\n"

     val =  wval[1];
     val=scut(val,1);
     val=scut(val,-1);

     Idnt = val;

//  <<"%V$Idnt\n"
//Idnt->info(1)


     
     Lon2 = wval[4];

//<<"%V $Lon2\n"


     Lon =  ccoor (Lon2);
//<<"%V$Lon  $Lon2\n"

     Lat2 = wval[3]; // wayp
     
     Lat =  ccoor (Lat2);


//<<"%V$Lat  $Lat2\n"
  
     val = wval[5];

//  <<"%V$val  \n"

     scut(val,-2); 

//     <<"%V$val  \n"


     Alt = atof(val)

//     <<"%V$Alt  \n"

     is_airport =0

     rway = wval[6];

  //  <<"%V$rway  \n"

     if (rway == "5") {
         is_airport =1
     }

     rway = wval[7];

     if (rway != "") {
         is_airport =1
     }


//     val = wval[9];

//  <<"Radio ?? $val  \n"

     //Radio = atof(wval[9]);

     Radio = wval[9];

//     <<"%V$Radio  \n"

     tptype = wval[10];
     
    // spat (tptype,"A",-1,-1,&is_airport);

     Ladeg =  coorToDeg(Lat); 

     Longdeg = coorToDeg(Lon);
     



      }
//=========================//

void SetPlace (str val)   
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
     <<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"
   }
//=========================//


 void GetTA()   
   {
      int amat =0;
      spat (tptype,"A",-1,-1,&amat);
//DBG"Turnpt  $amat\n"
//DBG"%V $amat $(typeof(amat)) \n"
      return amat;
   }
//=========================//
 void Turnpt()
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




//<<"%V $_include $Ntp_id\n"


