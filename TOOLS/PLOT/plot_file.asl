#/* -*- c -*- */

setdebug(1)


//  use following line for debug print 
#define DBPR  <<
// else use this for no debug
//#define DBPR  ~!


// our generic Plot script
// default pipe records to script
// or as arg -data foo.dat ?
// choose  Y cols
//
//  using readrecord for ascii data
//  data can be in csv or tab spaced ascii records of n cols
//  
//  for binary data use rdata and select ncols (asl can work out data type)

//  each col can be selectively plotted
//  col 0 (default) can be used as X axis or
//  treat as cols as uniformly spaced -- arg used for delta time, distance


// default option to plot each vector into same graph 
// line type
// line color
// symbols
// grid (have to make line thickness smaller than plot lines)

// option different vectors in different graph windows

// scaling -- auto
// use left and right axis for different scales


// filter data using readrecord pick options


A = ofr("velfftMag.csv")

ncols = 1

int YCOL[10+]

 YCOL[0] = 0
 int ac =2
 int i = 0

 double xmin
 double xmax
 double ymin
 double ymax


i = 1
ncols = i
pars = i

<<" $YCOL \n"

ycol = 1


    R = ReadRecord(A,@type,FLOAT,@ncols,1)
  //  R = ReadRecord(A,@type,ASCII,@ncols,1)

  sz = Caz(R)
  dmn = Cab(R)
  nrows = dmn[0]

<<"%v$nrows \n"

<<"%V$sz $dmn\n"

sz = Caz(R)

// check # cols


  YV = R
    
//      yi = YCOL[0]
//      YV = R[*][yi]

  Redimn(YV)

  sz = Caz(YV)

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  npts = sz[0]


<<"%V8.6f$YV[0:10] \n"

<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

      symin = MM[1] - 5 * MM[4]

      symax = MM[1] + 5 * MM[4]

      ymax = MM[6]
      ymin = MM[5]



      xmin = 0

      xmax = sz[0]-1

  XV = Fgen(sz,0,1)
    
  <<"%V$xmin $xmax \n"


  xrange = fabs(xmax-xmin)
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 

  yr = (ymax-ymin) / 255.0

 // want num of bins  +1  so the ymin values and ymax values fall into a bin and are not excluded


  H = Hist(YV, yr, ymin, ymax) 

  sz = Caz(H)


<<"Hist sz $sz \n $H \n"

  // scale this related to total number of pts

float HS[]

  HS = H
  hs = (1.0 / npts) * 200000

  //  hs = 0.5
<<"Hist scalar $hs \n"

  HS = HS * hs

<<"Hist scaled \n $HS \n"


  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }




  aslw = asl_w("PLOT_Y")


 proc drawScreens()
  {
<<"drawScreens $_cproc \n"
    sWi(aw,@clearclip)
    setGwob(grwo,@clearclip,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)
    setGline(refgl,@draw)
   sWo(fewos,@redraw)

//   setGwob(histwo,@clearclip,@clipborder,@redraw)
//   setGline(histgl,@draw)
  }


////////////////////////KEYW CALLBACKS///////////////////////////////////////
proc EXIT()
{
  exit_gs()
}
//-------------------------------------------
proc REDRAW()
{
  drawScreens()
}
proc MOVE()
{
  drawScreens()
}
//-------------------------------------------
proc RESIZE()
{
  drawScreens()
}
//-------------------------------------------
//---------------------------------------------
proc TimeSeries()
{

       DBPR" setting cursors $button $Rinfo\n"
	 //  need v cursors -- 

       if (button == 1) {
           lcpx = Rinfo[1]
	     sGl(lc_gl,@cursor,lcpx,wymin,lcpx,wymax,@draw)
        }

       if (button == 3) {
           rcpx = Rinfo[1]
	     sGl(rc_gl,@cursor,rcpx,wymin,rcpx,wymax,@draw)
       }

}

//------------------------------------------------------------

proc ZIN()
{
  if (button == 1) {
        sWo(grwo,@xscales,lcpx,rcpx) 

        drawScreens()
	  }
}

wdir = "xout"

proc ZOUT()
{
  // increase current by 10% ?


  zoom(grwo,wdir,5);
  rs=woGetRscales(grwo)
<<"$rs \n"

  xmin = rs[1]
  xmax = rs[3]

  if (xmin < 0) {
      xmin = 0
  }

  sWo(grwo,@xscales,xmin,xmax) 

        drawScreens()
}
//--------------------------------------------------

///////////////////////// SCREENS ////////////////////////////////////////////////////////


///////////////////////// WINDOWS ////////////////////////////////////////////////////////

   wymin = ymin
   wymax = ymax

// Window

    aw= CreateGwindow(@title,"PLOTY",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.1,0.9,0.7,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.05,0.15,0.8,0.95,@name,"TimeSeries",@color,"white")

  //  setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.1,0.9,0.9,@scales,xmin,ymin-0.5,xmax+xpad,ymax,@savescales,0)
   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.1,0.9,0.9,@scales,xmin,ymin-0.1,xmax,ymax,@savescales,0)


  //////////////////////////////////////////////////////////////////////////////////

 
   dmn = Cab(YV)

<<"$dmn \n"

<<"${YV[0:10]} \n"

//////////////////////////// GLINES & SYMBOLS //////////////////////////////////////////


   refgl=cGL(grwo, @TY, YV, @color, "blue",@usescales,0)

   setGline(refgl,@draw)

      // redraw
      // if not gwm -exit
//  CURSORS

  lc_gl   = cGl(grwo,@type,"XY",@color,"orange",@ltype,"cursor")

  rc_gl   = cGl(grwo,@type,"XY",@color,"blue",@ltype,"cursor")

  plw = aw

  pfname ="ypic"

  xsc = 1/360.0
  ysc = 1.0

  /////////////////  BUTTONS /////////////////////////////////

  zinwo=cWo(aw,@ONOFF,@name,"ZIN",@color,"hotpink")

  zoomwo=cWo(aw,@onoff,@name,"ZOUT",@color,"cadetblue")

  hwo= cWo(aw,@onoff,@name,"YRD",@color,"violetred")

  int fewos[] = {zinwo,zoomwo,hwo}

  wo_htile( fewos, 0.03,0.01,0.3,0.08,0.05)
  /////////////////////////////////////////////
  sWo(fewos,@redraw)

///////////////////////////////////////////////////////////////////////////////////////

//setdebug(0)

    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)
    setGline(refgl,@draw)

int wScreen = 0
float Rinfo[30]

woname = ""
E =1

int m_num = 0
int button = 0

   sWo(grwo,@save,@redraw,@drawon,@pixmapon)

   drawScreens()

   Keyw = ""
   lcpx = 50.0
   rcpx = 100.0

   sGl(lc_gl,@cursor,lcpx,0,lcpx,300)

   sGl(rc_gl,@cursor,rcpx,0,rcpx,300)

   drawScreens()

   while (1) {

        m_num++

        msg  = E->waitForMsg()

        DBPR"got message\n $msg \n"

        msgw = split(msg)

        Keyw = E->getEventKeyw()

DBPR"%V$m_num $msg $Keyw \n"

       button = E->getEventButton()

DBPR"%V$button \n"

       woname = E->getEventWoname()

DBPR"%V$woname \n"

       Rinfo = E->getEventRinfo()

DBPR"%V$Rinfo\n"

       Evtype = E->getEventType()    

DBPR"%V$Evtype\n"

       if ( (msg @= "REDRAW") || (msg @= "RESIZE") || (msg @= "RESCALE") || (msg @= "PRINT")) {
        drawScreens()
        continue
       }  

       if (Evtype @= "PRESS") {

        if (!(woname @= "")) {
            DBPR"calling function via woname $woname !\n"
            $woname()
            continue
        }

       }

        
       if (!(Keyw @= "")) {
         DBPR"calling function via keyword |${Keyw}| $(typeof(Keyw))\n"
         $Keyw()        
         }


        DBPR"%V$lcpx $rcpx \n"
   }


stop("Done!")
;

exit_si()


///////////////////////////////////////////////////////////

