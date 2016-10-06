#/* -*- c -*- */



 setdebug(0)

OpenDll("plot")
// default pipe records to script
// choose  Y cols
    //
    // want this to also accept include "plotlib"  or "$dir/plotlib"
    // this should be an alias to lib location



A = 0

ncols = 1

int YCOL[10+]
YCOL[0] = 0
 int ac =2
 int i = 0


i = 1
ncols = i
pars = i

<<" $YCOL \n"

ycol = 1


     R = ReadRecord(A,@type,FLOAT_,@ncols,1)

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

  //<<"%V6.4f${YV[0:nsz]} \n"

  //<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

      ymin = MM[1] - 2*MM[4]

      ymax = MM[1] + 5*MM[4]

	//      ymax = MM[6]



      xmin = 0

      xmax = sz-1

  XV = Fgen(sz,0,1)
    
  //  <<"%V$xmin $xmax \n"


  xrange = fabs(xmax-xmin)
  xpad=xrange * 0.05


  //<<" %V$ymin $ymax \n" 



  Graphic = CheckGwm()

  if (!Graphic) {
    // this spawns off a server 
    // can we just connect to an existing server ??
    Xgm = spawnGwm()

  }

  aslw = asl_w("PLOT_Y")

// Window
    aw= cWi(@title,"PLOTY",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    sWi(aw,@resize,0.1,0.1,0.9,0.7,0)
    sWi(aw,@drawon,@pixmapon)
    sWi(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo

   grwo = cWo(aw,@GRAPH,@resize,0.15,0.1,0.95,0.95,@name,"PY",@color,"red")

  //   sWo(grwo,@drawon,@clip,0.1,0.1,0.9,0.9,@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0,@drawon,@pixmapon,@savepixmap)
     sWo(grwo,@clip,0.1,0.1,0.9,0.9,@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0,@drawon)

  //////////////////////////////////////////////////////////////////////////////////

 
  dmn = Cab(YV)

  //<<" $dmn \n"
  <<" ${YV[0:10]} \n"

   refgl=cGl(grwo,@TY,YV, @color, "black"); // xincrement by default is one
  
  // refgl=cGl(grwo,@TY,YV, @color, "black",@XI,0.1); // xincrement by default is one

  XV= vgen(FLOAT_,nrows,0,1)
  
  //refgl = cGl(grwo,@TXY,XV,YV, @color, BLACK_)

    // sGl(refgl,@draw)

      // redraw
      // if not gwm -exit


    plw = aw;

   pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0

  // RedrawGlines(grwo)


  //  DrawAxis(aw, -1, -1, xsc,ysc)

  dGl(refgl)

  //sWo(grwo,@showpixmap)



  


int E;

keyw = "";

    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)

dGl(refgl)
  
  // sGl(refgl,@draw)\
  j=0
  while (1) {

    sWo(grwo,@clearpixmap)

    msg = E->waitForMsg()
    keyw = E->getEventKeyW()
    <<"%V $keyw  $msg\n"

    if ( (keyw @= "REDRAW") || (keyw @= "RESIZE")) {
      if ((j %2) == 0) {   
       sWo(grwo,@clipborder,@clear,@color,BLUE_)
      }
      else {
       sWo(grwo,@clipborder,@clear,@color,GREEN_)
      }
    axnum(grwo,2)
    axnum(grwo,1)
    //setGline(refgl,@draw)
     dGl(refgl)
    //sWo(grwo,@showpixmap)
    j++;
    }

    //Plot(grwo,@line,j,YV[j],j+1,YV[j+1],"blue")

  }





STOP!
