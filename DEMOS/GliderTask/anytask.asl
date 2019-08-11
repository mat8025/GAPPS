//%*********************************************** 
//*  @script anytask.asl 
//* 
//*  @comment task-planner 
//*  @release CARBON 
//*  @vers 4.1 H Hydrogen                                                  
//*  @date Tue Aug  6 06:28:50 2019 
//*  @cdate 9/17/1997 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

///
/// anytask
///

include "debug"

setDebug(1,@keep,@~pline)

scriptDBON()

<<[_DB]"debug anytask\n"

<<" %V $_DB\n"

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");



Main_init = 1;

proc nameMangle(aname)
{
  // FIXIT --- bad return
  str fname;

 nname=aname
 //<<" %V $nname $aname \n"

  kc =slen(nname)

 if (kc >7) {
 nname=svowrm(nname)
 }

 scpy(fname,nname,7)

   // <<"%V$nname --> $fname \n"


 return fname
}

include "ootlib"

float Cruise_speed = 80 * nm_to_km;


// try Wtp as args

//<<" done class def \n"


Turnpt  Wtp[20];

Svar CLTPT;

float Leg[10+];
float TC[10+];
float Dur[10+];


svar Wval;

  str tpb =""
  Units="KM"


  //<<" done defines \n"
#  set_debug(0,"steponerror")

# dynamic variables no need to declare and set to default
# unless default value used

#  the_min = "0"
int nerror = 0

  A=ofr("turnpts.dat")  // open turnpoint file

    if (A == -1) {
      A=ofr("cfi/turnpts")
    }
    
  if (A == -1) {
    exit(-1, " can't find turnpts file ")
  }



brief = 0
show_dist = 1
show_title = 1

# main

 na = get_argc()

ac = 1
via_keyb = 0
via_file = 0
via_cl = 1

# 

    float LoD = 35;

int istpt = 1

int cltpt = 0

    svar targ;

//<<" %V $LoD \n"

  while (ac < na) {


    istpt = 1

    targ = _argv[ac]

    sz = targ->Caz()
    ac++

      //  <<"%V $ac  $targ $sz $istpt \n"

    if (targ @= "LD") {

      LoD= atof(_argv[ac])

        ac++

        istpt = 0
      //<<"setting LD %V $LoD \n"
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


      if (istpt) {

        via_keyb = 0

        via_cl = 1

	//        CLTPT[cltpt++] = targ
        CLTPT[cltpt] = targ

	//<<"%V$targ $sz $cltpt $CLTPT[cltpt] \n"
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
int n_legs = 0

# enter start

int input_lat_long = 0

int i = -1

    //<<"DONE ARGS  $cltpt\n"

    ////   do this to check routine    
    //<<"Start  $the_start \n"

// first parse code bug on reading svar fields?


/////////////////////////////
    
i = -1;    

while ( i == -1) {

<<[_DB]" iw %V$i %v $via_keyb $via_cl\n"

      Fseek(A,0,0)

      if (via_cl) {

	//	 the_start = CLTPT[cnttpt++]
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

      //<<"searching file for $the_start  \n";
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
  }


//<<"inputs\n"
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

      //  <<"$w \n"

	//ki=Fseek(A,w,0)
	ki = seek_line(A,0)
<<[_DB]" $ki back to beginning of line ?\n"

	  // need to step back a line

        nwr = Wval->Read(A)

      //    <<" %i $Wval \n"
<<[_DB]"$nwr $Wval[0] $Wval[1] $Wval[2] $Wval[3] \n"

	  //    msz = Wval->Caz()

	// <<"%V$msz \n"
	// <<"%V$n_legs \n"
	tplace = Wval[0];
	tlon = Wval[3];

<<[_DB]"%V$tplace $tlon \n"
<<[_DB]"$Wval[::]\n"	  
      Wtp[n_legs]->Set(Wval)

	  //Wtp[n_legs]->Print()

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

        //nxttpt = CLTPT[cnttpt++]
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
            nwr = Wval->Read(A)
            msz = Wval->Caz()
            Wtp[n_legs]->Set(Wval)

      }


  }

    //      prompt("%v $more_legs next turn %-> ")

# compute legs

 //<<"compute \n"


total = 0.0
ild= abs(LoD)


     if (show_title) {
<<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
        <<"Leg\tTP\tID\tLAT\tLONGI\t\tFGA\t  MSL\tPC\t $Units\tRTOT\t Radio\t TC \n"
	    }

# get total

 if (ok_to_compute) {


  for (nl = 0; nl < n_legs ; nl++) {

        tkm = ComputeTPD(nl, nl+1);

//<<"<$nl> $tkm\n"
       Leg[nl] = tkm;
       //Leg[nl] = ComputeTPD(nl, nl+1)

       TC[nl] =  ComputeTC(nl, nl+1)

       Dur[nl] = Leg[nl]/ Cruise_speed;

       total += Leg[nl]
  }

  //  <<" $total \n"

   rtotal = 0
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
             if (total > 0) {
             pc_tot = the_leg/total * 100.0
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


    tpb = Wtp[nl]->Place
    ident = Wtp[nl]->Idnt

    li = nl
    rtotal += the_leg

    if (Units @= "KM") {
        wleg = the_leg ; 
    }
    else {
       wleg = nleg ;
    }

    kiss = "^$tpb"
    ki=Fsearch(A,kiss,0,1,0,0,1)



    //  kc =slen(tpb)
    //if (kc >7) {
    //  tpb=svowrm(tpb)
    //}


       tpb = nameMangle(tpb);

   // <<"namemangle returns $tpb \n"


    if (li == 0) {
       wleg = 0.0	 
       rtotal = 0
       }

 <<"$li $tpb\t%4s$ident ${Wtp[li]->Lat}\t${Wtp[li]->Lon} %9.0f$agl ${Wtp[li]->Alt} %4.1f$pc_tot\t "
<<"%5.1f$wleg $rtotal\t%6.2f${Wtp[li]->Radio} %6.0f$TC[li] %6.2f$Dur[li]\n"

  }

   if (show_dist) {
<<"Total distance\t %8.2f$total km\t%8.2f$(total*km_to_sm) sm\t%6.2f$(total*km_to_nm) nm    LOD %6.1f$LoD \n"
<<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
    }
   else {
    <<"# \n"
       }

  }


//<<" polish \n"
exit(0,"%6.1f$total km to fly ")




/{


  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint


/}

