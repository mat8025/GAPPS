//  test some ways of plotting an image file
//  in this case input csv file Rows x Cols of float values 
//  input 120 x 256 cells between 0- 100 in value

include "event"

Event E

setdebug(0)

//opendll("math","image","plot")

opendll("image","plot")

BF=ofw("cloud_debug")

ALTVEC = vgen(FLOAT,120,0,1)

float SRADBZ[120]
float LRADBZ[120]
float LRNADBZ[120]
float LRXADBZ[120]

float R[]
float RS[]
float RL[]

float NRZ[]

uchar U[]

uchar UL[]

uchar N_UL[]

const float nm2km = 1.852
const float km2nm = 1.0/nm2km


int skip_manuals = 0

last_msg = "XX"

proc CheckMsg()
{

  tid = GthreadGetId()

  int nl = 0

  while (1) {

    w_activate(vp)

    E->Read()

    msg = E->keyw

    dcont = 0

    if ( ! (msg @= "NO_MSG") ) {
       <<"$nl <<$msg>> \n"
        zmn = msg 
//       dcont = Controls()
       if (last_msg @= "XX") {
        last_msg = msg
      }
    }    


    <<"$nl <<$msg>> \n"
    nl++
    sleep(1.0)

   }


  GthreadExit(tid)

}




proc redraw()
{
  
  setgwob(lri_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lri_wo,UL,mapi)
 
  plotPixRect(lrip_wo,N_UL,mapi,0,0)

  setgwob(lri_wo,@clear,@border,@showpixmap,@drawon)

  plotsymbol(lri_wo,range_nm,60,"diamond",5,RED,0)
  plotWosymbol(lri_wo,start_r,-5,"diamond",10,GREEN,0)
  
  plotWosymbol(lri_wo,end_r,-5,"diamond",10,BLUE,0)
  plotWosymbol(lri_wo,range_nm,-5,"diamond",10,RED,0)

  ky = -5



  setgwob(sri_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(sri_wo,U,mapi)

  setgwob(sri_wo,@clear,@border,@showpixmap,@drawon)

  plotsymbol(sri_wo,range_nm,60,"triangle",5,RED,0)

  plotWosymbol(sri_wo,start_r,-5,"diamond",10,GREEN,0)
  plotWosymbol(sri_wo,end_r,-5,"diamond",10,BLUE,0)
  plotWosymbol(sri_wo,range_nm,-5,"diamond",10,RED,0)


  axnum(lri_wo,1,0,100,20,1)
  axnum(sri_wo,1,0,40,5,1)

}



proc plotAltDBZ()
{

  //setgwob(adbz_wo,@BORDER,@drawoff,@clearpixmap)
setgwob(adbz_wo,@BORDER,@drawon,@clearpixmap)
//b = Cab(LRADBZ)
//<<"$b \n"
//<<"$LRADBZ\n"

  DrawGline(adbz_gl)
  DrawGline(ndbz_gl)
  DrawGline(xdbz_gl)

  plotWosymbol(adbz_wo,18,stAlt,"diamond",10,GREEN,0)
  setgwob(adbz_wo,@clear,@border,@showpixmap,@drawon)
 

        alt_feet = 60000 - (Alt * 500)
        setgwob(alt_wo,@VALUE,alt_feet,@redraw)
        axnum(adbz_wo,1,-5,75,20,1)

 setgwob(adbz_wo,@scales,-5,0,90,60,@savescales,0)

        axnum(adbz_wo,4,0,60,10,-2)

 setgwob(adbz_wo,@scales,-5,120,90,0,@savescales,0)
 

}


float last_xrange =0

proc showRange()
{
// should use a WO SYMBOL TYPE
  xrange = (Lrange_xbin * 120/185.0) 

// plotWosymbol(lri_wo,-2,(120-Lalt),"diamond",10,WHITE,0)

  plotWosymbol(lri_wo,last_xrange,-3,"diamond",8,WHITE,0)
  plotWosymbol(lri_wo,xrange,-3,"diamond",8,"cyan",0)

  last_xrange = xrange

}

proc plotCompDBZ()
{

  setgwob(cdbz_wo,@BORDER,@drawoff,@clearpixmap)

  DrawGline(srdbz_gl)
  DrawGline(lrdbz_gl)

  plotWosymbol(sri_wo,-2,(120-Lalt),"diamond",10,WHITE,0)
  plotWosymbol(sri_wo,-2,(120-Alt),"diamond",10,GREEN,0)

  setgwob(cdbz_wo,@clear,@border,@showpixmap,@drawon)
  alt_feet = 60000 - (Alt * 500)
  setgwob(alt_wo,@VALUE,alt_feet,@redraw)
}


proc getAltDBZ()
{

  SRVEC = RS[Alt][::]

//  LR40 = RL[Alt][0:63:]

   LR40 = getRow(RL,Alt,0,63)


  LRVEC = vzoom(LR40,256)

}

int Palt = 10
float PA[185]
float PkDBZrange = 0
int mmi[2]

int CCV[120]
float CCRV[120]

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
<<"%V$PkDBZrange \n"
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
<<"%V$b \n"

     maxi = cv[Alt]
     maxval = RL[Alt][maxi]

<<"%V$maxi $maxval\n"

     CCV =cv

     CCRV = CCV * 1.2 * km2nm 
} 


proc plotCCV()
{
<<"cloud peak DBZ vec\n"
//<<"%V$CCV\n"
//<<"%V$CCRV\n"

 setgwob(pkdbzr_wo,@BORDER,@drawon,@clearpixmap)

     DrawGline(pkdbzr_gl)

 setgwob(pkdbzr_wo,@BORDER,@drawon,@showpixmap)
      axnum(pkdbzr_wo,1,0,120,20,0.5)
 setgwob(pkdbzr_wo,@scales,-5,0,90,60,@savescales,0)
        axnum(pkdbzr_wo,4,0,60,10,-2)
 setgwob(pkdbzr_wo,@scales,0,0,120,120,@savescales,0)

}




int stAlt = 0

proc stormTop()
{

  stAlt = findVal(LRADBZ, 18,0,1,0,"<=")
  setgwob(stormtop_wo,@VALUE,(60000-stAlt*500),@redraw)
//<<"$LRADBZ\n"

}


proc  plotRab()
{
// range and bearing

   float x1
   float y1
   //float ang = ((bearing + ac_hdg) % 360)


   x1 = range_nm * sin(deg2rad(bearing))
   y1 = range_nm * cos(deg2rad(bearing))

   setgwob(rab_wo,@CLEAR,@BORDER)
   plotLine(rab_wo,0,0,x1,y1,RED)
   //<<"$x1 $y1 "

}

proc showVSFE()
{
      redraw()

      getRangeDBZ()
      plotAltDBZ()
      plotCompDBZ()

      getPeakDBZAlt(Lrange_nbin, Lrange_fbin)
      plotRab()
      plotCCV()
}





int Lrange_bin = 50      // long range bin
int Lrange_nbin = 45      // long range near bin
int Lrange_fbin = 45      // long range far bin
int Lrange_xbin = 180      // selectable bin

float yf = 0.25

proc getRangeDBZ()
{

//  SRADBZ = RS[::][Srange]
  float ADBZ[120]

//  ADBZ = RL[::][Lrange_bin]    // TBD FIX!!
    ADBZ = getCol(RL,Lrange_bin)

/{
  for (k = 0; k < 120; k++) {
    ADBZ[k] = RL[k][Lrange_bin]
//<<"$k $ADBZ[k]\n"
  }

/}

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
    ADBZ = getCol(RL,Lrange_nbin)
b=Cab(ADBZ)
//<<[BF]"ADBZ $b\n"

  LRNADBZ = ADBZ
b=Cab(LRNADBZ)
//<<[BF]"LRADBZ $b  %V$Lrange_nbin\n"
//<<[BF]"LRNADBZ\n$LRNADBZ \n"

//  ADBZ = RL[::][Lrange_xbin]

  ADBZ = getCol(RL,Lrange_xbin)

  LRXADBZ = ADBZ

  //LRADBZ = vgen(FLOAT,120,-5,yf)
  //yf += 0.2

    stormTop()
    Alt = stAlt + 20
    if (Alt >=120) {
        Alt = 119
    }
}








int Alt = 80
int Lalt = 80

int nc = 1
int eof_error = 0

proc nextCloud()
{

  nc++
  cell_id = 40000

  //while (cell_id == 40000) {

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



//<<"%V$range_nm $start_r $end_r $cell_id $cell_lat $cell_lng\n"

        Lrange_bin =  (range_nm * nm2km * 1000) / 1200 
        Lrange_nbin = (start_r * nm2km * 1000) / 1200 
        Lrange_fbin = (end_r * nm2km * 1000) / 1200 
//<<"%V$Lrange_nbin $Lrange_bin $Lrange_fbin\n"

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


  LR40 = RL[Alt][0:63:]

  LRVEC = vzoom(LR40,256)

  NRZ=rowZoom(RL,nxp,1)

  b = Cab(NRZ)

//<<"$b\n"


  UL =  Transpose(rowZoom(Transpose(NRZ),nyp,1))

  b = Cab(UL)

//<<"$b\n"


  N_UL = vrange(NRZ,10,65,10,65)
  //N_UL=imop(N_UL,"laplace")

  N_UL=imop(N_UL,"sobel")


  //N_UL=imop(UL,"sobel")
  <<"$cell_id $ts $range_nm\n"

    
    //   break;
 // }

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


/{
//<<"START BACKUP %V$ba $where\n"
       CW = readline(A)
       where = ftell(A)
//<<"$where -->%s$CW \n"
       ba=seekLine(A,-1)            // backup
       where = ftell(A)
//<<"%V$ba $where\n"
       CW = readline(A)
       where = ftell(A)
//<<"$where -->%s$CW \n"

       ba=seekLine(A,-4)            // backup
       where = ftell(A)
//<<"%V$ba $where\n"
       CW = readline(A)
//<<"start_of_data_block %s$CW \n"
      ba=seekLine(A,-1)            
<<"%V$ba\n"
/}


   where = ftell(A)

//<<"DONE BACKUP @ $ba  $where\n"
// should be at data_block
}



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

int    ac_alt = 0




str ts





fn = _clarg[1]

<<"$fn \n"

  A= ofr(fn)


//  A= ofr("vfe_SRI_20100714_231135.csv")
//  B= ofr("vfe_LRI_20100714_231135.csv")





/////////////////////////////// Color Map ------- Cloud dbZ
///////////////////////////////

mapi = 100

mapki = mapi
// black



 rgb_v = getRGB("BLACK")
<<"$rgb_v BLACK\n"

// 0 - 10 dBZ
 for (i = 0; i < 5; i++) {

  setrgb(mapki,rgb_v[0],rgb_v[1], rgb_v[2])
  mapki++

 }

    pi = getColorIndexFromName("lightblue")

 for (i = 5; i < 10; i++) {
  setrgbfromIndex(mapki,pi)
  mapki++
 }




// 5-15

    pi = getColorIndexFromName("skyblue")

 rgb_v = getRGB("skyblue")
<<"$rgb_v SKYBLUE\n"

<<"%V$pi  Skyblue\n"


 for (i = 10; i < 15; i++) {

    setrgb(mapki,rgb_v)

    r_rgb_v = getRGB(mapki)

//   <<"$mapki $r_rgb_v \n"

    mapki++
 }







// 15 -20  BLUE

 for (i = 15; i < 20; i++) {
  setrgbfromIndex(mapki,BLUE)
  mapki++
 }


    pi = getColorIndexFromName("green")

 for (i = 20; i < 30; i++) {
  setrgbfromIndex(mapki,pi)
  mapki++
 }


 for (i = 30; i < 40; i++) {
  setrgbfromIndex(mapki,YELLOW)
  mapki++
 }



// red



 pi = getColorIndexFromName("red")
<<"%V$pi 40-50  RED\n"

 for (i = 40; i < 50; i++) {
    setrgbfromIndex(mapki,RED)
    mapki++
 }



// white

// 45 ->>

  pi = getColorIndexFromName("purple")
//<<"%V$pi\n"

 for (i = 50; i < 65; i++) {
    setrgbfromIndex(mapki,pi)
    mapki++
 }

  pi = getColorIndexFromName("white")
//<<"%V$pi white\n"

 for (i = 65; i < 200; i++) {
    setrgbfromIndex(mapki,WHITE)
    mapki++
 }




/////////////////////////////////////////////////////////////////



/////////////////////// BUTTONS ////////////////////////////////////////////////////
//  use  a control window
//
    fstem = sele("$fn",0,-4)
<<"%V$fstem\n"
    cw= CreateGwindow(@title,"CW_$fstem")

    SetGwindow(cw,@resize,0.01,0.01,0.95,0.14,0)
    SetGwindow(cw,@drawon,@pixmapon,@save,@sticky,1,@fname,"$fn")
    SetGwindow(cw,@clip,0.1,0.12,0.95,0.9,@redraw)

   cell_wo=createGWOB(cw,"BV",@name,"CELL_ID",@color,"green",@clipbhue,"blue")

   find_wo=createGWOB(cw,"BV",@name,"FIND",@color,"cyan")

   ts_wo=createGWOB(cw,"BV",@name,"TIME",@color,"green",@clipbhue,"green")

   rng_wo=createGWOB(cw,"BV",@name,"RANGE_NM",@color,"white",@clipbhue,"red")

   stormtop_wo=createGWOB(cw,"BV",@name,"TOP_FEET",@color,"white",@clipbhue,"skyblue")

   alt_wo=createGWOB(cw,"BV",@name,"ALT_INC",@VALUE,80,@color,"orange")

   setgwob({cell_wo,ts_wo,rng_wo,stormtop_wo,alt_wo},@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@VALUE,0,@STYLE,"SVB")
   setgwob(find_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@VALUE,-1,@func,"bell")

   nxt_wo=createGWOB(cw,"BV",@name,"NEXT",@VALUE,"NEXT",@color,"orange")
   setgwob(nxt_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   prev_wo=createGWOB(cw,"BN",@name,"PREV",@VALUE,"ON",@color,"pink")
   setgwob(prev_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   track_wo=createGWOB(cw,"BN",@name,"TRACK",@VALUE,"ON",@color,"pink")
   setgwob(track_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)


   quit_wo=createGWOB(cw,"BN",@name,"QUIT",@VALUE,"QUIT",@color,"red")
   setgwob(quit_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   wo_htile({cell_wo,ts_wo,rng_wo,alt_wo,stormtop_wo,nxt_wo,prev_wo, find_wo, track_wo,quit_wo},0.02,0.15,0.9,0.85,0.02)

   int buttons[] = {cell_wo,ts_wo,rng_wo,nxt_wo,prev_wo,alt_wo,track_wo, quit_wo, find_wo, stormtop_wo}

   setGwob(buttons,@redraw)

/////////////////////////////////////////////////////////////////////////////////////



// Window
int sri_nxp
int sri_nyp


int CI[]


    aw= CreateGwindow(@title,"CLOUD_SWEEP")

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.01,0.15,0.95,0.95,0)
    SetGwindow(aw,@drawon,@pixmapon,@save)
    SetGwindow(aw,@clip,0.1,0.1,0.95,0.9)

//////////////////////////////// CLOUD SWEEP SCREEN 2 //////////////////////////////////////



    aw2= CreateGwindow(@title,"CLOUD_SWEEP2")

    SetGwindow(aw2,@resize,0.01,0.15,0.95,0.95,1)
    SetGwindow(aw2,@drawon,@pixmapon,@save)
    SetGwindow(aw2,@clip,0.1,0.1,0.95,0.9)



  // GraphWo

   cdbz_wo=createGWOB(aw,@GRAPH,@resize,0.1,0.66,0.49,0.98,@name,"CBDZ",@color,"white")
   setgwob(cdbz_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.9,0.9,@scales,0,-5,256,100,@savescales,0)

   sri_wo=createGWOB(aw,@GRAPH,@resize,0.1,0.1,0.49,0.65,@name,"PY",@color,"white")
   lri_wo=createGWOB(aw,@GRAPH,@resize,0.5,0.4,0.85,0.95,@name,"PY",@color,"white")

   adbz_wo=createGWOB(aw,@GRAPH,@resize,0.86,0.5,0.95,0.95,@name,"PY",@color,"white")
   setgwob(adbz_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.9,0.9,@scales,-5,120,90,0,@savescales,0)


   pkdbzr_wo=createGWOB(aw,@GRAPH,@resize,0.5,0.1,0.85,0.39,@name,"PY",@color,"white")
   setgwob(pkdbzr_wo,@drawon,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,120,120,@savescales,0)


   // lri image 185 units of 1200 meters  --- range is 120 nmiles

   setgwob(lri_wo,@drawon,@pixmapon,@save,@clip,0.01,0.1,0.98,0.98,@scales,0,0,120,120,@savescales,0)

   CI =getWoClip(lri_wo)

   nxp = CI[3] - CI[1]

   nyp = CI[4] - CI[2]

<<"%V$nxp $CI[3] $CI[1]\n"

<<"%V$nyp $CI[4] $CI[2]\n"

  //setgwob(lri_wo,@scales,0,0,nxp,120,@savescales,0)


   lrip_wo=createGWOB(aw2,@GRAPH,@resize,0.5,0.02,0.85,0.49,@name,"PY",@color,"white")
   setgwob(lrip_wo,@drawon,@pixmapon,@clip,0.05,0.1,0.98,0.9,@scales,0,0,120,120,@savescales,0)


   rab_wo=createGWOB(aw,@GRAPH,@resize,0.86,0.35,0.95,0.49,@name,"RAB",@color,"white")
   setgwob(rab_wo,@drawon,@pixmapon,@clip,0.05,0.1,0.9,0.9,@scales,-120,0,120,120,@savescales,0)



   setgwob(sri_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.9,0.9,@scales,0,0,40,120,@savescales,0)
   // for pixmap on --- need to first save image
   CI =getWoClip(sri_wo)

   sri_nxp = CI[3] - CI[1]

   sri_nyp = CI[4] - CI[2]











//  pixel size ? 

//  Glines

float SRVEC[]
float LRVEC[]


   srdbz_gl = CreateGline(@wid,cdbz_wo,@type,"Y",@yvec,SRVEC,@color,"red")
   lrdbz_gl = CreateGline(@wid,cdbz_wo,@type,"Y",@yvec,LRVEC,@color,"green")
   //adbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@xvec,ALTVEC,@yvec,LRADBZ,@color,"green",@hue,"red")
   adbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@yvec,ALTVEC,@xvec,LRADBZ,@color,"red")
   ndbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@yvec,ALTVEC,@xvec,LRNADBZ,@color,"green")
   xdbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@yvec,ALTVEC,@xvec,LRXADBZ,@color,"blue")



   pkdbzr_gl = CreateGline(@wid,pkdbzr_wo,@type,"XY",@yvec,ALTVEC,@xvec,CCRV,@color,"red")






   CI =getWoClip(lri_wo)

<<"%V$CI \n"


  //plotPixRect(lri_wo,N_UL,mapi)
  //plotPixRect(sri_wo,U,mapi)


  //plotsymbol(lri_wo,120,60,"triangle",5)




//  axis warping ?



//  image transforms



//  read header

    CW = readline(A)  // read version

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

    E->waitForMsg()

//<<"keyw $E->keyw $E->woname $E->woval $E->button\n"

    if (! (E->keyw @= "NO_MSG")) {

    if (E->woname @= "QUIT") {
         break
    }


    if (E->woname @= "NEXT") {

      nextCloud()

      showVSFE()

      last_cell_id = cell_id

    }

    if (E->woname @= "FIND") {

      nextCloud()

// skip manuals

     while (cell_id >= 4000) {
       nextCloud()
       plotRab()
       getRangeDBZ()
       plotAltDBZ()
       showVSFE()
       }

       showVSFE()
       last_cell_id = cell_id


    }

    if (E->woname @= "TRACK") {

      nextCloud()

      while (cell_id != last_cell_id) {
        nextCloud()
        if (eof_error) {
          break
        }
      }

      showVSFE()

     // if (f_error() == EOF_ERROR)        break;
    }

    if (E->woname @= "PREV") {

    // have to search/seek back two data blocks
       backUP()
       backUP()

      nextCloud()

      showVSFE()

    }


    if (E->woname @= "ALT_INC") {

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



      if (E->woname @= "RANGE_NM") {

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