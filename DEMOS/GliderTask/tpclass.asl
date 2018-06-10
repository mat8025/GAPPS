///
///   task and turnpt
///


CLASS Taskpt 
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

#  method list

  CMF Read (fh) 
  {
  
     la_deg = "" 
     long_deg = ""

     nwr = wval->Read (fh)

DBG"$nwr  $wval[0] $wval[1] $wval[2]  \n"

      if (scmp(wval[0],"#",1)) {
       // comment line in file
         return 0;
      }

    xx= "$wval[0] \n"
    
    if (nwr > 6) {
      
      Place =wval[0] // taskpt place
      
//<<" $wval[0]  \n"

     Alt = atof(wval[4])

//    Ladeg = GetDeg(la_deg)

    Ladeg = GetDeg(wval[2]) ; // taskpt Ladeg

    Longdeg = GetDeg(wval[3]) ; // taskpt Longdeg

    tptype = wval[7];
    }

    return nwr
   }

   CMF SetPlace (ival)   
   {
     Place = ival;
   }

   CMF GetPlace ()   
   {
      return Place;
   }

   CMF GetTA ()   
   {
      int amat =0;
      val = tptype; 
      spat (val,"A",-1,-1,amat)
//<<"taskpt %V$amt $(typeof(amat)) \n"
      return amat;
   }

   CMF GetLat ()   
   {
      val = wval[2] 
	return val;
   }

   CMF GetLong ()   
   {
      val = wval[3] 
	return val;
   }

   CMF GetRadio ()   
   {
      val = wval[6] 
	return val;
   }

   CMF GetID ()   
   {
     val = wval[1]; 
	return val;
   }

   CMF GetMSL ()   
   {
     int ival = Alt; 
     return ival;
   }

   CMF Print ()    
   {
     //<<"$wval[0] $wval[1]  $wval[2] $wval[3] \n"
     <<"%V $Place $Ladeg $Longdeg\n"
//     xx= "$wval[2:6]"
//     <<"$xx \n"
   }


  CMF Taskpt()
    {
      //<<" CONS $_cobj  $Place\n"
      Ladeg = 40.0;
      Longdeg = 105.0;
      cltpt = "";
      Place = "";      
    }


  CMF GetDeg (svar the_ang)
    {

  //<<" $_cproc %v $the_ang \n"
  //  <<"%V $the_ang $(typeof(the_ang)) \n"
//ttyin()

      float la;
      float the_deg;
      float the_min;

//<<" $_cproc  $the_ang  \n"

      the_parts = Split(the_ang,",")

//FIX    float the_deg = atof(the_parts[0])   // TBF

    //<<"%v $the_parts \n"

//<<"%v $the_parts[0] \n"

        dv = the_parts[0]
        the_deg = atof(dv)


//<<"%v $the_deg \n"
        dv = the_parts[1]
        the_min = atof(dv)

//        <<" %V $the_deg $the_min \n"

	//sz= Caz(the_min);

 // <<" %V $sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

	the_dir = the_parts[2];

      y = the_min/60.0

      la = the_deg + y

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1.0
      }

   //  <<" %V $la  $y $(typeof(la)) $(Cab(la)) \n"
    return (la)
   }

}

//============================================

CLASS Turnpt 
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

//  method list

  CMF Set (wval) 
   {

DBG"$_proc $(typeof(wval)) $wval[::] \n"

//<<"%V$_cproc  %i$_cobj   %i$wval \n"
     //sz = wval->Caz()

      sz = Caz(wval);      
 // <<"%V$sz \n"
DBG"$sz 0: $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"
    
   
      //   <<"$wval[0]\n"
       //  <<"$(typeof(wval))\n"
       //ans = iread("-->");
     Place=wval[0]; // wayp 
    
     DBG"%V$Place\n"


     Idnt =  wval[1];
 DBG"%V$Idnt\n"
 //    <<"%V$wval[2]\n"
     
     Lat = wval[2]; // wayp 

     //   <<"%V$Lat  <| $wval[2] |>\n"

     //   <<"%V$wval[3]\n"	 
     Lon = wval[3];

     //       <<"%V$Lon  <| $wval[3] |>\n" 
     
     Alt = wval[4];
     
     rway = wval[5];
     
     Radio = atof(wval[6]);

     tptype = wval[7];

DBG"%V$Lat $Lon \n"
     //  <<" $(typeof(Lat)) \n"
     // <<" $(typeof(Lon)) \n"
     //  <<" $(typeof(Ladeg)) \n"	 

    Ladeg =  GetDeg(Lat); // wayp 
     //       <<" $(typeof(Longdeg)) \n"	 
    Longdeg = GetDeg(Lon); // wayp 

DBG"%V $Ladeg $Longdeg \n"

      }

   CMF SetPlace (val)   
   {
       Place = val;
   }
//=========================//

   CMF GetPlace ()   
   {
       return Place; 
   }
//=========================//
   CMF Print ()    
   {
     <<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"
   }
//=========================//

  CMF Turnpt()
    {
     <<"CONS $_proc \n"
      Place="nowhere";
      Ladeg = 0.0;
      Longdeg = 0.0;
    }
//=========================//
 CMF GetTA()   
   {
      int amat =0;
      val = tptype; 
      spat (val,"A",-1,-1,amat)
//<<"%V$amt $(typeof(amat)) \n"
      return amat;
   }
//=========================//
  CMF GetDeg ( the_ang)
    {
      str the_dir;
      //<<"input args is $the_ang \n"

      float la;
      str wd;
 //<<"%V$_cproc %i $the_ang  \n"
	

    the_parts = Split(the_ang,",")

      //<<"%V$the_parts \n"


//FIX    float the_deg = atof(the_parts[0])
    wd = the_parts[0];
    //the_deg = atof(the_parts[0])  // fix returns vec instead to supplied scalar string
    the_deg = atof(wd);

//    float the_min = atof(the_parts[1]
    wd = the_parts[1];
    the_min = atof(wd)

      //<<"%V$the_deg $the_min \n"

      //  sz= Caz(the_min);

      //<<" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

    the_dir = the_parts[2];

    y = the_min/60.0;

    la = the_deg + y

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1
      }

//    <<"%V $la  $y  \n"
      
    return (la);
   }

}
//======================================//

