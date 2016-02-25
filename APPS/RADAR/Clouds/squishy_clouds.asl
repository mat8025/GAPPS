//  test some ways of plotting an image file
//  in this case input csv file Rows x Cols of float values 
//  input 120 x 256 cells between 0- 100 in value

setdebug(0)

opendll("image","plot","uac")

BF=ofw("cloud_debug")

////////////////////////////////////////////////  GLOBALS ///////////////////////////////////////////////////////
// some used in graphic plots

ALTVEC = vgen(FLOAT,120,0,1)


float Strm_r[200] ;  // can we make this dynamic for a gline ?
float Strm_t[100] ;  


float StrmSQ_t[100] ;  
float StrmSQ_m[100] ;  
float StrmSQ_cbase[100] ;  



int sti = 0;
int cloud_mp
int Malt = 60
int SQTalt = 60

float SRADBZ[120]
float LRADBZ[120]
float SQ_LRADBZ[120]

float LRNADBZ[120]
float LRXADBZ[120]



float Inpat[]
float R[]
float RS[]
float RSQ[]
float RL[]
float NRL[]

float NRZ[]

float SRVEC[]
float LRVEC[]
float Lrip[]

float LRmdbz[]  // LR mid-alt dbz
float LRtopdbz[]  // LR mid-alt dbz

float mc_alt[185]

float mci_alt[185]
//int mc_alt[185]

uchar U[]

uchar UL[]

uchar N_UL[]

const float nm2km = 1.852
const float km2nm = 1.0/nm2km

int find_cell_id = 1
int track_id = 1

int skip_manuals = 0

last_msg = "XX




int Palt = 10
float PA[185]
float PkDBZrange = 0
int mmi[2]

int CCV[120]
float CCRV[120]


int Alt = 80
int Lalt = 80

int nc = 1
int eof_error = 0

int Lrange_bin = 50      // long range bin
int Lrange_nbin = 45      // long range near bin
int Lrange_fbin = 45      // long range far bin
int Lrange_xbin = 180      // selectable bin

float yf = 0.25


int stAlt = 0
int stSQAlt = 0

int cell_id = -1
int last_cell_id = -1

float range_nm = 0
float rangec_nm = 0
float ac_hdg = 0
float start_r = 0
float end_r = 0

float cell_lat
float cell_lng

float  bearing 
float  ac_lat
float  ac_lng
float last_xrange =0



int    ac_alt = 0

str ts

c_option = ""



 mc_rng = vgen(FLOAT,185,0,(1.2*km2nm))




/////////////////////////// DeConvolve ////////////////////////////////////////////////////////////
// beam smear

nb = 37

//  what does the beam antenna gain look like ---- symmetrical
//  3 1/2 deg beam-width -- where gain is at 1/2 (3 db down) so 1.75 deg either side 
//  but we have sparse samples --
//  so do we interpolate then despread 



int half_bw = nb/2
int mp = half_bw

//float Bm[nb] = { 0.125, 0.25, 0.5, 0.75, 1.0, 0.75, 0.5, 0.25, 0.125 }

float Bm[nb] = 1.0

float dy = 1.0/half_bw


//  triangle _/\_   convolver


      wt = dy
      for (i = 0; i < half_bw; i++) {
         Bm[i] = wt;
         Bm[nb-1-i] = wt;
         wt += dy;
      }

//////////////////////////////////////////////////////////////////////////////////////////////////////
// SQUISHY_3

float cloud_range = 80
float screen_range = 40
uchar UBPJ[]

uchar WUVS[]  // hold LR VS for archive

proc do_squishy3 ()
{
// get input cloud
int i

   NRL = RL



   NRL->limit(0,85)


   UBPJ = NRL   
   WUVS = UBPJ    

   for (i = 1 ; i < 185 ; i++) {

      //<<"%V$i smear-backproject \n"


   Inpat = NRL[::][i]  // an altitude column 

// FIX seems to give no dimensions instead of one??

//   Redimn(Inpat)

//<<"$Inpat \n"

//<<"$(Caz(Inpat)) \n"
// show Ip

// run Squishy transform

   wpts = findSegments(Inpat,10)

//<<"%V$wpts \n"


   wr = (i * 1200)/1000.0 * km2nm
  
   cloud_mp =  wpts[2]

   //cloud_mp = 120 - wpts[2]

  // cloud_mp =  120 - cy

//<<"%V$cloud_mp \n"


   if (wpts[3] < 7) {
    cloud_mp = 60          // best mid 60? - unbiased
   }


// TEMPORARY HACK

// want the cloud mid-Point to be biased towards the bottom --
//  our vector is sky (0) to ground (119) ?? 
  // cloud_mp += 10


   mci_alt[i] = cloud_mp


   if (i > 5) {
    

    cloud_mp = median(mci_alt[i-4:i])

   }

  mc_alt[i] =  120 - cloud_mp

 // mc_alt[i] =  cloud_mp

   RSQ = squishy3(Inpat,i,cloud_mp,screen_range)
  
b=Cab(RSQ)

 if (b[0] != 120) {
<<" RSQ bounds $b \n"  
}

   UBPJ[::][i] = RSQ[0:-1]

   }


}


proc write_vs()
{
// write out the LR to file
wfile(Fvs,"LRI $cell_id, $ac_alt , $range_nm , $st_alt,  $(Cab(WUVS)),\n") 
//wfile(Fvs,"%(,,\,,\n)$WUVS")  // hold LR VS for archive
wfile(Fvs,"$WUVS")  // hold LR VS for archive
wfile(Fvs,"---------------------------------------------\n")
/{
<<[Fvs]"LRI $cell_id, $ac_alt , $range_nm , $st_alt,  $(Cab(WUVS)),\n"
<<[Fvs]"%(,,\,,\n)$WUVS")  // hold LR VS for archive
/}
}







///////////////////////////////////////  CL_ARGS /////////////////////////////////////////////////////

fn = _clarg[1]

<<"$fn \n"

  A= ofr(fn)

if (A == -1) {
   stop("can't open $fn \n")
}



o_fn_csv = scat(sele(fn,0,-3),"csv")

C = ofw(o_fn_csv)

Fvs = ofw("vs.csv")

fprint(C,"ac_alt,range,raw_stalt,s_stalt,s_cbase,s_mca\n")

///////////////////////////////////////////////////////////////////////////////////////////////////////




proc getPeakDBZAlt(sr, er)
{
// given sub-range find peak DBZ and range as function of alt
//
// use LR reflect array

/{
     Palt = Alt
 <<"%V$Alt $Palt $sr $er\n"

     PA = RL[Palt][::]
b = Cab(PA)
<<"%V$b \n"
//
    // Redimn(PA)

b = Cab(PA)
<<"%V$b \n"

     mmi = minmaxi(PA)

     PkDBZrange = (mmi[1] * 1.2 * km2nm) 

//<<"%V$PkDBZrange \n"


   mini = mmi[0]
   maxi = mmi[1]
   min_val = PA[mini]
   max_val = PA[maxi]

 <<"$mmi $min_val $max_val\n"
/}
// force width

    if( sr == er) {
        er += 5
    }
    cv = maxvalcoli(RL,sr,er)

b = Cab(cv)

//<<"%V$b \n"

     maxi = cv[Alt]
     maxval = RL[Alt][maxi]

<<"%V$maxi $maxval\n"

     CCV =cv
// FIX
//     CCRV = CCV * 1.2 * km2nm 

} 



proc stormTop()
{
// FIX string arg not being passed correctly

//  stAlt = findVal(LRADBZ, 18,0,1,0,"<=")  // last index which is less than = 18 ?
//  5 is <= 
// our vectors are from sky to ground
// findval is the val that goes above <= 18 
  stAlt = findVal(LRADBZ, 18,0,1,0, 5)  // last index which is less than = 18 ?

//<<"$LRADBZ \n"

  r_alt = 60000 - stAlt * 500

   <<"%V$stAlt $r_alt \n"
  setgwob(stormtop_wo,@VALUE, r_alt,@redraw)

  Strm_t[sti] = r_alt  

  Strm_r[sti] = range_nm/120.0 * 185

//<<"$Strm_r \n"
//<<"$Strm_t \n"

  stSQAlt = findVal(SQ_LRADBZ, 18,0,1,0, 5)  // last index which is less than = 18 ?

  st_alt = 60000 - stSQAlt * 500

   <<"%V$stAlt $r_alt \n"
  setgwob(stormtop_wo,@VALUE, st_alt,@redraw)


  StrmSQ_t[sti] = st_alt

  bAlt = findVal(SQ_LRADBZ, 18,-1,-1,0, 5)  // last index which is less than = 18 ?

  b_alt = 60000 - bAlt * 500 

  StrmSQ_cbase[sti] = b_alt  


  m_alt = (mc_alt[Lrange_bin]) * 500

  Malt = 120 - mc_alt[Lrange_bin]

  StrmSQ_m[sti] =  m_alt  



  sti++

//  FIX
//  fprint(C,"$ac_alt , $range_nm , $r_alt , $st_alt , $b_alt, $(m_alt * 500) \n")  // FIXME

   fprintf(C,"$ac_alt , $range_nm , $r_alt , $st_alt , $b_alt, $m_alt \n") 

  <<"$ac_alt , $range_nm , $r_alt , $st_alt , $b_alt, $m_alt \n"

//<<"$LRADBZ\n"

}



proc getRangeDBZ()
{

//  SRADBZ = RS[::][Srange]

  float ADBZ[120]

//  ADBZ = RL[::][Lrange_bin]    // TBD FIX!!


    LRADBZ = getCol(RL,Lrange_bin)



  b = Cab(LRADBZ)

//<<"bounds ADBZ $b\n"
//<<"$LRADBZ\n"

// seems to break on redimn ??
 // Redimn(ADBZ) // make vector

//  b = Cab(LRADBZ)
//<<"bounds LRADBZ $b\n"


//  LRADBZ = ADBZ



  SQ_LRADBZ= getCol(NRL,Lrange_bin)


b=Cab(RL)
//<<[BF]"RL $b\n"
//  FIX
//  ADBZ = RL[::][Lrange_nbin]

  LRADBZ->Limit(0,100)

  ADBZ = getCol(RL,Lrange_nbin)


//b=Cab(ADBZ)
//<<[BF]"ADBZ $b\n"

  LRNADBZ = ADBZ

// set anything less than 0 to 0


  LRNADBZ->Limit(0,100)

//<<"deconvolve \n"
//<<"$LRNADBZ \n"
//<<"Bm\n $Bm\n"
//  Lbm= dconvolve(LRNADBZ,Bm)
//<<"Lbm \n"
//<<"$Lbm \m"

//    LRNADBZ = Lbm


//b=Cab(LRNADBZ)

//<<[BF]"LRADBZ $b  %V$Lrange_nbin\n"
//<<[BF]"LRNADBZ\n$LRNADBZ \n"

//  ADBZ = RL[::][Lrange_xbin]

  ADBZ = getCol(RL,Lrange_xbin)

  LRXADBZ = ADBZ

  LRXADBZ->Limit(0,100)




    stormTop()


    Alt = stSQAlt - 20

    if (Alt >=120) {
        Alt = 119
    }

}



proc nextParams()
{

    CW = readline(A)    // parameters 
    where = ftell(A)

    if (f_error() == EOF_ERROR) {
       eof_error = 1
    }

<<"$i $where --->%s$CW\n"

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


// temp adjust ---- FIXME -- look for storm-cell center

        range_nm -= 3

        range_km = howfar(cell_lat,cell_lng,ac_lat,ac_lng)

        rangec_nm = range_km * km2nm

<<"%V$range_nm $rangec_nm $start_r $end_r $cell_id $cell_lat $cell_lng\n"

        Lrange_bin =  (range_nm * nm2km * 1000) / 1200 

        Lrange_nbin = (start_r * nm2km * 1000) / 1200 

        Lrange_fbin = (end_r * nm2km * 1000) / 1200 



  <<"%V$Lrange_nbin $Lrange_bin $Lrange_fbin\n"



}



proc nextCloud()
{
  nc++
int i
int cok = 1

  

  float cinput[]

  

     //findNext()


     nextParams()

     if (range_nm < 0) {
          cok = 0
     }
    else {

    CW = readline(A)    // should be SRI
    where = ftell(A)

b = Cab(RS)
//<<"RS bounds were $b\n"
  RS= readRecord(A,@del,',',@nrecords,120)
  b = Cab(RS)
//<<"RS bounds are $b\n"


  SRVEC = RS[Alt][::]

  NRZ=rowZoom(RS,sri_nxp,1)

  U = Transpose(rowZoom(Transpose(NRZ),sri_nyp,1))

  CW = readline(A)    // LRI

  RL= readRecord(A,@del,',',@nrecords,120)

  b = Cab(RL)

//<<"RL bounds are $b\n"
//  LR40 = RL[Alt][0:63:]
//  LRVEC = vzoom(LR40,256)

    LRVEC = RL[Alt][::]

//    Lrip = RL[Alt][::]
//    LRVEC = dconvolve(Lrip,Bm)




   do_squishy3()


  //N_UL = UBPJ

// zoom it out to fit clip area 


   NRL = UBPJ

   b=Cab(UBPJ)

<<"bounds $b\n"

   NRZ=rowZoom(NRL,nxp,1)

   N_UL =  colZoom(NRZ,nyp,1))

  //N_UL = UBPJ


   NRZ=rowZoom(RL,nxp,1)

  b = Cab(NRZ)

//<<"$b\n"


//  UL =  Transpose(rowZoom(Transpose(NRZ),nyp,1))


  UL =  colZoom(NRZ,nyp,1))

  b = Cab(UL)

//<<"$b\n"

    //N_UL = vrange(NRZ,10,65,10,65)

  //N_UL=imop(N_UL,"laplace")

//  N_UL=imop(N_UL,"sobel")

//  N_UL=imop(UL,"sobel")

  <<"%V$cell_id $ts $range_nm\n"
    //   break;

     showCloudMidAltDBZ()

<<"Done $_proc\n"


  }




  if (f_error() != EOF_ERROR) { 

  setgwob(cell_wo,@VALUE,cell_id,@redraw)
  setgwob(ts_wo,@VALUE,ts,@redraw)
  setgwob(rng_wo,@VALUE,range_nm,@redraw)

 <<"NextCloud $cell_id $nc\n"

   nc++

   }
   else {
       eof_error = 1
       cok = 0
   }
  
    return cok

}


proc backUP()
{

       ba=searchFile(A,"SRI",0,-1)  // find prev SRI block
       where = ftell(A)
       ba=seekLine(A,-1)            // now at parameters line           
       CW = readline(A)
       where = ftell(A)
//<<"$where -->%s$CW \n"
       ba=seekLine(A,-1)            // now at parameters line           
       where = ftell(A)

//<<"DONE BACKUP @ $ba  $where\n"
// should be at data_block
}

proc findNext()
{
       ba=searchFile(A,"SRI",0,1)  // find next SRI block
       where = ftell(A)
       ba=seekLine(A,-1)            // now at parameters line           
       CW = readline(A)
       where = ftell(A)

//<<"$where -->%s$CW \n"

       ba=seekLine(A,-1)            // now at parameters line           
       where = ftell(A)

//<<"DONE BACKUP @ $ba  $where\n"
// should be at data_block

}






/////////////////////////////////////////////////////////////////////////////////////////////

proc Do_range()
{
        if ((E->button == 1) || (E->button == 4)) {
          Lrange_xbin++
        }
        else {
          Lrange_xbin--
        }

         Lrange_xbin->Limit(0,184)        

         range_nm = (Lrange_xbin * 120/185.0) 

         showRange()
         getRangeDBZ()
         plotAltDBZ()

         setgwob(rng_wo,@VALUE,range_nm,@redraw)
}


proc Do_track()
{

      track_id = atoi(getWoValue(find_wo))


<<"looking for $track_id  @ $cell_id\n"

      cell_id = -1

      while (cell_id != track_id) {

      findNext()

      nextParams()


<<"looking for $track_id  @ $cell_id\n"

        if (cell_id == track_id)  {

<<"FOUND $track_id \n"

           backUP()
           //break;
        }


        if (eof_error) {
          break
        }

   // CW = readline(A)    
   // CW = readline(A)
   // CW = readline(A)   

      if (f_error() != EOF_ERROR) { 
        <<"broke on ferror \n"
    //    break
     }

  
        iscok = nextCloud()

        if (iscok) {

<<"showing $cell_id \n"
         showVSFE()
        }

      cell_id = -1

      if (range_nm < 8) {

         break
      }

    }
  


<<"Done $_proc\n"
}

proc Do_alt()
{

        Lalt = Alt

        if ((E->button == 1) || (E->button == 4)) {
        Alt--
        }
        else {
        Alt++
        }

        if (Alt < 0) {
            Alt = 0
        }

        if (Alt >= 120) {
            Alt = 119
        }


        alt_feet = 60000 - (Alt * 500)

        setgwob(alt_wo,@VALUE,alt_feet,@redraw)

        getAltDBZ()

        plotCompDBZ()

        getPeakDBZAlt(Lrange_nbin, Lrange_fbin)
}


proc showCloudMidAltDBZ()
{

  LRmdbz = RL[Malt][::]
  LRtopdbz = RL[Malt][::]

  if ((stSQAlt >= 0) && (stSQAlt < 120)) { 
  LRtopdbz = RL[stSQAlt][::]
  }

}



proc getAltDBZ()
{

  //SRVEC = RS[Alt][::]

//  LR40 = RL[Alt][0:63:]
//  LR40 = getRow(RL,Alt,0,63)
//  LRVEC = vzoom(LR40,256)

    LRVEC = RL[Alt][::]


}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

include "squishy_clouds_graphic"


//  read header

    CW = readline(A)  // read version

<<"version %s$CW\n"

    CW = readline(A)  // read short version

<<"version %s$CW\n"

    CW = readline(A)  // read parameters names

<<"parameter names %s$CW\n"

    CW = readline(A)  // read image array bounds

<<"image array %s$CW\n"


//  read csv image - cloud dbZ

      nextCloud()

      getRangeDBZ()

      redraw()
      plotAltDBZ()
      plotCompDBZ()

      getPeakDBZAlt(Lrange_nbin, Lrange_fbin)

      plotCCV()

   setGwob(buttons,@redraw)





  //msgid = gthreadcreate("CheckMsg")

   setGwindow(aw,@redraw)

   redraw()

int n_ready =0


   while (1) {


    sleep(1)

    <<"Ready! $n_ready\n"

    n_ready++

    setGWOB(nxt_wo,@color,"lightgreen",@name,"NEXT",@redraw)


    E->waitForMsg()

    c_option = E->woname

//<<" checking main loop for msg $c_option $E->woname $E->keyw \n"

  
   if ( slen(c_option) > 2 ) {
<<"got $c_option \n"
    setGWOB(nxt_wo,@color,"green",@name,"Wait",@redraw)

   }
   

    if (c_option @= "QUIT") {
         break
    }

    if (c_option @= "EXIT") {
         break
    }


    if (c_option @= "NEXT") {
 

     <<"got <|$c_option|> keyw $E->keyw $E->woname $E->woval $E->button\n"

      nextCloud()

      showVSFE()

      last_cell_id = cell_id

      setgwob(find_wo,@VALUE,cell_id,@redraw)

    }


    if (c_option @= "FIND") {

      find_cell_id = atoi(E->wovalue)

      <<"$E->wovalue %V$find_cell_id \n"

/{
//      find_cell_id = 51
      last_cell_id = find_cell_id

      if (find_cell_id > 0) {
      nextCloud()

// skip manuals

    
      while (cell_id != find_cell_id) {

         nextCloud()

//       plotRab()
//       getRangeDBZ()
//       plotAltDBZ()
//       showVSFE()

       }

       showVSFE()
       last_cell_id = cell_id
     }
/}


    }


    if (c_option @= "TRACK") {
           Do_track()
 
    }

    if (c_option @= "WRITE_VS") {
           write_vs()
     }

    if (c_option @= "PREV") {

    // have to search/seek back two data blocks
       backUP()
       backUP()

      nextCloud()

      showVSFE()

    }


     if (c_option @= "ALT_INC") {
           Do_alt()
     }


     if (c_option @= "RANGE_NM") {
            Do_range()
      }


    c_option = "" ;  // done now reset

   

  

    if (f_error() == EOF_ERROR)  {
     <<" EOF \n"
       break;
    }



   }


    w_delete({aw,cw,aw2})
    stop!
    exit_gs()


/////////////////////////////////////////////////////////
// TBD
//
//  SQUISHY3
//
//  median filter for reflect point --- sinfo update - plot this for range - obtain for stormtop slice
//  plot vertical extent of cloud at cloud-center?
//  cloud width?

//  segment thresholding
//

// algorithm has two components
// (1) locate cloud  --- look at extents and its reflectivity profile with height --
       find vertical center -- or knee height - inflection where reflectivity starts to decrease
       use that as the squishy compression point
       what if the start and end of cloud either at ground or above the tilt angle --- have to guess the ends
       extend the ceiling ?

   (2) given range from aircraft use simple projection schem to compress the cloud proportional to the beam spread

       would like may to locally integrate (window the reflectivity - kinda deconvolve the reflectivity)


//   want for Squishy4 to try neural net
//   for squishy5 --- try deconvolve in power domain -- remove any prior smoothing


//  csv file for output measures - done add error measures - rms score 10-80 nmiles

// fix fill symbol
// need symbol plot outside of clip area
//
// need image_plot for 2D array --- takes care of zooming 
// fix resize -- Wo buttons -- disappear
//
// need spatial image filter to get core boundaries

// need map - showing locations of clouds and ac track
// need range bearing of cloud from ac and lat,lng of cloud and/or ac
// need aircraft track/heading

//  scale range slice - plot over SR window - done 
//  range -slice add axnum
//  next screen plot SR in non-zoomed window - check ground-removal

//////////////////////////// SIGNAL-PROCESSING TBD ////////////////////

(1) sanity check given range, and lat,lon position

(2) make input reflectivity cloud  image for comparison

(3) show a beam - convolution and deconvolution operation for comparison with radar

(4) is there a deconvolution type operation 
         that could be done on the smoothed coarsely sampled relfectivity slice ?
         or is that just unstable


(5) how best to find cloud-base middle for compression ? average 3 vertical neighbouring slices?
    check gradient 

(6) how we determine that top has been clipped  and adjust mid-compression point


(7) can the compression operation put back the reflectivity profile


(8) what is the goal ---- best determination of how much dbz near freezing level
    how about in winter?

(9) need good resolution of the top?


(10) check with anvil, nasa1,2 real wx files





















////////////////////////////   FIX /////////////////////////
//  read CSV comma after last value in row -- OK??
//  WoSymbol ---- not filling only outline
//  Redimn --- XIC version fails?
//  TS time string has trailing comma - use del version of split FIXED 
//  skipLines   FIXED


//     GW
// last window -- not in window list ?
// prints only on SCREEN 1 ?