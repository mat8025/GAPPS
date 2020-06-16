///
///   task and turnpt
///

<<"read in tpclass\n"

<<"TPCLASS %V $_DB\n"

DB_TP = _DB;

class Taskpt 
 {

 public:

  svar wval;  // holds all field info
  str cltpt; //
  svar val;
  float Alt;
  float Ladeg;
  float Longdeg;
  float Leg;
  str Place;
  str tptype;

  int nrw;

#  method list


  cmf TPset (svar tpval) 
   {
   
//<<"Taskpt Set $_proc $tpval \n"

     tpval->info(1)


//<<": $tpval[0] 1: $tpval[1] 2: $tpval[2] 3: $tpval[3] 4: $tpval[4] \n"

     Place=tpval[0]; // wayp 
    
   //  <<"%V$Place\n"
     cltpt = Place;

     Idnt =  tpval[1];
     
     Lat = tpval[2]; // wayp 

     DBG"%V$Lat  \n"

     //   DBG"%V$tpval[3]\n"	 
     Lon = tpval[3];

    DBG"%V$Lon  \n" 
     
     Alt = tpval[4];
     
     rway = tpval[5];
     
     Radio = atof(tpval[6]);

     tptype = tpval[7];

      //Lat->info(1)
     
      Ladeg =  coorToDeg(Lat); // wayp

      Longdeg = coorToDeg(Lon);
//DBG"%V $Ladeg $Longdeg \n"


      }
//======================================//


  cmf Read (int fh) 
  {
     //int nrw = 0;
     la_deg = "" ;
     long_deg = "";

     nrw = wval->ReadWords (fh);

DBG"nwr $nwr  $wval[0] $wval[1] $wval[2]  $wval[3] $wval[4]\n"



      if (scmp(wval[0],"#",1)) {
       // comment line in file
         return 0;
      }

    xx= "$wval[1] \n"
//DBG" $xx\n"
 ifo = nrw->info();
 
//DBG"nrw $nrw $(Caz(nrw))  $ifo\n"

    if (nrw > 6) {

//DBG"assigning data file info \n"

      Place = wval[0]; // taskpt place
      
//DBG" $wval[0] $Place \n"

      Alt = atof(wval[4]);

//DBG" $Place $Alt \n"


//    Ladeg = GetDeg(la_deg)

xla= wval[2];

ylo= wval[3];

//DBG"%V $xla $ylo\n"

    //Ladeg = GetDeg(wval[2]) ; // taskpt Ladeg
  //  Ladeg = getDeg(wval[2]) ; // taskpt Ladeg

/{
// bizzare -first not split into 3 parts
// suceeding calls are TBF
    Longdeg = getDeg(ylo) ; // taskpt Longdeg

    Ladeg = getDeg(xla) ; // taskpt Ladeg

    Longdeg = getDeg(ylo) ; // taskpt Longdeg
/}

    Ladeg = coorToDeg(xla); // use c asl function
<<"%V $Ladeg \n"


    Longdeg = coorToDeg(ylo);
<<"%V $Longdeg \n"

    tptype = wval[7];

    }

//DBG"%V $Place $Alt $Ladeg $Longdeg $tptype \n"
    
    return nrw;
   }
//===================================
   cmf SetPlace (str ival)   
   {
     Place = ival;
   }
//===================================   

   cmf GetPlace ()   
   {
      return Place;
   }
//===================================   

   cmf GetTA ()   
   {
      int amat =0;
      <<"%V$tptype \n"
      spat (tptype,"A",-1,-1,&amat);
DBG"taskpt %V $amat $(typeof(amat)) \n"
      return amat;
   }
//===================================
   cmf GetLat ()   
   {
      val = wval[2] 
	return val;
   }
//===================================
   cmf GetLong ()   
   {
      val = wval[3] 
	return val;
   }
//===================================
   cmf GetRadio ()   
   {
      val = wval[6] 
	return val;
   }
//===================================
   cmf GetID ()   
   {
     val = wval[1]; 
	return val;
   }
//===================================
   cmf GetMSL ()   
   {
     int ival = Alt; 
     return ival;
   }
//===================================
   cmf Print ()    
   {
     //DBG"$wval[0] $wval[1]  $wval[2] $wval[3] \n"
     <<"%V $Place $Ladeg $Longdeg\n"
     return 1;
   }

/{/*
  cmf Taskpt()
    {
      //DBG" CONS $_cobj  $Place\n"
      Ladeg = 40.0;
      Longdeg = 105.0;
      cltpt = "";
      Place = "xxx";      
    }
/}*/
//===================================

  cmf GetDeg (svar the_ang)
    {

  //DBG" $_cproc  $the_ang \n"
  //  DBG"%V $the_ang $(typeof(the_ang)) \n"
//ttyin()

      float la;
      //float the_deg;
      float the_min;

//DBG" $_cproc  $the_ang  \n"

      the_parts = Split(the_ang,",")

//FIX    float the_deg = atof(the_parts[0])   // TBF

   // DBG"%V $the_parts \n"

//DBG"%v $the_parts[0] \n"

        dv = the_parts[0]
        the_deg = atof(dv)


//DBG"%v $the_deg \n"
        dv = the_parts[1]
        the_min = atof(dv)

//        DBG" %V $the_deg $the_min \n"

	//sz= Caz(the_min);

 // DBG" %V $sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

	the_dir = the_parts[2];

      y = the_min/60.0;

      la = the_deg + y;

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1.0;
      }

   //  DBG" %V $la  $y $(typeof(la)) $(Cab(la)) \n"
    return (la);
   }

//===================================
}

//============================================

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
  float Radio;
  float Alt;
  float Ladeg;
  float Longdeg;

//  int amat;

//  method list

  cmf TPset (svar wval) 
   {
//DBG"TPCLASS Set $wval \n"
//<<"TPset $_proc $wval \n"

//      wval->info(1)

//<<[_DB]"$_proc $(typeof(wval)) $wval[::] \n"

//DBG"%V$_cproc  %i$_cobj   %i$wval \n"
     //sz = wval->Caz()

   //   sz = Caz(wval);      
 // DBG"%V$sz \n"

DBG": $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"
    
   
      //   DBG"$wval[0]\n"
       //  DBG"$(typeof(wval))\n"
       //ans = iread("-->");
     Place=wval[0]; // wayp 
    
     DBG"%V$Place\n"


     Idnt =  wval[1];

     
     Lat = wval[2]; // wayp 

     DBG"%V$Lat  \n"

     //   DBG"%V$wval[3]\n"	 
     Lon = wval[3];

    DBG"%V$Lon  \n" 
     
     Alt = wval[4];
     
     rway = wval[5];
     
     Radio = atof(wval[6]);

     tptype = wval[7];

     //Lat->info(1)
     DBG"Lat $Lat\n"

Ladeg =  coorToDeg(Lat); // wayp



     Longdeg = coorToDeg(Lon);
     
DBG"%V $Ladeg $Longdeg \n"


      }

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
  cmf GetDeg (str the_ang)
    {
      str the_dir;
//DBG"input args is $the_ang \n"
//   float the_deg;
      float la;
      str wd;
 //DBG"%V$_cproc %i $the_ang  \n"
	

     the_parts = Split(the_ang,",")

//DBG"%V$the_parts \n"


//FIX    float the_deg = atof(the_parts[0])
    wd = the_parts[0];
    
    //the_deg = atof(the_parts[0])  // fix returns vec instead to supplied scalar string

    the_deg = atof(wd);

//DBG"%V $wd $the_deg \n"

//    float the_min = atof(the_parts[1]
    wd = the_parts[1];
    the_min = atof(wd)

      //DBG"%V$the_deg $the_min \n"

      //  sz= Caz(the_min);

      //DBG" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

    the_dir = the_parts[2];

    y = the_min/60.0;

    la = the_deg + y

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1
      }

//    DBG"%V $la  $y  \n"
      
    return (la);
   }
//=========================//
/{/*
 cmf Turnpt()
    {
     //DBG"CONS $_proc \n"
      Place=" ";
      Ladeg = 0.0;
      Longdeg = 0.0;
    }
//=========================//
/}*/

}
//======================================//

