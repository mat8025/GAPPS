

CLASS turnpt 
 {

 public:

  str Lat;
  str Lon;
  str CPlace;
  str CIdnt;
  str rway;
  str Cltpt;
  float Radio;

  float Alt;
  float Ladeg;
  float Longdeg;

#  method list

  CMF Set (wval) 
   {

     <<"Set $wval \n"
    // <<"%V$_proc  $wval[0] $wval[1] $wval[2] $wval[3]\n"

       //  sz = wval->Caz()
        sz = Caz(wval)
         <<"%V$sz \n"
    <<"$(typeof(wval)) $(Caz(wval))\n"
       
     CPlace = wval[0];


       
<<"%V$CPlace\n"


       CIdnt =  wval[1];
     
     <<"%V$CIdnt\n";

     
       Lat =    wval[2];
<<"%V$Lat\n"
      GLat =    Wval[2];
<<"%V$GLat\n"
    Lon = wval[3];
<<"%V$Lon\n"
    GLon = Wval[3];
<<"%V$GLon\n"    
    
    

      }
}

//===========================================


setdebug(1)


proc Set (wval) 
   {
     <<"%V$_proc  $wval[0] $wval[1] $wval[2] $wval[3]\n"
     <<"$wval \n"


       //  sz = wval->Caz()
        sz = Caz(wval)
         <<"%V$sz \n"
    <<"$(typeof(wval)) $(Caz(wval))\n"
       
      Place = wval[0];
       
<<"%V$Place\n"
       PIdnt =  wval[1];
     
     <<"%V$PIdnt\n";

     
       Lat =    wval[2];
<<"%V$Lat\n"


    Lon = Wval[3];
<<"%V$Lon\n"

 }



Svar Wval;


 tp = "BrokenBow    	BBW	41,26.18,N	99,38.5,W	2547	14/32	122.8	TAV"

   Wval = Split(tp);

<<"$Wval  \n"

<<"$Wval[1] $Wval[2]\n"

   lat = Wval[2];
   

   Set(Wval)


 tp = "CrystalL    	cry	40,55.00,N	105,42.00,W	8000	_	_	TA"

   Wval = Split(tp);

Set(Wval)





turnpt  Wtp



    Wtp->Set(Wval);
    



<<"is it fixed yet?\n"


    Wtp->Set(Wval);
 