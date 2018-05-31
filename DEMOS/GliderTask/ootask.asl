#/* -*- c -*- */
# "$Id: ootask.asl,v 1.2 2005/05/29 19:15:11 mark Exp mark $"

// Object Orientated version of anytask
//SetDebug(1)

Main_init = 1

  setDebug(1,"~trace")

#define DBG <<

  
proc namemangle(aname)
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



// try Wtp as args

proc ComputeTPD( j, k)
{

    float km = 0.0

// FIX <<" %I $j $k \n"

//<<" $_cproc %V $j $k \n"

    L1 = Wtp[j]->Ladeg

    L2 = Wtp[k]->Ladeg

//    <<" %I $L1 $L2 \n"

    //<<" %I $k $Wtp[k]->Ladeg \n"
    //<<" %I $j $Wtp[j]->Ladeg \n"

    lo1 = Wtp[j]->Longdeg

    lo2 = Wtp[k]->Longdeg

      //<<"%V$lo1 $lo2 \n"

      //<<"%V$L1 $L2 \n"

    rL2 = d2r(L2)

    rL1 = d2r(L1)


      //<<" %V$rL1 $rL2 \n"

    //<<" %I $rL1 $rL2 \n"

    rlo1 = d2r(lo1)
    rlo2 = d2r(lo2)

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2))

    //          <<" %V $D  $LegK   $nm_to_km\n"

    N = LegK * D

    km = N * nm_to_km

    //       <<" %V  $N $km $(typeof(km))\n"
    ;

    return km
 }

//<<" done class def \n"


Turnpt  Wtp[20];


  Svar CLTPT

  float Leg[10+]


  svar Wval

  str tpb =""
  Units="KM"


  //<<" done defines \n"
#  set_debug(0,"steponerror")

# dynamic variables no need to declare and set to default
# unless default value used

#  the_min = "0"
int nerror = 0

  A=ofr("turnpts.dat")  // open turnpoint file

  if (A == -1) A=ofr("cfi/turnpts")

  if (A == -1) {
    <<" can't find turnpts file \n"
    STOP!
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

float LoD = 35

int istpt = 1

int cltpt = 0

svar targ




  while (ac < na) {


    istpt = 1

    targ = _argv[ac]


    sz = targ->Caz()
    ac++

    //<<"%V $ac  $targ $sz $istpt \n"

    if (targ @= "LD") {

        LoD= _argv[ac]

        ac++

        istpt = 0
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
            stop()
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

  // <<"DONE ARGS  $cltpt\n"


    i=Fsearch(A,the_start,0,1,0);
    ki = seek_line(A,0)
    nwr = Wval->Read(A);

//<<"%V $i $nwr \n"
    Wtp[0]->Set(Wval);


  
i = -1;

  while ( i == -1) {

    //      <<" iw %V$i %v $via_keyb \n"

      Fseek(A,0,0)

      if (via_cl) {

	//	 the_start = CLTPT[cnttpt++]
	 the_start = CLTPT[cnttpt]
	 //<<"$the_start $cnttpt \n"

         cnttpt++;

	 if (cnttpt > cltpt) { 
            the_start = "done"
         }
      }
      else {
       the_start = get_word(the_start)
      }

      	//<<"Start %v $the_start \n"
	//    	prompt(" ? ")

      if (the_start @= "done") {
              STOP!
      }

      
      if (the_start @= "input") {
        input_lat_long = 1
        i = 0
        break
          }

      //<<"searching file for $the_start  \n"

        i=Fsearch(A,the_start,0,1,0)

      // <<"index found was $i \n"

      if (i == -1) {
	      <<"$the_start not found \n"
        ok_to_compute = 0
              if (!via_keyb) {
              STOP!
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
	//<<" $ki back to beginning of line ?\n"
	// need to step back a line

       nwr = Wval->Read(A)

      //    <<" %i $Wval \n"
	// <<"$nwr $Wval[0] $Wval[1] $Wval[2] $Wval[3] \n"

      msz = Wval->Caz()

	// <<"%V$msz \n"
	// <<"%V$n_legs \n"

      Wtp[n_legs]->Set(Wval)

	  //Wtp[n_legs]->Print()

	}

//<<"next \n"

# NEXT TURN

 more_legs = 1
 ok_to_compute = 1

 // FIX
 float the_leg

  while (more_legs == 1) {

        Fseek(A,0,0)

      if (via_cl) {

        //nxttpt = CLTPT[cnttpt++]
          nxttpt = CLTPT[cnttpt]
          cnttpt++
	  if (cnttpt > cltpt) {
	  //	    <<" done reading turnpts $cnttpt\n "

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
                   STOP!
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
        <<"Leg\tTP\tID\tLAT\tLONGI\t\tFGA\t  MSL\tPC\t $Units\tRTOT\t Radio \n"
	    }

# get total

 if (ok_to_compute) {


  for (nl = 0; nl < n_legs ; nl++) {

       Leg[nl] = ComputeTPD(nl, nl+1)

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
             pc_tot = the_leg/total * 100.0
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


       tpb = namemangle(tpb)
    //<<"namemangle returns $tpb \n"


    if (li == 0) {
       wleg = 0.0	 
       rtotal = 0
       }

 <<"$li\t$tpb\t%4s$ident ${Wtp[li]->Lat}\t${Wtp[li]->Lon} %9.0f$agl ${Wtp[li]->Alt} %4.1f$pc_tot\t %5.1f$wleg $rtotal\t%6.2f${Wtp[li]->Radio} \n"

  }

   if (show_dist) {
<<"Total distance\t %8.2f$total km\t%8.2f$(total*km_to_sm) sm\t%6.2f$(total*km_to_nm) nm    LOD %6.1f$LoD \n"
<<" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
    }
   else {
    <<"# \n"
       }

  }


float avespd = 70.0;
dur =  (total*km_to_nm) /avespd  

//<<" polish \n"
  exit(1,"%6.1f$total km to fly %6.2f$dur hours @ $avespd knots\n")




/{


  TBD ==============================
  namemangle return error
  add  bearing to next turnpoint


/}

