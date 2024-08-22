/* 
 *  @script ploty.asl                                                  
 * 
 *  @comment test ploty record column data (revised)                                      
 *  @release Carbon                                                     
 *  @vers 1.3 Na Sodium [asl 6.50 : C Sn]                              
 *  @date 07/20/2024 15:13:32                                           
 *  @cdate Sun Mar 22 11:05:34 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 






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


A = 0  

ncols = 1

  int YCOL[10];

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

   //<<" $YCOL \n"

ycol = 1

allowDB("spe,vmf,plot,fop,svar,record,math",1) 
   
   /*
   D= readfile(A,1)
   
   // <<"$D\n"
    sz= Caz(D)
    <<"%V$sz\n"
    sz.pinfo()
    str grs
    gki = 0.0
   for (i=0;i< sz; i++) {
    // C=D[i]
     E=split(D[i])
     grs= E[0]
     gr = atof(E[0])
     kr = atof(E[1])
     if (kr > 0) 
     gki = gr/18.0/kr
    // <<"[$i] <|$E[0]|> $E[1] \n"
     if (grs != "#"  && gr > 0) {
    
     <<"[$i] %6.2f $gr $kr $gki\n"
     }
   }
   ans=ask("readfile OK?",1)
   */


     fname = _clarg[1]
   if (fname == "") {
    <<" no data file via clarg !\n"
    exit(-1)
   }
       
     A=ofr(fname);

Record RX;

RX.pinfo()

//Nrecs=RX.readRecord(A,_RDEL,-1,_RLAST);

Nrecs=RX.readRecord(A,_RDEL,-1,_RTYPE,FLOAT_);

 

//     R = ReadRecord(A,@type,FLOAT_,@NCOLS,ncols,@del,',')

  sz = Caz(RX);

  RX.pinfo()


  

    
  glr = 0.0
  kr =  0.0 
  dmn = Cab(RX);
  dmn.pinfo()

  nrows = dmn[0]
  ncols = dmn[1]

<<"%V$nrows $ncols\n"

    <<"%V$sz $dmn \n"  // TBF dmn just dmn[1]
    <<"%V $dmn[0] $dmn[1] \n" // TBF 8/21/24  not correct ele of dmn

  glr = RX[0][0]
  <<"%V $glr \n"  

 
    
  wr= 0

    /*
// IF recordtype is ascii/svar  
while (wr < Nrecs) {


  Col= RX.getRecord(wr);

  glr = atof(Col[0]);
  kr =  atof(Col[1]);
  <<"[$wr] $glr $kr \n"
  wr++
  }
    */

    
// check # cols
  ans=ask("readRecord $Nrecs OK?",0)

    YV = RX[::][0]

    Redimn(YV)

    YV.pinfo()

    
        sz = Caz(YV)
    <<"%V $sz \n"

    <<"%V $YV[0] $YV[1] \n" // TBF

    <<"%V $YV \n"
    
    
  // if want to exclude neg and 0
    // MM= Stats(YV,">",0)
  // but we don't
    
    mms= Stats(YV)

    mms.pinfo()

    npts = Caz(YV)
    
    ans=ask("$npts $mms OK?",1)
    
    exit(-1)
    

<<"%V8.6f$YV \n"

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

   float HS[];

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


 void drawScreens()
  {

    //<<"drawScreens $_cproc \n"
 
    sWi(aw,_wclearclip)
    sWo(grwo,_wclearclip,_wclipborder)
    axnum(grwo,2)
    axnum(grwo,1)
    sGl(refgl,_wdraw)

//   setGwob(histwo,_wclearclip,_wclipborder,_wredraw)
//   setGline(histgl,_wdraw)
     sWo(fewos,_wredraw)
  }


////////////////////////KEYW CALLBACKS///////////////////////////////////////
void EXIT()
{
  exit_gs()
}
//-------------------------------------------
void REDRAW()
{
  drawScreens()
}
void MOVE()
{
  drawScreens()
}
//-------------------------------------------
void RESIZE()
{
  drawScreens()
}
//-------------------------------------------
//---------------------------------------------

void TimeSeries()
{

       DBPR" setting cursors $button $Rinfo\n"
	 //  need v cursors -- 

       if (button == 1) {
           lcpx = Rinfo[1]
	     sGl(lc_gl,_wcursor,lcpx,wymin,lcpx,wymax,_wdraw)
        }

       if (button == 3) {
           rcpx = Rinfo[1]
	     sGl(rc_gl,_wcursor,rcpx,wymin,rcpx,wymax,_wdraw)
       }

}

//------------------------------------------------------------

void Zin()
{
     if (button == 1) {

         sWo(grwo,_wxscales,lcpx,rcpx) 

         drawScreens()
	  }
}
//------------------------------------

wdir = "xout"

void Zout()
{
  // increase current by 10% ?
<<"$_proc   Zout \n"
  zoomwo(grwo,wdir,5);

  rs=woGetRscales(grwo)

<<"$rs \n"

  xmin = rs[1]
  xmax = rs[3]

  if (xmin < 0) {
      xmin = 0
  }

<<"%V$xmin $xmax\n"

  sWo(grwo,_wxscales,xmin,xmax) 

  drawScreens()
}
//--------------------------------------------------
void Quit()
{

  exitgs();

}

  
///////////////////////// SCREENS ////////////////////////////////////////////////////////


///////////////////////// WINDOWS ////////////////////////////////////////////////////////

   wymin = ymin
   wymax = ymax

// Window

    aw= cWi(_wtitle,"PLOTY",_wscales,xmin,ymin,xmax+xpad,ymax,_wsavescales,0)

//<<" CGW $aw \n"

    sWi(aw,_wresize,0.1,0.1,0.9,0.7,0)
    sWi(aw,_wdrawon)
    sWi(aw,_wclip,0.1,0.1,0.8,0.9)

  // GraphWo


   grwo=cWo(aw,_wgraph,_wresize,0.05,0.15,0.8,0.95,_wname,"TimeSeries",_wcolor,"white")

  //  setgwob(grwo,_wdrawon,_wpixmapon,_wclip,0.1,0.1,0.9,0.9,_wscales,xmin,ymin-0.5,xmax+xpad,ymax,_wsavescales,0)
   sWo(grwo,_wdrawon,_wpixmapon,_wclip,0.1,0.1,0.9,0.9,_wscales,xmin,ymin-0.1,xmax,ymax*1.1,_wsavescales,0)

  //   histwo=createGWOB(aw,_wGRAPH,_wresize,0.85,0.15,0.99,0.95,_wname,"Histogram",_wcolor,"white")
  //   setgwob(histwo,_wdrawon,_wpixmapon,_wclip,0.1,0.1,0.9,0.9,_wscales,ymin,0,ymax+0.1,10000,_wsavescales,0)
  //////////////////////////////////////////////////////////////////////////////////

 
   dmn = Cab(YV)

<<"$dmn \n"

<<"${YV[0:10]} \n"

//////////////////////////// GLINES & SYMBOLS //////////////////////////////////////////


   refgl=cGl(grwo, _glTY, YV, _glcolor, "blue",_glusescales,0)

   sGl(refgl,_gldraw)

      // redraw
      // if not gwm -exit

  // histgl=cGL(histwo, @TH, HS, yr, @color, "red",@usescales,0)


  //  setGline(histgl,@draw)

//  CURSORS

  lc_gl   = cGl(grwo,_gltype,"XY",_glcolor,"orange",_glltype,"cursor")

  rc_gl   = cGl(grwo,_gltype,"XY",_glcolor,"blue",_glltype,"cursor")



  plw = aw

  pfname ="ypic"


 xsc = 1/360.0
 ysc = 1.0

  /////////////////  BUTTONS /////////////////////////////////

  // zinwo=cWo(aw,_wname,"ZIN",_wcolor,"hotpink")
  zinwo=cWo(aw,_wONOFF,_wname,"ZIN",_wcolor,"hotpink",_wcallback,"Zin")

  zoomwo=cWo(aw,_wONOFF,_wname,"ZOUT",_wcolor,"cadetblue",_wcallback,"Zout")

  quitwo=cWo(aw,_wONOFF,_wname,"Quit",_wcolor,"cadetblue",_wcallback,"Quit")


  int fewos[] = {zinwo,zoomwo, quitwo };

  wo_htile( fewos, 0.03,0.01,0.3,0.08,0.05)
  /////////////////////////////////////////////
  sWo(fewos,_wredraw)


  //  RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)

///////////////////////////////////////////////////////////////////////////////////////

//setdebug(0)



    setGwob(grwo,_wclipborder)
    axnum(grwo,2)
    axnum(grwo,1)
    sGl(refgl,_gldraw)

   //sWo(histwo,@clearclip,@clipborder,@redraw)


int wScreen = 0
float Rinfo[30]

woname = ""
E =1

int m_num = 0
int button = 0

   sWo(grwo,_wsave,_wredraw,_wdrawon,_wpixmapon)

   drawScreens()

   Keyw = ""
   lcpx = 50.0
   rcpx = 100.0

   sGl(lc_gl,_glcursor,lcpx,0,lcpx,300)

    sGl(rc_gl,_glcursor,rcpx,0,rcpx,300)

   drawScreens()

   while (1) {

        m_num++

        msg  = E->waitForMsg()

        msgw = split(msg)

        Keyw = E->getEventKeyw()

       DBPR"%V$m_num $msg $Keyw \n"

       button = E->getEventButton()

       woname = E->getEventWoname()

       Rinfo = E->getEventRinfo()

       Evtype = E->getEventType()    
<<"%V$Evtype \n"
       Woproc = E->getEventWoProc()


    if ( (msg @= "REDRAW") || (msg @= "RESIZE") || (msg @= "RESCALE") || (msg @= "PRINT")) {
      drawScreens()
      continue
    }

       if (Evtype @= "PRESS") {
          if ( !(Woproc @= "")) {
             $Woproc()        
             continue
          }

       }

        
       if (!(Keyw @= "")) {
         DBPR"calling function via keyword |${Keyw}| $(typeof(Keyw))\n"
         $Keyw()        
         }


        DBPR"%V$lcpx $rcpx \n"
   }



  exitsi()


///////////////////////////////////////////////////////////

