/////////////////////////////////////
//      SQUISHY_3          
//
setdebug(0)

opendll("uac")

float RS[]
float RL[]

float NRZ[]

float SRVEC[]
float LRVEC[]
float Lrip[]

uchar ULI[]
uchar UBDC[]
uchar UBPJ[]
uchar BP[120][1]

double Bm[] 

double R[]   // recovered signal
double Op[]

float Inpat[]
float Spat[]
float Dpat[]

float LRADBZ[120]

int Lrange_bin = 50      // long range bin

const float nm2km = 1.852
const float km2nm = 1.0/nm2km

XV = vgen(FLOAT,300,0,1)

//////////////////////////////////////

double pwr

//  SQUISHY VIA BACK-PROJECTION
//  segment the cloud
//  find mid-pts of the segements
//  back-project to squish around mid-point
//  typically cloud will be one segment
//  if there is a cloudtop below 60K and cloud-base above ground
//  should be able to compensate for range dependent smear
//  find these edges - mid-point and compress

//  TBD show original ?? from eaglesim


int Nalt = 120

////////////////////////  SQUISHY via back-projection //////////////////////////////

// FIXME
int mid_point =85
float S[120]
float cloud_range = 80
float screen_range = 30


proc p_squishy3( rng)
{
<<"%V$rng

RS = Inpat
int n_alt = 120
int isq
int jsq
int k
int ki = 0;
  C = Inpat
  cloud_range = rng
  S= 0

  for (isq = 0; isq < 120; isq++) {

   if (rng <= screen_range) {
      RS[isq]  = C[isq]
   }
   else {
     if (C[isq] > 0) {

        jsq = abs(isq-mid_point)

        ang = r2d(atan(jsq/cloud_range))

        k = (screen_range * tan(d2r(ang)) + 0.5)
//<<"$i $j $ang $k\n"


        if (isq > mid_point) {
          ki = mid_point+k;
        }
        else {
          ki = mid_point-k;
        }

        if ((ki < n_alt) && (ki >= 0)) {
               S[ki] = C[isq];
<<"set $ki to $C[isq] \n"
        }
     }
    }

  }




}



//proc find_be(float X[],n)
proc find_be()
{

int sr = 0
int er = 0
int j
int pts[4]
int n = 120
X= Inpat

//<<"$X\n"
float tot = 0;
  for (j=1 ; j < n ; j++) {

    if (sr < 10) {
      //<<"check start $j \n"
      if ((X[j-1] <= 10) && (X[j] > 10)) {
         sr = j
      }
    }
    if (sr >= 10) {

        tot += X[j]

    }


    if ((X[j] <= 5) && (X[j-1] > 5)) {
       er = j
    }
  }

  mp = 0
  av = 0.0;
  seg_len = 0
  if (er > sr) {
  seg_len = (er-sr)
  mp = sr + (er-sr)/2
  av = tot/ seg_len
  }

  if ((sr > 10) && (seg_len > 20) && (av > 15)) {

<<"%V$sr $er $seg_len $mp $av\n"

// i_read()
// try adjust the mid-point to vertical center of cloud -- track this ??
   mid_point = mp
  }

  pts[0] = sr
  pts[1] = er
  pts[2] = mp
  pts[3] = seg_len
  return pts

}


float r_alt;
int stAlt

proc stormTop()
{



// FIX string arg not being passed correctly

//  stAlt = findVal(LRADBZ, 18,0,1,0,"<=")  // last index which is less than = 18 ?
//  5 is <= 

  stAlt = findVal(LRADBZ, 18,0,1,0, 5)  // last index which is less than = 18 ?

//<<"$LRADBZ \n"

  r_alt = 60000- ( stAlt * 500)

//   <<"%V$stAlt $r_alt \n"
  //setgwob(stormtop_wo,@VALUE, r_alt,@redraw)

  //Strm_t[sti] = r_alt / 500 

  //Strm_r[sti] = range_nm/120.0 * 185

//<<"$Strm_r \n"
//<<"$Strm_t \n"

 // sti++
//<<"$LRADBZ\n"

}



///////////////////////////////////////////////////////////////////////////////////



//  read in a cloud at range x nmiles - that has been through the eaglesim and has the beam spread built in

///////////////////////////////////////  CL_ARGS /////////////////////////////////////////////////////

fn = _clarg[1]

<<"$fn \n"

  A= ofr(fn)

  Hdr = readline(A)

    
        wds =split(Hdr,',')

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

// the range of the clouds does not look correct!!
//  this is because cloud lat,lng is lower,left corner so it is an edge
        range_nm -= 5


        Lrange_bin =  (range_nm * nm2km * 1000) / 1200 

       

        Lrange_nbin = (start_r * nm2km * 1000) / 1200 

        Lrange_fbin = (end_r * nm2km * 1000) / 1200 


<<"%V$Lrange_nbin $Lrange_bin $Lrange_fbin\n"


  RL = readRecord(A,@del,',',@nrecords,120)

  b = Cab(RL)

  <<"bounds $b \n"

  RL->limit(0,75)



  for (alt = 20; alt < 100; alt++) {
        LRVEC_1 = RL[alt][::]
//   <<"%6.1f$LRVEC_1\n"
  }





//i_read()



 // NRL = colZoom(RL,240,1)
  NRL = RL
  NRL->limit(0,85)


   b = Cab(NRL)
//  <<"bounds $b \n"

   b = Cab(LRVEC_1)
//  <<"bounds LRVEC_1 $b \n"

   LRVEC = NRL[0][::]

   b = Cab(LRVEC)
//  <<"bounds LRVEC $b \n"



  for (alt = 20; alt < 60; alt++) {
   LRVEC_1 = RL[alt][::]
   //<<"%(10,, ,\n)6.1f$LRVEC_1\n"
   LRVEC = NRL[alt*2][::]
   //<<"%(10,, ,\n)6.1f$LRVEC\n"
//i_read()   
  }

<<"check NRL \n"

//i_read()


   ULI = NRL
   UBPJ = NRL

  b = Cab(ULI)

  <<"bounds $b \n"

   RBF = NRL
   RBD = NRL


   Inpat = RBF[::][20] 

   Redimn(Inpat)

//<<"$Inpat \n"




// for each nmile do the despread

   bw = 2

   start_nm = 10



include "squishy3_graphic.asl"


//  plot image

  //plotPixRect(lri_wo,ULI,mapi,0,240,1)

    


// measure cloud top & bottom




si_pause(1)

   end_nm = 100



<<"creating sigi \n"
     sigi_gl=CreateGline(@woid,sigi_wo,@type,"XY",@xvec, XV, @yvec, Inpat, @color, "blue" ,@usescales,0)
     setGwob(sigi_wo,@clipborder,@border)

   
    setGline(sigs_gl,@type,"Y", @yvec, RS, @color, "red" ,@usescales,0)
    setGwob(sigs_wo,@clipborder,@border)
   
text(aw,fn,0.8,0.8)



    plotPixRect(lri_wo,ULI,mapi,0,0)

  //  setgwob(lri_wo,@clear,@border,@showpixmap,@save)
  setgwob(lri_wo,@clipborder,GREEN,@drawon)
  setgwob(lri_wo,@BORDER,RED,@clearpixmap)
  plotPixRect(lri_wo,ULI,mapi)


int xi = 0
int yi = 0

   for (i = 0 ; i < 185 ; i++) {

      //<<"%V$i smear-backproject \n"


   Inpat = RBF[::][i]  // an altitude column 

   Redimn(Inpat)

//<<"$(Caz(Inpat)) \n"

// show Ip


   setGwob(sigi_wo,@clearpixmap)
   setGline(sigi_gl,@draw)
   setGwob(sigi_wo,@showpixmap)


// run Squishy transform


   wpts = find_be(Inpat,120)

//<<"$wpts \n"
   wr = (i * 1200)/1000.0 * km2nm
  
   cloud_mp = wpts[2]
   if (wpts[3] < 7) {
    cloud_mp = 0
   }

   plotSymbol(lrist_wo,wr,wpts[2],"diamond",5,GREEN)


    RS = squishy3(Inpat,i,cloud_mp,screen_range)
   // RS = squishy3(Inpat,i,mid_point,screen_range)

   // p_squishy3(i)

//<<"$(typeof(RS)) \n"
//b = Cab(RS)
//<<"bounds $b\n"

<<"squished output \n"

//<<"%(10,, ,\n)$RS\n"
<<"//////////////////////////////////////\n"

//i_read()





   setGwob(sigs_wo,@clearpixmap)
   setGline(sigs_gl,@draw)
   setGwob(sigs_wo,@showpixmap)


   RBD[::][i] = RS[0:-1]

// show BP

   BP[::][0] = RS[0:-1]
   UBPJ[::][i] = RS[0:-1]


   plotPixRect(lrbpj_wo,BP,mapi,xi,yi)


  if (i > 1) {
  TRL = ULI
  LRADBZ = getCol(TRL,i-1)
  stormTop()
  top_alt = r_alt/1000 * 2
  if (top_alt < 120) {
  plotSymbol(lrist_wo,wr,top_alt,"diamond",5,RED)
  }
  TRL = UBPJ
  LRADBZ = getCol(TRL,i-1)
  stormTop()
  top_alt = r_alt/1000 * 2
  if (top_alt < 120) {
  plotSymbol(lrbpjst_wo,wr,top_alt,"diamond",5,RED)
  }
  }

   xi++

   //setgwob(lrbpj_wo,@border,@showpixmap,@drawon)

  }






  ///////////////////////////////// STORMTOP //////////////////////
  // should do this for three cols and average  
///////// for RAW

  TRL = ULI

  ADBZ = getCol(TRL,Lrange_bin)

// seems to break on redimn ??
 // Redimn(ADBZ) // make vector

//  b = Cab(LRADBZ)
//<<"bounds LRADBZ $b\n"

  LRADBZ = ADBZ

  stormTop()

<<"raw %V$r_alt \n"

  text(aw,"$r_alt",0.8,0.7)

  top_alt = r_alt/1000 * 2


  setgwob(lri_wo,@clipborder,GREEN,@drawon)
  setgwob(lri_wo,@BORDER,RED,@clearpixmap)
  plotPixRect(lri_wo,ULI,mapi)

  plotline(lri_wo,range_nm,0,range_nm,120,RED)

  plotline(lri_wo,0,top_alt,120,top_alt,RED)

  //setgwob(lrbpj_wo,@showpixmap,@save)

  //plotPixRect(lri_wo,ULI,mapi)
 
  //plotline(lri_wo,range_nm,0,range_nm,120,RED)


//////////////////////////////////////////////////////



  TRL = UBPJ

  ADBZ = getCol(TRL,Lrange_bin)
  LRADBZ = ADBZ

  stormTop()

<<"squished %V$r_alt \n"

  text(aw,"$r_alt",0.8,0.6)

  top_alt = r_alt/1000 * 2

  setgwob(lrbpj_wo,@clipborder,GREEN,@drawon)
  setgwob(lrbpj_wo,@BORDER,RED,@clearpixmap)

  plotline(lrbpj_wo,range_nm,0,range_nm,120,RED)

  plotline(lrbpj_wo,0,top_alt,120,top_alt,RED)

  //setgwob(lrbpj_wo,@showpixmap,@save)


  setgwob(lrbpj_wo,@BORDER,@drawoff,@clearpixmap)

 // plotPixRect(lrbpj_wo,UBPJ,mapi)
 
  plotline(lrbpj_wo,range_nm,0,range_nm,120,RED)

  plotline(lrbpj_wo,0,top_alt,120,top_alt,RED)


//  setgwob(lrbpj_wo,@border,@showpixmap)


////////////////////////////////////////////////////////////////////////////////////

  setGwindow(aw,@save)

  si_pause(3)


// measure cloud top & bottom
// plot


//  compare raw and squished ---- top and bottom in right place






stop!