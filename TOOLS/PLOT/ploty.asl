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

ycol = 0

allowDB("spe,vmf,plot,fop,svar,record,math,wcom",1) 
   
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
     wcol = _clarg[2]
if (wcol != "") {
  ycol = atoi(wcol)  
}
     A=ofr(fname);

Record RX;

//wdb= DBaction(DBSTEP_)
  
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
    
    if (ycol >= ncols) {
        ycol = ncols-1
    }
    


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

    RX.pinfo()
    
    //YV = RX[::][ycol]
    YV = RX[::][::]



    YV.pinfo()

    dim = Cab(YV)
    sz = Caz(YV)
    <<"%V $sz $dim\n"
    

    //   Redimn(YV)

    <<"RX $RX[0][1]  $RX[1][1] \n"
    


    kr = RX[2][1]

    <<"%V RX[2][1] $kr\n"
    for (i = 0 ; i <nrows; i++) {
     kr = RX[i][1]
    <<"[$i] $kr\n"
    }

wdb= DBaction(DBSTEP_)
     kr = YV[1][1]

    <<"%V YV[1][1] $kr\n"

    
    

    <<"%V $YV\n"

        <<"YV $YV[0][1]  $YV[1][1] \n"
    

    
    exit(-1)

    <<"%V $YV[0] $YV[1] \n" // TBF

    <<"%V $YV \n"
    
    
  // if want to exclude neg and 0
    // MM= Stats(YV,">",0)
  // but we don't
    
    MM = Stats(YV)

    MM.pinfo()

    npts = Caz(YV)
    
    ans=ask("$npts $MM OK?",0)
    

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

    /*
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
    */



  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm("PLOT_Y")
  }




  // aslw = asl_w("PLOT_Y")


 void drawScreens()
  {

    <<"drawScreens $_proc \n"
 
    sWi(_woid,aw,_wclearclip,WHITE__)
      sWo(_woid,grwo,_wclipborder,BLACK_)
    axnum(grwo,2)
    axnum(grwo,1)
      sGl(_glid,refgl,_gldraw,ON_)

//   setGwob(histwo,_wclearclip,_wclipborder,_wredraw)
//   setGline(histgl,_wdraw)
      // sWo(fewos,_wredraw)
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
	     sGl(lc_gl,_wcursor,wbox(lcpx,wymin,lcpx,wymax),_wdraw,ON_)
        }

       if (button == 3) {
           rcpx = Rinfo[1]
	     sGl(rc_gl,_wcursor,wbox(rcpx,wymin,rcpx,wymax),_wdraw,ON_)
       }

}

//------------------------------------------------------------

void Zin()
{
  <<"calling Zin\n"
     if (button == 1) {

         sWo(grwo,_wxscales,lcpx,rcpx) 

         drawScreens()
	  }
}
//------------------------------------
void ZIN()
{
  <<"calling $_proc\n"
  Zin()

}

wdir = "xout"

void Zout()
{
  // increase current by 10% ?
<<"$_proc    \n"
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
void ZOUT()
{
  <<"calling $_proc\n"
  Zout()

}


 void Quit()
{
  <<"calling $_proc\n"
  exitgs();
  exit(0)
}

  
///////////////////////// SCREENS ////////////////////////////////////////////////////////


///////////////////////// WINDOWS ////////////////////////////////////////////////////////

   wymin = ymin
   wymax = ymax

// Window

  aw= cWi("PLOTY")



//<<" CGW $aw \n"

  sWi(_woid, aw,_wresize,wbox(0.1,0.1,0.9,0.7,0))
  sWi(_woid,aw,_wclip,wbox(0.1,0.1,0.8,0.9))

  sWi(_woid,aw,_wscales,wbox(xmin,ymin,xmax+xpad,ymax),_wsavescales,0)
  
  // GraphWo


  grwo=cWo(aw,WO_GRAPH_);

   sWo(_woid,grwo,_wresize,wbox(0.05,0.15,0.8,0.95),_wname,"TimeSeries",_wcolor,WHITE_)


     sWo(_woid,grwo,_wdraw,ON_,_wpixmap,ON_,_wclip,wbox(0.1,0.1,0.9,0.9))
     sWo(_woid,grwo,_wscales,wbox(xmin,ymin-0.1,xmax,ymax*1.1),_wsavescales,0)

  //   histwo=createGWOB(aw,_wGRAPH,_wresize,0.85,0.15,0.99,0.95,_wname,"Histogram",_wcolor,"white")
  //   setgwob(histwo,_wdrawon,_wpixmapon,_wclip,0.1,0.1,0.9,0.9,_wscales,ymin,0,ymax+0.1,10000,_wsavescales,0)
  //////////////////////////////////////////////////////////////////////////////////

 
   dmn = Cab(YV)

<<"$dmn \n"

<<"${YV[0:10]} \n"

//////////////////////////// GLINES & SYMBOLS //////////////////////////////////////////



    refgl=cGl(grwo)
    
    sGl(_GLID, refgl, _glty, YV, _glcolor, GREEN_,_glsymline,DIAMOND_,_glusescales,0)

    sGl(_glid,refgl,_gldraw,ON_)

      // redraw
      // if not gwm -exit

  // histgl=cGL(histwo, @TH, HS, yr, @color, "red",@usescales,0)


  //  setGline(histgl,@draw)

//  CURSORS
  lc_gl   = cGl(grwo);

  sGl(_GLID,lc_gl,_GLTYPE_CURS, ON_,_GLHUE,RED_,_GLDRAW,ON_);

  rc_gl   = cGl(grwo);

  sGl(_GLID,rc_gl,_GLTYPE_CURS, ON_,_GLHUE,BLUE_,_GLDRAW,ON_);



  plw = aw

  pfname ="ypic"


 xsc = 1/360.0
 ysc = 1.0

  /////////////////  BUTTONS /////////////////////////////////

  // zinwo=cWo(aw,_wname,"ZIN",_wcolor,"hotpink")
    zinwo=cWo(aw,WO_BN_)
    
	    sWo(_woid,zinwo,_wname,"ZIN",_wcolor,"hotpink",_wcallback,"Zin")

  zoomwo=cWo(aw,WO_BN_)
    
	     sWo(_woid,zoomwo,_wname,"ZOUT",_wcolor,"cadetblue",_wcallback,"Zout")

  quitwo=cWo(aw,WO_BN_)

	    sWo(_woid,quitwo, _wname,"Quit",_wcolor,"cadetblue",_wcallback,"Quit")


    


  int fewos[] = {zinwo,zoomwo, quitwo };

  wo_htile( fewos, 0.03,0.01,0.3,0.08,0.05)
  /////////////////////////////////////////////
  //    sWo(fewos,_wredraw,ON_)


  //  RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)

///////////////////////////////////////////////////////////////////////////////////////

//setdebug(0)



    
    axnum(grwo,2)
    axnum(grwo,1)

    sGl(refgl,_gldraw,ON_)

   //sWo(histwo,@clearclip,@clipborder,@redraw)


int wScreen = 0
float Rinfo[30]

woname = ""
E =1

int m_num = 0
int button = 0

    sWo(_woid,grwo,_wdraw,ON_,_wpixmap,ON_)

   drawScreens()


   lcpx = 50.0
   rcpx = 100.0


   sGl(_glid,lc_gl,_glcursor,wbox(lcpx,0,lcpx,300))

  sGl(_glid,rc_gl,_glcursor,wbox(rcpx,0,rcpx,300))

   drawScreens()

    #include "wevent.asl" 


      drawScreens()
   while (1) {

        m_num++

       eventWait()

       DBPR"%V$m_num $emsg $ekeyc $etype $ekeyw\n"





    if ( (ekeyw == "REDRAW") || (ekeyw == "RESIZE") || (ekeyw == "RESCALE") || (ekeyw == "PRINT")) {
      <<"%V $ekeyw so  drawScreens()\n"
      drawScreens()
      //continue
    }

	//  if (ename == "PRESS" ) {
	  if (etype == PRESS_ ) {
	       //    TBF 8/22/24

          if ( !(ewoproc == "")) {
          <<" trying callback iproc via ewoproc <|$ewoproc|>\n"
	    $ewoproc()        
	      // continue
          }

		     /*		     
          if ( !(ewoname == "")) {
	     <<" trying iproc via woname <|$ewoname|>\n"
	      $ewoname()        
            // continue
          }		     
		     */
	  
       }

       /* 
       if (!(ekeyw == "")) {
         DBPR"calling function via keyword <|$ekeyw|>  $(typeof(ekeyw))\n"
	   $ekeyw()        
         }
       */

        DBPR"%V$lcpx $rcpx \n"
   }



  exitsi()


///////////////////////////////////////////////////////////

