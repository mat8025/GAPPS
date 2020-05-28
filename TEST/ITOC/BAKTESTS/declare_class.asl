#! /usr/local/GASP/bin/asl
// test declare

SetPCW("writepic","writeexe")
prog= GetScript()

int ok = 0
int bad = 0
int ntest = 0


CLASS turnpt 
 {

 public:

  svar Lat;
  svar Longi;
  svar Place;

 svar Idnt;
  svar Cltpt
  svar Radio
  svar Nickn;

  float Alt;
  float Ladeg;
  float Longdeg;


 CMF Set (wval) 
   {

//    <<"$_cproc  %i $_cobj %i $wval \n"

    sz = wval->Caz()


    Place = wval[0]
//     <<"$Place \n"
    Nickn = wval[1]
    Idnt =  wval[2]
    Lat =   wval[3]
    Longi = wval[4]
    Alt = wval[5]
    Radio = wval[7]
//<<"$Radio $Lat\n"

    Ladeg = GetDeg(Lat)

    Longdeg = GetDeg(Longi)
  //   <<"$Place $Nickn $Idnt $Lat $Longi $Alt $Radio $Ladeg $Longdeg\n"

      }

   CMF SetPlace (val)   
   {
       Place = val
   }

   CMF Print ()    
   {

     <<"$Place $Nickn $Idnt $Lat $Longi $Alt $Radio $Ladeg $Longdeg\n"
   
   }

}



turnpt  Wtp



STOP!

