#/* -*- c -*- */



 setdebug(0)


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


  R = ReadRecord(A,@type,FLOAT,@ncols,1)

     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

  //<<"%v$nrows \n"

  //<<"%V$sz $dmn\n"

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
    aw= CreateGwindow(@title,"PLOTY",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.1,0.9,0.7,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo

   grwo=createGWOB(aw,@GRAPH,@resize,0.15,0.1,0.95,0.95,@name,"PY",@color,"white")

   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.1,0.9,0.9,@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

  //<<" $dmn \n"
  //<<" ${YV[0:3]} \n"

   refgl=CreateGline(@woid,grwo,@type,"Y",@yvec, YV, @color, "blue",@usescales,0)

   setGline(refgl,@draw)

      // redraw
      // if not gwm -exit


  plw = aw

  pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0

  //    RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)

include "event"

Event E

    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)

    setGline(refgl,@draw)

  while (1) {


    E->waitForMsg()

    if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
    <<"REDRAW \n"
    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)
    setGline(refgl,@draw)

    }



  }





STOP!
