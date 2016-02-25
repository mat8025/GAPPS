///  break up sim2100  cloud file into lri,sri per vertical scan
///  need inputs for neural-net

setdebug(0)
const float nm2km = 1.852
const float km2nm = 1.0/nm2km

int c_rng
proc nextParams()
{

    CW = readline(A)    // parameters 
    where = ftell(A)

    if (f_error() == EOF_ERROR) {
       eof_error = 1
    }

//<<"$CW\n"

//<<"$i $where --->%s$CW\n"

// parameters :-
// HH:MM:SS,secSinceMidnight,acHdg,acAlt,sat,auto_mode,windShearState,totalbars,currBar,Azimuth,ERIB,scanN,cell_id_iq,cell_id_corr,cell_corr_rng,cell_corr_status,cell_lat,cell_lng,range,start_range,end_range,bearing,ac_lat,ac_lng

    
        wds =split(CW,',')

//<<"$wds \n"
//<<"|$wds[0]| |$wds[12]| \n"

        ts = wds[0]
        ac_hdg = atof(wds[2])
        ac_alt = atoi(wds[3])
        cell_id = atoi(wds[12])   // 


//<<"|$ts| cell_id=|$cell_id| \n"

        pi = 16
        cell_lat = atof(wds[pi]) ; pi++
        cell_lng = atof(wds[pi]) ; pi++
        range_nm = atof(wds[pi]) ; pi++
        start_r = atof(wds[pi]) ; pi++
        end_r = atof(wds[pi]) ; pi++
        bearing = atof(wds[pi]) ; pi++
        ac_lat = atof(wds[pi]) ; pi++
        ac_lng = atof(wds[pi]) ; pi++



//<<"%V$range_nm $start_r $end_r $cell_id $cell_lat $cell_lng\n"

        Lrange_bin =  (range_nm * nm2km * 1000) / 1200 

        Lrange_nbin = (start_r * nm2km * 1000) / 1200 

        Lrange_fbin = (end_r * nm2km * 1000) / 1200 

        c_rng = range_nm

//<<"%V$Lrange_nbin $Lrange_bin $Lrange_fbin\n"

}

int nc = 0

proc nextCloud()
{

  nc++



 nextParams()

 if (c_rng < 8) {

   stop("close enuf!\n")

 }

 //B= ofw("sri_ACx_STy_${c_rng}.txt")
 rp = CW
 //<<"$CW\n"

 //<<[B]"$CW\n"
// fprint(B,'%s\n',rp)

 CW = readline(A)    // should be SRI
 
 where = ftell(A)

 
 for (i = 0; i < 120; i++) {
    CW = readline(A)    
  //  fprint(B,'%s\n',CW)
 }
 
 //cf(B)

//<<"RS bounds were $b\n"
//  RS= readRecord(A,@del,',',@nrecords,120)
//  b = Cab(RS)
//<<"RS bounds are $b\n"
 

  CW = readline(A)    // LRI

  <<"lri_${acalt}_${strmtop}_${c_rng}.txt\n"

   B= ofw("lri_${acalt}_${strmtop}_${c_rng}.txt")
   fprint(B,'%s\n',rp)
 for (i = 0; i < 120; i++) {
   CW = readline(A)    
    fprint(B,'%s\n',CW)
 }


    
  cf(B)

  if (f_error() == EOF_ERROR) { 
      stop!
  }  

}




///////////////////////////////////////  CL_ARGS /////////////////////////////////////////////////////

fn = _clarg[1]

<<"$fn \n"

  A= ofr(fn)

  if (A == -1) {
    stop("can't find $fn !\n")
  }


   acalt = sele(spat(fn,"ALT",1),0,2)

   strmtop = sele(spat(fn,"WX",1),0,2)

<<"%V$acalt $strmtop\n"


//  read header

    CW = readline(A)  // read long version info

//<<"version %s$CW\n"
    CW = readline(A)  // read version

    CW = readline(A)  // read parameters names

    CW = readline(A)  // read image array bounds

//<<"image array %s$CW\n"


// now read each SRI, LRI and write out to files lri_$acalt_$stmtop_$range.txt

    

    
while (1) {
    nextCloud()

}



stop!


