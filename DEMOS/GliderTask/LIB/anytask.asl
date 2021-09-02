/* 
 *  @script anytask.asl 
 * 
 *  @comment task-planner 
 *  @release CARBON 
 *  @vers 4.3 Li Lithium [asl 6.3.39 C-Li-Y] 
 *  @date 07/09/2021 19:47:29 
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                            



<|Use_=
Compute task distance
e.g  asl anytask.asl   gross laramie mtevans boulder  LD 40 
///////////////////////

|>


#include "debug"

ignoreErrors()

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}
ignoreErrors()
//#define DBG ~!


//#define DBG <<
#define DBG ~!


_DB = 0;
chkIn(_dblevel)


//setMaxICerrors(-1) // ignore - overruns etc

Main_init = 1;

#include "tpclass"
#include "ootlib"

//<<"%V $totalD\n"


float Leg[20];

float CSK = 70.0
float Cruise_speed = (CSK * nm_to_km);

<<"%V $Cruise_speed\n"

// try Wtp as args

//<<" done class def \n"
<<"%V$Ntp_id\n"

Turnpt  Wtp[50];



<<"%V$Ntp_id\n"

Wtp[1]->Alt = 100.0;

Wtp[40]->Alt = 5300.0;

<<"$Wtp[1]->Alt\n"

//Wtp->pinfo() ;  // should identify Obj





Tleg  Wleg[20];



svar CLTPT;

svar Wval;

  str tpb =""
  Units="KM"


  //<<" done defines \n"


# dynamic variables no need to declare and set to default
# unless default value used

#  the_min = "0"
int nerror = 0

int use_cup = 1;

  
  if (use_cup) {
   A=ofr("CUP/bbrief.cup")  // open turnpoint file
  }
  else {
   A=ofr("DAT/turnptsA.dat")  // open turnpoint file
  }

    
  if (A == -1) {
    exit(-1, " can't find turnpts file ")
  }



brief = 0
show_dist = 1
show_title = 1

# main

 na = get_argc()

DBG"%v $na\n"

int ac = 1;
via_keyb = 0
via_file = 0
via_cl = 1

# 

float LoD = 35;

int istpt = 1

int cltpt = 0

    str targ;

<<" %V $LoD \n"

  while (ac < na) {



    istpt = 1

    targ = _argv[ac]

DBG"%V $ac $targ\n"

    sz = targ->Caz()
    ac++


    if (targ @= "LD") {

       LoD= atof(_argv[ac])

        ac++

        istpt = 0
      <<"setting LD %V $LoD \n"
    }

    if (targ @= "CS") {

       CSK = atof(_argv[ac])

        ac++

        istpt = 0
	Cruise_speed = (CSK * nm_to_km);
      <<"setting CS %V $CSK knots $Cruise_speed kmh \n"
    }




    if ( targ @= "task") {

        via_keyb = 0
        via_file = 1
        byfile = _argv[ac]
        ac++
	//     <<" opening taskfile $byfile \n"
        TF = ofr(byfile)

        tasktype = r_file(TF)

          if (TF == -1 || si_error()) {
            exit(-1,"file error")
          }
          else {
            <<"$TF  $tasktype \n"
          }

        istpt = 0

      }


    if (targ @= ">") {
             break
    }

    if (targ @= "briefreport") {
                   brief = 1
    }

      if (targ @= "tasklist") {
       show_dist = 0
       show_title = 0
       istpt = 0
      }

    //<<" %V $targ $istpt $(typeof(istpt)) \n"
 //   <<"%V $ac  $targ $sz $istpt \n"

      if (istpt) {

        via_keyb = 0

        via_cl = 1

        CLTPT[cltpt] = targ

//	<<"%V$targ $sz $cltpt $CLTPT[cltpt] \n"
        cltpt++
      }
    //    <<"%V $ac  $targ $sz \n"
  }

# look up lat/long

the_start= "Longmont"
nxttpt = "Laramie"


N = 0.0
int ki

int cnttpt = 0

# enter start

int input_lat_long = 0

int i = -1

    <<"DONE ARGS  $cltpt\n"



    ////   do this to check routine    
    //<<"Start  $the_start \n"

// first parse code bug on reading svar fields?

 for (k= 0; k < cltpt; k++) {

   <<"$k  $CLTPT[k] \n"

 }

/////////////////////////////
    
i = -1;    

while ( i == -1) {

<<[_DB]" iw %V $cnttpt $i %v $via_keyb $via_cl\n"

      Fseek(A,0,0)

      if (via_cl) {

	the_start = CLTPT[cnttpt];
	
	//<<"$the_start $cnttpt \n"

         cnttpt++;

	 if (cnttpt > cltpt) { 
            the_start = "done"
         }
      }
      else {
        the_start = get_word(the_start)
      }

      // <<"Start  $the_start \n"
	//    	prompt(" ? ")

      if (the_start @= "done") {
	exit(0,"done");
      }

      
      if (the_start @= "input") {
          input_lat_long = 1
          i = 0;
	  break;
          }

      //<<"searching file for $the_start\n";
      // <<"         \n";
      //<<" \n";

      i=Fsearch(A,the_start,0,1,0);

<<[_DB]"$i\n"
      //<<"index found was $i \n"
    if (i == -1) {
      the_start = nameMangle(the_start);
    }
          i=Fsearch(A,the_start,0,1,0);
    
             if (i == -1) {
	      <<"$the_start not found \n"
              ok_to_compute = 0
              if (!via_keyb) {
		//testargs(1,0,"start not found");
		exit(0,"start not found");
              }

      }






DBG"inputs  $the_start\n"
// -------------------------------
//<<"%V$input_lat_long  $i \n"

  if (input_lat_long) {

// <<" input place !\n"

  }
  else {

        Fseek(A,i,0)

	if (via_keyb) {
             w=pcl_file(A)
	  }
	else {
	  //<<"pcl \n"
	    //w=pcl_file(A,0,1,0)
	}
	
	ki = seek_line(A,0)

<<[_DB]" $ki back to beginning of line ?\n"

	  // need to step back a line
        if (use_cup) {
         nwr = Wval->readWords(A,0,',');
	 }
        else { 
         nwr = Wval->readWords(A)
        }
      //    <<" %i $Wval \n"

DBG"$nwr $Wval[0] $Wval[1] $Wval[2] $Wval[3] \n"

	  //    msz = Wval->Caz()

	// <<"%V$msz \n"
	// <<"%V$n_legs \n"
	tplace = Wval[0];

     if (use_cup) {
       	tlon = Wval[4];
	}
     else {
	tlon = Wval[3];
     }


//<<"%V$tplace $tlon \n"
//<<"$Wval[::]\n"	  

       if (use_cup) {
         Wtp[n_legs]->TPCUPset(Wval)
	 }
       else { 
         Wtp[n_legs]->TPset(Wval)
       }

 }

}

//<<"next \n"

# NEXT TURN

 more_legs = 1
 ok_to_compute = 1

 // FIX
 float the_leg;

  while (more_legs == 1) {

        Fseek(A,0,0)

      if (via_cl) {


          nxttpt = CLTPT[cnttpt]
          cnttpt++
	  if (cnttpt > cltpt) {
	    
<<[_DB]" done reading turnpts $cnttpt\n "

            nxttpt = "done"

          }
    
      }
      else {
        <<" get via a keyboard or file !! \n"
          nxttpt = get_word(nxttpt)
      }
	


          if ((nxttpt @= "done") || (nxttpt @= "finish") || (nxttpt @= "quit") ) {
            <<"\n"
            more_legs = 0
          }
          else {

              i=Fsearch(A,nxttpt,0,1,0)

             if (i == -1) {

              <<"$nxttpt not found \n"
              ok_to_compute = 0

              if (!via_keyb) {
		exit(0,"$nxttpt not found ");
	      }

	     }
          }

      if (more_legs) {

        Fseek(A,i,0)

        n_legs++

	    if (via_keyb) {
                w=pcl_file(A)
	    }
	    else {
	      // w=pcl_file(A,0,1,0)
            }


	// Fseek(A,w,0)
            ki = seek_line(A,0)
           if (use_cup) {
             nwr = Wval->readWords(A,0,',')
             Wtp[n_legs]->TPCUPset(Wval)
	   }
	   else {
             nwr = Wval->readWords(A)
             Wtp[n_legs]->TPset(Wval)

           }
            msz = Wval->Caz()
      }

  }

    //      prompt("%v $more_legs next turn %-> ")

# compute legs

 //<<"compute \n"

ild= abs(LoD)

   <<"%V  $CSK knots $Cruise_speed kmh\n"
     if (show_title) {
<<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
        <<"Leg\tTP\t\tID\tLAT\t\tLONGI\t\tFGA\t  MSL\tPC\t $Units\tRTOT\tRTIM\t Radio\t TC \n"
	    }

# get totals

   float rtime = 0.0;
   float rtotal = 0.0;

// in main --- no obj on stack?

 if (ok_to_compute) {


    
   //computeHTD()
totalD = 0;
//totalD->info(1)

float TKM[20];


  for (nl = 0; nl < n_legs ; nl++) {

       L1 = Wtp[nl]->Ladeg;
       L2 = Wtp[nl+1]->Ladeg;
       
       //DBG"%V $L1 $L2 \n"
       lo1 = Wtp[nl]->Longdeg;

       lo2 = Wtp[nl+1]->Longdeg;

       //DBG"%V $lo1 $lo2 \n"


      // tkm = ComputeTPD(nl, nl+1);
       tkm = Howfar(L1,lo1 , L2, lo2 );

      // DBG"%V $nl $tkm \n"
       TKM[nl] = tkm;
       Leg[nl] = tkm;
       Wleg[nl+1]->dist = tkm;
//<<"%V $nl $tkm $Leg[nl] $TKM[nl]\n"
DBG"%V $Wleg[nl]->dist\n"
       //Leg[nl] = ComputeTPD(nl, nl+1)
       
       tcd =  ComputeTC(nl, nl+1)
       TC[nl] = tcd;
       
       Dur[nl] = Leg[nl]/ Cruise_speed;
       

//<<"%V $Leg[nl] $tkm \n"
       totalDur += Dur[nl];

       totalD += tkm;
       
//<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"

}

    //  <<" $total \n"

   

   rmsl = 0.0
   msl = 0.0
   pc_tot = 0.0

  for (nl = 0; nl <= n_legs ; nl++) {

    if (nl == 0) {
                the_leg =0;
                pc_tot = 0.0
    } 
    else { 
             the_leg = Leg[nl-1]
             pc_tot = 0.0;
             if (totalD > 0) {
             pc_tot = the_leg/totalD * 100.0
	     Wleg[nl-1]->pc = pc_tot;
	     //<<"%V $nl $the_leg $pc_tot\n"
	     }
    }

    nleg = the_leg * km_to_nm

    alt =  Wtp[nl]->Alt
    
    msl = alt
    //    <<" %I $msl $Wtp[nl]->Alt \n"
    //    <<" %I $nl $msl \n"
    //    <<" %I $rmsl $Wtp[nl+1]->Alt \n"
    //<<" %I $LoD \n"

    ght = (Leg[nl] * km_to_feet) / LoD

    //<<" $ght = ${Leg[nl]} * $km_to_feet / $LoD \n"
    // <<"    $agl = $ght + 1200.0 + $rmsl \n"

    if (nl == n_legs) {
        agl = 1200 + msl
    }
    else {
      rmsl =  Wtp[nl+1]->Alt
      agl = ght + 1200.0 + rmsl
    }


    Wtp[nl]->fga = agl;

    tpb = Wtp[nl]->Place
    
    ident = Wtp[nl]->Idnt

//<<"$ident \n"

//ident->info(1)

    li = nl
    rtotal += the_leg

    if (Units @= "KM") {
        wleg = the_leg ; 
    }
    else {
       wleg = nleg ;
    }

 //   kiss = "^$tpb"
 //   ki=Fsearch(A,kiss,0,1,0,0,1)
 //   tpb = nameMangle(tpb);
 // <<"namemangle returns $tpb \n"
    if (li > 0) {
     rtime = Dur[li-1];
    }
//    rtime->info(1)

//<<"%V $li $rtime $Dur[li] \n"

    if (li == 0) {
       wleg = 0.0	 
       rtotal = 0
       }


tplen = slen(tpb)
ws =  nsc((15-tplen)," ")
idlen = slen(ident)
wsi= nsc((15-idlen)," ")

 // <<"$li $Wleg[li]->dist  $Wleg[li]->pc_tot \n"


 <<"$li ${tpb}${ws}${ident}${wsi} %9.3f${Wtp[li]->Lat} %11.3f${Wtp[li]->Lon}\s%11.0f${Wtp[li]->fga} ${Wtp[li]->Alt} %4.1f$Wleg[li]->pc_tot\t"
<<"%5.1f$Wleg[li]->dist\t$rtotal\t$rtime\t%6.2f${Wtp[li]->Radio}"
<<"\t%6.0f$TC[li] "
<<"\t%6.2f$Dur[li]\n"

  }

   if (show_dist) {
<<"Total distance\t %8.2f$totalD km\t%8.2f$(totalD*km_to_sm) sm\t%6.2f$(totalD*km_to_nm) nm    LOD %6.1f$LoD \n"
<<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
    }
   else {
    <<"# \n"
       }

  }


<<"%6.1f$totalD km to fly -  $totalDur hrs - bon voyage!\n")

//exit(0,"%6.1f$totalD km to fly -  $totalDur hrs")




/*


  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint


*/

