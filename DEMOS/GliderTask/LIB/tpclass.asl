//%*********************************************** 
//*  @script tpclass.asl 
//* 
//*  @comment turnpt class for showtask 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.60 C-He-Nd]                               
//*  @date Tue Jun 23 07:00:24 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();


//<<"read in tpclass\n"

//============================================
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

Idnt->info(1)

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
//    <<"<|$wval[0]|>\n"

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
     
     DBG"%V $Ladeg $Longdeg \n"


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
     //DBG"CONS $_proc \n"
      Place=" ";
      Ladeg = 0.0;
      Longdeg = 0.0;
      id = Ntp_id++;
    }
//=========================//

}
//======================================//

