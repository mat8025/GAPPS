///
/// svar as proc arg
/// 
#define DBG <<

setdebug(1,@keep,@pline,@trace);

checkIn()
proc pS ( SV)
{
static int k = 1;
<<"$(typeof(SV)) $SV[::]\n"
sz = Caz(SV)

<<"%V $sz $SV[2] \n"

w2 = SV[2];
<<"$k %V $w2\n"

if (k==1) {
checkStr(w2,"we")
}
else if (k==2) {
checkStr(w2,"is")
}
else if (k==3) {
 checkStr(w2,"40,07.00,N")
 ang =getDeg(SV[2]);
 <<"%V $ang\n"
 ang = getDeg(SV[3]);
 <<"%V $ang\n" 
}

 k++;

}
//===========

S = Split("how did we get here")

<<"$(typeof(S)) $S[::]\n"

pS(S)

T = Split("again how is this happening")

pS(T)

//===========

proc getDeg ( the_ang)
    {
      str the_dir;
      float la;
      str wd;
      <<"in $_proc  $the_ang\n"
	

    the_parts = Split(the_ang,",")

      //<<"%V$the_parts \n"


//FIX    float the_deg = atof(the_parts[0])
   wd = the_parts[0];
    the_deg = atof(wd)

      sz= Caz(the_deg);
<<" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  \n"

//    float the_min = atof(the_parts[1])
   wd = the_parts[1];
    the_min = atof(wd)

    <<"%V$the_deg $the_min \n"

      sz= Caz(the_min);

      <<" %V$sz $(typeof(the_min))   $(Cab(the_min)) \n"

    the_dir = the_parts[2];

    y = the_min/60.0;

    la = the_deg + y

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1
      }

    <<"%V $la  $y  \n"

 <<"%V $(caz(la))  $(Cab(la)) \n"
      
    return (la);
 }

//===============================//

//======================
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
     Place = wval[0];
    
DBG"%V$Place\n"


     Idnt =  wval[1];
 DBG"%V$Idnt\n"
 //    <<"%V$wval[2]\n"
checkStr(Idnt,"jmt")     
     Lat = wval[2];

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

    Ladeg =  getDeg(Lat);

     //       <<" $(typeof(Longdeg)) \n"	 
     Longdeg = getDeg(Lon);

<<"%V $Ladeg $Longdeg \n"

      }


}
//=================================

 P=split("Jamestwn    	jmt	40,07.00,N	105,24.00,W	8470	0/0	_	T ");

pS(P)


checkOut()
exit()


Turnpt  Tp;



 
 Tp->Set(P);

 P= Split("AngelFire    	AXX	36,24.75,N	105,18.00,W	8383	17/35	122.8	TA")
 
 Tp->Set(P);
 



checkOut()
exit()