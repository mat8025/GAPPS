/* 
 *  @script tsk_tpclass.asl                                             
 * 
 *  @comment turnpt class for showtask                                  
 *  @release Silicon                                                    
 *  @vers 1.6 C Carbon [asl 5.14 : B Si]                                
 *  @date 08/11/2023 16:35:59                                           
 *  @cdate 1/1/2001                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//                                                                                                                                 

#ifndef TPCLASS_

#define TPCLASS_ 1

//<<" TPCLASS\n"

int Tleg_id = 0

#if _ASL_


if (GT_DB) {
<<"%V $_include $Tleg_id\n"
}



#endif

class Tleg 
 {

 public:

  
  int tpA
  int tpB
  
  float dist
  float pc
  float tfga
  //  msl is part of class should not clash with global msl
  float msl

  Str Tow
  Str Tplace

//  use cmf for cons,destruct
//  preprocess to asc will remove cmf
 cmf Tleg()   
 {
 //<<"Starting cons \n"
  dist = 0.0
  pc = 0.0
  tfga =0
  msl = 0.0
 // <<"Done cons $dist $pc\n"
 }
 
 Str getPlace ()   
   {
       return Tplace 
   }

 cmf ~Tleg()   
 {
    //<<"destructing Tleg \n"
 }
};   // need ;



int Ntp_id = 0 // ids for turnpt objs


class Turnpt 
 {

 public:
 //static uint Ntp_id;
  Str Lat
  Str Lon
  Str Place
  
  Str Idnt
  Str rway
  Str tptype
  
  Str Cltpt
  Str Radio
  float Alt
  float fga  // final glide msl to next TP?
  float Ladeg
  float Longdeg
  int is_airport
  int is_strip
  int is_mtn
  int is_mtn_pass
  
  int id
  //int match[2]
  int match
  Str smat 
  
//  int amat;

//  method list

// for cpp  either use reference or ptr
// else copy constructor - memory corruption??

  void TPset (Svar& wval)
   {

     is_airport =0
     is_mtn =0
     is_mtn_pass =0     
     
     Place = wval[0] // wayp 

     Idnt =  wval[1]


     Lat = wval[2] // wayp 

     Lon = wval[3]
     
     Alt = atof(wval[4])
     
     rway = wval[5]
     
     Radio = wval[6]

     tptype = wval[7]

    if (tptype == "TPA") {
       is_airport = 1
    }
    if (tptype == "TPM") {
       is_mtn = 1
    }
    if (tptype == "TPP") {
       is_mtn_pass = 1
    }
     
     //smat = spat (&tptype, "A",-1,-1,match)

     Ladeg =  coorToDeg(Lat) // wayp
     
     Longdeg = coorToDeg(Lon)

      }
//=========================//



void TPCUPset (Svar& wval)
 {


Str val

Str val2

//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

     val = wval[0]

      val.dewhite() // TBF ? corrupting vars ?



    val.scut(1)


     val.scut(-1)


     Place = val // wayp 


     val =  wval[1]

    val.scut(1)
     
     val.scut(-1)

     Idnt = val

     Lat = wval[3] // wayp
     
     ccoor(Lat)

 
     Lon = wval[4]

     ccoor(Lon)

  
     val = wval[5]
     pinfo(val)

    val2 = sele(val,-1,-2)


    if (val2 == "ft") {

      val.scut(-2) 

      Alt = atof(val)
   }
    else {
       val.scut(-1)

            Alt = atof(val)
	    Alt *= 3.280839 

    }


     is_airport =0
     is_mtn =0
     is_mtn_pass =0     
     is_strip = 0
     rway = wval[6]


     if (rway == "5") {
         is_airport =1
     }

     if (rway == "3") {
         is_strip =1
     }

     if (rway == "7") {
         is_mtn =1
     }

     if (rway == "8") {
         is_mtn_pass =1
     }

     rway = wval[7]

     if (rway != "") {
       //  is_airport =1
     }

    val = wval[9]

     Radio = wval[9]

     if (Radio == "") {
          Radio = "    -    "
     } 


     tptype = wval[10]
     

     Ladeg =  coorToDeg(Lat,2) 

     Longdeg = coorToDeg(Lon,2)

      }
//=========================//

void SetPlace (Str val)   
   {
       Place = val
   }
//=========================//

  Str GetPlace ()   
   {
       return Place 
   }
//=========================//
   void Print ()    
   {
     //<<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"

     <<" $Place  $Lat $Lon $Radio\n"

   }
//=========================//


 int GetTA()   
   {
      int amat[2]
      spat (tptype.cptr(),"A",-1,-1,amat)  //PP_error ?
      return amat[0]
   }
//=========================//

cmf Turnpt()
 {

            Ntp_id++
	    id = Ntp_id
      Place=" "
      Ladeg = 0.0
      Longdeg = 0.0
      Alt = -1.5
    //<<"CONS $id $Ntp_id\n"
   }
//=========================//

};


//======================================//

#endif



//==============\_(^-^)_/===EOS==============//
