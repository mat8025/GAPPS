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


i = 2
ncols = i
pars = i

   //<<" $YCOL \n"

ycol = 0

allowDB("spe,vmf,plot,fop,svar,parse,record,math,wcom,ic",1) 
   /////

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

csv_del = 0
csv_del = spat(fname,".csv")

Record RX;

//wdb= DBaction(DBSTEP_)
  
RX.pinfo()

  if (csv_del) {
  <<"its a csv del file !\n"
      Nrecs=RX.readRecord(A,_RDEL,44,_RTYPE,FLOAT_); // make record a float
  }
  else {
    <<"its a tabsv del file !\n"
    Nrecs=RX.readRecord(A,_RDEL,-1,_RTYPE,FLOAT_); // make record a float
  }

 ask("%V $csv_del ",0)
  sz = Caz(RX);

  RX.pinfo()

    
  glr = 0.0
  kr =  0.0 
  dmn = Cab(RX);
  dmn.pinfo()

  nrows = dmn[0]
  ncols = dmn[1]

    ask("%V $csv_del $nrows $ncols\n",0)
    
    if (ycol >= ncols) {
        ycol = ncols-1
    }
    


    <<"%V$sz $dmn \n"  // TBF dmn just dmn[1]
    <<"%V $dmn[0] $dmn[1] \n" // TBF 8/21/24  not correct ele of dmn

  glr = RX[0][0]
  glr00 = RX[0][0] ; // converts Svar ascii value to float
  glr11 = RX[1][1]
  glr22 = RX[2][2]
  glr33 = RX[3][3]
  glr53 = RX[5][3]
  
  
  
  
 ask("%V $glr00 $glr11 $glr22 $glr33 $glr53\n",1)

 Siv YCOLS[5]

// now get a col to double vec
   YV0 = RX.getCol(0)   // be =0 (or 1,2,3 ..), ee = -1 (-2,3 or +ve 
   YV0.pinfo();
   wc = 1;
   YV1 = RX.getCol(wc)   // be =0 (or 1,2,3 ..), ee = -1 (-2,3 or +ve 
   YV1.pinfo();

   YV2 = RX.getCol(2)   // be =0 (or 1,2,3 ..), ee = -1 (-2,3 or +ve 
   YV2.pinfo();

   YV3 = RX.getCol(3)   // be =0 (or 1,2,3 ..), ee = -1 (-2,3 or +ve 
   YV3.pinfo();


<<"%V $YV3 \n"
<<"%V $YV3[0] $YV[1] \n"


  // YCOLS[0] =  RX.getCol(0)  ;
     YCOLS[0] = "ycol0"

   YCOLS[0].pinfo()

ask("arrayof Sivs work?",1)


/*    
// check # cols
    YVSC = "xyz"
    i = 3
    YVSC = "YV$i"

<<"%V $YVSC $i\n"

  $YVSC  = RX.getCol(i);

  $YVSC.pinfo()
  YV3.pinfo()

*/
  wr= 0



    
// check # cols
  ans=ask("readRecord $Nrecs OK?",1)
    int scz = -1;
    RX.pinfo()

  


/{/*

    for (i=0; i< ncols ; i++) {

      YVSC = "YV$i"
      
      //$YVSC = RX[::][i]  ; // extract as double and auto create named double vec ??
      $YVSC  = RX.getCol(i, 0, -1);
      pinfo($YVSC,2)
      
      //    Redimn($YVSC)
       scz = Caz($YVSC)
  
      
      //$YVSC.pinfo()
      
     ans=ask(" $scz $YVSC built OK?",1)
      
    }
       
    scz = Caz($YVSC)
    sz = Caz(YV2)
    dim = Cab(YV2)
    <<"%V $YVSC $sz $dim\n"
    
    sz.pinfo()

    ans=ask("%V $YVSC $sz $scz OK?",1)
/}*/


    YV0.pinfo()

    YV1.pinfo()    
    
    YV2.pinfo()

    ans=ask(" YV2 built OK?",1)
    
    <<"RX $RX[0][1]  $RX[1][1] \n"
 
    YV0 *= 0.1  // want glines to have own scaling max/min

    kr = RX[2][1]

    <<"%V RX[2][1] $kr\n"
    for (i = 0 ; i <nrows; i++) {
     kr = RX[i][1]
    <<"[$i] $kr\n"
    }

//wdb= DBaction(DBSTEP_)
    
  // if want to exclude neg and 0
    // MM= Stats(YV,">",0)
  // but we don't

    YVSC = "YV1"

    MM = Stats($YVSC)

    MM.pinfo()

    npts = Caz($YVSC)

 <<"%V $npts \n"   

    ans=ask("%V $npts OK?",1)
    

<<"%V8.6f$YV2 \n"

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

    ans=ask(" $MM OK?",0)
  xrange = fabs(xmax-xmin)
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 

  yr = (ymax-ymin) / 255.0

<<" $YV2[::] \n"


    ans=ask("$npts YV2 OK?",0)

    
//////////////////////////




  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm("PLOT_Y")
  }

  // aslw = asl_w("PLOT_Y") // ? does this work?


 void drawScreens()
  {

    <<"drawScreens $_proc \n"
 
    sWi(_woid,aw,_wclearclip,WHITE__)
    sWo(_woid,grwo,_wclipborder,BLACK_,_wredraw,ON_)
    axnum(grwo,2)
    axnum(grwo,1)

      for(i=0; i< ncols; i++) {  
          sGl(_glid, refgl[i],_gldraw,ON_)
      }

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


void YMEASURES()
{
// ymin,ymax - needed
      <<" $_proc setting cursors $ebutton $btn\n"
	 //  need v cursors -- 

       if (ebutton == 1) {
           lcpx = erx
	     sGl(_GLID,lc_gl,_GLHUE,RED_,_glcursor,wbox(lcpx,0,lcpx,50,GCL_init),_gldraw,ON_)
	     ki = round(lcpx);
	     <<"[$ki] $YV0[ki]  $YV1[ki] \n"
	     YV0.pinfo()
             YV1.pinfo()	     
	     
	     titleMessage(aw, "[$ki] $YV0[ki]  $YV1[ki]  $YV2[ki]")
	     GCL_init =0
        }

       if (ebutton == 3) {
           rcpx = erx
	     sGl(_GLID,rc_gl,_GLHUE,BLUE_,_glcursor,wbox(rcpx,0,rcpx,50,GCR_init),_gldraw,ON_)
             GCR_init =0
      }

}

//------------------------------------------------------------

void ZIN()
{
  <<"In $_proc  Zin\n"
     if (ebutton == 1) {

       sWo(_woid, grwo,_wxscales,lcpx,rcpx) 

         drawScreens()
	  }
}
//------------------------------------

wdir = 8 ; // need ZOOMOUT,IN PAN defined

void ZOUT()
{
  // increase current by 10% ?
<<"IN $_proc    \n"

 // zoomwo(zoomwo,wdir,5);

  rs=woGetRscales(grwo)

<<"$rs \n"

  xmin = rs[1]
  xmax = rs[3]

  if (xmin < 0) {
      xmin = 0
  }

<<"%V$xmin $xmax\n"

  sWo(_woid, grwo,_wxscales,xmin,xmax) 

  drawScreens()
}
//--------------------------------------------------


 void QUIT()
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

   //  sWi(_woid,aw,_wscales,wbox(xmin,ymin,xmax+xpad,ymax),_wsavescales,0)
     sWi(_woid,aw,_wscales,wbox(xmin,0,xmax+xpad,ymax),_wsavescales,0,_wsave,ON_)
  
  // GraphWo


  grwo=cWo(aw,WO_GRAPH_);

   sWo(_woid,grwo,_wresize,wbox(0.05,0.15,0.8,0.95),_wname,"TimeSeries",_wcallback,"YMEASURES",_wcolor,WHITE_)


     sWo(_woid,grwo,_wdraw,ON_,_wpixmap,ON_,_wclip,wbox(0.1,0.1,0.9,0.9))
   //sWo(_woid,grwo,_wscales,wbox(xmin,ymin-0.1,xmax,ymax*1.1),_wsavescales,0)
     sWo(_woid,grwo,_wscales,wbox(xmin,0,xmax,100),_wsavescales,1)
     sWo(_woid,grwo,_wscales,wbox(xmin,0,xmax,15),_wsavescales,0)          

  //   histwo=createGWOB(aw,_wGRAPH,_wresize,0.85,0.15,0.99,0.95,_wname,"Histogram",_wcolor,"white")
  //   setgwob(histwo,_wdrawon,_wpixmapon,_wclip,0.1,0.1,0.9,0.9,_wscales,ymin,0,ymax+0.1,10000,_wsavescales,0)
  //////////////////////////////////////////////////////////////////////////////////

 
   dmn = Cab($YVSC)

<<"$dmn \n"

   //<<"$${YVSC[0:10]} \n" // does that work?

//////////////////////////// GLINES & SYMBOLS //////////////////////////////////////////

int refgl[5]
     
     lncol = RED_
     wsc = 0;
     for (i = 0; i < ncols ; i++) {
      refgl[i]=cGl(grwo)
      YVSC="YV$i"
<<"$i $YVSC $refgl[i]  $wcol\n"
      sGl(_GLID, refgl[i], _glty, $YVSC, _glcolor, lncol,_glsymline,DIAMOND_,_glusescales,wsc)
	//	if (i == 0) wsc++;
      lncol++;
     }

    
   /*
     YVSC = "YV1"
     <<"%V $YVSC \n"
     YV1.pinfo()
     sGl(_GLID, refgl[1], _glty, $YVSC, _glcolor, RED_,_glsymline,DIAMOND_,_glusescales,0)
   */

  ans=ask(" %V set $refgl[0]  $refgl[1]  OK?",0)

     for (i = 0; i < ncols ; i++) {     
      sGl(_glid,refgl[i],_GLDRAW,ON_)
     }
     
  ans=ask(" draw $YVSC  OK?",0)
      // redraw
      // if not gwm -exit

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
    
	    sWo(_woid,zinwo,_wname,"Zin",_wcolor,"hotpink",_wcallback,"ZIN")

  zoutwo=cWo(aw,WO_BN_)
    
	     sWo(_woid,zoutwo,_wname,"Zout",_wcolor,LILAC_,_wcallback,"ZOUT")

 // quitwo=cWo(aw,WO_BN_)

//	    sWo(_woid,quitwo, _wname,"Quit",_wcolor,"cadetblue",_wcallback,"QUIT")


    


    int fewos[] = {zinwo,zoutwo, -1 };

  wo_htile( fewos, 0.03,0.01,0.3,0.08,0.05)
  /////////////////////////////////////////////
  //    sWo(fewos,_wredraw,ON_)


  //  RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)

///////////////////////////////////////////////////////////////////////////////////////

//setdebug(0)



    
    axnum(grwo,2)
    axnum(grwo,1)

    sGl(refgl[1],_gldraw,ON_)

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
#include "tbqrd.asl"

titleButtonsQRD(aw);


      drawScreens()

     wo_htile( fewos, 0.03,0.01,0.3,0.08,0.05)

    while (1) {

        m_num++

       eventWait()

       DBPR"%V$m_num $emsg $ebutton $ekeyc $etype $ekeyw\n"

       ans=ask("why not waiting?",0);



    if ( (ekeyw == "REDRAW") || (ekeyw == "RESIZE") || (ekeyw == "RESCALE") || (ekeyw == "PRINT")) {
      <<"%V $ekeyw so  drawScreens()\n"
      drawScreens()
      continue
    }

	//  if (ename == "PRESS" ) {
	 // if (etype == PRESS_ || etype == MOTION_) {
	  if (etype == PRESS_ ) {
	       //    TBF 8/22/24

          if ( !(ewoproc == "")) {
	    ebutton.pinfo()
          <<" trying callback iproc via ewoproc <|$ewoproc|> $ebutton\n"
	    $ewoproc()        
	    continue
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


    
/*
    for (i=0 ;i < 5 ; i++) {
     WVSC = "WV$i"
     $WVSC = fgen(10,i,1)
     pinfo($WVSC,2)		       
     ans=ask("$WVSC built OK?",0)

     scz = Caz($WVSC)

     ans=ask(" $scz $WVSC  OK?",0)
		       
    }

   WV0.pinfo()
   WV1.pinfo()
ans=ask("%V WV1 OK?",0)   
   WV1.pinfo()   
   WV3.pinfo()   

     pinfo(WV4,2)		       
   
ans=ask("%V WV4 OK?",1)

           pinfo(WV1,2)		       

      
      WVSC = "WV1"
      pinfo($WVSC,2)		

ans=ask("%V $WVSC OK?",0)

*/
