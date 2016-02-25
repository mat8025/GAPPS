//  test some ways of plotting an image file
//  in this case input csv file Rows x Cols of float values 
//  input 120 x 256 cells between 0- 100 in value

setdebug(0)

opendll("image","plot")

BF=ofw("cloud_debug")

////////////////////////////////////////////////  GLOBALS ///////////////////////////////////////////////////////
// some used in graphic plots

ALTVEC = vgen(FLOAT,120,0,1)


float Strm_r[80] ;  // can we make this dynamic for a gline ?
float Strm_t[80] ;  
int sti = 0;


float SRADBZ[120]
float LRADBZ[120]
float LRNADBZ[120]
float LRXADBZ[120]

float R[]
float RS[]
float RL[]

float NRZ[]

float SRVEC[]
float LRVEC[]
float Lrip[]

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

int cell_id = -1
int last_cell_id = -1

float range_nm = 0
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





///////////////////////////////////////  CL_ARGS /////////////////////////////////////////////////////

fn = _clarg[1]

<<"$fn \n"

  A= ofr(fn)



///////////////////////////////////////////////////////////////////////////////////////////////////////


include "clouds_graphic"


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

     CCRV = CCV * 1.2 * km2nm 
} 



proc stormTop()
{
// FIX string arg not being passed correctly

//  stAlt = findVal(LRADBZ, 18,0,1,0,"<=")  // last index which is less than = 18 ?
//  5 is <= 

  stAlt = findVal(LRADBZ, 18,0,1,0, 5)  // last index which is less than = 18 ?

//<<"$LRADBZ \n"

  r_alt = 60000 - stAlt * 500

   <<"%V$stAlt $r_alt \n"
  setgwob(stormtop_wo,@VALUE, r_alt,@redraw)

  Strm_t[sti] = r_alt / 500 

  Strm_r[sti] = range_nm/120.0 * 185

//<<"$Strm_r \n"
//<<"$Strm_t \n"

  sti++
//<<"$LRADBZ\n"

}





proc getRangeDBZ()
{

//  SRADBZ = RS[::][Srange]
  float ADBZ[120]

//  ADBZ = RL[::][Lrange_bin]    // TBD FIX!!


    ADBZ = getCol(RL,Lrange_bin)



  b = Cab(ADBZ)

//<<"bounds ADBZ $b\n"
//<<"$LRADBZ\n"

// seems to break on redimn ??
 // Redimn(ADBZ) // make vector

//  b = Cab(LRADBZ)
//<<"bounds LRADBZ $b\n"


  LRADBZ = ADBZ

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

<<"deconvolve \n"
<<"$LRNADBZ \n"
<<"Bm\n $Bm\n"
  Lbm= dconvolve(LRNADBZ,Bm)
<<"Lbm \n"
<<"$Lbm \m"

    LRNADBZ = Lbm


b=Cab(LRNADBZ)

//<<[BF]"LRADBZ $b  %V$Lrange_nbin\n"
//<<[BF]"LRNADBZ\n$LRNADBZ \n"

//  ADBZ = RL[::][Lrange_xbin]

  ADBZ = getCol(RL,Lrange_xbin)

  LRXADBZ = ADBZ

  LRXADBZ->Limit(0,100)
//<<"LRADBZ \n $LRADBZ \n"


    stormTop()


    Alt = stAlt + 20

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



<<"%V$range_nm $start_r $end_r $cell_id $cell_lat $cell_lng\n"

        Lrange_bin =  (range_nm * nm2km * 1000) / 1200 

        Lrange_nbin = (start_r * nm2km * 1000) / 1200 

        Lrange_fbin = (end_r * nm2km * 1000) / 1200 



<<"%V$Lrange_nbin $Lrange_bin $Lrange_fbin\n"



}



proc nextCloud()
{

  nc++
  cell_id = 40000

  while (cell_id >= 40000) {


    nextParams()

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


  NRZ=rowZoom(RL,nxp,1)

  b = Cab(NRZ)

//<<"$b\n"


//  UL =  Transpose(rowZoom(Transpose(NRZ),nyp,1))


  UL =  colZoom(NRZ,nyp,1))



  b = Cab(UL)

//<<"$b\n"


  N_UL = vrange(NRZ,10,65,10,65)
  //N_UL=imop(N_UL,"laplace")

  N_UL=imop(N_UL,"sobel")


  //N_UL=imop(UL,"sobel")
  <<"$cell_id $ts $range_nm\n"

    
    //   break;
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
   }
  
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

       ba=searchFile(A,"SRI",0,1)  // find prev SRI block
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




//  A= ofr("vfe_SRI_20100714_231135.csv")
//  B= ofr("vfe_LRI_20100714_231135.csv")


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

     if (track_id > 0) {

      while (cell_id != track_id) {

      findNext()
      nextParams()

<<"looking for $track_id  found $cell_id\n"

        if (cell_id == track_id)  {
           backUP()
           break;
        }


        if (eof_error) {
          break
        }

    CW = readline(A)    
    CW = readline(A)   
    CW = readline(A)   

      }
  
     while (1) {

      nextCloud()

      showVSFE()
        if (eof_error) {
          break
        }
        if (cell_id == 0) {
         <<" bad cell \n"
         break
        }
      }
    }
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



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

   msgid = gthreadcreate("CheckMsg")


   while (1) {


    sleep(1)

    <<"Ready! \n"
    setGWOB(nxt_wo,@color,"lightgreen",@name,"NEXT",@redraw)
    E->waitForMsg()

//<<"keyw $E->keyw $E->woname $E->woval $E->button\n"


    if (! (E->keyw @= "NO_MSG")) {

           setGWOB(nxt_wo,@color,"red",@name,"Wait",@redraw)


    if (E->woname @= "QUIT") {
         break
    }


    if (E->woname @= "NEXT") {

      nextCloud()

      showVSFE()

      last_cell_id = cell_id

    }

    if (E->woname @= "FIND") {

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

    if (E->woname @= "TRACK") {
           Do_track()
     }

    if (E->woname @= "PREV") {

    // have to search/seek back two data blocks
       backUP()
       backUP()

      nextCloud()

      showVSFE()

    }


    if (E->woname @= "ALT_INC") {
           Do_alt()
     }


    if (E->woname @= "RANGE_NM") {
            Do_range()
      }

   }

    if (f_error() == EOF_ERROR)  {
     <<" EOF \n"
       break;
    }

   }


    w_delete({aw,cw,aw2})


/////////////////////////////////////////////////////////
// TBD
// fix fill symbol
// need symbol plot outside of clip area
//
// need image_plot for 2D array --- takes care of zooming 
// fix resize -- Wo buttons -- disappear
//
// need spatial image filter to get core boundaries
// need next button - done
// need previous VS  - done

// need map - showing locations of clouds and ac track
// need range bearing of cloud from ac and lat,lng of cloud and/or ac
// need aircraft track/heading

//  scale range slice - plot over SR window - done 
//  range -slice add axnum
//  next screen plot SR in non-zoomed window - check ground-removal



////////////////////////////   FIX /////////////////////////
//  read CSV comma after last value in row -- OK??
//  WoSymbol ---- not filling only outline
//  Redimn --- XIC version fails?
//  TS time string has trailing comma - use del version of split FIXED 
//  skipLines   FIXED


//     GW
// last window -- not in window list ?
// prints only on SCREEN 1 ?