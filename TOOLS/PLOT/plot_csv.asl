//   generic ? plot one col against others

y_label = "ALT FT"
x_label = "RANGE-NM"

  pfname ="csv_pic.ps"

proc redraw_fig()
{

      setGwindow(aw,@redraw)
      setGwob(grwo,@border,@clipborder,@save,@color,BLACK,@axnum,2,@axnum,1)

      DrawGline(prgl) // array of glines --- those with invalid id's not processed

      setGwob(grwo,@textf,x_label, 0.5,-0.1,0,0,RED)
      setGwob(grwo,@textf,y_label, -0.1,0.5,0,-90,BLACK)

      setGwob(grwo,@textf,fn, 0.1,1.1,0,0,BLUE)
      setGwob(grwo,@showpixmap)
}

// get args


   fn = _clarg[1]


// read in csv data


  A= ofr (fn)

  if (A == -1) {

       stop("can't open $fn !\n")
  }



  ///////////////////////////////////   CL_args //////////////////////////////////////


  na = argc()  // how many command line args

  ka = 2  // first is file


  while ( ka < na ) {
  
    key = _clarg[ka] ; ka++
    val = _clarg[ka] ; ka++
<<"$ka $key $val\n" 

    if (key @= "ylabel") {
        y_label = val
    }
    if (key @= "xlabel") {
        x_label = val
    }

  }

<<"DONE ARGS $na $ka \n"


  ////////////////////////////////////////////////////////////////////////////////////






  hdr = readline(A)

<<"$hdr \n"

  R = ReadRecord(A,@type,FLOAT,@del,',')


<<"$R\n"


     dmn = Cab(R)

nrows = dmn[0]
ncols = dmn[1]

<<"%V$nrows $ncols\n"

<<"%V$sz $dmn\n"

sz = Caz(R)

// check # cols
  YV = R[::][2]

  Redimn(YV)

  sz = Caz(YV)
<<"ysz $sz \n"

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  nsz = sz -1

<<"%V6.4f${YV[0:nsz]} \n"

<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

      ymin = MM[1] - 2*MM[4]

      ymax = MM[1] + 5*MM[4]

	//      ymax = MM[6]

////////////////////////////////////////////////////
//  which col to use as Xvec?
//  typically first 0?

  XV = R[::][1]
    
      <<"%V$xmin $xmax \n"
  XMM = Stats(XV)

  xmin = XMM[5]

  xmax = XMM[6]

  xrange = fabs(xmax-xmin)
 
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 
<<" %V$xmin $xmax \n" 


/////////////////////////////////////////////////




    k = 2
    clr = 2
// creates a copy of values in input matrix column
    while (k < ncols) {
      nyc = "ic_$k"
      //v= R[::][k]
      $nyc = R[::][k]
      y = $nyc
      b = Cab($nyc)

<<"$k  $b\n"
     
      k++
    }

b = Cab(ic_2)
<<"$b\n"

<<"\\\\\\\\\\\n"

 redimn(ic_2)
<<"%(10,, ,\n)6.1f$ic_2 \n"

<<"\\\\\\\\\\\n"


/{
<<"$ic_3 \n"
<<"$ic_4 \n"
<<"$ic_5 \n"
/}





  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("PLOT_Y")

// Window
  
   aw= CreateGwindow(@title,"BEAM-CAL",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.1,0.9,0.7,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.15,0.1,0.95,0.95,@name,"PXY",@color,"white")

   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,0,0,120,60000,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

//    gl=CreateGline("wid",grwo,"type","XY","xvec",XV,"yvec",YV,"color", RED,"usescales",0)
//    DrawGline(gl)


       setGwob(grwo,@border,@clipborder,@save,@axnum,2,@axnum,1)

int prgl[ncols]

    k = 2
    clr = 3

// creates a copy of values in input matrix column
    s_num = 1
    while (k < ncols) {
      nyc = "ic_$k"
      $nyc = R[::][k]
//<<"$k $nyc \n"
      redimn($nyc)
      prgl[k]=CreateGline("wid",grwo,@type,"XY",@xvec,XV,@yvec,$nyc,@color, clr,"usescales",0)
      setGline( prgl[k], @ltype,"symbol","triangle",@symsize,5,@symhue,clr++)
      k++
    }


// FIX symbols only if pixmap
      DrawGline(prgl) // array of glines --- those with invalid id's not processed


include "event"

Event E


redraw_fig()

  while (1) {


      E->waitForMsg()

     <<"$E->keyw \n"

       if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
          
          redraw_fig()
      }

     if ( (E->keyw @= "PRINT") ) {
          open_laser(pfname)
          //scr_laser(aw)
          gsync()
          redraw_fig()
          CloseLaser()
          //laser_scr(aw)
          gsync()
          
          si_pause(1)
          //<<" cat $pfname | lpr "
          <<"PRINT DONE \n"
    }



  }




si_pause(3)

stop!