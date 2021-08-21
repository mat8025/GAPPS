/* 
 *  @script tpc.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.46 C-Li-Pd]                               
 *  @date 08/09/2021 10:09:54 
 *  @cdate 08/09/2021 10:09:54 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

<<"first $_include\n"

<<"I don't see you - why?\n"
<<"I see the second - why?\n"

<<" where am i? $_include\n"
int Ntp_id = 0;

class Sturnpt 
 {

 public:

  str Lat;
  str Lon;
  str Place;
  
  str Idnt;

  int id;
//  int amat;

//  method list

//=========================//
   cmf Print ()    
   {
     <<"$Idnt $id\n"
   }
//=========================//

 cmf Turnpt()
    {
    // <<"CONS $_proc \n"
            id = Ntp_id++;
         //   Ntp_id++;
	    id = Ntp_id;
	    Idnt = "$id";
    }
//=========================//

}
//======================================//


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

  cmf TPset (svar wval) 
   {

//<<"TPset $_proc $wval \n"

//      wval->info(1)
//<<": $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"

     Place=wval[0]; // wayp 
    
     //<<"%V$Place\n"


     Idnt =  wval[1];

    <<"%V$Idnt  \n"

//Idnt->info(1)

     Lat = wval[2]; // wayp 

    // <<"%V$Lat  \n"

     //   DBG"%V$wval[3]\n"	 
     Lon = wval[3];

    //<<"%V$Lon  \n" 
     
     Alt = atof(wval[4]);
     
     rway = wval[5];

<<"radio $wval[6] \n"
     
     Radio = wval[6];

     tptype = wval[7];
     
     spat (tptype,"A",-1,-1,&is_airport);

     Ladeg =  coorToDeg(Lat); // wayp
     Longdeg = coorToDeg(Lon);
     
     DBG"%V $Ladeg $Longdeg \n"


      }
//=========================//

  cmf TPCUPset (svar wval) 
   {

//    <<"%V $wval[::]\n"
DBG"<|$wval[0]|>\n"

     val = dewhite(wval[0])
//val->info(1)
//<<"%V$val  \n"
     val = scut(val,1)
     val = scut(val,-1)
     

//     val = wval[9]
//     val->info(1)

     Place=val; // wayp 
    
//    <<"%V$Place\n"


     Idnt =  wval[1];

//  <<"%V$Idnt\n"
//Idnt->info(1)

     Lat = wval[3]; // wayp 

     Lon = wval[4];

//  <<"%V$Lon  \n"
  
     val = wval[5];

//  <<"%V$val  \n"

     val = scut(wval[5],-2); 

//     <<"%V$val  \n"


     Alt = atof(val)

//     <<"%V$Alt  \n"

     is_airport =0

     rway = wval[7];

//     <<"%V$rway  \n"

     if (!rway @="") {
         is_airport =1
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

cmf SetPlace (str val)   
   {
       Place = val;
   }
//=========================//

   cmf GetPlace ()   
   {
       return Place; 
   }
//=========================//
   cmf Print ()    
   {
     <<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"
   }
//=========================//


 cmf GetTA()   
   {
      int amat =0;
      spat (tptype,"A",-1,-1,&amat);
//DBG"Turnpt  $amat\n"
//DBG"%V $amat $(typeof(amat)) \n"
      return amat;
   }
//=========================//
 cmf Turnpt()
    {


//id = Ntp_id++;
            Ntp_id++;
	    id = Ntp_id;
      Place=" ";
      Ladeg = 0.0;
      Longdeg = 0.0;
 //   <<"CONS $id $Ntp_id\n"
}
//=========================//

}
//======================================//

