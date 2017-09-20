///
///  old procs === 
///

// pretty slow -- local/global bug when using Class variables??

proc ReadIGC(igc_file)
{
  // think we want a C version of this
<<"%V $igc_file \n"
   T=fineTime();

   a=ofr(igc_file)

   if (a == -1) {
     <<" can't open IGC file $igc_file\n"
     return
   }

   svar igcval;

     nwr = igcval->Read (a)

<<"$a $igc_file  $nwr $igcval[0] \n"

// read words ---
     int kk = 0;
     int jj = 0;
     
   while (1) {

                          nwr = igcval->Read (a)
			    //<<" $nwr $igcval[0] \n"
  
// if (f_error(a) == 6) break
                         if (nwr == -1) break
					  
                 if (nwr == 1) { 
		   tword = igcval[0];
		   //  <<"$tword \n"
		   //"$(sele(tword,0)) \n"   
			

		   if (sele(tword,0,1) @= "B") {

			  igclat = sele(tword,7,8)
                          igclong = sele(tword,15,9)
			    iele =  sele(tword,25,5)
			    latnum = igc_dmsd(igclat);
                          lngnum = igc_longd(igclong);
			   //<<"$kk $tword \n"
                           kk++
                          if (kk > 10) {
			  elev =  atof(iele);
                          IGCLONG[jj] = lngnum
                          IGCLAT[jj] = latnum
                          IGCELE[jj] = elev;
			  jj++;
			  //<<[B]"$igclat $latnum $igclong $lngnum $iele\n"
			  // <<"$latnum $lngnum $elev\n"			  
                          }
         		 }
		 }

   }

<<" read B $kk set $jj lat,long values \n"




    dt=fineTimeSince(T);
<<"$_proc took $(dt/1000000.0) secs \n"
    cf(a);
   //  cf(B);
 }


//=================================================

# conversion routines



proc get_dmsd (the_ang)
{

  //  <<" $_proc %v $the_ang \n"

    the_parts = Split(the_ang,",")

      //<<" $the_parts \n"

    the_deg = atof(the_parts[0])

    the_min = atof(the_parts[1]);

      //sz= Caz(the_min)

    the_dir = the_parts[2]
      //<<" %v $the_dir \n"
   
      //    <<" %v $the_ang \n"
      //     <<"%V $the_deg $(typeof(the_deg)) $the_min $sz $(typeof(the_min)) $the_dir \n"

    y = the_min/60.0;

    la = the_deg + y

    //    sz= Caz(la)
    //<<"%v $la  $(typeof(la))    $sz\n"

      if (the_dir @= "W") {
         la *= -1
      }

    if (the_dir @= "S") {
           la *= -1
	     }

    //     <<" %V $la  $y $(typeof(la)) \n"
      ;
 return (la)
 
}


proc dat_dmsd (the_ang)
{

  //<<" $_cproc %V$the_ang \n"
  float the_min;
  float the_deg;
  
    nang = ssub(the_ang,":",".")

    the_parts = Split(nang,".")

    the_deg = atof(the_parts[0]);

    the_min =  atof(the_parts[1]);

    the_cdir = the_parts[2]

    sl= slen(the_cdir) 
    sli = sl -1

    the_dir = the_cdir{sli}

  //     <<" %V $the_deg $the_min $sl  $the_cdir $the_dir\n"

    float la
    float y = the_min/60.0

    la = the_deg + y

    if (the_dir @= "W") la *= -1

    if (the_dir @= "S") la *= -1

      //      <<" %v $la  $y $(typeof(la)) \n"

    return (la)
  }
//============================



proc igc_dmsd (the_ang)
  {
    
    //the_deg = the_min = 0.0;
    //the_deg =  0.0;
    //the_min = 0.0;

    the_deg = atof(sele(the_ang,0,2));
    the_min = atof(sele(the_ang,2,2));
    fr = atof(sele(the_ang,4,3));

    //<<"$the_ang $the_deg $the_min $f\n"
      
    the_min += (fr/1000.0);
    la = the_deg + the_min/60.0;
    the_dir = sele(the_ang,8,1)

      if (the_dir @= "S") la *= -1;
    //<<"%V$la\n"
	//ps=iread("::>")
    return (la)
  }
//============================

proc igc_longd (the_ang)
  {
    //the_deg = the_min = 0.0;
      the_deg = atof(sele(the_ang,0,3))
      the_min = atof(sele(the_ang,3,2))
      fr = atof(sele(the_ang,5,3))
    the_min += (fr/1000.0);
    //<<"$the_ang $the_deg $the_min $f\n"
    la = the_deg + the_min/60.0;
    the_dir = sele(the_ang,9,1)

    if (the_dir @= "W")) la *= -1;
    return (la)
  }
//============================


/{/*
///    DUP the first 10 or so LAT,LONG  for start glitch?
      k = Ntpts - 10;
//    slat = IGCLAT[k];
//    slng = IGCLONG[k];
      slat = 40.04
      slng= 105.226

   for (i= 0; i < 10; i++) {
       IGCLAT[i] = slat;
       IGCLONG[i] = slng;       
    }

    for (i= k; i < Ntpts; i++) {
       IGCLAT[i] = slat;
       IGCLONG[i] = slng;       
    }
/}*/
